module("lib.mvc.View", Class.impl("lib.component.BaseContainer"))

panelName = "" -- 窗口唯一名(继承View.lua需显示赋值或调用构造函数super.ctor(self))
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelCloseTime = -1 --窗口关闭记录时间（n秒后自动销毁）
isPop = 0 --是否打开状态1 打开 0 关闭
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 --模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isAdapta = 1 --是否开启适配刘海
isShowMoneyBar = 0 -- 是否显示货币栏 1开启（仅2弹窗有效）
isAddMask = 1 --窗口模式下是否需要添加mask (1 添加 0 不添加)
isShow3DBg = 0 --是否使用3D背景（0不开启 1开启同时会禁止UI背景图）
isShowBlackBg = 1 --是否显示全屏纯黑防穿帮底图
escapeClose = 1 -- 是否能通过esc关闭窗口
isShowCloseAll = 1 --是否显示导航按钮

-- ui已被自动销毁
EVENT_VIEW_DESTROY = "EVENT_VIEW_DESTROY"
-- ui关闭
EVENT_CLOSE = "EVENT_CLOSE"

--构造函数
function ctor(self)
    if self.panelType == 1 and self.isScreensave == 1 then
        UIFactory:openScreenSaver()
    end
    super.ctor(self)
    self.panelName = self.__cname

end
--析构函数
function dtor(self)
end

-- 设置界面的所属ui code
function setUICode(self, uicode)
    super.setUICode(self, uicode)
end

-- 设置宽高
function setSize(self, w, h)
    self.gWidth = w
    self.gHeight = h

    self:drawPanel()
end

-- 设置2弹窗内容底图的距离
function setInnerOffset(self, top, bottom, left, right)
    self.mTop = top
    self.mBottom = bottom
    self.mLeft = left
    self.mRight = right

    self:drawPanel()
end

-- 设置文本标题
function setTxtTitle(self, title)
    if self.gTitleName ~= title then
        self.gTitleName = title
    end

    if self.base_childTrans and self.gTitleName ~= nil and self.gTitleName ~= "" then
        self.gTxtTitle = self.base_childTrans["gTxtTitle"]
        self.base_childGos["gTxtTitle"]:SetActive(true)
        self.base_childGos["mGroupTitle"]:SetActive(true)
        self.gTxtTitle:GetComponent(ty.Text).text = self.gTitleName
        -- self.gTxtTitle:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gTxtTitle.transform)
        if self.gBtnClose:GetComponent(ty.ContentSizeFitter) then
            --     self.gBtnClose:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
            gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gBtnClose.transform)
        end

    end
end
-- 设置图片标题
function setImgTitle(self, path)
    if self.gTitlePath ~= path then
        self.gTitlePath = path
    end

    if self.UIBase then
        self.gImgTitle = self.base_childGos["gImgTitle"]
        self.gImgTitle:GetComponent(ty.AutoRefImage):SetImg(self.gTitlePath)
    end
end

