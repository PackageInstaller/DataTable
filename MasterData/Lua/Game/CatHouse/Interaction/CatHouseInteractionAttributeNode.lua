---
--- Created by Eric.
--- DateTime: 2021/12/10 15:07
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local xLuaUtils = CS.Engine.Lib.XLuaUtils
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/CatHouse/CatAttributeNode.prefab
---@class CatHouseInteractionAttributeNode
---@field Env                            CatHouseInteractionAttributeNode
---@field controller                        Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field bg                                UnityEngine.UI.Image
---@field UIFX_CatHouseInteractionDialog2    UnityEngine.RectTransform
---@field CatAttributeTextDesc            UnityEngine.RectTransform
---@field CatAttributeIcon                Engine.UI.RawImageAlterable
---@field CatAttribute                    UnityEngine.RectTransform
---@field ForceAttribute                    UnityEngine.RectTransform
---@field TextNumber                        TMPro.TextMeshProUGUI
---@field TextTitle                        UnityEngine.UI.Text
---@field ImgIcon                        Engine.UI.RawImageAlterable
local CatHouseInteractionAttributeNode = Class("CatHouseInteractionAttributeNode")
function CatHouseInteractionAttributeNode:__init()
    --self.btnAction = nil
    self.bg = nil
    self.attrData = {}
end

function CatHouseInteractionAttributeNode:__delete()
    --self.btnAction = nil
    self.bg = nil
    self.attrData = nil
    self.controller = nil
end

-----SetCallBack
-----设置单击回调函数
--function CatHouseInteractionAttributeNode:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

function CatHouseInteractionAttributeNode:Awake()
    self.EventAttrPreview = Events.AddListener(Constants.EventNames.CatHouseCatAttrPreview, Bind(self, self.FreshAttrPreview))

    --KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end
end

---设置猫数据，训练技能需要用到
function CatHouseInteractionAttributeNode:SetCatData(catData)
    self.catData = catData
end

function CatHouseInteractionAttributeNode:FreshBaseUI(data, position)
    KTool.SetActive(self.UIFX_CatHouseInteractionDialog2, false)
    self.TextTitle.text = data.name
    self.ImgIcon:LoadSprite(data.picture)
    if not isNull(self.bg) then
        if position % 2 == 0 then
            self.bg.color = xLuaUtils.HexToColor("#FFFFFF")
        else
            self.bg.color = xLuaUtils.HexToColor("#DFDFDF")
        end
    end
end

--attrData = {
--    id = v.id,
--    num = self.catData.attr[v.id],
--    subJoin = 0,
--}
function CatHouseInteractionAttributeNode:FreshAttrValue(attrData)
    local txt
    self.attrData = attrData
    if table.count(checkTable(self.attrData.subJoin)) > 0 and self.attrData.subJoin[1] > 0 then
        --传了正确的范围
        --print("------>>"..table.dump(self.attrData, nil, 3))
        local leftNum = math.ceil(self.attrData.subJoin[1])
        local rightNum = math.ceil(math.max(self.attrData.subJoin[1], self.attrData.subJoin[2]))
        --print(leftNum.."<<------>>"..rightNum)
        txt = string.format("%d<color=#ff41b7>+%d~%d</color>", self.attrData.num, leftNum, rightNum)--最小值不能超过最大值
    else
        txt = self.attrData.num
    end
    if not isNull(self.TextNumber) then
        self.TextNumber.text = txt
    end
end

---@param data table 编队数据
function CatHouseInteractionAttributeNode:FreshAttrPreview(data)
    --print("roleData------->>"..table.dump(data))
    --print("go------->>"..self.controller.gameObject.name)
    if isNull(self.catData) then
        return
    end
    if isNull(data) then
        self.attrData.subJoin = {}
    else
        local CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
        local subjoinAttrMap = CatHouseComponent:GetSubjoinAttr(data, self.catData)
        if subjoinAttrMap[checkString(self.attrData.id)] then
            self.attrData.subJoin = subjoinAttrMap[checkString(self.attrData.id)]
        else
            self.attrData.subJoin = {}
        end
        --return
    end

    --local isMax = self.attrData.upperLimit <= self.attrData.num + self.attrData.subJoin
    --KTool.SetActive(self.TextMax, isMax and data.id ~= 0)
    --self.attrData.subJoin = math.min((self.attrData.upperLimit - self.attrData.num), self.attrData.subJoin)
    self:FreshAttrValue(self.attrData)
end

function CatHouseInteractionAttributeNode:ShowIncreaseEffect()
    self.co = cs_coroutine.start(function()
        KTool.SetActive(self.UIFX_CatHouseInteractionDialog2, false)
        KTool.SetActive(self.UIFX_CatHouseInteractionDialog2, true)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
        KTool.SetActive(self.UIFX_CatHouseInteractionDialog2, false)
    end)


end

function CatHouseInteractionAttributeNode:FreshCatAttribute(handbookDesc, picture)
    KTool.SetActive(self.CatAttribute.gameObject, true)
    KTool.SetActive(self.ForceAttribute.gameObject, false)
    self.CatAttributeIcon:LoadSprite(picture)
    self.CatAttributeTextDesc.text = handbookDesc

end

function CatHouseInteractionAttributeNode:OnDestroy()
    Events.RemoveListener(Constants.EventNames.CatHouseCatAttrPreview, self.EventAttrPreview)
    if self.co then
        cs_coroutine.stop(self.co)
    end
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseInteractionAttributeNode