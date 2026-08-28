---
--- Created by Eric.
--- DateTime: 2022/6/20 11:36
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
local SDKService = import('Game.Entry.SDKService')

------------ import ------------

------------ define ------------
local SwitchStatus = {
    Child = 1,
    Adult = 2,
}
------------ define ------------


---@class CatHouseCatShareShow
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextTitle                     	UnityEngine.RectTransform
---@field ImgBg                         	UnityEngine.RectTransform
---@field TxtTypeCat                    	UnityEngine.RectTransform
---@field TxtBirthday                   	TMPro.TextMeshProUGUI
---@field TxtNameCat                    	UnityEngine.UI.Text
---@field TxtNumberUID                  	TMPro.TextMeshProUGUI
---@field TxtNamePlayer                 	UnityEngine.UI.Text
---@field DataListGroup                 	UnityEngine.RectTransform
local CatHouseCatShareShow = Class("CatHouseCatShareShow")
function CatHouseCatShareShow:__init()
    self.initCompleteCB = nil


end

function CatHouseCatShareShow:__delete()
    self.initCompleteCB = nil


    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseCatShareShow:SetInitCompleteCB(cb)
    self.initCompleteCB = cb

end

function CatHouseCatShareShow:Awake()
    local isOpenFtCommunity = SDKService:GetInstance():IsOfficialSDK()
    local codeGroup = self.controller.gameObject.transform:Find("Root/Container/ContentGroup/CodeGroup")
    KTool.SetActive(codeGroup, (isOpenFtCommunity or GameUtils.IsWindow()) and (not IS_REVIEW) )
end

function CatHouseCatShareShow:OnInit(arg)
    self.catData = arg
    self:FreshBaseUI()
end

function CatHouseCatShareShow:FreshBaseUI()
    local currentCatData = self.catData
    local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
    local p = '(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)'
    local year, month, day, hour, min, sec = tostring(currentCatData.birthday):match(p)
    self.TxtNameCat.text = currentCatData.name
    self.TxtBirthday.text = string.format("%s-%s-%s", year, month, day)
    local catVo = CfUtils.GetCfVo(AutoIds.IdSetting1906, "CatHouseCatVo", currentCatData.petId)
    self.TxtTypeCat.text = catVo.name
    local dataListEnv = CfUtils.GetLuaScr(self.DataListGroup, "Game.CatHouse.Interaction.CatHouseInteractionDataList")
    dataListEnv:FreshBaseUI(currentCatData)

    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local playerDojo = playerComponent:GetPlayerDojo()
    self.TxtNamePlayer.text = playerDojo.playerName
    self.TxtNumberUID.text = playerDojo.playerId

    CfUtils.SetUISwitchImage(self.ImgBg, isChild and SwitchStatus.Child or SwitchStatus.Adult)
    CfUtils.SetUISwitchText(self.TextTitle, isChild and SwitchStatus.Child or SwitchStatus.Adult)
    if self.initCompleteCB then
        self.initCompleteCB()
    end
end

function CatHouseCatShareShow:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseCatShareShow