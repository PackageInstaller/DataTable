module("updateRes.UpdateResLoadingView", Class.impl(updateRes.UpdateResBaseView))

-- 是否异步
IsAsyn = true
UIRes = UrlManager:getPrefabPath("updateRes/UpdateResLoadingView.prefab")

--构造函数
function ctor(self)
    CS.Lylibs.LifeCyclelManager.Instance:AddRegister("UpdateResLoadingView", self.onCSharpLifeCycleHandler, self)
    super.ctor(self)
end

function onCSharpLifeCycleHandler(self, lifeCycleName)
    if (lifeCycleName == "Start") then
        CS.Lylibs.LifeCyclelManager.Instance:RemoveRegister("UpdateResLoadingView")

        local function callFun()
	        web.setSplashTipProcess(100)
            CS.Lylibs.Splash.Instance:CloseVisible()
            web.setSplashTipProcess(nil)
            gs.PopPanelManager.CloseAll()
            gs.PopPanelManager.DestroyAllPanel()

            self:__updateBgPlayState(StorageUtil:getBool0('IsUpdateResImgBg'))
            self:__updateBgAudioState(StorageUtil:getBool0('IsUpdateResAudioMute'))
            web.WebManager:dispatchEvent(web.WebManager.FIRST_VIEW_INIT_FINISH, {})
        end
        -- 运行更新逻辑，则UpdateResLoadingView界面做为第一个显示界面，则需要派发通知
        if (web.WebManager.run_update_code) then
            if (BoardShower:getBoardState() == BoardShower.BoardState.None) then
                BoardShower:showBoard(BoardShower:getBoardImgSource(), BoardShower:getBoardImgAudioSource(), BoardShower:getBoardVideoSource(), false, nil,
                function()
                    callFun()
                end)
            else
                callFun()
            end
        end
    end
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mIsImgBg = BoardShower:isForceBoardImg()
    self.mIsAudioMute = false
    self.mIsHasNet = true
    self.mIsOpenedTip = false
    self.mIsReadyClose = false
    self:initProData()
end

function initProData(self)
    -- 全部进度，此处不设为1，以防100后还有些等待
    self.mAllPro = 0.99
    -- 准备进度比例（在开始下载资源前，游戏前期的各种请求准备用进度条做表现，免得像卡死）
    self.mMaxPreparePro = 0.1
    self.mPreparePro = 0
    -- 代码加载的进度（在不用热更新时，此处进度值和登录预加载起始进度值保持一致，整体看起来类似只有一个进度条）
    self.mMaxCodePro = 0.5
    -- zip的进度
    self.mZipPro = 0
    -- zip的大小
    self.mZipSize = 0
    -- 最终的显示进度
    self.mShowProgress = 0
end

-- 设置父容器
function getParentTrans(self)
    return updateRes.loading
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self:getChildGO('mImgBg'):SetActive(false)

    self.mBtnSwitch = self:getChildGO('BtnSwitch')
    self.mTextSwitch = self:getChildGO('TextSwitch'):GetComponent(ty.Text)
    self.mImgSwitch = self:getChildGO('mImgIconSwitch'):GetComponent(ty.AutoRefImage)
    
    self.mBtnAudio = self:getChildGO('BtnAudio')
    self.mTxtAudio = self:getChildGO('TextAudio'):GetComponent(ty.Text)
    self.mImgAudio = self:getChildGO('mImgIconAudio'):GetComponent(ty.AutoRefImage)
    self.mBtnCleanAssets = self:getChildGO('BtnCleanAssets')
    self.mTxtCleanAssets = self:getChildGO('TextCleanAssets'):GetComponent(ty.Text)

    self.mTxtClientVersion = self:getChildGO('TextClientVersion'):GetComponent(ty.Text)
    self.mTxtServerVersion = self:getChildGO('TextServerVersion'):GetComponent(ty.Text)
    self.mTxtState = self:getChildGO('TextState'):GetComponent(ty.Text)
    self.mTextSpeed = self:getChildGO('TextSpeed'):GetComponent(ty.Text)
    self.mTextSize = self:getChildGO('TextSize'):GetComponent(ty.Text)

    self.mTxtPro = self:getChildGO('TextProgress'):GetComponent(ty.Text)
    self.mTransImgAct = self:getChildTrans('ImgAct')

    self.mImgProBar = self:getChildTrans('ImgProBar'):GetComponent(ty.Image)
    self.mImgProBar.fillAmount = 0

    self.mGroupAdapt = self:getChildGO('GroupAdapt')
    self.mGroupBottom = self:getChildGO('GroupBottom')

    self.mBtnSwitch:SetActive(not BoardShower:isForceBoardImg())
    self.mGroupAdapt:SetActive(true)
    self.mGroupBottom:SetActive(true)
    -- self.mBtnAudio:SetActive(false)