-- 设置窗口公共底板
function drawPanel(self)
    local parentTrans = self:getParentTrans()
    if self.panelType == 1 then
        self.UIBase = AssetLoader.GetGO(UrlManager:getUIPrefabPath("compent/BasePopPanel.prefab"), self)
        self:updateBgScale()
    elseif self.panelType == 2 then
        if not self.UIBase then
            self.UIBase = AssetLoader.GetGO(UrlManager:getUIPrefabPath("compent/BaseSubPopPanel.prefab"), self)
        end
    else
        return
    end

    self.UIBaseTrans = self.UIBase.transform
    -- if parentTrans then
    --     self.UIBaseTrans:SetParent(parentTrans, false)
    --     self.UIBaseTrans:SetSiblingIndex(0)
    --     -- gs.UIComponentProxy.SetSiblingIndex(0)
    -- end
    self:updateBaseChild()
    self:addOnParent()

    if self.base_childTrans then
        if self.panelType == 2 then
            self.gGroup = self.base_childTrans["gGroup"]
            self.ImgPreventClickCenter = self.base_childTrans["ImgPreventClickCenter"]
            -- 内底固定大小
            if self.gWidth ~= nil and self.gHeight ~= nil then
                gs.TransQuick:SizeDelta(self.gGroup, self.gWidth, self.gHeight)
                gs.TransQuick:SizeDelta(self.ImgPreventClickCenter, self.gWidth, self.gHeight)
            end
            -- 内底边距适应拉升
            if self.mBottom ~= nil and self.mTop ~= nil or self.mLeft ~= nil and self.mRight ~= nil then
                gs.TransQuick:Anchor(self.gGroup, 0, 0, 1, 1)
                gs.TransQuick:Offset(self.gGroup, self.mLeft or 0, self.mBottom, -(self.mRight or 0), -self.mTop)
                gs.TransQuick:Anchor(self.ImgPreventClickCenter, 0, 0, 1, 1)
                gs.TransQuick:Offset(self.ImgPreventClickCenter, self.mLeft or 300, self.mBottom, -(self.mRight or 300), -self.mTop)
            end

            self.gImgBg = self.base_childGos["gImgBg"]
            self:addOnClick(self.gImgBg, self.onClickClose, self:getCloseSoundPath())
        end

        self.gBtnClose = self.base_childGos["gBtnClose"]
        self:addOnClick(self.gBtnClose, self.onClickClose, self:getCloseSoundPath())

        self.gBtnCloseAll = self.base_childGos["gBtnCloseAll"]
        if self.isShowCloseAll == 1 then
            if self.gBtnCloseAll then
                self:addOnClick(self.gBtnCloseAll, self.openNavigationLink, self:getCloseSoundPath())
            end
        else
            self.gBtnCloseAll:SetActive(false)
        end

        if self.gTitlePath ~= nil then
            self:setImgTitle(self.gTitlePath)
        elseif self.gTitleName ~= nil and self.gTitleName ~= "" then
            self:setTxtTitle(self.gTitleName)
        else
            self.base_childGos["gTxtTitle"]:SetActive(false)
            self.base_childGos["mGroupTitle"]:SetActive(false)
        end
    end
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = systemSetting.SystemSettingManager:getNotchH()
    if notchHeight ~= nil and self:getAdaptaTrans() then
        local minV = self:getAdaptaTrans().offsetMin;
        minV.x = notchHeight;
        self:getAdaptaTrans().offsetMin = minV;

        local maxV = self:getAdaptaTrans().offsetMax;
        maxV.x = -notchHeight;
        self:getAdaptaTrans().offsetMax = maxV;
    end
end

function getAdaptaTrans(self)
    if self.base_childTrans and self.base_childTrans["gGroup"] then
        return self.base_childTrans["gGroup"]
    end
    return self.UITrans
end

-- 设置页面背景图
function setBg(self, cusBgName, isNativeSize, cusDir)
    self:updateBaseChild()
    if (not self.gImgBg) then
        self.gImgBg = self.base_childGos["gImgBg"]
    end
    self.mBgName = cusBgName
    if cusBgName == '' or self.isShow3DBg == 1 then
        -- 显示3D背景，禁止UI背景
        self.gImgBg.gameObject:SetActive(false)

        if self.isShowBlackBg == 1 and self.isShow3DBg ~= 1 then
            self.base_childGos["mImgBlack"]:SetActive(true)
        else
            self.base_childGos["mImgBlack"]:SetActive(false)
        end
    else
        cusDir = cusDir and cusDir .. "/" or "common/"
        local path = UrlManager:getBgPath(cusDir .. cusBgName)
        self.gImgBg:GetComponent(ty.AutoRefImage):SetImg(path, false)
        self.gImgBg.gameObject:SetActive(true)
        self.base_childGos["mImgBlack"]:SetActive(true)

    end
    self:updateBgEff()
end

-- 获取页面背景图
function getBg(self)
    if (not self.gImgBg) then
        self.gImgBg = self.base_childGos["gImgBg"]
    end
    return self.gImgBg:GetComponent(ty.AutoRefImage):GetImgKey()
end

-- 设置背景特效
function updateBgEff(self)
    if self.m_uiCodeData and self.m_uiCodeData.uiEffect and #self.m_uiCodeData.uiEffect > 0 then
        self:addEffect(self.m_uiCodeData.uiEffect, self.gImgBg.transform)
    elseif self.mBgName and self.mBgName == "common_bg_003.jpg" then
        -- self:addEffect("fx_ui_common_beijing_003", self.gImgBg.transform)
    end
end

function updateBgScale(self)
    self:updateBaseChild()
    local imgBgRect = self.base_childTrans["gImgBg"]:GetComponent(ty.RectTransform)
    local scale = ScreenUtil:getScale()
    gs.TransQuick:Scale(imgBgRect, scale, scale, 1)
end

function updateBaseChild(self)
    if (self.UIBase and not self.base_childGos and not self.base_childTrans) then
        self.base_childGos, self.base_childTrans = GoUtil.GetChildHash(self.UIBase)
    end
end

function setPrevent(self, isPrevent)
    self.base_childTrans["GroupPreventClick_1"].gameObject:SetActive(isPrevent)
    self.base_childTrans["GroupPreventClick_2"].gameObject:SetActive(isPrevent)
end

--初始化UI
function configUI(self)
end

-- 内部激活，请勿使用
function __active(self, args)
    self:__playOpenAction()
    self:setMoneyBar()
    super.__active(self, args)
    self:initViewText()
    self:addAllUIEvent()
    self:updateBgEff()
    -- self:regGuide()
end

-- 内部非激活，请勿使用
function __deActive(self)
    self:recoverMoneyBar()
    self:removeAllUIEvent()
    super.__deActive(self)
end

--激活
function active(self)
end

--非激活
function deActive(self)
end

function getCloseSoundPath(self)
    -- if (self.panelType and self.panelType ~= 1) then
    return UrlManager:getUIBaseSoundPath("ui_basic_close.prefab")
    -- else
    --     return nil
    -- end
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_basic_popup.prefab")
end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self, args, cusSiblingIndex)
    self.tempArgs = args
    local parentTrans = self:getParentTrans()
    if not parentTrans then
        return
    end
    self:createUIRootNode()

    self.UIRootNode:SetParent(parentTrans, false)

    if self.UITrans and not self.base_childTrans then
        self.UITrans:SetParent(self.UIRootNode, false)
    end

    if self.UIBaseTrans then
        self.UIBaseTrans:SetParent(self.UIRootNode, false)
    end

    if self.UITrans and self.base_childTrans then
        self.UITrans:SetParent(self.base_childTrans["mUINode"], false)
    end

    if self.isBlur == 1 and self.panelType ~= 1 then
        self:setBlur()
    end

    if self.panelType ~= 1 and self.isAddMask == 1 and self.panelType ~= 3 then
        self:setMask()
    end
    self:__updateSiblingIndex()

    if self.isPop == 1 then
        if self.panelType == 1 and self.isAdapta == 1 then
            GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
            self:setAdapta()
        end

        self:__active(self.tempArgs)
        self:showScreensaver()
        self.tempArgs = nil

    end
end

function createUIRootNode(self)
    if self.UIRootNode then
        return
    end
    local nodeGo = gs.GameObject(self._NAME)
    self.UIRootNode = nodeGo:AddComponent(ty.RectTransform)
    gs.TransQuick:Anchor(self.UIRootNode, 0, 0, 1, 1)
    gs.TransQuick:Offset(self.UIRootNode, 0, 0, 0, 0)
    gs.TransQuick:LPosZ(self.UIRootNode, 0)
    self.UIRootNode.gameObject.layer = gs.LayerMask.NameToLayer("UI");
end

-- 设置UI节点
function getParentTrans(self)
    return GameView.UINode[self:getUiNodeName()]
end

-- 设置ui节点名称（ui通过节点名拿ui节点）
-- SCENE,MAIN_UI,POP,SUB_POP,GUIDE,LOADING,ALERT,MSG
function getUiNodeName(self)
    if self.panelType ~= 1 then
        return "SUB_POP"
    end
    return "POP"
end

-- 设置全屏透明遮罩
function setMask(self)
    if not self.mask then
        self.mask = AssetLoader.GetGO(UrlManager:getPrefabPath('base/MaskLayer.prefab'))
        if not self.UIRootNode then
            self:createUIRootNode()
        end
        self.mask.transform:SetParent(self.UIRootNode, false)
        self:addOnClick(self.mask, self.onClickClose, self:getCloseSoundPath())
    end
    self:__updateSiblingIndex()
end

-- 设置模糊背景
function setBlur(self)
    if not self.mBlurMask then
        self.mBlurMask = AssetLoader.GetGO(UrlManager:getUIPrefabPath('compent/BaseBlurMask.prefab'))
        if not self.UIRootNode then
            self:createUIRootNode()
        end
        self.mBlurMask.transform:SetParent(self.UIRootNode, false)
    end
    self:__updateSiblingIndex()

end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

-- 为组件加入侦听点击事件
function addUIEvent(self, obj, callBack, soundPath, ...)
    self:addOnClick(obj, callBack, soundPath, ...)

    self.uiEventList = self.uiEventList or {}
    table.insert(self.uiEventList, obj)
end

-- 移除一个页面组件监听
function removeUIEvent(self, obj)
    self:removeOnClick(obj)
    table.removebyvalue(self.uiEventList, obj)
end

-- 移除所有页面组件点击侦听
function removeAllUIEvent(self)
    if self.uiEventList then
        for i = #self.uiEventList, 1, -1 do
            self:removeOnClick(self.uiEventList[i])
            table.remove(self.uiEventList, i)
        end
    end
end

-- 货币栏父节点
function getMoneyBarParent(self)
    if self.base_childTrans then
        return self.base_childTrans["MoneyBar"]
    end
    return nil
end

-- 设置货币栏
function setMoneyBar(self)
    if self:getMoneyBarParent() and (self.panelType == 1 or (self.panelType ~= 1 and self.isShowMoneyBar == 1)) then
        if (not self.m_moneyBar) then
            self.m_moneyBar = MoneyBar.new()
        end
        if (self.m_moneyBar) then
            self.m_moneyBar:setData(self:getMoneyBarParent())
            self.m_moneyBar:active()
        end
    end
end

function recoverMoneyBar(self)
    if (self.m_moneyBar) then
        self.m_moneyBar:resetData()
        self.m_moneyBar:deActive()
    end
end

function __updateSiblingIndex(self)
    local totalCount = self.UIRootNode.childCount
    local curCount = 0
    if (self.mBlurMask) then
        curCount = curCount + 1
    end
    if (self.mask) then
        curCount = curCount + 1
    end
    if (self.UIBaseTrans) then
        curCount = curCount + 1
    end
    if (self.UITrans) then
        curCount = curCount + 1
    end
    local index = totalCount - curCount

    if (self.mBlurMask) then
        index = index + 1
        self.mBlurMask.transform:SetSiblingIndex(index)
    end
    if (self.mask) then
        index = index + 1
        self.mask.transform:SetSiblingIndex(index)
    end
    if (self.UIBaseTrans) then
        index = index + 1
        self.UIBaseTrans:SetSiblingIndex(index)
    end
    if (self.UITrans) then
        index = index + 1
        self.UITrans:SetSiblingIndex(index)
    end
end

function showScreensaver(self)
    if self.panelType == 1 and self.isScreensave == 1 then
        UIFactory:closeScreenSaver()
    end
end

--打开窗口
function open(self, args, isReshow)
    if self.isPop == 1 then
        return
    end
    self.isPop = 1

    -- 是否是恢复的打开（被前置窗口互斥后恢复）
    self.isReshow = isReshow

    local state = gs.PopPanelManager.Open(self, args, self._NAME)

    -- if self.panelType ~= 1 and self.isBlur == 1 and self:getUiNodeName() then
    --     gs.UIBlurManager.SetSuperBlur(true, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)
    -- end

    if self.UIObject then
        self:addOnParent(args)
    end
    GameDispatcher:dispatchEvent(EventName.EVENT_UI_OPEN, self)
    if (self.panelType and self.panelType ~= 1) then
        local OpenSoundPath = self:getOpenSoundPath()
        if not string.NullOrEmpty(OpenSoundPath) then
            AudioManager:playSoundEffect(OpenSoundPath)
        end
    end

    if self.isShow3DBg == 1 then
        Perset3dHandler:setupShowData(MainCityConst.UI_COMMON_3D_BG)
        self:setBg("")
    end

    if state == false then
        self:close()
    end
end

function __playOpenAction(self)
    if (self.panelType ~= 1) then
        local tweenTime = 0.3
        if (self.base_childGos and self.base_childGos["GameAction"]) then
            local canvasGroup = self.base_childGos["GameAction"]:GetComponent(ty.CanvasGroup)
            if (self.m_groupTweener) then
                self.m_groupTweener:Kill()
                self.m_groupTweener = nil
            end
            local _groupTweenFinishCall = function() end
            self.m_groupTweener = TweenFactory:canvasGroupAlphaTo(canvasGroup, 0, 1, tweenTime, nil, _groupTweenFinishCall)
            self.m_groupTweener:SetUpdate(true)

        elseif self.UIObject then
            local viewCanvasGroup = gs.GoUtil.AddComponent(self.UIObject, ty.CanvasGroup)
            if (self.m_viewTweener) then
                self.m_viewTweener:Kill()
                self.m_viewTweener = nil
            end
            local _viewTweenFinishCall = function() end
            self.m_viewTweener = TweenFactory:canvasGroupAlphaTo(viewCanvasGroup, 0, 1, tweenTime, nil, _viewTweenFinishCall)
            self.m_viewTweener:SetUpdate(true)
        end
    end
end

-- 窗口页面恢复（被前置窗口后置恢复）
function onViewReshow(self)

end

-- 设置背景陀螺仪晃动
function setGyroscopeWave(self, sensitivity)
    self.gyro = Gyro.new()
    self.gyro:attach(self.gImgBg, sensitivity, true)
end

-- 关闭背景陀螺仪晃动
function closeGyroscopeWave(self)
    if self.gyro then
        self.gyro:removeGyro()
        self.gyro = nil
    end
end

function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = 0.3
        -- gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)

        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end

        if (self.base_childGos and self.base_childGos["GameAction"]) then
            local canvasGroup = self.base_childGos["GameAction"]:GetComponent(ty.CanvasGroup)
            if (self.m_groupTweener) then
                self.m_groupTweener:Kill()
                self.m_groupTweener = nil
            end
            local _groupTweenFinishCall = function()
                if self.isPop == 1 then
                    self:close()
                end
            end
            self.m_groupTweener = TweenFactory:canvasGroupAlphaTo(canvasGroup, 1, 0, tweenTime, nil, _groupTweenFinishCall)
            self.m_groupTweener:SetUpdate(true)

        elseif self.UIObject then
            local viewCanvasGroup = gs.GoUtil.AddComponent(self.UIObject, ty.CanvasGroup)
            if (self.m_viewTweener) then
                self.m_viewTweener:Kill()
                self.m_viewTweener = nil
            end
            local _viewTweenFinishCall = function()
                if self.isPop == 1 then
                    self:close()
                end
            end
            self.m_viewTweener = TweenFactory:canvasGroupAlphaTo(viewCanvasGroup, 1, 0, tweenTime, nil, _viewTweenFinishCall)
            self.m_viewTweener:SetUpdate(true)
        end
    else
        if self.isPop == 1 then
            self:close()
        end
    end
end

-- 关闭窗口
function close(self)
    if self.isPop == 0 then
        gs.PopPanelManager.Close(self)
        return
    end
    self.isPop = 0
    self.isCloseing = false

    if self.UITrans then
        self.UITrans:SetParent(GameView.UICache, false)
    end
    if self.UIBaseTrans then
        self.UIBaseTrans:SetParent(GameView.UICache, false)
    end
    if self.UIRootNode then
        self.UIRootNode:SetParent(GameView.UICache, false)
    end
    if (self.mask) then
        self:removeOnClick(self.mask)
        gs.GameObject.Destroy(self.mask)
        self.mask = nil
    end

    if self.mBlurMask then
        gs.GameObject.Destroy(self.mBlurMask)
        self.mBlurMask = nil
    end

    if self.mNavigation then
        self.mNavigation:destroy()
        self.mNavigation = nil
    end
    ----------------该顺序不可变------------------
    -- 关闭UI的deactive先调用，再恢复其他UI（active）
    self:__deActive()
    gs.PopPanelManager.Close(self)
    ----------------该顺序不可变------------------
    -- 模糊节点变更
    -- if self.panelType ~= 1 and self.isBlur == 1 and self:getUiNodeName() then
    --     gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)
    -- end

    -- UI被完全关闭
    self:dispatchEvent(EVENT_CLOSE)
    GameDispatcher:dispatchEvent(EventName.EVENT_UI_CLOSE, self)

    if self.isShow3DBg == 1 then
        Perset3dHandler:toNormalShowData()
    end

end

-- 打开导航栏
function openNavigationLink(self)
    if not self.mNavigation then
        self.mNavigation = link.NavigationLink:new()
        self.mNavigation:setCloseAllCall(self.closeAll, self)
    end
    self.mNavigation:setParentTrans(self.base_childTrans["mGroupNavigation"], 0)
end

-- 关闭所有UI
function closeAll(self)
    note.NoteManager:setWillByCloseAll(true)
    gs.PopPanelManager.CloseAll()
end

-- 玩家点击关闭
function onClickClose(self)
    self:__closeOpenAction()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    if self.mNavigation then
        self.mNavigation:onCloseAllFinish()
    end

    self:close()
end

-- 修改激活参数，用于恢复窗口
function setActiveArgs(self, args)
    gs.PopPanelManager.SetActiveArgs(self.panelName, args)
end

-- 隐藏（关闭）本窗口，并强制下次关闭窗口时恢复（用于弹窗样式）（需要执行该隐藏，再打开新窗口，多层跳转顺序才正确）
function hideViewAndReshow(self)
    gs.PopPanelManager.HideOnePanel(self)
end

-- 销毁
function destroyPanel(self)
    self:destroy(true)

    if self.gBtnClose then
        self:removeOnClick(self.gBtnClose)
    end
    if self.isShowCloseAll == 1 then
        if self.gBtnCloseAll then
            self:removeOnClick(self.gBtnCloseAll)
        end
    end
    if self.gImgBg then
        self:removeOnClick(self.gImgBg)
    end
    if self.mask then
        gs.GameObject.Destroy(self.mask)
        self:removeOnClick(self.mask)
    end

    if (self.UIBase) then
        gs.GameObject.Destroy(self.UIBase)
        self.UIBase = nil
    end

    if self.UIRootNode then
        gs.GameObject.Destroy(self.UIRootNode.gameObject)
        self.UIRootNode = nil
    end

    self.UIBaseTrans = nil

    self.base_childGos = nil
    self.base_childTrans = nil

    self:dispatchEvent(EVENT_VIEW_DESTROY)

    --Debug:log_info("View", "destroy---------" .. self.__cname)
end

return _M
