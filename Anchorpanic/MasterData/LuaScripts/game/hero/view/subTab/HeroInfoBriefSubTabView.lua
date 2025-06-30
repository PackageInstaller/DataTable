module('hero.HeroInfoBriefSubTabView', Class.impl("lib.mvc.TabSubView"))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroInfoBriefSubTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_tabBarHero = nil
    self.m_curHeroId = nil
    self.m_itemList = {}
end

function configUI(self)
	self.progressBar = self:getChildGO('ProgressBar'):GetComponent(ty.ProgressBar)
    self.progressBar:InitData(4)
    self.m_textLvl = self:getChildGO("TextLvl"):GetComponent(ty.Text)
    self.m_textExp = self:getChildGO("TextExp"):GetComponent(ty.Text)
    self.m_textCountry = self:getChildGO("TextCountry"):GetComponent(ty.Text)
    self.m_ImgCountry = self:getChildGO("ImgCountry"):GetComponent(ty.AutoRefImage)
    self.m_textProfession = self:getChildGO("TextProfession"):GetComponent(ty.Text)
    self.m_textStature = self:getChildGO("TextStature"):GetComponent(ty.Text)
    self.m_textWeight = self:getChildGO("TextWeight"):GetComponent(ty.Text)
    self.m_contentTrans = self:getChildTrans("Content")
end

function active(self, args)
end

function deActive(self)
    self:recyAllItem()
    self.progressBar:SetValue(0, 0, false)
end

function setData(self, cusHeroId)
    self.m_curHeroId = cusHeroId
    self:__updateView()
end

function __updateView(self)
    self:recyAllItem()
    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    if (curHeroVo) then
        self.m_textLvl.text = curHeroVo.lvl
        self.m_textExp.text = curHeroVo.exp.."/"..curHeroVo.maxExp
        print(curHeroVo.maxExp)
        self.progressBar:SetValue(curHeroVo.exp, curHeroVo.maxExp, true)
        self.m_textCountry.text = curHeroVo:getCountryName()
        self.m_ImgCountry:SetImg(UrlManager:getHeroCountryIconUrl(curHeroVo.camp), true)
        self.m_textProfession.text = curHeroVo:getProfessionName()
        self.m_textStature.text = curHeroVo.stature
        self.m_textWeight.text = curHeroVo.weight

        for i = 1, #curHeroVo.attrList do
            local attrVo = curHeroVo.attrList[i]
            local item = gs.GOPoolMgr:Get("HeroAttrItem.prefab")
            item.transform:SetParent(self.m_contentTrans, false)
            item:GetComponent(ty.Text).text = AttConst.getName(attrVo.key) .. ":" .. AttConst.getValueStr(attrVo.key, attrVo.value)
            table.insert(self.m_itemList, item)
        end
    end
end

function recyAllItem(self)
    for i = 1, #self.m_itemList do
        gs.GOPoolMgr:Recover(self.m_itemList[i], "HeroAttrItem.prefab")
    end
    self.m_itemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