end

-- 刘海适配缩放节点
function getAdaptaTrans(self)
    return self.mGroupAdapt.transform
end

--激活
function active(self)
    super.active(self)
    self:setAdapta()
    web.WebManager:addEventListener(web.WebManager.MODULE_REQUIRE_FINISH, self.__onModuleRequireFinishHandler, self)
    web.WebManager:addEventListener(web.WebManager.ALL_MODULE_REQUIRE_FINISH, self.__onAllModuleRequireFinishHandler, self)
    self:addOnClick(self.mBtnSwitch, self.__onClickSwitchHandler)
    self:addOnClick(self.mBtnAudio, self.__onClickBgAudioHandler)
    self:addOnClick(self.mBtnCleanAssets, self.__onClickCleanAssetsHandler)
    self.mTxtAudio.text = _TT(62060)
    self.mTextSwitch.text = _TT(1196)
    self.mTxtCleanAssets.text = _TT(71)

    self:addPrepareProgressTimerHandler()
    self:addCheckNetFrameHandler(gs.Application.targetFrameRate)
    self:addActionFrameHandler(gs.Application.targetFrameRate)
    self:updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
    web.WebManager:removeEventListener(web.WebManager.MODULE_REQUIRE_FINISH, self.__onModuleRequireFinishHandler, self)
    web.WebManager:removeEventListener(web.WebManager.ALL_MODULE_REQUIRE_FINISH, self.__onAllModuleRequireFinishHandler, self)
    self:removeOnClick(self.mBtnSwitch)
    self:removeOnClick(self.mBtnAudio)
    self:removeOnClick(self.mBtnCleanAssets)
    self:removePrepareProgressTimerHandler()
    self:removeCheckNetFrameHandler()
    self:removeActionFrameHandler()
    self:removeSpeedTimerHandler()
    self:initProData()
    self.mGroupBottom:SetActive(true)
end

function addPrepareProgressTimerHandler(self)
    if (not self.mPrepareProgressTimerSn) then
        self.mPrepareProgressTimerSn = LoopManager:addTimer(1, 0, self, self.onPrepareProgressFrameHandler)
    end
end
function removePrepareProgressTimerHandler(self)
    if (self.mPrepareProgressTimerSn) then
        LoopManager:removeTimerByIndex(self.mPrepareProgressTimerSn)
        self.mPrepareProgressTimerSn = nil
    end
end
function addCheckNetFrameHandler(self, targetFrameRate)
    if (not self.mCheckNetFrameSn) then
        self.mCheckNetFrameSn = LoopManager:addFrame(targetFrameRate == 30 and 1 or 2, 0, self, self.onCheckNetFrameHandler)
    end
end
function removeCheckNetFrameHandler(self)
    if (self.mCheckNetFrameSn) then
        LoopManager:removeFrameByIndex(self.mCheckNetFrameSn)
        self.mCheckNetFrameSn = nil
    end
