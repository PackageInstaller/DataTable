





AnecdoteItemModel = {}
AnecdoteItemModel.__index = AnecdoteItemModel
AnecdoteItemModel.IconPath = "Assets/_BundleResources/Images/BranchAnecdote/"

local objs = {
    normal = {path = "Normal",type = "GameObject"},
    anecdoteIcon = {path = "Normal/AnecdoteIcon",type = "RawImage"},
    n_name = {path = "Normal/Name",type = "Text"},
    n_pass = {path = "Normal/Pass",type = "GameObject"},
    n_perfect = {path = "Normal/Perfect",type = "GameObject"},
    clickBtn = {path = "Normal/Btn",type = "Button"},
    n_red = {path = "Normal/Red",type = "GameObject"},

    lock = {path = "Lock",type = "GameObject"},
    l_name = {path = "Lock/Name",type = "Text"},
    noClickBtn = {path = "Lock/Btn",type = "Button"},
    
    choose = {path = "Choose",type = "GameObject"},
    c_name = {path = "Choose/Name",type = "Text"},
    c_red = {path = "Choose/Red",type = "GameObject"},
    c_pass = {path = "Choose/Pass",type = "GameObject"},
    c_perfect = {path = "Choose/Perfect",type = "GameObject"},
    anecdoteIcon_1 = {path = "Choose/AnecdoteIcon_1",type = "RawImage"},
}

function AnecdoteItemModel.New()
    local self = {}
    setmetatable(self, AnecdoteItemModel)
    return self
end

function AnecdoteItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.AnecdoteItemChoose,self.index)
    end
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
    self.notClickCommand = function()
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15015"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
    end
    LuaMgr.AddClick(self.noClickBtn,self.notClickCommand)
end

function AnecdoteItemModel:SetData(data)
    self.data = data.data
    self.index = data.data.index
    self.select = data.data.select
    self.redBool = self.data.red
    SetActive(self.normal,data.data.unlocked)
    self.anecdoteIcon.texture = LuaMgr.GetTexture(self.IconPath..self.data.data.page.."_Label.png")
    self.anecdoteIcon_1.texture = LuaMgr.GetTexture(self.IconPath..self.data.data.page.."_Label_1.png")
    local name = ""
    if data.data.unlocked then
        name = LuaMgr.GetLangText(self.data.data.namelan)
    else
        name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15015"].NameLan)
    end
    self.n_name.text = name
    self.l_name.text = name
    self.c_name.text = name
    SetActive(self.n_pass,data.data.dungeonstate == 2)
    SetActive(self.c_pass,data.data.dungeonstate == 2)
    SetActive(self.n_perfect,data.data.dungeonstate == 1)
    SetActive(self.c_perfect,data.data.dungeonstate == 1)
    SetActive(self.lock,not data.data.unlocked)
    SetActive(self.choose,self.select)
    self:SetRed()
    self.gameObject:SetActive(true)
end

function AnecdoteItemModel:SetRed()
    if self.lock.activeSelf then
        SetActive(self.n_red,false)
        SetActive(self.c_red,false)
    else
        if not UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid..self.data.data.ID) then
            SetActive(self.n_red,true)
            SetActive(self.c_red,true)
        else
            SetActive(self.n_red,self.redBool)
            SetActive(self.c_red,self.redBool)
        end
    end
end

function AnecdoteItemModel:RecordRed()
    self.redBool = self.data.red
    if not self.redBool then
        SetActive(self.n_red,false)
        SetActive(self.c_red,false)
    end
    if not UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid..self.data.data.ID) then
        UnityEngine.PlayerPrefs.SetString(DataMgr.Player.uid..self.data.data.ID)
    end
end

function AnecdoteItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function AnecdoteItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    if (self.notClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.noClickBtn, self.notClickCommand)
        self.notClickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end