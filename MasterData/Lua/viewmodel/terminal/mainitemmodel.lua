





MainItemModel = {}

MainItemModel.__index = MainItemModel

MainItemModel.position = {
    [1] = {Vector2(0,-7.2),Vector2(260,-5.9),Vector2(518.4,-7.6),Vector2(775.31,-7.81),Vector2(1030,-6)},
    [3] = {Vector2(0,-7.2),Vector2(260,-5.9),Vector2(518.4,-7.6),Vector2(775.31,-7.81),Vector2(1030,-6)},
}
MainItemModel.rotation = {
    [1] = {Vector3(28,6.21,0),Vector3(-32,-4,0),Vector3(28,-1.9,0),Vector3(-28.7,15.4,0),Vector3(27.38,-12.9,0)},
    [3] = {Vector3(28.5,-12.42,0),Vector3(-26.1,10.5,0),Vector3(31,6.1,0),Vector3(31.4,9.5,0),Vector3(27,21,0)},
}
MainItemModel.scale = {
    [1] = {Vector3(0.89,1,1),Vector3(0.87,1,1),Vector3(0.86,1,1),Vector3(0.87,1,1),Vector3.one},
    [3] = {Vector3(0.88,1,1),Vector3(0.88,1,1),Vector3(0.88,1,1),Vector3(0.88,1,1),Vector3.one},
}

local objs = {
    icon = {path = "Icon",type = "RawImage"},
    select = {path = "Select",type = "GameObject"},
    name = {path = "Select/Text",type = "Text"},
    button = {path = "Button",type = "Button"},
}

function MainItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, MainItemModel)
    if prefab ~= nil and parent ~= nil then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        UITool.Parse(self.gameObject, self, objs)
        self.transform = self.gameObject:GetComponent("RectTransform")
    end
    return self
end

function MainItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.buttonCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.MainItemClick, self.index)
    end
    LuaMgr.AddClick(self.button,self.buttonCommand)
end

function MainItemModel:SetData(data,type,index)
    local isShow = false
    if index == nil then
        self.index = data.data.index
        self.data = data.data.data
        self.type = data.data.type
        isShow = data.data.select
    else
        self.index = index
        self.data = data
        self.type = type
    end
    local config = ConfigMgr.Config.narrativeMap[self.data.PlotId[1]]
    if config ~= nil then
        self.name.text = LuaMgr.GetLangText(config.nameLan)
        local path = Path.BranchPlotPath..self.data.Icon..".png"
        self.icon.texture = LuaMgr.GetTexture(path)
        self.state = true
        self.state = DataHelper.GetNovelState(self.data.PlotId[1])
        ::continue::
        if self.state then
            self.icon.material = nil
        else
            local material = LuaMgr.GetMaterial("Assets/_BundleResources/Shader/Res/Materials/UISpriteGray.mat")
            self.icon.material = material
        end
        SetActive(self.select,isShow)
    end

    if self.type == 2 then
        self.transform.anchoredPosition = Vector2(self.transform.anchoredPosition.x,-9)

        self.transform.localScale = data.data.scale
    else
        self.transform.anchoredPosition = self.position[self.type][self.index]
        self.transform.localScale = Vector3(0.9,0.9,0.9)


    end
    self.gameObject:SetActive(true)
end

function MainItemModel:Clear()
    self.data = nil
    self.index = nil
    self.type = nil
    self.gameObject:SetActive(false)
end

function MainItemModel:Destroy()
    if (self.buttonCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.buttonCommand)
        self.buttonCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end