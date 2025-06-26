module('subPack.SubDownLoadController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:tryRemoveCheckNetTick()
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_SUB_DOWNLOAD_PANEL, self.openSubDownLoadPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SUB_DOWNLOAD_AWARD_PANEL, self.openSubDownLoadAwardPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_REC_SUB_DOWNLOAD_GIFT, self.onReqRecDownGiftMsgHandler, self)
    
    -- 静默下载进度更新
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_PROGRESS, self.onSubDownLoadProgressUpdateHandler, self)
    -- 静默下载整理更新
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_MOVE, self.onSubDownLoadMoveUpdateHandler, self)
    -- 静默下载成功结果更新
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS, self.onSubDownLoadSuccessUpdateHandler, self)
    -- 静默下载失败结果更新
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_FAIL, self.onSubDownLoadFailUpdateHandler, self)

    -- 静默下载监听
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_DATA_INIT, self.checkFunOpenTriggerDownLoadHandler, self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_UPDATE, self.checkFunOpenTriggerDownLoadHandler, self)
    GameDispatcher:addEventListener(EventName.START_CHECK_TRIGGER_DOWNLOAD, self.checkLvlStageTriggerDownLoadHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.checkLvlStageTriggerDownLoadHandler, self)
    battleMap.MainMapManager:addEventListener(battleMap.MainMapManager.EVENT_DUP_UPDATE, self.checkLvlStageTriggerDownLoadHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FIGHT_BACKGROUND_DOWNLOAD, self.updateFightDownLoadHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 下载有礼 24371
        SC_DOWN_GIFT = self.onResRecDownGiftMsgHandler,
        --- *s2c* 下载有礼已领取 24372
        SC_DOWN_GIFT_SHOW = self.onResHadRecDownGiftMsgHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 下载有礼
function onResRecDownGiftMsgHandler(self, msg)
    if(msg.result == 1)then
        subPack.SubDownLoadManager:parseRecDownGiftResult(true)
    end
end

-- 下载有礼已领取
function onResHadRecDownGiftMsgHandler(self, msg)
    subPack.SubDownLoadManager:parseRecDownGiftResult(msg.down_gift_show == 1)
end

---------------------------------------------------------------请求------------------------------------------------------------------
--- *c2s* 下载有礼 24370
function onReqRecDownGiftMsgHandler(self, args)
    SOCKET_SEND(Protocol.CS_DOWN_GIFT, {}, Protocol.SC_DOWN_GIFT)
end

------------------------------------------------------------------------ 逻辑、面板 ------------------------------------------------------------------------
-- 打开静默下载资源面板
function openSubDownLoadPanel(self, args)
    if self.mSubDownLoadPanel == nil then
        self.mSubDownLoadPanel = subPack.SubDownLoadPanel.new()
        self.mSubDownLoadPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySubDownLoadPanel, self)
    end
    self.mSubDownLoadPanel:open(args)
end

function onDestroySubDownLoadPanel(self)
    self.mSubDownLoadPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySubDownLoadPanel, self)
    self.mSubDownLoadPanel = nil
end

-- 打开资源下载奖励包奖励预览
function openSubDownLoadAwardPanel(self, args)
    if self.mSubDownLoadAwardPreviewPanel == nil then
        self.mSubDownLoadAwardPreviewPanel = subPack.SubDownLoadAwardPreviewPanel.new()
        self.mSubDownLoadAwardPreviewPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySubDownLoadAwardPanel, self)
    end
    self.mSubDownLoadAwardPreviewPanel:open(args)
end

function onDestroySubDownLoadAwardPanel(self)
    self.mSubDownLoadAwardPreviewPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySubDownLoadAwardPanel, self)
    self.mSubDownLoadAwardPreviewPanel = nil
end

------------------------------------------------------------静默下载资源检测-------------—------------------------------
-- 静默下载进度更新
function onSubDownLoadProgressUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeList do
        local moduleType = taskData.moduleTypeList[i]
        -- print("监听下载：", moduleType, "：" .. taskData.downloadedKbSize / taskData.downloadMaxKbSize * 100 .. "%(" .. taskData.downloadedCount .. "个/" .. taskData.downloadMaxCount .. "个)")
    end
end

-- 静默下载整理更新
function onSubDownLoadMoveUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeList do
        local moduleType = taskData.moduleTypeList[i]
        -- print("监听下载：", moduleType, "：正在整理下载资源：" .. taskData.movedCount .. "个/" .. taskData.moveTotalCount .. "个")
    end
