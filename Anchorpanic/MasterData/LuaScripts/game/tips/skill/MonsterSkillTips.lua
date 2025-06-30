--[[ 
-----------------------------------------------------
@filename       : MonsterSkillTips
@Description    : 怪物技能tips
@date           : 2021-03-22 16:59:42
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("tips.MonsterSkillTips", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("tips/MonsterSkillTips.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    --self:setTxtTitle("<size=24>异</size>常环境")
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mTxtName = self:getChildGO('TextName'):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO('TextDes'):GetComponent(ty.Text)
    self.mTxtSkillDesLab = self:getChildGO('TextSkillDesLab'):GetComponent(ty.Text)
    self.mImgSkillIcon = self:getChildGO("mImgSkillIcon"):GetComponent(ty.AutoRefImage)

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
    self.mTxtSkillDesLab.text = _TT(4064)
end

function __updateView(self)
    local skillVo = fight.SkillManager:getSkillRo(self.m_skillId)
    self.mTxtName.text = skillVo:getName()
    self.mTxtDes.text = skillVo:getDesc()
    self.mImgSkillIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4064):	"技能简介"
]]