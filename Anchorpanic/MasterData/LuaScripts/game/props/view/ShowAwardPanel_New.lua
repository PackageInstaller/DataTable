module("ShowAwardPanel_New", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("reward/ShowAwardPanel_New.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

function getInstance(self)
    -- 每次关闭都会被销毁，不用单例
    -- if(not self.mInstance)then
    local destroyView = function()
        self.mInstance:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.mInstance = nil
    end

    if not self.mInstance then
        self.mInstance = ShowAwardPanel_New.new()
        self.mInstance:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end

    -- end
    return self.mInstance
end

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
    self.mCloseCall = nil
    self.mlist = {}
end

function configUI(self)
    self.mScrollContent = self:getChildTrans("Content")
    self.mScroller = self:getChildTrans("mRewardGroup")
    self.mNextLevel = self:getChildGO("mBtnNextLevel")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mTxtDes = self:getChildGO("mTxtDes")
    self.mViewportRaycast = self:getChildGO("Viewport"):GetComponent(ty.RaycastEmptyEvent)
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mTxtNextLevel = self:getChildGO("mTxtNextLevel"):GetComponent(ty.Text)
    self.mTxtCancel = self:getChildGO("mTxtCancel"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtCancel.text = _TT(44219)
    self.mTxtNextLevel.text = _TT(44220)
end

function active(self, args)
    super.active(self, args)
    self:setGuideTrans("guide_ShowAwardPanel_close", self.mask.transform)
    GameDispatcher:dispatchEvent(EventName.NEW_SHOW_AWARD_PANEL_OPEN)
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_battle_gain.prefab"))

    self.mNextLevel:SetActive(false)
    self.mBtnCancel:SetActive(false)
    self.mTxtDes:SetActive(true)
end

function deActive(self)
    super.deActive(self)
    self:clearFrameSn()
    self:clearItem()
    if self.mNextLevelSn then
        LoopManager:removeTimerByIndex(self.mNextLevelSn)
        self.mNextLevelSn = nil
    end
end

function onClickClose(self)
    if not self.isCanClose then
        return
    end
    local tweenTime = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "ShowAwardPanel_New_Exit")
    self.mAnimator:Play("ShowAwardPanel_New_Exit")
    self:setTimeout(tweenTime, function()
        self:close(self)
    end)
end

function close(self)
    super.close(self)
    if self.mCloseCall then
        self.mCloseCall()
        self.mCloseCall = nil
    end
end

function clearItem(self)
    for i = #self.mItemList, 1, -1 do
        self.mItemList[i]:poolRecover()
        self.mItemList[i] = nil
    end
    self.mItemList = {}
end

-- 回调方法相关
function setCallFun(self, callFun)
    self.mCloseCall = callFun
end

function getCallFun(self)
    return self.mCloseCall
end

-- 服务器奖励模版列表
function showPropsAwardMsg(self, cusPropsList, closeCall)
    self.mCloseCall = closeCall

    local list = {}
    for _, v in ipairs(cusPropsList) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        if not configVo then
            logAll(configVo, "这个道具没有哦！！！请找下策划。id = " .. v.tid)
        end
        if configVo.type == PropsType.EQUIP then
            -- 服务器发来的会自动合并tid一样的，前端先全部拆分
            local count = v.count
            v.count = 1
            local equipVo = nil
            if v.id == 0 then
                equipVo = LuaPoolMgr:poolGet(props.EquipVo)
                -- 非直接入包处理（进了邮件）
                equipVo:setPropsAwardMsgData(v)
            else
                equipVo = bag.BagManager:getPropsVoById(v.id)
                if equipVo then
                    equipVo:setEquipDetailMsgData(v)
                else
                    logError("======错误：结算道具未完成入包=====")
                    equipVo = LuaPoolMgr:poolGet(props.EquipVo)
                    equipVo:setPropsAwardMsgData(v)
                end
            end
            table.insert(list, equipVo)
        else
            local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setPropsAwardMsgData(v)
            table.insert(list, propsVo)
        end
    end
    table.sort(list, self.sortPropsListByAscending)
    local instance = self:getInstance()
    instance:open()
    instance:createPropsGrid(list)
end

-- 道具列表排序，升序
function sortPropsListByAscending(propsVo1, propsVo2)
    if (propsVo1 and propsVo2) then
        --芯片类型（主类型为2）的道具优先排列在其他道具的前面
        if propsVo1.type == 2 and propsVo2.type ~= 2 then
            return false
        end

        if propsVo1.type ~= 2 and propsVo2.type == 2 then
            return true
        end

        -- 品质从小到大
        if (propsVo1.color and propsVo2.color) then
            if (propsVo1.color < propsVo2.color) then
                return true
            end
            if (propsVo1.color > propsVo2.color) then
                return false
            end
        end
        -- id从小到大
        if (propsVo1.id and propsVo2.id) then
            if (propsVo1.id < propsVo2.id) then
                return true
            end
            if (propsVo1.id > propsVo2.id) then
                return false
            end
        end
        -- 创建时间从小到大
        if (propsVo1.createdTime and propsVo2.createdTime) then
            if (propsVo1.createdTime < propsVo2.createdTime) then
                return true
            end
            if (propsVo1.createdTime > propsVo2.createdTime) then
                return false
            end
        end
    end
    return false
end

function setClimbTowerData(self, dupId)
    local instance = self:getInstance()
    instance:showNextLevel(dupId)
end

function createPropsGrid(self, list)
    self.mlist = list
    self:removeAllTimer()
    self:clearItem()

    for i = #self.mlist, 1, -1 do
        local propsVo = self.mlist[i]
        local grid = nil
        if propsVo.type == PropsType.EQUIP then
            if propsVo.subType == PropsEquipSubType.SLOT_7 then
                grid = BraceletsGrid2:createByData({tid = propsVo.tid, num = propsVo.count, parent = self.mScrollContent, isTween = true, showUseInTip = false, vo = propsVo})
            else
                grid = EquipGrid2:createByData({tid = propsVo.tid, num = propsVo.count, parent = self.mScrollContent, isTween = true, showUseInTip = false, vo = propsVo})
            end
        else
            grid = PropsGrid:createByData({tid = propsVo.tid, num = propsVo.count, parent = self.mScrollContent, isTween = true, showUseInTip = false})
        end
        grid:setActive(false)
        table.insert(self.mItemList, grid)
    end
    self.mViewportRaycast.enabled = #self.mlist > 8

    if #self.mlist > 0 then
        self.frameSn_1 = LoopManager:setFrameout(22, self, function()
            self:clearFrameSn()

            self.createIndex = 1
            self:onCreatePropsGrid()
            local frame = math.max(2, 12 / (#self.mlist / 4))
            self.frameSn_2 = LoopManager:addFrame(frame, -1, self, function()
                self.createIndex = self.createIndex + 1
                if self.createIndex > #self.mlist then
                    self:clearFrameSn()
                    self.isCanClose = true
                    return
                end
                self:onCreatePropsGrid()
                -- if self.createIndex > 10 then
                --     local row = math.max(0, math.ceil(self.createIndex / 5) - 2)
                --     gs.TransQuick:LPosY(self.mScrollContent, row * 161)
                -- end
            end)
        end)
    end
end

function showNextLevel(self, dupId)
    self.mNextLevel:SetActive(true)
    self.mBtnCancel:SetActive(true)
    self.mTxtDes:SetActive(false)
    local function onClickNextLevel()
        dup.DupClimbTowerManager:setGotoNextLevel(true, dupId)
        self:onClickClose()
    end
    local function onClickCancel()
        dup.DupClimbTowerManager:setGotoNextLevel(false)
        self:onClickClose()
    end
    self:addUIEvent(self.mNextLevel, onClickNextLevel)
    self:addUIEvent(self.mBtnCancel, onClickCancel)

    local timeCount = sysParam.SysParamManager:getValue(SysParamType.WAITFORNEXTLEVEL)
    self.mTxtNextLevel.text = _TT(44220, timeCount)
    self.mNextLevelSn = LoopManager:addTimer(1, 0, self, function()
        timeCount = timeCount - 1
        if timeCount < 0 then
            onClickNextLevel()
            return
        end
        self.mTxtNextLevel.text = _TT(44220, timeCount)
    end)
end

function onCreatePropsGrid(self)
    local grid = self.mItemList[self.createIndex]
    if grid then
        grid:setActive(true)
        grid:updateTween()
    end
end

function clearFrameSn(self)
    if self.frameSn_2 then
        LoopManager:removeFrameByIndex(self.frameSn_2)
        self.frameSn_2 = nil
    end

    if self.frameSn_1 then
        LoopManager:removeFrameByIndex(self.frameSn_1)
        self.frameSn_1 = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