end
function addActionFrameHandler(self, targetFrameRate)
    if (not self.mActionSn) then
        self.mActionSn = LoopManager:addFrame(targetFrameRate == 30 and 1 or 2, 0, self, self.onActionHandler)
    end
end
function removeActionFrameHandler(self)
    if (self.mActionSn) then
        LoopManager:removeFrameByIndex(self.mActionSn)
        self.mActionSn = nil
    end
end
function addSpeedTimerHandler(self)
    if(not self.mSpeedTimerSn)then
        self.mSpeedTimerSn = LoopManager:addTimer(1, 0, self, self.onSpeedTimerHandler)
    end
end
function removeSpeedTimerHandler(self)
    if self.mSpeedTimerSn then
        LoopManager:removeTimerByIndex(self.mSpeedTimerSn)
        self.mSpeedTimerSn = nil
    end
end

function __onClickSwitchHandler(self)
    self:__updateBgPlayState(not self.mIsImgBg)
    self:__updateBgAudioState(self.mIsAudioMute)
end

function __updateBgPlayState(self, isImgVideo)
    self.mIsImgBg = isImgVideo
    if (self.mIsImgBg) then
        self.mImgSwitch:SetImg(UrlManager:getPackPath("updateRes/update_res_7.png"), true)
    else
        self.mImgSwitch:SetImg(UrlManager:getPackPath("updateRes/update_res_6.png"), true)
    end
    StorageUtil:saveBool0('IsUpdateResImgBg', isImgVideo)
    if(self.mIsImgBg ~= (BoardShower:getBoardState() == BoardShower.BoardState.ImgBg))then
        BoardShower:onClickSwitchModeHandler()
    end
end

function __onClickBgAudioHandler(self)
    self:__updateBgAudioState(not self.mIsAudioMute)
end

function __updateBgAudioState(self, isMute)
    self.mIsAudioMute = isMute
    if (self.mIsAudioMute) then
        self.mImgAudio:SetImg(UrlManager:getPackPath("updateRes/update_res_2.png"), true)
    else
        self.mImgAudio:SetImg(UrlManager:getPackPath("updateRes/update_res_3.png"), true)
    end
    StorageUtil:saveBool0('IsUpdateResAudioMute', isMute)
    BoardShower:updateBoard(isMute, nil, nil)
end

function __onClickCleanAssetsHandler(self)
    -- self.mIsOpenedTip = true
    -- download.ResDownLoadManager:cancelAllDownloadingAssets()
    -- updateRes.ShowAlert(updateRes.TipType.Normal, _TT(5), _TT(52)
    -- , "确认",
    -- function()
    --     local result = download.ResDownLoadManager:cancelAllDownloadingAssets()
    --     if (result) then
    --         self.mIsOpenedTip = false
    --         updateRes.UpdateResController:resetDownload()
    --         self:initProData()
    --         self:addPrepareProgressTimerHandler(gs.Application.targetFrameRate)
    --         download.ResDownLoadManager:cleanGameRes(function(cleanResult) download.ResDownLoadManager:start() end)
    --         -- CS.Lylibs.SDKManager.Ins:RestartApplication()
    --         -- CS.Lylibs.SDKManager.Ins:CloseApplication()
    --     else
    --         gs.Message.Show("正在整理中，请稍候再试")
    --     end
    -- end
    -- , _TT(2),
    -- function()
    --     self.mIsOpenedTip = false
    --     -- 此处在版本文件和资源配置文件下载完后,也就是开始下载后才允许继续下载(出现手机没网,下载不了版本文件和资源配置文件,点击清理资源后取消继续下载出现的一些逻辑问题)
    --     local nowState = download.ResDownLoadManager:getUpdateState()
    --     -- 可能一开始启动游戏就没网络没有数据，连cdn地址请求都还未执行
    --     if (nowState == nil) then
    --         CS.Lylibs.SDKManager.Ins:RestartApplication()
    --     elseif (nowState > download.ResState.CompareAssetVersion) then
    --         updateRes.UpdateResController:judgeDownload()
    --     end
    -- end)
    
    updateRes.ShowAlert(updateRes.TipType.Normal, _TT(5), "本操作会清除所有已下载资源，请重启游戏再次进行下载"
    , "确认",
    function()
        gs.AssetsUtils:AddCleanResSign(true, true)
        CS.UnityEngine.PlayerPrefs.Save()
        LoopManager:addTimer(1, 1, self, function()
            -- CS.Lylibs.SDKManager.Ins:RestartApplication()
            CS.Lylibs.SDKManager.Ins:CloseApplication()
        end)
        
        -- gs.ApplicationUtil.SetDebugVisible(true)
        -- Debug:setLogAllow(true)
        -- gs.ApplicationUtil.ShowDebugView()
    end
    , _TT(2),
    function()
    end
    )
end

function onCheckNetFrameHandler(self)
    -- if (not self.mIsOpenedTip) then
    --     local nowState = download.ResDownLoadManager:getUpdateState()
    --     -- 可能一开始启动游戏就没网络没有数据，连cdn地址请求都还未执行
    --     if (nowState and nowState > download.ResState.CompareAssetVersion and nowState < download.ResState.Finished) then
    --         local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
    --         if (not isHasNetWork and self.mIsHasNet) then
    --             local result = download.ResDownLoadManager:cancelAllDownloadingAssets()
    --             if (result) then
    --                 self.mIsHasNet = isHasNetWork
    --                 updateRes.ShowAlert(updateRes.TipType.Net, _TT(5), "当前网络不可用，请检查是否连接了可用的Wifi或移动网络"
    --                 , "确认",
    --                 function()
    --                     self.mIsHasNet = true
    --                     updateRes.UpdateResController:judgeDownload()
    --                 end, nil, nil)

    --                 self:updateView()
    --             end
    --         end
    --     end
    -- end
end

function onActionHandler(self)
    if (self:checkCircleVisible()) then
        self.mTransImgAct.gameObject:SetActive(true)
        if (not self.m_rotation) then
            self.m_rotation = 360
        else
            if (self.m_rotation <= 0) then
                self.m_rotation = 360 - 2
            else
                self.m_rotation = self.m_rotation - 4
            end
        end
        gs.TransQuick:SetRotation(self.mTransImgAct, 0, 0, self.m_rotation)
    end
end

function checkCircleVisible(self)
    if (self.mTxtPro) then
        if (self.mTxtPro.text == "") then
            self.mTransImgAct.gameObject:SetActive(false)
            return false
        else
            return true
        end
    else
        return false
    end
end

-- 速度更新
function onSpeedTimerHandler(self, args)
    local state = download.ResDownLoadManager:getUpdateState()
    local zipDownLoadState = download.ResDownLoadManager:getZipDownLoadState()
    if(zipDownLoadState == download.ZipState.Restore or zipDownLoadState == download.ZipState.Downloading or state == download.ResState.DownloadFiles or state == download.ResState.DownloadFilesMove or state == download.ResState.DownloadFilesSuc)then
        local downloadKbSize = download.ResDownLoadManager:getDownLoadKbSzie(true)
        if(downloadKbSize <= 0)then
            self:removeSpeedTimerHandler()
            self:updateSpeedView("0 KB/s")
        else
            local formatSize, unit = download.GetFormatSize(downloadKbSize)
            self:updateSpeedView(tostring(formatSize) .. " " .. unit .. "/s")
        end
    end
end

function updateSpeedView(self, speedStr)
    if(self.mShowProgress and self.mShowProgress >= 0.98 and speedStr == "0 KB/s")then
        -- 下到97、98会速度为0，暂时还无方案，特殊处理下
        speedStr = "整理中"
    end
    if(self.mTextSpeed.text ~= speedStr)then
        -- self.mTextSpeed.text = speedStr
        self.mTextSpeed.text = speedStr -- .. "，正在下载的线程数:" .. download.ResDownLoadManager:getRunThreadCount()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTextSpeed.gameObject:GetComponent(ty.RectTransform))
    end
