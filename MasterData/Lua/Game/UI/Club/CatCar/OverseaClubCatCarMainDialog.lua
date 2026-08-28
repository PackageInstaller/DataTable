---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
Mgr:Reset()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local KTool = CS.Engine.Lib.KTool
local ResourceModule = CS.Engine.Modules.ResourceModule
local speedPrefabPath = "Prefabs/OverClub/OverseaClubCatCarSpeedDialog.prefab"
local scrapePrefabPath = "Prefabs/OverClub/OverseaClubCatCarScrapeRewardDialog.prefab"

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarBackgroundDialog.prefab > name: OverseaClubCatCarBackgroundDialog
---@class OverseaClubCatCarMainDialog
---@field Env                           	OverseaClubCatCarMainDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field UIContainer                   	UnityEngine.RectTransform               	@ 0    
---@field BgNode                        	UnityEngine.RectTransform               	@ 1    
---@field Ground1                       	UnityEngine.RectTransform               	@ 2    
---@field Ground2                       	UnityEngine.RectTransform               	@ 3    
---@field Ground3                       	UnityEngine.RectTransform               	@ 4    
---@field GroundConnect                 	UnityEngine.RectTransform               	@ 5    
---@field Bg1                           	UnityEngine.RectTransform               	@ 6    
---@field Bg2                           	UnityEngine.RectTransform               	@ 7    
---@field Bg3                           	UnityEngine.RectTransform               	@ 8    
---@field Bg4                           	UnityEngine.RectTransform               	@ 9    
---@field Bg5                           	UnityEngine.RectTransform               	@ 10   
---@field Bg6                           	UnityEngine.RectTransform               	@ 11   
---@field BgConnect                     	UnityEngine.RectTransform               	@ 12   
---@field Imgsign                       	UnityEngine.RectTransform               	@ 13   
local OverseaClubCatCarMainDialog = Class("OverseaClubCatCarMainDialog")

---@class OverseaClubCatCarMainDialog.InputData

function OverseaClubCatCarMainDialog:__init()
    self.controller = nil
    self.subCreate = false
    self.events = {}
    self.events[ClubUtils.EventName.Dice_Submit] = Events.AddListener(ClubUtils.EventName.Dice_Submit,Bind(self,self.PerformOvertake))
    self.events[ClubUtils.EventName.Loading_End] = Events.AddListener(ClubUtils.EventName.Loading_End,function()
        if checkNumber(Mgr.Server.dojo.catCarBoss.isFirstJoin) ~= 0 then
            return 
        end
        CfUtils.PlayAnimation(self.BgNode, "OverseaClubCatCarBackgroundDialog_Entry")
    end)
    self.events[ClubUtils.EventName.MileageSettlement_Open] = Events.AddListener(ClubUtils.EventName.MileageSettlement_Open,function()
        --animation:GetClip("OverseaClubCatCarBackgroundDialog_Loop").wrapMode = WrapMode.Loop
        CfUtils.PlayAnimation(self.BgNode, "OverseaClubCatCarBackgroundDialog_Loop")
    end)
    self.events[ClubUtils.EventName.MileageSettlement_Close] = Events.AddListener(ClubUtils.EventName.MileageSettlement_Close,function()
        CfUtils.StopAnimation(self.BgNode)
        local vfx = self.BgNode:Find("UIFX_SpeedLine")
        CfUtils.SetActive(vfx,false)
    end)
end

function OverseaClubCatCarMainDialog:__delete()
    self.controller = nil
    if self.events then
        for i, v in pairs(self.events) do
            Events.RemoveListener(i,v)
        end
        self.events = nil
    end
end

function OverseaClubCatCarMainDialog:Awake()
end

function OverseaClubCatCarMainDialog:OnFocus()
    --c# onFocus 会调用Navigation,刷新资源栏,导致覆盖scrapeDialog里的资源栏控制
    local dojo = Mgr.Server.dojo
    if dojo.scheduleType == 3 and self.scrapeDialog then
        self.scrapeDialog:RefreshTopGoods()
    end
end

function OverseaClubCatCarMainDialog:OnInitialize()
    return CoWaitDo(function()
        CriWareUtils.PlayMusicById("bgm_catbus_highway")
        Mgr.Server:ReqCatCarHome(function()
            self:CreateSubUI()
        end)
    end)
end

