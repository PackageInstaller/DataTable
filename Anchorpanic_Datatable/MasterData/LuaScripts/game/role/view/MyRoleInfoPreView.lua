module('role.MyRoleInfoPreView', Class.impl(role.OtherRoleInfoView))

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mGroupBtn:SetActive(false)
    self.m_btnModifyMark:SetActive(false)
end

--激活
function active(self, args)
    self:upateInfo()
end

--反激活（销毁工作）
function deActive(self)
    if self.m_playerHeadGrid then
        self.m_playerHeadGrid:poolRecover()
    end
end

-- UI事件管理
function addAllUIEvent(self)
end

-- 更新信息
function upateInfo(self)
    local roleVo = role.RoleManager:getRoleVo()

    self.mTxtName.text = roleVo:getPlayerName()

    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.m_playerHeadGrid:setData(roleVo:getAvatarId())
    self.m_playerHeadGrid:setHeadFrame(roleVo:getAvatarFrameId())
    self.m_playerHeadGrid:setParent(self.m_headNode)
    self.m_playerHeadGrid:setScale(1)
    -- self.m_playerHeadGrid:setLvl(roleVo:getPlayerLvl())
    self.m_playerHeadGrid:setLvl(nil)
    self.m_playerHeadGrid:setClickEnable(false)
    self.mMarksTxt.text = ""

    local signature = _TT(25101) --"这家伙很懒，什么都没留下"
    if(roleVo:getAutograph() == "") then
        self.m_textAutograph.text = ""
        self.mNoAutoTxt.gameObject:SetActive(true)
    else
        self.m_textAutograph.text = self.data.signature
        self.mNoAutoTxt.gameObject:SetActive(false)
    end
    --self.m_textAutograph.text = roleVo:getAutograph() == "" and signature or roleVo:getAutograph()
    
    self.m_textID.text = roleVo.showId
    self.m_textLvl.text = roleVo:getPlayerLvl()
    self.m_textHeroNum.text = #hero.HeroManager:getHeroList(false)
    self.m_textPowerNum.text = 0

    self:updateTitle()
    self:updateShowHeroList()
end

-- 更新称号
function updateTitle(self)
    local roleVo = role.RoleManager:getRoleVo()
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(roleVo:getTitleId())
    if (titleDataRo) then
        self.m_imgTitleGo:SetActive(true)
        self.m_imgTitle:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.m_imgTitleGo:SetActive(false)
    end
end

-- 更新英雄展示格子
function updateShowHeroList(self, args)
    self:__resetShowList()

    local showHeroList, showHeroPosDic, showHeroIdDic = role.RoleManager:getRoleVo():getShowHeroData()
    for i = 1, #showHeroList do
        local showHeroVo = showHeroList[i]
        local pos = showHeroVo.pos
        local heroVo = hero.HeroManager:getHeroVo(showHeroVo.heroId)
        local item = self.m_heroCardDic[pos]
        item:setData(heroVo)
    end
end

-- 点击英雄展示格子
function __onClickShowGridHandler(self, item)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