end

-- 特殊更新Zip进度
function updateZipView(self, successCode, failCode, state, downloadedCount, totalCount, downloadedSize, totalSize)
    if(self:checkView() and download.ResDownLoadManager:getIsNeedCheckZip() and not successCode and not failCode)then
        self:removePrepareProgressTimerHandler()
        downloadedCount = math.max(0, downloadedCount or 0)
        totalCount = math.max(0, totalCount or 0)
        downloadedSize = math.max(0, downloadedSize or 0)
        totalSize = math.max(0, totalSize or 0)
        self.mZipSize = totalSize

        local downLoadModuleTypeList, totalNeedSize, matchSignModuleTypeList = download.ResDownLoadManager:getDownLoadModuleTypeList()
        local zipPro = math.min(1, downloadedSize / totalSize)
        self.mZipPro = (self.mAllPro - self.mPreparePro) * (totalSize / (totalSize + totalNeedSize)) * zipPro
        local showProgress = self.mPreparePro + self.mZipPro
        -- if ((not self.mSpeedTimerSn and self.mShowProgress <= 0) or self.mShowProgress <= showProgress) then
            self.mShowProgress = showProgress
            if(state == download.ZipState.Restore)then
                self.mTxtState.text = "正在校验进度中，请稍候"
            elseif(state == download.ZipState.Downloading)then
                self.mTxtState.text = "正在下载基础包"
            end
            local formatDownloadedSize, downloadedUnit = download.GetFormatSize(math.min(downloadedSize, totalSize))
            local formatTotalSize, totalUnit = download.GetFormatSize(totalSize + totalNeedSize)
            self.mTextSize.text = string.format("（%s）", tostring(formatDownloadedSize) .. downloadedUnit .. "/" .. tostring(formatTotalSize) .. totalUnit)
            self.mTxtPro.text = string.format("%.2f", self.mShowProgress * 100) .. "%"
            self:__updateTween(self.mShowProgress)
            if(math.ceil(self.mShowProgress * 100) == 50)then
                collectgarbage("collect")
            end
        -- end

        if(zipPro > 0 and zipPro < 1)then
            if(not self.mSpeedTimerSn)then
                local downloadKbSize = download.ResDownLoadManager:getDownLoadKbSzie(false)
                if(downloadKbSize > 0)then
                    self:onSpeedTimerHandler()
                    self:addSpeedTimerHandler()
                else
                    if(state == download.ZipState.Restore)then
                        self:updateSpeedView("")
                    elseif(state == download.ZipState.Downloading)then
                        self:updateSpeedView("0 KB/s")
                    end
                end
            end
        elseif(zipPro >= 1)then
            self:removeSpeedTimerHandler()
            self:updateSpeedView("")
            self.mTxtState.text = "正在解压资源包"
        end
    else
        if(successCode)then
            updateRes.UpdateResController:judgeDownload()
        elseif(failCode)then
            self.mIsOpenedTip = true

            local checkDownloadClean = function()
                local result = download.ResDownLoadManager:cancelAllDownloadingAssets()
                if(result)then
                    LoopManager:removeTimerByIndex(self.mCheckDownloadCleanSn)
                    self.mCheckDownloadCleanSn = nil

                    local function initZipDownManger()
                        download.ResDownLoadManager:initZipDownManger(function(resultCode)
                            if(resultCode == 0)then
                                updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", "网络下载出错请重新下载" .. "，提示码：" .. string.format("%s(%s)", updateRes.ErrorCode.ZipDownLoadError, tostring(failCode))
                                    ,"确认",
                                    function()
                                        self.mIsOpenedTip = false
                                        updateRes.UpdateResController:judgeDownload()
                                    end
                                    -- ,"退出",
                                    -- function()
                                    --     CS.Lylibs.SDKManager.Ins:CloseApplication()
                                    -- end
                                )
                            else
                                updateRes.ShowAlert(updateRes.TipType.Net, "更新提示", "网络下载出错请重新下载" .. "，提示码：" .. string.format("%s[%s]", updateRes.ErrorCode.ZipInitError, tostring(resultCode))
                                    ,"确认",
                                    function()
                                        initZipDownManger()
                                    end
                                    -- ,"退出",
                                    -- function()
                                    --     CS.Lylibs.SDKManager.Ins:CloseApplication()
                                    -- end
                                )
                            end
                        end)
                    end
                    initZipDownManger()
                end
            end
            if(self.mCheckDownloadCleanSn)then
                LoopManager:removeTimerByIndex(self.mCheckDownloadCleanSn)
            end
            self.mCheckDownloadCleanSn = LoopManager:addTimer(1, 0, self, checkDownloadClean)
        end
    end
