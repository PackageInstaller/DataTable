--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarSpeedDialog.prefab > name: Content
---@class CommonList
---@field Env                           	CommonList                              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Template                      	UnityEngine.RectTransform               	@ 0    
local CommonList = Class("CommonList")

function CommonList:__init()
    self.controller = nil
    self.goList = {}
    self.onRefreshItem = nil
    self.inited = false
end

function CommonList:__delete()
    self.controller = nil
end

function CommonList:Awake()
    if self.Template then
        CfUtils.SetActive(self.Template, false)    
    end
end

---@param count number 节点数量
---@param onRefreshItem fun()  节点刷新回调
function CommonList:Initialize(count, onRefreshItem)
    self.inited = true
    self.onRefreshItem = onRefreshItem
    self:RefreshUI(count)
end

function CommonList:SetCount(count)
    self.count = checkNumber(count)
end

function CommonList:RefreshUI(count)
    if count then
        self:SetCount(count)
    end
    if self.onRefreshItem == nil then
        printError("CommonList:RefreshUI() OnRefreshItem is nil")
        return
    end
    
    self:HideExtraGo()
    for i = 1, self.count do
        local go = self:GetGo(i)
        if go then
            CfUtils.SetActive(go.gameObject, true)
            self.onRefreshItem(self,go, i)
        end
    end
end

function CommonList:GetGo(index)
    local go = self.goList[index]
    if not go then
        go = self:CreateItem()
        go.name = "Go" .. index
        self.goList[index] = go
    end
    return go
end

--隐藏多余的go
---@private
function CommonList:HideExtraGo()
    for i = self.count + 1, #self.goList do
        local go = self.goList[i]
        if go then
            CfUtils.SetActive(go.gameObject, false)
        end
    end
end

---@private
function CommonList:CreateItem()
    local go = CS.UnityEngine.GameObject.Instantiate(self.Template, self.controller.transform)
    return go
end

function CommonList:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CommonList