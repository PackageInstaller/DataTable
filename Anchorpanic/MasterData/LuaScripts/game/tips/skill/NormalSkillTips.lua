--[[ 
-----------------------------------------------------
@filename       : NormalSkillTips
@Description    : 默认技能tips  普攻
@Author         : shenxintian
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module("tips.NormalSkillTips",Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/NormalSkillTips.prefab")

function ctor(self)
    super.ctor(self)
    self:setSize(1023, 570)
end

--初始化UI
function configUI(self)
    super.configUI(self)
    
    self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("TextDes"):GetComponent(ty.Text)

    self.mNextTxtDes = self:getChildGO("NextTextDes"):GetComponent(ty.Text)
    self.mMaxImg = self:getChildGO("MaxImg")

    self.mNextImgSkillDes = self:getChildGO("NextImgSkillDes")
    self.mSkillDesLab = self:getChildGO("TextSkillDesLab"):GetComponent(ty.Text)
    self.mNextSkillDesLab = self:getChildGO("NextTextSkillDesLab"):GetComponent(ty.Text)
    self.mMaxTxt = self:getChildGO("MaxTxt"):GetComponent(ty.Text)
end


function active(self, args)
    super.active(self, args)
    self.skillId = args.skillId
    
    self.skillVo = fight.SkillManager:getSkillRo(self.skillId)

    self.mTxtName.text = self.skillVo:getName()

    local des = self.skillVo:getDesc()
    local form = args.preValue / 100

    if args.showNext then
        if args.nextValue == nil  then
            self.mTxtDes.text = string.substitute(des,form) --.. "\n☆下一等级 \n" .."已满级"
            self.mNextTxtDes.text = ""
            self.mMaxImg:SetActive(true)
            self.mNextImgSkillDes:SetActive(false)
        else
            local nextForm = args.nextValue / 100
            self.mTxtDes.text = string.substitute(des,form) --.. "\n☆下一等级 \n" ..
            self.mNextTxtDes.text = string.substitute(des,nextForm)
            self.mMaxImg:SetActive(false)
            self.mNextImgSkillDes:SetActive(true)
        end
    else
        self.mTxtDes.text = string.substitute(des,form)
    end
end

function initViewText(self)
    super.initViewText(self)

    self.mSkillDesLab.text = _TT(45010)
    self.mNextSkillDesLab.text = _TT(45011)
    self.mMaxTxt.text = _TT(45012)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