end

-- 静默下载成功结果更新
function onSubDownLoadSuccessUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeSuccessList do
        local moduleType = taskData.moduleTypeSuccessList[i]
        print("监听下载：", moduleType, "：整理下载资源成功")
        print("设置归并热更标识：", moduleType)
        download.ResDownLoadManager:setModuleAssetsSign(moduleType, true)
    end
    
    if(not self:isExistNeedUpdate())then
        gs.GOPoolMgr:ClearAll()
        gs.ResMgr:ForceUnload(false, false)
        if(not subPack.SubDownLoadManager:isDownGiftHadRec())then
            GameDispatcher:dispatchEvent(EventName.REQ_REC_SUB_DOWNLOAD_GIFT)
        end
    end
end

-- 静默下载失败结果更新
function onSubDownLoadFailUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeFailList do
        local moduleType = taskData.moduleTypeFailList[i]
        print("监听下载：", moduleType, "：下载失败")
    end
end

-- 功能开启监听触发下载
function checkFunOpenTriggerDownLoadHandler(self, args)
    if(not web.WebManager:isOfficialApp())then
        if(self:isExistNeedUpdate(true))then
            self:tryAddCheckNetTick()
            return self:checkTriggerDownLoad(args, true)
        else
            if(not subPack.SubDownLoadManager:isDownGiftHadRec())then
                GameDispatcher:dispatchEvent(EventName.REQ_REC_SUB_DOWNLOAD_GIFT)
            end
        end
    end
end

-- 玩家等级、关卡更新监听触发下载
function checkLvlStageTriggerDownLoadHandler(self)
    if(not web.WebManager:isOfficialApp())then
        if(self:isExistNeedUpdate(true))then
            self:tryAddCheckNetTick()
            return self:checkTriggerDownLoad(nil, false)
        else
            if(not subPack.SubDownLoadManager:isDownGiftHadRec())then
                GameDispatcher:dispatchEvent(EventName.REQ_REC_SUB_DOWNLOAD_GIFT)
            end
        end
    end
end

-- 是否存在需要更新的资源
function isExistNeedUpdate(self, isSetModuleAssetsSign)
    local isExist = false
    local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
    for moduleType in pairs(assetsDic) do
        local data = assetsDic[moduleType]
        if (data.startup_auto_update == 0) then
            if (download.ResDownLoadManager:isModuleAssetsNeedUpdate({moduleType})) then
                isExist = true
                if(not isSetModuleAssetsSign)then
                    break
                end
            else
                if(isSetModuleAssetsSign)then
                    if(not download.ResDownLoadManager:getModuleAssetsSign(moduleType))then
                        print("设置归并热更标识：", moduleType)
                        download.ResDownLoadManager:setModuleAssetsSign(moduleType, true)
                    end
                end
            end
        end
    end
    return isExist
end

-- 是否存在正在更新的资源
function isExistDownLoading(self)
    local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
    for moduleType in pairs(assetsDic) do
        local data = assetsDic[moduleType]
        if (data.startup_auto_update == 0) then
            local moduleTypeList = {moduleType}
            if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(moduleTypeList)) then
                if (download.ResDownLoadManager:isModuleAssetsDownloading(moduleTypeList)) then
                    return true
                end
            end
        end
    end
    return false
end

