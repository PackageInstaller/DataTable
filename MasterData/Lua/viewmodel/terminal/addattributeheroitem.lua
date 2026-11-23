





AddAttributeHeroItem = {}
AddAttributeHeroItem.__index = AddAttributeHeroItem

local objs = {
    isCanActive = {path = "Animator/CanActive",type = "GameObject"},
    heroPic = {path = "Animator/Normal/HeroPic",type = "RawImage"},
    heroRare = {path = "Animator/Normal/HeroRare",type = "Image"},
    mask = {path = "Animator/Normal/Mask",type = "GameObject"},
    nameText = {path = "Animator/Normal/NameText",type = "Text"},
    canActive = {path = "Animator/Normal/State/CanActive",type = "GameObject"},
    c_text = {path = "Animator/Normal/State/CanActive/Image/Text",type = "Text"},
    progress = {path = "Animator/Normal/State/Progress",type = "GameObject"},
    p_text = {path = "Animator/Normal/State/Progress/Image/Text",type = "Text"},

    activeBtn = {path = "Animator/Normal/State/CanActive/Image",type = "Button"},
    openBtn = {path = "Animator/Normal/Btn",type = "Button"},
    animatorObj = {path = "Animator",type = "GameObject"},
    heroZZ = {path = "Animator/Normal/HeroZZ",type = "Image"},
    heroZZText = {path = "Animator/Normal/HeroZZ/Text",type = "Text"},
}

function AddAttributeHeroItem.New()
    local self = {}
    setmetatable(self, AddAttributeHeroItem)
    return self
end

function AddAttributeHeroItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.activeCommand = function()
        if self.data.state == 1 then
            self.activeFun(self.data)
        elseif self.data.state == 2 then
            self.starFun(self.data)
        elseif self.data.state == 3 then
            self.brilliantFun(self.data)
        end
    end
    self.openCommand = function()

        LuaMgr.ShowLuaPanel(UIName.AddAttributePopup,self.data)
    end
    LuaMgr.AddClick(self.activeBtn,self.activeCommand)
    LuaMgr.AddClick(self.openBtn,self.openCommand)
    SetActive(self.animatorObj,false)
end

function AddAttributeHeroItem:SetData(data)
    if data.data.animBool then

        SetActive(self.animatorObj,true)
    end
    self.transform.anchoredPosition = Vector2(self.transform.anchoredPosition.x,-35)
    self.data = data.data.data
    self.activeFun = data.data.activeFun
    self.starFun = data.data.starFun
    self.brilliantFun = data.data.brilliantFun
    SetActive(self.isCanActive,self.data.state == 4)
    self.heroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(self.data.id,self.data.skin))
    local tempRare = HeroMgr.GetHeroNowRare(self.data.id)
    local imageRare = tempRare >= 5 and 4 or tempRare
    self.heroRare.sprite = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..imageRare)
    SetActive(self.mask,self.data.state ~= 4 and self.data.state ~= 2 and self.data.state ~= 3)
    self.nameText.text = self.data.name
    SetActive(self.canActive,self.data.state == 1 or self.data.state == 2 or self.data.state == 3)
    if self.data.state == 1 then
        self.c_text.text = ConfigMgr.LangGlobal("17305")
    elseif self.data.state == 2 then
        self.c_text.text = ConfigMgr.LangGlobal("17307")
    elseif self.data.state == 3 then
        self.c_text.text = ConfigMgr.LangGlobal("22605")
    end
    SetActive(self.progress,self.data.state == 5)
    self.p_text.text = self.data.level..string.format("<size=20><color=#C1C0C0>/%s</color></size>",self.data.needLevel)

    local zzLevel = BattlePrepareMgr.isLeveling and self.data.star or HeroMgr.GetCharacterZZ(self.data.id)
    local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    self.heroZZText.text = string.format(zzStr,HeroMgr.GetNumStr(math.abs(zzLevel)))
    self.heroZZ.sprite = LuaMgr.GetSprite("CommonRes",zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
    self.gameObject:SetActive(true)
end






























function AddAttributeHeroItem:Clear()
    self.data = nil
    self.activeFun = nil
    self.starFun = nil
    self.brilliantFun = nil
    SetActive(self.animatorObj,false)
    self.gameObject:SetActive(false)
end

function AddAttributeHeroItem:Destroy()
    if (self.activeCommand ~= nil) then
        LuaMgr.RemoveClick(self.activeBtn, self.activeCommand)
        self.activeCommand = nil
    end
    if (self.openCommand ~= nil) then
        LuaMgr.RemoveClick(self.openBtn, self.openCommand)
        self.openCommand = nil
    end






    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end