end

-- 更新资源进度
function updateView(self)
    if(self:checkView())then
        local state = download.ResDownLoadManager:getUpdateState() or download.ResState.Init
        local tip = updateRes.UpdateResManager:getStateTip(state)
        local data = download.ResDownLoadManager:getUpdateData()
        if (state == download.ResState.Init) then
            self:addPrepareProgressTimerHandler()
            self:updateSpeedView("")
            self:updateClientVersion()
            self:updateServerVersion()
        elseif (state == download.ResState.ReadLocalVersion) then
            self:addPrepareProgressTimerHandler()
            self:updateClientVersion()
        elseif (state == download.ResState.ReadCdnVersion) then
            self:addPrepareProgressTimerHandler()
            self:updateServerVersion()
        elseif (state == download.ResState.CompareVersion) then
            self:addPrepareProgressTimerHandler()
        elseif (state == download.ResState.CompareAssetVersion) then
            self:addPrepareProgressTimerHandler()
        elseif (state == download.ResState.DownloadFiles and not download.ResDownLoadManager:getIsNeedCheckZip()) then
            self:removePrepareProgressTimerHandler()

            -- 下载文件回调的该moduleTypeList数组只有一个值
            local moduleType = data.moduleTypeList[1]
            local downloadedCount = data.downloadedCount
            local maxCount = data.maxCount
            local downloadedKbSize = math.max(0, data.downloadedKbSize)
            local maxKbSize = math.max(0, data.maxKbSize)
            
            local totalDownloadedSize = 0
            local moduleNeedSizeDic = download.ResDownLoadManager:getDownLoadModuleSizeDic()
            local downLoadModuleTypeList, totalNeedSize, matchSignModuleTypeList = download.ResDownLoadManager:getDownLoadModuleTypeList()
            -- 按照模块顺序遍历下来
            for index = 1, #downLoadModuleTypeList do
                local indexModuleType = downLoadModuleTypeList[index]
                if(indexModuleType == moduleType)then
                    -- 走到这里，说明当前的 moduleType 前面的 module 模块（包括当前的moduleType）的已经下载的总量已经统计好了，直接跳出循环
                    totalDownloadedSize = totalDownloadedSize + downloadedKbSize
                    break
                else
                    -- 走到这里，说明 moduleNeedSizeDic[indexModuleType] 已经下载好了，统计当前的 moduleType 前面的 module 模块（不包括当前的moduleType）的已经下载的总量
                    totalDownloadedSize = totalDownloadedSize + moduleNeedSizeDic[indexModuleType]
                end
            end
            if(totalDownloadedSize > 0)then
                local showProgress = math.min(self.mAllPro, self.mPreparePro + self.mZipPro + (self.mAllPro - self.mPreparePro - self.mZipPro) * (totalDownloadedSize / totalNeedSize))
                if (not self.mSpeedTimerSn or self.mShowProgress <= showProgress) then
                    self.mShowProgress = math.max(self.mShowProgress, showProgress)
                    self.mTxtState.text = tip .. download.GetModuleName(moduleType)
    
                    local formatDownloadedSize, downloadedUnit = download.GetFormatSize(math.min(self.mZipSize + totalDownloadedSize, self.mZipSize + totalNeedSize))
                    local formatTotalSize, totalUnit = download.GetFormatSize(self.mZipSize + totalNeedSize)
    
                    self.mTextSize.text = string.format("（%s）", tostring(formatDownloadedSize) .. downloadedUnit .. "/" .. tostring(formatTotalSize) .. totalUnit)
                    self.mTxtPro.text = string.format("%.2f", self.mShowProgress * 100) .. "%"
                    self:__updateTween(self.mShowProgress)
                    if(math.ceil(self.mShowProgress * 100) == 50)then
                        collectgarbage("collect")
                    end
                end
    
                if(self.mShowProgress > 0 and self.mShowProgress < self.mAllPro)then
                    if(not self.mSpeedTimerSn)then
                        local downloadKbSize = download.ResDownLoadManager:getDownLoadKbSzie(true)
                        if(downloadKbSize > 0)then
                            self:onSpeedTimerHandler()
                            self:addSpeedTimerHandler()
                        else
                            self:updateSpeedView("0 KB/s")
                        end
                    end
                elseif(self.mShowProgress >= self.mAllPro)then
                    self:removeSpeedTimerHandler()
                    self:updateSpeedView("")
                end
            else
                if(totalNeedSize <= 0)then
                    self.mShowProgress = self.mAllPro
                end
                self.mTxtState.text = string.format("正在校验 %s（%s个/%s个），请稍候", download.GetModuleName(moduleType), downloadedCount, maxCount)
                self.mTextSize.text = ""
                self.mTxtPro.text = ""
                self:removeSpeedTimerHandler()
                self:updateSpeedView("")
            end
        elseif (state == download.ResState.DownloadFilesMove and not download.ResDownLoadManager:getIsNeedCheckZip()) then
            if(self.mShowProgress >= self.mAllPro)then
                -- 移动文件回调的该moduleTypeList数组只有一个值
                local moduleType = data.moduleTypeList[1]
                self.mTxtState.text = string.format("正在整理 %s（%s个/%s个），请稍候", download.GetModuleName(moduleType), data.movedCount, data.moveTotalCount)
                self.mTextSize.text = ""
                self.mTxtPro.text = ""
            end
        elseif (state == download.ResState.DownloadFilesSuc and not download.ResDownLoadManager:getIsNeedCheckZip()) then
            if(self.mShowProgress >= self.mAllPro)then
                -- 移动文件回调的该moduleTypeList数组只有一个值
                local moduleType = data.moduleTypeList[1]
                self.mTxtState.text = string.format("成功整理 %s，请稍候", download.GetModuleName(moduleType))
                self.mTextSize.text = ""
                self.mTxtPro.text = ""
            end
        elseif (state == download.ResState.DownloadFilesFail and not download.ResDownLoadManager:getIsNeedCheckZip()) then
            self.mTxtState.text = tip
            self.mTextSize.text = ""
            self.mTxtPro.text = ""
            self:updateSpeedView("")
        elseif (state == download.ResState.SaveVersion and not download.ResDownLoadManager:getIsNeedCheckZip()) then
            self.mTxtState.text = tip
            self.mTextSize.text = ""
            self.mTxtPro.text = ""
            self:updateSpeedView("")
        elseif (state == download.ResState.Finished and not download.ResDownLoadManager:getIsNeedCheckZip()) then
            self.mTxtState.text = tip
            self.mTextSize.text = ""
            self.mTxtPro.text = ""
            self:updateSpeedView("")
            self:__updateTween(self.mShowProgress)

            -- if(updateRes.UpdateResManager:getIsNeedRestart())then
            --     updateRes.ShowAlert("更新提示", "本次更新需要重启游戏"
            --         ,"确认",
            --         function()
            --             CS.Lylibs.SDKManager.Ins:RestartApplication()
            --         end
            --         -- ,"退出",
            --         -- function()
            --         --     CS.Lylibs.SDKManager.Ins:CloseApplication()
            --         -- end
            -- 	)
            -- else
            print(updateRes.UpdateResManager:getStateTip())
            web.WebController:reqReportStep(web.REPORT_STEP.UPDATE_MODULE_FINISH)
            web.WebManager:dispatchEvent(web.WebManager.MODULE_UPDATE_CHECK_FINISH, {})
            -- end
        end
    end