-- 功能开启、玩家等级、关卡更新监听触发下载
function checkTriggerDownLoad(self, args, isFunOpen)
    local isDownLoad = false
    if(fight.SceneManager:isInFightScene())then
        return isDownLoad
    end
    self:updateDownLoadSpeedByFight(fight.SceneManager:isInFightScene())
    if (role and battleMap and funcopen) then
        local roleLvl = role.RoleManager:getRoleVo():getPlayerLvl()
        local mainStageId = battleMap.MainMapManager:getMainMapCurStage()
        if (roleLvl and mainStageId) then
            local tempList = {}
            local moduleTypeList = {}
            local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
            for moduleType in pairs(assetsDic) do
                local data = assetsDic[moduleType]
                if (data.startup_auto_update == 0) then
                    -- 功能开启检测
                    if(table.indexof(moduleTypeList, tonumber(moduleType)) == false and (isFunOpen == nil or isFunOpen == true))then
                        if(data.fun_open_id ~= -1)then
                            if(not args or args.funcId == data.fun_open_id)then
                                local funcIsOpen = funcopen.FuncOpenManager:isOpen(data.fun_open_id, false)
                                if (funcIsOpen) then
                                    tempList[1] = moduleType
                                    if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(tempList)) then
                                        if (not download.ResDownLoadManager:isModuleAssetsDownloading(tempList)) then
                                            table.insert(moduleTypeList, tonumber(moduleType))
                                        end
                                    else
                                        if(not download.ResDownLoadManager:getModuleAssetsSign(moduleType))then
                                            print("功能开启监听设置归并热更标识：", moduleType)
                                            download.ResDownLoadManager:setModuleAssetsSign(moduleType, true)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    -- 关卡等级检查
                    if(table.indexof(moduleTypeList, tonumber(moduleType)) == false and (isFunOpen == nil or isFunOpen == false))then
                        if (
                            (data.role_lvl ~= -1 and data.main_stage_id == -1 and roleLvl >= data.role_lvl) or 
                            (data.role_lvl == -1 and data.main_stage_id ~= -1 and mainStageId > data.main_stage_id) or 
                            (data.role_lvl ~= -1 and data.main_stage_id ~= -1 and mainStageId > data.main_stage_id and roleLvl >= data.role_lvl) 
                        ) then
                            tempList[1] = moduleType
                            if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(tempList)) then
                                if (not download.ResDownLoadManager:isModuleAssetsDownloading(tempList)) then
                                    table.insert(moduleTypeList, tonumber(moduleType))
                                end
                            else
                                if(not download.ResDownLoadManager:getModuleAssetsSign(moduleType))then
                                    print("等级关卡监听设置归并热更标识：", moduleType)
                                    download.ResDownLoadManager:setModuleAssetsSign(moduleType, true)
                                end
                            end
                        end
                    end
                end
            end
            if(#moduleTypeList > 0)then
                table.sort(moduleTypeList, function (a, b) return a < b end)

                local _downLoad = function()
                    local tip = ""
                    if(isFunOpen == true)then
                        tip = "功能开启"
                    elseif(isFunOpen == false)then
                        tip = "等级关卡"
                    end
                    for i = 1, #moduleTypeList do
                        local moduleType = moduleTypeList[i]
                        print(tip .. "监听开始触发下载：", moduleType)
                        download.ResDownLoadManager:addDownLoadTask({moduleType})
                    end
                end

                local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
                if(isWifi)then
                    gs.Message.Show("正在为您静默下载完整版所需资源")
                    _downLoad()
                else
                    local giftId = sysParam.SysParamManager:getValue(SysParamType.DOWN_LOAD_GIFT_ID)
                    local propsList = AwardPackManager:getAwardListById(giftId)
                    local propsTip = ""
                    for i = 1, #propsList do
                        local awardPackConfigVo = propsList[i]
                        local propsConfigVo = props.PropsManager:getPropsConfigVo(awardPackConfigVo.tid)
                        propsTip = propsTip .. string.format("%s*%s ", propsConfigVo.name, awardPackConfigVo.num)
                    end
                    local kbSize = download.ResDownLoadManager:getModuleAssetsSize(moduleTypeList)
                    local formatSize, unit = download.GetFormatSize(kbSize)
                    UIFactory:alertMessge(string.format("当前版本仅能体验部分游戏内容\n是否下载完整版？下载过程为后台静默\n资源大小：%s，奖励：%s", tostring(formatSize) .. unit, propsTip),
                    true, function() _downLoad() end, _TT(1), -- "确定"
                    nil, true, function() end, _TT(2), -- "取消"
                    "下载提示",
                    nil, RemindConst.BACKGROUND_DOWNLOAD)
                end
                
                isDownLoad = true
            end
        end
    end
    return isDownLoad
end

-- 通知资源下载模块更新相关处理
function updateFightDownLoadHandler(self, isStartFight)
    if(isStartFight)then
        self:updateDownLoadSpeedByFight(isStartFight)
    else
        return self:checkTriggerDownLoad(nil, nil)
    end
end

function updateDownLoadSpeedByFight(self, isStartFight)
    download.ResDownLoadManager:setFrequencyRatio(0.01)
    if(isStartFight)then
        local threadCount = 1
        local oneThreadLimitSpeed = 0
        if(sdk.SdkManager:getIsSimulator())then
            -- 模拟器的设置多线程设置少点
            threadCount = 5
            oneThreadLimitSpeed = 540
        else
            if(gs.Application.platform == gs.RuntimePlatform.Android)then
                threadCount = 5
                oneThreadLimitSpeed = 540
            elseif(gs.Application.platform == gs.RuntimePlatform.IPhonePlayer)then
                threadCount = 5
                oneThreadLimitSpeed = 540
            elseif(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)then
                threadCount = 5
                oneThreadLimitSpeed = 0
            else
                threadCount = 5
                oneThreadLimitSpeed = 0
            end
        end
        download.ResDownLoadManager:setThreadCount(threadCount)
        download.ResDownLoadManager:setThreadLimitSpeed(threadCount * oneThreadLimitSpeed)
    else
        local threadCount = 1
        local oneThreadLimitSpeed = 0
        if(sdk.SdkManager:getIsSimulator())then
            -- 模拟器的设置多线程设置少点
            threadCount = 5
            oneThreadLimitSpeed = 540
        else
            if(gs.Application.platform == gs.RuntimePlatform.Android)then
                threadCount = 5
                oneThreadLimitSpeed = 540
            elseif(gs.Application.platform == gs.RuntimePlatform.IPhonePlayer)then
                threadCount = 5
                oneThreadLimitSpeed = 540
            elseif(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)then
                threadCount = 5
                oneThreadLimitSpeed = 0
            else
                threadCount = 5
                oneThreadLimitSpeed = 0
            end
        end
        download.ResDownLoadManager:setThreadCount(threadCount)
        download.ResDownLoadManager:setThreadLimitSpeed(threadCount * oneThreadLimitSpeed)
    end
end

-- 判断主线关卡被禁止打
function checkBattleDownLoadState(self, dupType, dupId)
    local isNeedCheckDownLoad = false -- 是否需要顺带触发下更新
    local isForbidByDownLoad = false
    if(dupType == PreFightBattleType.MainMapStage)then
        local roleLvl = role.RoleManager:getRoleVo():getPlayerLvl()
        local mainStageId = dupId
        local tempList = {}
        local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
        for moduleType in pairs(assetsDic) do
            local data = assetsDic[moduleType]
            if (data.startup_auto_update == 0) then
                -- if (
                --     (data.role_lvl ~= -1 and data.main_stage_id == -1 and roleLvl >= data.role_lvl) or 
                --     (data.role_lvl == -1 and data.main_stage_id ~= -1 and mainStageId > data.main_stage_id) or 
                --     (data.role_lvl ~= -1 and data.main_stage_id ~= -1 and mainStageId > data.main_stage_id and roleLvl >= data.role_lvl) 
                -- ) then
                --     tempList[1] = moduleType
                --     if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(tempList)) then
                --         if (not download.ResDownLoadManager:isModuleAssetsDownloading(tempList)) then
                --             self:checkTriggerDownLoad(nil, nil)
                --         else
                --             self:showDownLoadMsg(tempList)
                --         end
                --         isForbidByDownLoad = true
                --         break
                --     end
                -- end
                
                if(#data.main_stage_id_forbid_list > 0 and table.indexof(data.main_stage_id_forbid_list, mainStageId) ~= false)then
                    tempList[1] = moduleType
                    if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(tempList)) then
                        if (not download.ResDownLoadManager:isModuleAssetsDownloading(tempList)) then
                            local isTrigger = self:checkTriggerDownLoad(nil, nil)
                            if(not isTrigger)then
                                -- 如果限制的入口在配置条件之前就检测了，是不会触发下载的，这里再单独给提示，或者让策划把配置的触发条件设置再提前一点
                                gs.Message.Show("需要先下载完剩余资源")
                            end
                        else
                            self:showDownLoadMsg(tempList)
                        end
                        isForbidByDownLoad = true
                        break
                    end
                end
            end
        end
    end
    return isForbidByDownLoad