function OverseaClubCatCarMainDialog:CreateSubUI()
    if self.subCreate then
        local dojo = Mgr.Server.dojo
        if dojo.scheduleType == 1 or dojo.scheduleType == 2 then
            self.speedDialog:RefreshData()
        else
            self.scrapeDialog:RefreshData()
        end
        self:RefreshUI()
        return
    end
    
    local dojo = Mgr.Server.dojo
    if dojo.scheduleType == 1 or dojo.scheduleType == 2 then
        ResourceModule.LoadGameObjectAsync(speedPrefabPath, function(go)
            if not KTool.IsNull(go) then
                ---@type OverseaClubCatCarSpeedDialog
                self.speedDialog = CfUtils.GetLuaScr(go, "Game.UI.Club.CatCar.Speed.OverseaClubCatCarSpeedDialog")
                self.speedDialog:RefreshData()
            end
        end, true, self.UIContainer)
    else
        ResourceModule.LoadGameObjectAsync(scrapePrefabPath, function(go)
            if not KTool.IsNull(go) then
                ---@type OverseaClubCatCarScrapeRewardDialog
                self.scrapeDialog = CfUtils.GetLuaScr(go, "Game.UI.Club.CatCar.Scrape.OverseaClubCatCarScrapeRewardDialog")
                self.scrapeDialog:RefreshData()
            end
        end, true, self.UIContainer)
    end
    
    self.subCreate = true
    self:RefreshUI()
end

function OverseaClubCatCarMainDialog:RefreshUI()
    ---@type ClubCatCarSpeedGradeVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",Mgr.Server.dojo.clubCatCarLevel)
    CfUtils.FillImage(self.Ground1,vo.Background)
    CfUtils.FillImage(self.Bg1,vo.leftBackground)
    CfUtils.FillImage(self.Bg2,vo.rightBackground)
    CfUtils.FillImage(self.Ground2,vo.Background)
    CfUtils.FillImage(self.Bg3,vo.leftBackground)
    CfUtils.FillImage(self.Bg4,vo.rightBackground)

    CfUtils.SetActive(self.GroundConnect,false)
    CfUtils.SetActive(self.BgConnect,false)
    CfUtils.SetActive(self.Imgsign,false)
end

---@param overtake boolean  是否超车
---@param levelChange boolean  是否等级变更
function OverseaClubCatCarMainDialog:PerformOvertake(overtake,levelChange)
    ---@type ClubCatCarSpeedGradeVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",Mgr.Server.dojo.clubCatCarLevel)
    if overtake and isNotNull(self.BgNode) then
        CfUtils.PlayAnimation(self.BgNode,"OverseaClubCatCarBackgroundDialog_OverTaking")
    else
        CfUtils.PlayAnimation(self.BgNode,"OverseaClubCatCarBackgroundDialog_Travel")
    end

    if levelChange then
        local preVo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",Mgr.Server.dojo.clubCatCarLevel - 1)
        preVo = preVo or vo
        CfUtils.FillImage(self.Ground1,preVo.Background)
        CfUtils.FillImage(self.Bg1,preVo.leftBackground)
        CfUtils.FillImage(self.Bg2,preVo.rightBackground)
        CfUtils.FillImage(self.Ground2,vo.Background)
        CfUtils.FillImage(self.Bg3,vo.leftBackground)
        CfUtils.FillImage(self.Bg4,vo.rightBackground)
        CfUtils.FillImage(self.Ground3,vo.Background)
        CfUtils.FillImage(self.Bg5,vo.leftBackground)
        CfUtils.FillImage(self.Bg6,vo.rightBackground)

        local showConnect = self:GetShowConnect(levelChange,preVo)
        if showConnect then
            CfUtils.FillImage(self.GroundConnect,preVo.connectGround)
            CfUtils.FillImage(self.BgConnect,preVo.connectBackground)
        end
        CfUtils.SetActive(self.GroundConnect,showConnect)
        CfUtils.SetActive(self.BgConnect,showConnect)
        CfUtils.SetActive(self.Imgsign,true)
        CfUtils.FillImage(self.Imgsign,OverseaClubCatCarUtils:GetSignImgName(vo.grade))
    else
        CfUtils.FillImage(self.Ground2,vo.Background)
        CfUtils.FillImage(self.Bg3,vo.leftBackground)
        CfUtils.FillImage(self.Bg4,vo.rightBackground)
        CfUtils.FillImage(self.Ground3,vo.Background)
        CfUtils.FillImage(self.Bg5,vo.leftBackground)
        CfUtils.FillImage(self.Bg6,vo.rightBackground)

        CfUtils.SetActive(self.GroundConnect,false)
        CfUtils.SetActive(self.BgConnect,false)
        CfUtils.SetActive(self.Imgsign,false)
    end
end

function OverseaClubCatCarMainDialog:GetShowConnect(levelChange,vo)
    levelChange = checkBool(levelChange)
    if levelChange then
        return not string.isEmpty(vo.connectBackground)
    else
        --r如果下一次必定越过,是否显示
       return false 
    end
end

function OverseaClubCatCarMainDialog:OnFinalize()
    if self.speedDialog then
        CS.UnityEngine.GameObject.Destroy(self.speedDialog.controller.gameObject)
    end
    
    if self.scrapeDialog then
        CS.UnityEngine.GameObject.Destroy(self.scrapeDialog.controller.gameObject)
    end
    CriWareUtils.PlayRandomBGMFromCDList()
    self:Delete()
end

function OverseaClubCatCarMainDialog:OnDestroy()
    self:Delete()
    self.speedDialog = nil
    self.scrapeDialog = nil
end

return OverseaClubCatCarMainDialog