end

function checkView(self)
    if self.UIObject then
        local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
        if (isHasNetWork) then
            return true
        else
            self.mTxtState.text = "等待网络连接中......"
            self.mTextSize.text = ""
            self.mTxtPro.text = ""
            self:removeSpeedTimerHandler()
            self:updateSpeedView("")
            self:__updateTween(self.mShowProgress)
        end
        self:checkCircleVisible()
    end
    return false
end

function onPrepareProgressFrameHandler(self)
    local state = download.ResDownLoadManager:getUpdateState() or download.ResState.Init
    if(state ~= nil and state <= download.ResState.CompareAssetVersion)then
        if(self.mPreparePro < self.mMaxPreparePro)then
            self.mPreparePro = self.mPreparePro + 0.0001
            local tip = updateRes.UpdateResManager:getStateTip(state)
            self.mTxtState.text = tip
            self.mTextSize.text = ""
            self.mTxtPro.text = string.format("%.2f", self.mPreparePro * 100) .. "%"
            self:__updateTween(self.mPreparePro)
        end
    end
end

-- 更新显示客户端版本号
function updateClientVersion(self)
    local version = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.VersionKey)
    local versionStr = download.ResDownLoadManager:getVersionStr(version)
    local prefixVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.PrefixVersionKey)
    local proVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.ProVersionKey)
    local artVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.ArtVersionKey)
    if (version ~= "" and proVersion ~= "" and artVersion ~= "") then
        self.mTxtClientVersion.text = web.getFormatVersion(prefixVersion, versionStr, proVersion, artVersion)
        self.mTxtClientVersion.gameObject:SetActive(true)
    else
        self.mTxtClientVersion.text = "";
        self.mTxtClientVersion.gameObject:SetActive(false)
    end