end

-- 判断ui是否因为未下载被禁止打开
function isForbidUIByDownload(self, uiCode)
    local isForbidByDownLoad = false
    local tempList = {}
    local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
    for moduleType in pairs(assetsDic) do
        local data = assetsDic[moduleType]
        if (data.startup_auto_update == 0) then
            if(#data.ui_code_forbid_list > 0 and table.indexof(data.ui_code_forbid_list, uiCode) ~= false)then
                tempList[1] = moduleType
                if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(tempList)) then
                    if (not download.ResDownLoadManager:isModuleAssetsDownloading(tempList)) then
                        local isTrigger = self:checkTriggerDownLoad(nil, nil)
                        if(not isTrigger)then
                            -- 如果限制的入口在配置条件之前就检测了，是不会触发下载的，这里再单独给提示，或者让策划把配置的触发条件设置再提前一点
                            gs.Message.Show("需要先下载完剩余资源")
                        end
                    else
                        self:showDownLoadMsg(tempList)
                    end
                    isForbidByDownLoad = true
                    break
                end
            end
        end
    end
    return isForbidByDownLoad
end

-- 判断事件是否UI界面是否需要下载的界面
function checkEventNameDownLoadState(self, eventName, args)
    local isForbidByDownLoad = false
    -- if(eventName == EventName.SEND_RECRUIT)then
    --     if(args.type ~= recruit.RecruitType.RECRUIT_ACTIVITY_2)then
    --         local moduleTypeList = {sysParam.SysParamManager:getValue(SysParamType.RECRUIT_CHECK_STAGE_DOWNLOAD)}
    --         if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(moduleTypeList)) then
    --             if (not download.ResDownLoadManager:isModuleAssetsDownloading(moduleTypeList)) then
    --                 local isTrigger = self:checkTriggerDownLoad(nil, nil)
    --                 if(not isTrigger)then
    --                     -- 如果限制的入口在配置条件之前就检测了，是不会触发下载的，这里再单独给提示，或者让策划把配置的触发条件设置再提前一点
    --                     gs.Message.Show("需要先下载完剩余资源")
    --                 end
    --             else
    --                 self:showDownLoadMsg(moduleTypeList)
    --             end
    --             isForbidByDownLoad = true
    --         end
    --     end
    -- end
    return isForbidByDownLoad
