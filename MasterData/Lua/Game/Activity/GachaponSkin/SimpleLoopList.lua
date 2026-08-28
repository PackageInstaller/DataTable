local GameObject = CS.UnityEngine.GameObject

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinPropDescPopUp.prefab > name: NormalGoodsList
---@class SimpleLoopList
---@field Env                           	SimpleLoopList                          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field template                      	UnityEngine.RectTransform               
local SimpleLoopList = Class("SimpleLoopList")

function SimpleLoopList:__init()
    self.controller = nil
    self.goList = {}
    self.onRefreshItem = nil
end

function SimpleLoopList:__delete()
    self.controller = nil
end

function SimpleLoopList:Awake()
    if self.template then
        CfUtils.SetActive(self.template.gameObject, false)
    end
end

function SimpleLoopList:Initialize(count, onRefreshItem, template)
    self.count = checkNumber(count)
    self.onRefreshItem = onRefreshItem
    self:SetTemplate(template)
    self:RefreshUI()
end

function SimpleLoopList:RefreshData(data)
    self.data = checkTable(data)
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function SimpleLoopList:RefreshUI()
    if self.onRefreshItem == nil then
        printError("SimpleLoopList:RefreshUI() OnRefreshItem is nil")
        return
    end
    for i = 1, self.count do
        local go = self:GetGo(i)
        if go then
            CfUtils.SetActive(go.gameObject, true)
            self.onRefreshItem(go, i)
        end
    end
end

--设置模板go
---@param go UnityEngine.RectTransform
function SimpleLoopList:SetTemplate(go)
    if go then
        self.template = go    
    end
end

function SimpleLoopList:GetGo(index)
    local go = self.goList[index]
    if not go then
        go = self:CreateItem()
        self.goList[index] = go
    end
    return go
end

function SimpleLoopList:CreateItem()
    local go = GameObject.Instantiate(self.template, self.controller.transform)
    return go
end

return SimpleLoopList