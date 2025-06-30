--[[ 
-----------------------------------------------------
@filename       : PassiveSkillTips
@Description    : 被动技能tips
@date           : 2021-03-22 16:59:42
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("tips.PassiveSkillTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/PassiveSkillTips.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1023, 528)
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mTxtName = self:getChildGO('TextName'):GetComponent(ty.Text)
    self.m_textDes = self:getChildGO('TextDes'):GetComponent(ty.Text)
    self.m_textSkillDesLab = self:getChildGO('TextSkillDesLab'):GetComponent(ty.Text)
    self.m_imgTitle = self:getChildGO('ImgCurSkillTitle'):GetComponent(ty.AutoRefImage)

end

function active(self, args)
    super.active(self, args)
    self.m_skillIdList = args.skillIdList
    self.m_skillId = args.skillId
    self.m_heroVo = args.heroVo

    self:__updateView()
end

function initViewText(self)
    super.initViewText(self)
    self.m_textSkillDesLab.text = _TT(4064)
end

function __updateView(self)
    local skillVo = fight.SkillManager:getSkillRo(self.m_skillId)
    self.mTxtName.text = skillVo:getName()
    self.m_textDes.text = skillVo:getDesc()
    self.m_imgTitle:SetImg(UrlManager:getPackPath("alertView/tips_passive_skill_title_"..skillVo:getSubType()..".png"), true)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4064):	"技能简介"
]]
