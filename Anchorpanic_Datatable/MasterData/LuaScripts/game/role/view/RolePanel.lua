module("role.RolePanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("role/RolePanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShow3DBg = 1
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52011))
    -- self:setBg("common_bg_016.jpg", false)
    self:setUICode(LinkCode.HomePage)
end

-- 更新页签列表
function updateTabBar(self)
    super.updateTabBar(self)
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    return {}
end

function getTabDatas(self)
    self.tabDataList = {}
    for i = 1, #self.mTabDataList do
        local tabType = self.mTabDataList[i]
        table.insert(self.tabDataList, {
            type = tabType,
            content = {role.getPageName(tabType)},
            nomalIcon = role.getPageIcon(tabType),
            selectIcon = role.getPageIcon(tabType)
        })
    end
    return self.tabDataList
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mTabDataList = {}
    table.insert(self.mTabDataList, role.RoleInfoTab.RoleInfo)
    table.insert(self.mTabDataList, role.RoleInfoTab.QualitySetting)
    table.insert(self.mTabDataList, role.RoleInfoTab.SoundSetting)
    if (not GameManager:getIsInCommiting() and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_EXCHANGE_CODE, false)) then
        table.insert(self.mTabDataList, role.RoleInfoTab.ExchangeCodeTabView)
    end
    self.showTabType = 2
end

function configUI(self)
    super.configUI(self)
    self.mBtnLogOut = self:getChildGO("mBtnLogOut")
    self.mBtnQuit = self:getChildGO("mBtnQuit")
    self.mTabBarTrans = self:getChildTrans("mTabBarTrans")

    self.mTextPolicyAgreement = self:getChildGO("mTextPolicyAgreement"):GetComponent(ty.TMP_Text)
    self.mTextPolicyAgreementLink = self:getChildGO("mTextPolicyAgreement"):GetComponent(ty.TextMeshProLink)
    self.mTextPolicyAgreementLink:SetEventCall(self.commonUrlLinkData)
end

function active(self, args)
    super.active(self, args)
    self.tabBar:setType(args.type)
    self:updateBubble()
    MoneyManager:setMoneyTidList({})
    self:setTabBar2Parent(self.mTabBarTrans)
    self:onCloseBgViewHandler()
    GameDispatcher:addEventListener(EventName.CLOSE_PREVIEW_BG, self.onCloseBgViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOWROLE_BG_VIEW, self.onOpenBgViewHandler, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateInfoBubble, self)
    decorate.DecorateManager:addEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.updateInfoBubble, self)
    if role.RoleManager:getBgIsOpen() == true then
        self:onOpenBgViewHandler()
    end

    self.mBtnQuit:SetActive(web.WebManager.platform == web.DEVICE_TYPE.WINDOWS and not gs.Application.isEditor)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.CLOSE_PREVIEW_BG, self.onCloseBgViewHandler, self)
    GameDispatcher:removeEventListener(EventName.OPEN_SHOWROLE_BG_VIEW, self.onOpenBgViewHandler, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateInfoBubble, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    decorate.DecorateManager:removeEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.updateInfoBubble, self)

end

function initViewText(self)
    self:updateChannel()
    self.mTextPolicyAgreement.text = _TT(340)
end

function updateChannel(self)
    -- 用户中心按钮
    if (web.WebManager:isReleaseApp()) then
        if (sdk.SdkManager:hasUserCenter()) then
            self.mBtnLogOut:SetActive(true)
            local channelId, channelName = sdk.SdkManager:getChannelData()
            if(channelId == sdk.AndroidChannelId.QIANYOU)then
                self:setBtnLabel(self.mBtnLogOut, nil, "账号注销")
            else
                self:setBtnLabel(self.mBtnLogOut, nil, "用户中心")
            end
        else
            self.mBtnLogOut:SetActive(false)
        end
    else
        self.mBtnLogOut:SetActive(true)
        self:setBtnLabel(self.mBtnLogOut, nil, "账号登出")
    end

    -- 华为渠道再单独显示隐私政策
    if (web.WebManager:isReleaseApp()) then
        local channelId, channelName = sdk.SdkManager:getChannelData()
        if channelId == sdk.AndroidChannelId.HMS then
            self.mTextPolicyAgreement.gameObject:SetActive(true)
        else
            self.mTextPolicyAgreement.gameObject:SetActive(false)
        end
    else
        self.mTextPolicyAgreement.gameObject:SetActive(false)
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLogOut, self.__onClickLogOutHandler)
    self:addUIEvent(self.mBtnQuit, self.__onClickQuitHandler)
end

-- 点击退出账号
function __onClickLogOutHandler(self, args)
    if (web.WebManager:isReleaseApp()) then
        if (sdk.SdkManager:hasUserCenter()) then
            local channelId, channelName = sdk.SdkManager:getChannelData()
            if(channelId == sdk.AndroidChannelId.QIANYOU)then
                sdk.SdkManager:logout()
            else
                sdk.SdkManager:openSdkUserUI()
            end
            return
        end
    end
    UIFactory:alertMessge(_TT(75), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, {
            isCleanGameRes = false,
            isCleanServerInfo = false,
            isNeedLoginSdk = true,
            isNeedRunUpdate = false
        })
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

-- 退出游戏
function __onClickQuitHandler(self)
    UIFactory:alertMessge(_TT(74), true, function()
        CS.Lylibs.SDKManager.Ins:CloseApplication()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

function getTabClass(self)
    self.tabClassDic[role.RoleInfoTab.RoleInfo] = role.RoleInfoView
    self.tabClassDic[role.RoleInfoTab.QualitySetting] = systemSetting.QualitySettingTabView
    self.tabClassDic[role.RoleInfoTab.SoundSetting] = systemSetting.SoundSettingTabView
    self.tabClassDic[role.RoleInfoTab.OtherSetting] = systemSetting.OtherSettingTabView
    self.tabClassDic[role.RoleInfoTab.ExchangeCodeTabView] = role.ExchangeCodeTabView
    return self.tabClassDic
end

function updateBubble(self)
    self:updateInfoBubble()
end

function updateTabBar(self)

end

-- 父节点
function getTabViewParent(self)
    return self:getChildTrans("mTabViewTrans")
end

-- 主页红点
function updateInfoBubble(self)
    if decorate.DecorateManager:isBubble() == true or decorate.DecorateManager:updateBgReadRed() == true then
        self:addBubble(role.RoleInfoTab.RoleInfo)
    else
        self:removeBubble(role.RoleInfoTab.RoleInfo)
    end
end

-- 背景替换回调打开
function onOpenBgViewHandler(self)
    self.mTextPolicyAgreement.gameObject:SetActive(false)
    self.mBtnLogOut:SetActive(false)
    self.base_childGos["mGroupTop"]:SetActive(false)
    self:getChildGO("mTabBarTrans"):SetActive(false)
end
-- 背景替换关闭
function onCloseBgViewHandler(self)
    self:updateChannel()
    self.base_childGos["mGroupTop"]:SetActive(true)
    self:getChildGO("mTabBarTrans"):SetActive(true)
end

function commonUrlLinkData(position, localPosition, linkIdStr, linkTextStr)
    if linkIdStr and linkTextStr then
		linkIdStr = string.gsub(linkIdStr, "\'", "")
        sdk.SdkManager:openSDKUIBrowser(linkIdStr)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
