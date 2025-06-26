module("cycle.CycleHeroSkillItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleHeroSkillItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mImgSkillBg = self:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage)
    self.mImgSkillIcon = self:getChildGO("mImgSkillIcon"):GetComponent(ty.AutoRefImage)

    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    self.heroVo = self.mData.heroVo
    self.skillVo = self.mData.skillVo
    self.isTalent = self.mData.isTalent

    self:updateView()
end

function updateView(self)
    if self.isTalent then     -- 主动技能
        self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), false)
    else   -- 被动技能
        self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), false)
    end
    local level  = 1
    if self.isTalent then
        level = self.heroVo:getActivePassiveSkill(self.skillVo:getRefID()) + self.heroVo:getExtraLv(self.skillVo:getRefID())
    else
        level = self.heroVo:getActiveSkill(self.skillVo:getRefID()) + self.heroVo:getExtraLv(self.skillVo:getRefID())
    end

    self.mImgSkillIcon:SetImg(UrlManager:getSkillIconPath(self.skillVo:getIcon()), false)
    self.mTxtInfo.text = self.skillVo:getName() .." Lv."..level
    self.mTxtDes.text = self.skillVo:getDesc()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
