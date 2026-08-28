---
--- Created by Eric.
--- DateTime: 2022/6/17 10:23
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CatHouseMgr = import('Game.CatHouse.CatHouseMgr')
local SDKService = import('Game.Entry.SDKService')

------------ import ------------

------------ define ------------
local CatHouseCaptureTextureComplete = Constants.EventNames.CatHouseCaptureTextureComplete

------------ define ------------

---@class CatHouseEvolutionShare
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgIconCat                    	UnityEngine.UI.RawImage
---@field DataListGroup                 	UnityEngine.RectTransform
---@field TxtNumberUID                  	TMPro.TextMeshProUGUI
---@field TxtNamePlayer                 	UnityEngine.UI.Text
---@field TxtBirthday                   	TMPro.TextMeshProUGUI
---@field TxtTypeCat                    	UnityEngine.UI.Text
---@field TxtNameCat                    	UnityEngine.UI.Text
local CatHouseEvolutionShare = Class("CatHouseEvolutionShare")
function CatHouseEvolutionShare:__init()
    self.catData = {}
    self.initCompleteCB = nil

end

function CatHouseEvolutionShare:__delete()
    self.catData = nil
    self.initCompleteCB = nil

    self.controller = nil
end

function CatHouseEvolutionShare:Awake()
    self.__EventCaptureTextureCompleteAction = Events.AddListener(CatHouseCaptureTextureComplete, Bind(self, self.OnEventCaptureTextureCompleteAction))
    local isOpenFtCommunity = SDKService:GetInstance():IsOfficialSDK()
    local codeGroup = self.controller.gameObject.transform:Find("Root/Container/ShareDialog/Screenshot/CodeGroup")
    KTool.SetActive(codeGroup, (isOpenFtCommunity or GameUtils.IsWindow()) and (not IS_REVIEW) )
end

function CatHouseEvolutionShare:SetInitCompleteCB(cb)
    self.initCompleteCB = cb
end

function CatHouseEvolutionShare:OnInit(arg)
    self.catData = arg
    self:FreshBaseUI()
end

function CatHouseEvolutionShare:FreshBaseUI()
    local currentCatData = self.catData
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
    local catHouseMgr = CatHouseMgr:GetInstance()
    local attributes = catHouseMgr:GetAttributes(currentCatData.genes)
    self.fileNameId = catHouseMgr:GetFileNameId(checkNumber(currentCatData.age), currentCatData.catId, attributes)    
    catHouseMgr:CaptureTexture(currentCatData.age, currentCatData.catId, attributes, false, self.fileNameId)
    -- self.fileNameId = catHouseMgr:CaptureTexture(checkNumber(currentCatData.age), currentCatData.catId, catHouseMgr:GetAttributes(currentCatData.genes))
    --while not self.isFinish do--没完成的时候不return
    --    --print("n")
    --end
end

function CatHouseEvolutionShare:OnEventCaptureTextureCompleteAction(id, path)
    if self.fileNameId == id then
        local texture = CatHouseMgr:GetInstance():LoadCaptureTexture(path)
        self.ImgIconCat.texture = texture
        if self.initCompleteCB then
            self.initCompleteCB()
        end
        --self.isFinish = true
    end
end


function CatHouseEvolutionShare:OnDestroy()
    if self.__EventCaptureTextureCompleteAction then
        Events.RemoveListener(CatHouseCaptureTextureComplete, self.__EventCaptureTextureCompleteAction)
        self.__EventCaptureTextureCompleteAction = nil
    end
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseEvolutionShare