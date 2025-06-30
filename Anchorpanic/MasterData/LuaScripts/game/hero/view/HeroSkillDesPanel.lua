module('hero.HeroSkillDesPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('hero/HeroSkillDesPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
	super.ctor(self)
	self:setSize(400, 300)
	self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
	self.m_skillVo = nil
	self.m_curHeroId = nil
end

function configUI(self)
	self.m_imgSkillIcon = self:getChildGO('ImgSkillIcon'):GetComponent(ty.AutoRefImage)
	self.m_imgCost = self:getChildGO('ImgCost'):GetComponent(ty.AutoRefImage)
	self.m_textCost = self:getChildGO('TextCost'):GetComponent(ty.Text)
	self.mTxtName = self:getChildGO('TextName'):GetComponent(ty.Text)

	self.m_textDes_1 = self:getChildGO('m_textDes_1'):GetComponent(ty.Text)
	self.m_textDes_2 = self:getChildGO('m_textDes_2'):GetComponent(ty.Text)
end

function active(self)
end

function deActive(self)
end

function setData(self, cusHeroId, cusSkillVo)
	self.m_curHeroId = cusHeroId
	self.m_skillVo = cusSkillVo
	self:__updateView()
end

function __updateView(self)
	self.m_imgSkillIcon:SetImg(self.m_skillVo:getIcon(), true)
	self.mTxtName.text = self.m_skillVo:getName()

	local skillType = self.m_skillVo:getType()
	if(skillType == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL or skillType == fight.FightDef.SKILL_TYPE_FINAL_SKILL)then
		self:getChildGO('ImgCost'):SetActive(true)
		self:getChildGO('TextCost'):SetActive(true)
		
		self.m_imgCost:SetImg("skill_cost_icon.png", false)
		self.m_textCost.text = self.m_skillVo:getCost()
	else
		self:getChildGO('ImgCost'):SetActive(false)
		self:getChildGO('TextCost'):SetActive(false)
	end

	self.m_textDes_1.text = HtmlUtil:colorAndSize(fight.FightDef.GetSkillTypeName(skillType), ColorUtil.RED_NUM, 30).."\n"..self.m_skillVo:getDesc()

    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
	local militaryRankConfigVo = hero.HeroMilitaryRankManager:getVoByHeroTidAndSkillId(heroVo.tid, self.m_skillVo:getRefID())
	if(militaryRankConfigVo)then
		self:getChildGO('m_element_2'):SetActive(true)

		local activeColor
		if(heroVo.militaryRank >= militaryRankConfigVo.lvl)then
			activeColor = ColorUtil.BLACK_NUM
		else
			activeColor = ColorUtil.GRAY_NUM
		end
		local strengthSkillVo = fight.SkillManager:getSkillRo(militaryRankConfigVo.unlockSkillId)
		self.m_textDes_2.text = HtmlUtil:size(_TT(1312, militaryRankConfigVo.name), 30).."\n"..HtmlUtil:color(strengthSkillVo:getDesc(), activeColor)
	else
		self:getChildGO('m_element_2'):SetActive(false)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
