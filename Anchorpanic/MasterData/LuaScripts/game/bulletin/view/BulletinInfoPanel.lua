--[[ 
-----------------------------------------------------
@filename       : BulletinInfoPanel
@Description    : 游戏内公告
@date           : 2023-4-09 11:07:05
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.bulletin.view.BulletinInfoPanel', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bulletin/BulletinInfoPanel.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mCurBulletinId = nil
    self.mCurType = nil
    self.mCurLinkCode = 0
end
--析构  
function dtor(self)
end

-- 初始化
function configUI(self)
    self.mViewport = self:getChildGO("mViewport")
    self.mContent = self:getChildTrans("Content")
    self.mImgBanner = self:getChildGO("mImgBanner")
    self.mTabBarNode = self:getChildTrans("mTabBarNode")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.ScrollRect)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.TMP_Text)
    self.mTxtContentLink = self:getChildGO("mTxtContent"):GetComponent(ty.TextMeshProLink)
    self.mTxtContentLink:SetEventCall(function(position, localPosition, linkIdStr, linkTextStr) 
        notice.HrefUtil.commonNoticeDesLinkData(position, localPosition, linkIdStr, linkTextStr, self.mCurBulletinId)
    end)
    self.mVerticalGroup = self:getChildGO("mScroller"):GetComponent(ty.VerticalLayoutGroup)
end

function initViewText(self)
end

--激活
function active(self, args)
    super.active(self, args)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateModuleReadHandler, self)
    bulletin.BulletinManager:addEventListener(bulletin.BulletinManager.EVENT_BULLETIN_UPDATE, self.onUpdateBulletinDataHandler, self)
    if args and args.bulletinId then
        self.isLink = true
        self.mCurBulletinId = args.bulletinId
    end
    self.mCurType = args.type
    if (self.mBulletinTabBar) then
        self.mBulletinTabBar:reset()
        self.mBulletinTabBar = nil
    end
    gs.TransQuick:UIPosY(self.mTabBarNode, 0)
    self:onUpdateBulletinTab()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateModuleReadHandler, self)
    bulletin.BulletinManager:removeEventListener(bulletin.BulletinManager.EVENT_BULLETIN_UPDATE, self.onUpdateBulletinDataHandler, self)
    if self.mBulletinTabBar then
        self.mBulletinTabBar:reset()
        self.mBulletinTabBar = nil
    end
    self.mCurBulletinId = nil
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mImgBanner, self.onClickTurnHandelr)
end

function onClickTabHandler(self)
    self.mCurBulletinId = self.mBulletinTabBar.curSelectPage
    self:showContent()
end

function onClickTurnHandelr(self)
    if self.mCurLinkCode > 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.mCurLinkCode })
        bulletin.BulletinManager:dispatchEvent(bulletin.BulletinManager.EVENT_BULLETIN_PANEL_CLOSE)
    end
end

-- function onUpdateBubbleHandler(self, args)
--     if (args) then
--         if (args.type == ReadConst.SYSTEM_BULLETIN) then
--             self:onUpdateBulletinTab()
--         end
--     else
--         self:onUpdateBulletinTab()
--     end
-- end

function onUpdateModuleReadHandler(self, args)
    self:updateReadRed()
end

function onUpdateBulletinDataHandler(self, args)
    if not self.isLink then
        self.mCurBulletinId = nil
    else
        self.isLink = false
    end
    self:onUpdateBulletinTab()
end

-- 更新公告
function onUpdateBulletinTab(self)
    if (self.mBulletinTabBar) then
        self.mBulletinTabBar:reset()
        self.mCurLinkCode = 0
    end
    local tablist = {}
    local list = bulletin.BulletinManager:getBulletinDataByType(self.mCurType)
    if (#list > 0) then
        for i, bulletinVo in ipairs(list) do
            table.insert(tablist, { page = bulletinVo.id, nomalLan = bulletinVo.name, nomalLanEn = "" })
        end
    end
    if (self.mCurBulletinId == nil) then
        self.mCurBulletinId = list[1].id
    end
    self.mBulletinTabBar = CustomTabBar:create(self:getChildGO("mTabItem"), self.mTabBarNode, self.onClickTabHandler, self)
    self.mBulletinTabBar:setData(tablist)
    self.mBulletinTabBar:setPage(self.mCurBulletinId)
    self:updateReadRed()
    --self.mBulletinTabBar:setIsRepeatTrigger(false)
end

function updateReadRed(self)
    local list = bulletin.BulletinManager:getBulletinDataByType(self.mCurType)
    if self.mCurType ~= bulletin.BulletinConst.BULLETIN_SYSTEM then
        for i, bulletinVo in ipairs(list) do
            if (read.ReadManager:isModuleRead(ReadConst.SYSTEM_BULLETIN, bulletinVo.id)) then
                self.mBulletinTabBar:removeBubble(bulletinVo.id)
            else
                self.mBulletinTabBar:addBubble(bulletinVo.id, 97, 18)
            end
        end
    end
end

-- 显示内容
function showContent(self)
    local bulletinVo = bulletin.BulletinManager:getBulletinVoById(self.mCurBulletinId)
    if (bulletinVo) then
        self.mCurLinkCode = bulletinVo.uicode
        self.mScroller.verticalNormalizedPosition = 1
        gs.TransQuick:SizeDelta02(self.mViewport.transform, 285.4)
        self.mVerticalGroup.childControlHeight = (bulletinVo.pic == "") and true or false
        self.mViewport:SetActive(bulletinVo.content ~= "")
        self.mTxtTitle.text = bulletinVo.title
        self.mTxtContent.text = gs.StringUtil.HtmlDecode(bulletinVo.content)
        if bulletinVo.pic == "" then
            self.mImgBanner:SetActive(false)
        else
            self.mImgBanner:SetActive(true)
            if (string.starts(bulletinVo.pic, "http")) then
                self.mImgBanner:GetComponent(ty.AutoRefRawImage):SetImgWebKey(bulletinVo.pic, true)
            else
                -- if bulletinVo.pic == "1009" then
                --     gs.TransQuick:SizeDelta01(self.mImgBanner:GetComponent(ty.RectTransform) ,830)
                --     gs.TransQuick:SizeDelta02(self.mImgBanner:GetComponent(ty.RectTransform) ,530)
                --     self.mImgBanner:GetComponent(ty.AutoRefRawImage):SetImg(UrlManager:getBgPath("bulletin/" .. string.format("bulletin_banner_1009.jpg", bulletinVo.pic)), false)
                -- else
                    self.mImgBanner:GetComponent(ty.AutoRefRawImage):SetImg(UrlManager:getBgPath("bulletin/" .. string.format("bulletin_banner_%s.jpg", bulletinVo.pic)), true)
                --end
            end
        end
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mScroller"))--立即刷新
        if (not read.ReadManager:isModuleRead(ReadConst.SYSTEM_BULLETIN, bulletinVo.id)) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.SYSTEM_BULLETIN, id = bulletinVo.id })
        end
    end
end

function removeList(self)

end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]