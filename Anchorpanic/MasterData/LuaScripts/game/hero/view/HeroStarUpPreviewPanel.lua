--[[   
     英雄进化预览界面
]]
module('hero.HeroStarUpPreviewPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroStarUpPreviewPanel.prefab')

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
    self.m_starItemList = nil
end

-- 初始化
function configUI(self)
	super.configUI(self)

	self.m_groupPreview = self:getChildGO('GroupPreview')
	self.m_groupPreviewFull = self:getChildGO('GroupPreviewFull')
	self.m_btnBack = self:getChildGO('BtnBack')
	
	self.m_textPreview = self:getChildGO("TextPreview"):GetComponent(ty.Text)
	self.m_textAttrTitle = self:getChildGO("TextAttrTitle"):GetComponent(ty.Text)

	self.m_textCurStarTitle = self:getChildGO("TextCurStarTitle"):GetComponent(ty.Text)
	self.m_curStarDic = {}
	self.m_curStarDic["TextStar"] = self:getChildGO("TextCurStar"):GetComponent(ty.Text)
	for i = 1, 6 do
		self.m_curStarDic["ImgStar_"..i] = self:getChildGO("ImgCurStar_"..i)
	end

	self.m_textNextStarTitle = self:getChildGO("TextNextStarTitle"):GetComponent(ty.Text)
	self.m_nextStarDic = {}
	self.m_nextStarDic["TextStar"] = self:getChildGO("TextNextStar"):GetComponent(ty.Text)
	for i = 1, 6 do
		self.m_nextStarDic["ImgStar_"..i] = self:getChildGO("ImgNextStar_"..i)
	end
	
	self.m_scrollerPreData = self:getChildTrans('Content')
	self.m_groupSkillFull = self:getChildTrans("GroupSkillFull")
	
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
	self.m_textPreview.text = _TT(1079)--"技能全览"
	self.m_textCurStarTitle.text = _TT(1042)--"进化"
	self.m_textNextStarTitle.text = _TT(1042)--"进化"
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
	
    if (self.m_starItemList) then
        for i = 1, #self.m_starItemList do
            local item = self.m_starItemList[i]
            item:poolRecover()
        end
    end
    self.m_starItemList = {}
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

	local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(self.m_heroVo.tid)
	if(self.m_heroVo.evolutionLvl >= maxStarLvl)then
		self.m_groupPreview:SetActive(false)
		self.m_groupPreviewFull:SetActive(true)
		self:__updatePrevewFullView()
	else
		self.m_groupPreview:SetActive(true)
		self.m_groupPreviewFull:SetActive(false)
		self:__updatePrevewView()
	end
end

function __updatePrevewView(self)
	-- 更新普通的属性展示
	local nextAttrDic = self.m_heroVo:getStarUpPreviewAttrDic()
	if(nextAttrDic)then
		local index = 0
		local len = #self.m_heroVo.attrList
		for i = 1, len do
			local attrVo = self.m_heroVo.attrList[i]
			if(nextAttrDic[attrVo.key] and attrVo.value ~= nextAttrDic[attrVo.key])then
				index = index + 1
				local item = hero.HeroStarUpListItem:poolGet()
				item:setData(attrVo, nextAttrDic, 3, index % 2 == 0, true)
				item:setParent(self.m_scrollerPreData)
				table.insert(self.m_itemList, item)
			end
		end
	end

	self:__updateStarView(self.m_heroVo.evolutionLvl, true)
	self:__updateStarView(self.m_heroVo.evolutionLvl + 1, false)
	self:__updateUnlockSkillView()
end

function __updatePrevewFullView(self)
	local curStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl)
	-- local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl + 1)
	-- 更新普通的属性展示
	local attrDic = self.m_heroVo.attrDic
	if(attrDic)then
		local index = 0
		local len = #curStarConfigVo.keyList
		for i = 1, len do
			local key = curStarConfigVo.keyList[i]
			if(attrDic[key])then
				index = index + 1
				local item = hero.HeroStarUpListItem:poolGet()
				item:setData({key = key, value = attrDic[key]}, attrDic, 4, index % 2 == 0, true)
				item:setParent(self.m_scrollerPreData)
				table.insert(self.m_itemList, item)
			end
		end
	end
	
    local starDic = hero.HeroStarManager:getHeroStarDic(self.m_heroVo.tid)
    for starLvl, vo in pairs(starDic) do
        local item = hero.HeroStarUpSkillItem:poolGet()
        item:setData(starLvl, self.m_heroVo.id, false)
        item:setParent(self.m_groupSkillFull)
        table.insert(self.m_starItemList, item)
    end
end

function __updateUnlockSkillView(self)
	local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl + 1)
	if(nextStarConfigVo)then
		if(nextStarConfigVo.passiveSkillId > 0)then
			local skillVo = fight.SkillManager:getSkillRo(nextStarConfigVo.passiveSkillId)
			if(skillVo)then
				self.m_groupSkill:SetActive(true)
				self.m_imgUnlockSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
				self.m_textSkillTypeName.text = fight.FightDef.GetSkillTypeName(skillVo:getType())
				self.m_textSkillName.text = skillVo:getName().._TT(1080)--"解锁"
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

function __updateStarView(self, star, isCur)
	local dic = isCur and self.m_curStarDic or self.m_nextStarDic
	dic["TextStar"].text = star
	for i = 1, 6 do
		if(i <= star)then
			dic["ImgStar_"..i]:SetActive(true)
		else
			dic["ImgStar_"..i]:SetActive(false)
		end
	end
end

-- 英雄预览属性更新
function __onHerPreviewAttrUpdateHandler(self, args)
	local previewType = args.previewType
	if(previewType == hero.PreviewAttrType.STAR_UP)then
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
	-- local curStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl)
	local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl + 1)
	if(nextStarConfigVo)then
		TipsFactory:skillTips(nil, nextStarConfigVo.passiveSkillId, self.m_heroVo)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
