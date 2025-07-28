module("seabed.SeabedTopPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedTopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 3 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 3 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

function initData(self)
end

function getAdaptaTrans(self)
    return self:getChildTrans("adaptaContent")
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCoinCount = self:getChildGO("mTxtCoinCount"):GetComponent(ty.Text)
    self.mTxtRunPointCount = self:getChildGO("mTxtRunPointCount"):GetComponent(ty.Text)
end

function setActiveTopPanel(self, isActive)
    self.UIRootNode:SetParent(GameView.story, false)
    self:setAdapta()
    self.UIObject:SetActive(isActive)
end

function active(self)
    super.active(self)
    self.UIRootNode:SetParent(GameView.story, false)
    self:setAdapta()
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_TOP_PANEL, self.showPanel, self)
    self:showPanel()

end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_TOP_PANEL, self.showPanel, self)
    if self.mCoinSn then
        LoopManager:removeFrameByIndex(self.mCoinSn)
        self.mCoinSn = nil
    end
    if self.mRunSn then
        LoopManager:removeFrameByIndex(self.mRunSn)
        self.mRunSn = nil
    end
end

function showPanel(self)
    self.mTxtTitle.text = seabed.SeabedManager:getCurMapName()

    self.newRunPoint, self.newCoin = seabed.SeabedManager:getSeabedResource()
    if self.newRunPoint < 0 then
        seabed.SeabedManager:setNeedShowTips(true)
    end

    self.oldRunPoint,self.oldCoin = seabed.SeabedManager:getOldSeabedResource()

    self.mCoinAniTime = 0.5
    self.mRunPointAniTime = 0.5

    self.mCoinTime = 0
    self.mRunPointTime = 0

    if self.oldCoin ~= self.newCoin then
        self.mTxtCoinCount.color = self.oldCoin > self.newCoin and gs.ColorUtil.GetColor("fa3a2bff") or
                                       gs.ColorUtil.GetColor("18ec68ff")
        self.mCoinSn = LoopManager:addFrame(0, 0, self, self.loopAnimCoin)
    else
        self.mTxtCoinCount.text = self.newCoin
    end

    if self.oldRunPoint ~= self.newRunPoint then
        self.mTxtRunPointCount.color = self.oldRunPoint > self.newRunPoint and gs.ColorUtil.GetColor("fa3a2bff") or
                                           gs.ColorUtil.GetColor("18ec68ff")
        self.mRunSn = LoopManager:addFrame(0, 0, self, self.loopAnimRunPoint)
    else
        self.mTxtRunPointCount.text = self.newRunPoint
    end

end

function loopAnimCoin(self)
    self.mCoinTime = self.mCoinTime + gs.Time.deltaTime
    if self.mCoinTime <= self.mCoinAniTime then
        self.mTxtCoinCount.text = math.ceil(self.oldCoin + (self.newCoin - self.oldCoin) *
                                                (self.mCoinTime / self.mCoinAniTime))
    else
        self.mTxtCoinCount.text = self.newCoin
        if self.newCoin < 0 then
            self.mTxtCoinCount.color = gs.ColorUtil.GetColor("fa3a2bff")
        else
            self.mTxtCoinCount.color = gs.ColorUtil.GetColor("ffffffff")
        end
        if self.mCoinSn then
            LoopManager:removeFrameByIndex(self.mCoinSn)
            self.mCoinSn = nil
        end
    end
end

function loopAnimRunPoint(self)
    self.mRunPointTime = self.mRunPointTime + gs.Time.deltaTime
    if self.mRunPointTime <= self.mRunPointAniTime then
        self.mTxtRunPointCount.text = math.ceil(self.oldCoin + (self.newRunPoint - self.oldRunPoint) *
                                                    (self.mRunPointTime / self.mRunPointAniTime))
    else
        self.mTxtRunPointCount.text = self.newRunPoint
        if self.newRunPoint < 0 then
            self.mTxtRunPointCount.color = gs.ColorUtil.GetColor("fa3a2bff")
        else
            self.mTxtRunPointCount.color = gs.ColorUtil.GetColor("ffffffff")
        end
       
        if self.mRunSn then
            LoopManager:removeFrameByIndex(self.mRunSn)
            self.mRunSn = nil
        end
    end
end

return _M