end

-- 判断事件是否UI界面是否需要下载的界面
function checkPropUseDownLoadState(self)
    local isForbidByDownLoad = false
    local moduleTypeList = {sysParam.SysParamManager:getValue(SysParamType.PROP_SELECT_USE_CHECK_DOWNLOAD)}
    if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(moduleTypeList)) then
        if (not download.ResDownLoadManager:isModuleAssetsDownloading(moduleTypeList)) then
            local isTrigger = self:checkTriggerDownLoad(nil, nil)
            if(not isTrigger)then
                -- 如果限制的入口在配置条件之前就检测了，是不会触发下载的，这里再单独给提示，或者让策划把配置的触发条件设置再提前一点
                gs.Message.Show("需要先下载完剩余资源")
            end
        else
            self:showDownLoadMsg(moduleTypeList)
        end
        isForbidByDownLoad = true
    end
    return isForbidByDownLoad
end

function showDownLoadMsg(self, moduleTypeList)
    local downloadedKbSize, downloadMaxKbSize, downloadedCount, downloadMaxCount, movedCount, moveTotalCount = download.ResDownLoadManager:getDownLoadTaskData(moduleTypeList)
    if(downloadedKbSize < downloadMaxKbSize)then
        gs.Message.Show(string.format("正在下载所需资源，进度%s", string.format("%.2f", downloadedKbSize / downloadMaxKbSize * 100) .. "%"))
    elseif(downloadedKbSize >= downloadMaxKbSize)then
        if(movedCount < moveTotalCount)then
            -- gs.Message.Show(string.format("正在整理所需资源，进度%s", string.format("%.2f", movedCount / moveTotalCount * 100) .. "%"))
            gs.Message.Show("正在整理所需资源：" .. movedCount .. "/" .. moveTotalCount .. "，请稍等")
        else
            gs.Message.Show("正在整理所需资源，请稍等")
        end
    end
end

function tryAddCheckNetTick(self)
    if(not web.WebManager:isOfficialApp())then
        if(not self.mTickSn)then
            local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
            self.mIsWifiNet = isWifi
            self.mTickSn = LoopManager:addTimer(2, 0, self, self.onTickCheckNetHandler)
        end
    end
end

function onTickCheckNetHandler(self)
    local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
    if(self.mIsWifiNet ~= isWifi)then
        self.mIsWifiNet = isWifi
        if(not self.mIsWifiNet and self:isExistDownLoading())then
            UIFactory:alertMessge("当前正在静默下载，检测到网络数据变化，请检查是否继续下载",
            true, function() end, _TT(1), -- "确定"
            nil, false, function() end, _TT(2), -- "取消"
            "下载提示",
            nil, nil)
        end
    end
end

function tryRemoveCheckNetTick(self)
    if(not web.WebManager:isOfficialApp())then
        if(self.mTickSn)then
            LoopManager:removeTimerByIndex(self.mTickSn)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49):	"系统提示"
]]