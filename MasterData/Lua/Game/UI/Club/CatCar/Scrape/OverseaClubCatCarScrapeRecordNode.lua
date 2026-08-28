---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarScrapeRecordNode.prefab > name: OverseaClubCatCarScrapeRecordNode
---@class OverseaClubCatCarScrapeRecordNode
---@field Env                           	OverseaClubCatCarScrapeRecordNode       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgbgSel                      	UnityEngine.RectTransform               	@ 0    
---@field GoodNode                      	Engine.Modules.LuaBehaviour             	@ 1    
---@field CommonPlayerHeadNode          	Engine.Modules.LuaBehaviour             	@ 2    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 3    
---@field TxtDesc                       	UnityEngine.RectTransform               	@ 4    
---@field ImgLike                       	UnityEngine.RectTransform               	@ 5    
local OverseaClubCatCarScrapeRecordNode = Class("OverseaClubCatCarScrapeRecordNode")

---@class OverseaClubCatCarScrapeRecordNode.InputData
---@field selected boolean
---@field num number
---@field reward Reward
---@field playerData CommonPlayerHeadNode.Data

function OverseaClubCatCarScrapeRecordNode:__init()
    self.controller = nil
    self.clickCallback = nil
end

function OverseaClubCatCarScrapeRecordNode:__delete()
    self.controller = nil
end

function OverseaClubCatCarScrapeRecordNode:Awake()
    SetButtonAction(self.controller.gameObject, function()
        if type(self.clickCallback) == 'function' then
            self.clickCallback()
        end
    end)
end


---@param inData OverseaClubCatCarDojo.CallLog
function OverseaClubCatCarScrapeRecordNode:RefreshData(inData,clickCallback)
    self.inData = inData
    self.clickCallback = clickCallback
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarScrapeRecordNode:RefreshUI()
    CfUtils.SetActive(self.ImgbgSel,self.inData.selected)
    CfUtils.FillText(self.TxtNum, table.concat({"No.", checkNumber(self.inData.id)}))
    CfUtils.FillText(self.TxtDesc, self.inData.logText)
    local callConf = checkTable(Mgr.Server.dojo.catCarCallInfo.callConf[self.inData.id])
    if callConf then
        
    end
    CfUtils.SetActive(self.ImgLike,checkNumber(callConf.type)== 1)

    if callConf.rewards then
        local reward = callConf.rewards[1]
        ---@type GoodNodeMB
        local goodNodeMbEnv = CfUtils.GetLuaScr(self.GoodNode,Constants.UILuaTablePath.GoodNodeMB)
        goodNodeMbEnv:Reload({
            goodsId = reward.goodsId,
            text = string.format("x%d", reward.num),
            showNum = true
        })
    end
    
    ---@type CommonPlayerHeadNode
    local commonPlayerHeadNodeEnv = CfUtils.GetLuaScr(self.CommonPlayerHeadNode,Constants.UILuaTablePath.ComPlayerHead)
    commonPlayerHeadNodeEnv:FreshAvatarFrame(self.inData.avavar,self.inData.avatarFrame)
end

function OverseaClubCatCarScrapeRecordNode:Select(flag)
    CfUtils.SetActive(self.ImgbgSel,flag)
end

return OverseaClubCatCarScrapeRecordNode