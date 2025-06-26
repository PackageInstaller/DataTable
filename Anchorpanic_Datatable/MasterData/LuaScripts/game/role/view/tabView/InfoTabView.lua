module("role.InfoTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("role/tab/RoleInfoTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
end

function active(self)
    super.active(self)

    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
end

-- UI事件管理
function addAllUIEvent(self)

end

-- 点击复制ID
function __onClickCopyIDHandler(self, args)

end

-- 点击修改名字
function __onClickModifyNameHandler(self, args)
    --GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_MODIFY_NAME_PANEL, {})
end

-- 点击修改称号
function __onClickModifyTitleHandler(self, args)
    --GameDispatcher:dispatchEvent(EventName.OPEN_DECORATE_PANEL, { type = decorate.TabType.TITLE })
end

-- 点击修改签名
function __onClickModifyAutographHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_MODIFY_AUTOGRAPH_PANEL, {})
end

-- 点击打开预览界面
function __onOpenPreviewHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_PREVIEW_PANEL, {})
end

-- 打开修改头像面板
function __onClickHeadHandler(self, args)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_DECORATE_PANEL, {type = decorate.TabType.HEAD})
end

-- 更新名字
function __onUpdateNameHandler(self)
    local roleVo = role.RoleManager:getRoleVo()
    self.mTxtName.text = roleVo:getPlayerName()
end

-- 更新个性签名
function __onUpdateAutographHandler(self)
    local roleVo = role.RoleManager:getRoleVo()
    if roleVo:getAutograph() == "" then
        self.mTxtAutograph.text = _TT(520)
    else
        self.mTxtAutograph.text = roleVo:getAutograph()
    end
end

-- 更新称号
function __onUpdateTitleHandler(self)
    local roleVo = role.RoleManager:getRoleVo()
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(roleVo:getTitleId())
    if (titleDataRo) then
        self.mImgTitleGo:SetActive(true)
        self.mImgTitle:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitleGo:SetActive(false)
    end
end

-- 更新头像和头像框
function __onUpdateHeadHandler(self)
    local roleVo = role.RoleManager:getRoleVo()
    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.m_playerHeadGrid:setData(roleVo:getAvatarId())
    self.m_playerHeadGrid:setHeadFrame(roleVo:getAvatarFrameId())
    self.m_playerHeadGrid:setParent(self.mHeadNode)
    self.m_playerHeadGrid:setScale(0.85)
    self.m_playerHeadGrid:setCallBack(self, self.__onClickHeadHandler)
end

-- 更新进度条
function __onUpdateProgreassBarhHandler(self)
    local roleVo = role.RoleManager:getRoleVo()
    self.mProgressBar:SetValue(roleVo:getPlayerExp(), roleVo:getPlayerMaxExp(), true)
    self.mTxtLvl.text = roleVo:getPlayerLvl()
end

function __resetShowList(self)
    if (table.empty(self.m_headDic)) then
        self.m_headDic = {}
        for pos = 1, role.RoleManager.heroShowNum do
            local item = role.RoleShowHeroItem.new()
            item:setBaseData(pos, false, self, self.__onClickShowGridHandler, item)
            item:setParentTrans(self:getChildTrans("mHeroList"))
            item:resetState()
            self.m_headDic[pos] = item
        end
    else
        for pos, item in pairs(self.m_headDic) do
            item:resetState()
        end
    end
end

-- 更新英雄展示格子
function __onUpdateShowHeroListHandler(self, args)
    self:__resetShowList()

    local showHeroList, showHeroPosDic, showHeroIdDic = role.RoleManager:getRoleVo():getShowHeroData()
    for i = 1, #showHeroList do
        local pos = showHeroList[i].pos
        local item = self.m_headDic[pos]
        local heroVo = hero.HeroManager:getHeroVo(showHeroList[i].heroId)
        item:setData(heroVo)
    end
end

-- 点击英雄展示空格子
function __onClickShowGridHandler(self, item)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_SELECT_HERO_PANEL, { pos = item:getPos(), heroId = item:getData() and item:getData().id or nil })
end

function updateView(self)
    local args = role.RoleManager:getPersonalInfoList()
    args.isShowFriend = false
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_VIEW, args)
end

function __updateHeadBubble(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