end

-- 更新显示服务端版本号
function updateServerVersion(self)
    local serverVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.VersionKey)
    local serverVersionStr = download.ResDownLoadManager:getVersionStr(serverVersion)
    local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
    local serverProVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.ProVersionKey)
    local serverArtVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.ArtVersionKey)
    if (serverVersion ~= "" and serverProVersion ~= "" and serverArtVersion ~= "") then
        self.mTxtServerVersion.text = web.getFormatVersion(prefixVersion, serverVersionStr, serverProVersion, serverArtVersion)
        self.mTxtServerVersion.gameObject:SetActive(true)
    else
        self.mTxtServerVersion.text = ""
        self.mTxtServerVersion.gameObject:SetActive(false)
    end
end

function __updateTween(self, cusProgress)
    self.mImgProBar.fillAmount = cusProgress
end

function __onModuleRequireFinishHandler(self, args)
    local showProgress = self.mPreparePro + (self.mMaxCodePro - self.mPreparePro) * args
    if (self.mShowProgress <= showProgress) then
        self.mShowProgress = showProgress
        local tip = updateRes.UpdateResManager:getStateTip()
        self.mTxtState.text = tip
        self.mTxtPro.text = string.format("%.2f", self.mShowProgress * 100) .. "%"
        self:__updateTween(self.mShowProgress)
    end
end

-- 当热更完毕后，底部的进度条等待 所有功能模块加载完毕后再隐藏
function __onAllModuleRequireFinishHandler(self, args)
    self.mGroupAdapt:SetActive(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(52):	"将清除所有资源并重新下载"
	语言包: _TT(2):	"取消"
]]