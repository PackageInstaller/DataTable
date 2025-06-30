--[[   
     英雄军衔晋升预览界面
]]
module('hero.HeroMilitaryRankPreviewPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroMilitaryRankPreviewPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
	super.ctor(self)
    self:setSize(1169, 558)
	self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
	self.m_heroVo = nil
    self.m_itemList = nil
end

-- 初始化
function configUI(self)
	super.configUI(self)

	self.m_btnBack = self:getChildGO('BtnBack')
	
	self.m_textAttrTitle = self:getChildGO("TextAttrTitle"):GetComponent(ty.Text)
	self.m_textCurLvl = self:getChildGO("TextCurLvl"):GetComponent(ty.Text)
	self.m_textNextLvl = self:getChildGO("TextNextLvl"):GetComponent(ty.Text)
	self.m_textCurMilitary = self:getChildGO("TextCurMilitary"):GetComponent(ty.Text)
	self.m_textNextMilitary = self:getChildGO("TextNextMilitary"):GetComponent(ty.Text)
	self.m_imgCurIcon = self:getChildGO("ImgCurIcon"):GetComponent(ty.AutoRefImage)
	self.m_imgNextIcon = self:getChildGO("ImgNextIcon"):GetComponent(ty.AutoRefImage)
	
	self.m_scrollerPreData = self:getChildTrans('Content')
	
	self.m_groupSkill = self:getChildGO('GroupSkill')
	self.m_skillIcon = self:getChildGO('IconUnlockSkill')
	self.m_imgUnlockSkill = self.m_skillIcon:GetComponent(ty.AutoRefImage)
	self.m_textSkillTypeName = self:getChildGO("TextSkillTypeName"):GetComponent(ty.Text)
	self.m_textSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
	super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR, self.__onHerPreviewAttrUpdateHandler, self)
	self:setData(args)
end

-- 非激活
function deActive(self)
	super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR, self.__onHerPreviewAttrUpdateHandler, self)

	self:__recyShowHead()
	self:__recyAllItem()
end

function initViewText(self)
	self.m_textAttrTitle.text = _TT(1075)--"属性提升"
end

function addAllUIEvent(self)
	self:addUIEvent(self.m_btnBack, self.__onBtnBackHandler)
	self:addUIEvent(self.m_skillIcon, self.__onSkillTipHandler)
end

function __recyShowHead(self)
	if(self.m_heroCard)then
		self.m_heroCard:poolRecover()
		self.m_heroCard = nil
	end
end

function __recyAllItem(self)
    if (self.m_itemList) then
        for i = 1, #self.m_itemList do
            local item = self.m_itemList[i]
            item:poolRecover()
        end
    end
    self.m_itemList = {}
end

function setData(self, heroVo)
	self.m_heroVo = heroVo
	self:__updateView()
end

function __updateView(self)
	self:__recyShowHead()
	self:__recyAllItem()

	self.m_heroCard = hero.HeroCard:poolGet()
	self.m_heroCard:setData(self.m_heroVo)
	self.m_heroCard:setParent(self.UITrans)
	self.m_heroCard:setStarLvl(self.m_heroVo.evolutionLvl)
	self.m_heroCard:setPosition(gs.Vector3(-455, 15, 0))
	self.m_heroCard:setClickEnable(false)

    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
	local nextMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank + 1)
	-- -- 等级上限显示
	-- local lvlLimitItem = hero.HeroMilitaryRankListItem:poolGet()
	-- lvlLimitItem:setData(curMilitaryRankVo.heroMaxLvl, nextMilitaryRankVo.heroMaxLvl, 2, true)
	-- lvlLimitItem:setParent(self.m_scrollerPreData)
	-- table.insert(self.m_itemList, lvlLimitItem)

	-- -- 军衔名显示
	-- local nameItem = hero.HeroMilitaryRankListItem:poolGet()
	-- nameItem:setData(curMilitaryRankVo, nextMilitaryRankVo, 1, true)
	-- nameItem:setParent(self.m_scrollerPreData)
	-- table.insert(self.m_itemList, nameItem)
	
	-- 等级上限、军衔名显示
	self.m_textCurLvl.text = nextMilitaryRankVo.heroMaxLvl
	self.m_textNextLvl.text = _TT(1068).."+"..(nextMilitaryRankVo.heroMaxLvl - curMilitaryRankVo.heroMaxLvl)--"等级上限+{0}"
	self.m_textCurMilitary.text = curMilitaryRankVo:getName()
	self.m_textNextMilitary.text = nextMilitaryRankVo:getName()
	self.m_imgCurIcon:SetImg(UrlManager:getHeroMilitaryRankIconUrl(curMilitaryRankVo.lvl), false)
	self.m_imgNextIcon:SetImg(UrlManager:getHeroMilitaryRankIconUrl(nextMilitaryRankVo.lvl), false)
	
	-- 更新普通的属性展示
	local nextAttrDic = self.m_heroVo:getMilitaryRankPreviewAttrDic()
	if(nextAttrDic)then
		local index = 0
		local len = #self.m_heroVo.attrList
		for i = 1, len do
			local attrVo = self.m_heroVo.attrList[i]
			if(nextAttrDic[attrVo.key] and attrVo.value ~= nextAttrDic[attrVo.key])then
				index = index + 1
				local item = hero.HeroMilitaryRankListItem:poolGet()
				item:setData(attrVo, nextAttrDic, 3, index % 2 == 0, true)
				item:setParent(self.m_scrollerPreData)
				table.insert(self.m_itemList, item)
			end
		end
	end

	self:__updateUnlockSkillView()
end

function __updateUnlockSkillView(self)
	local nextMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank + 1)
	if(nextMilitaryRankVo)then
		if(nextMilitaryRankVo.unlockSkillId > 0)then
			local skillVo = fight.SkillManager:getSkillRo(nextMilitaryRankVo.unlockSkillId)
			if(skillVo)then
				self.m_groupSkill:SetActive(true)
				self.m_imgUnlockSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
				self.m_textSkillTypeName.text = fight.FightDef.GetSkillTypeName(skillVo:getType())
				self.m_textSkillName.text = skillVo:getName().._TT(1069)--"增强"
			else
				self.m_groupSkill:SetActive(false)
			end
		else
			self.m_groupSkill:SetActive(false)
		end
	else
		self.m_groupSkill:SetActive(false)
	end
end

-- 英雄预览属性更新
function __onHerPreviewAttrUpdateHandler(self, args)
	local previewType = args.previewType
	if(previewType == hero.PreviewAttrType.MILITARY_RANK)then
		local heroId = args.heroId
		if (self.m_heroVo.id == heroId) then
			self.m_heroVo = hero.HeroManager:getHeroVo(self.m_heroVo.id)
			self:setData(self.m_heroVo)
		end
	end
end

function __onBtnBackHandler(self)
	self:close()
end

function __onSkillTipHandler(self)
	local nextMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank + 1)
	if(nextMilitaryRankVo)then
		TipsFactory:skillTips(nil, nextMilitaryRankVo.unlockSkillId, self.m_heroVo)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
