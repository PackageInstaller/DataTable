--- from: Assets/BundleResources/Prefabs/ResidentEvent/ResidentUpgradeBenefits.prefab > name: Item1
---@class Draw300TimesCell
---@field Env                           	Draw300TimesCell                        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GoodNode                      	UnityEngine.RectTransform               	@ 0    
---@field LvTextNumber                  	UnityEngine.RectTransform               	@ 1    
---@field FontStyleButton               	Game.Native.Common.FontStyleButton      	@ 2    
---@field redPoint                      	UnityEngine.RectTransform               	@ 3    
---@field ImgCountdown                  	UnityEngine.RectTransform               	@ 4    
---@field MaskBlack                     	UnityEngine.RectTransform               	@ 5    
---@field ImgFinish                     	UnityEngine.RectTransform               	@ 6    
---@field ImgLock                       	UnityEngine.RectTransform               	@ 7    
---@field CountdownTxtPrompt            	UnityEngine.RectTransform               	@ 8    
---@field UIFX_Iteam                    	UnityEngine.RectTransform               	@ 9    
local Draw300TimesCell = Class('Draw300TimesCell')
local KTool = CS.Engine.Lib.KTool
---@type PlayerComponent
local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
function Draw300TimesCell:__init()
end


function Draw300TimesCell:__delete()

end


function Draw300TimesCell:Awake()
   
end


function Draw300TimesCell:Start()

end
---@param vo  FeiXingDraw300TimesVo
function Draw300TimesCell:RefreshUI(vo , currentDay , currentLevel , callback)
    CfUtils.FillText(self.LvTextNumber , vo.level)
    ---@type GoodNodeMB
    local scr =  CfUtils.GetLuaScr(self.GoodNode , "Game.Behaviours.GoodNodeMB")
    scr:Reload({
        goodsId = vo.rewardId,
        text = string.format("x%d", vo.rewardNum),
        isShowNo = true
    })
    scr:SetClickButtonAction(function(goodsId, id)
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(self.GoodNode, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
    local status = Constants.GetStatus.Not
    if vo.cumLogin > currentDay then
        KTool.SetActive(self.ImgCountdown , true)
        CfUtils.FillText(self.CountdownTextNumber , localize("_day_天后解锁" , {_day_ = vo.cumLogin - currentDay}))
        KTool.SetActive(self.MaskBlack , true) 
        KTool.SetActive(self.ImgLock , true) 
        KTool.SetActive(self.ImgFinish , false) 
        KTool.SetActive(self.FontStyleButton , false)
        KTool.SetActive(self.UIFX_Iteam , false)
    else
        ---@type PlayerComponent
        local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local drawnRookie2Gift = PlayerComponent:GetPlayerDojo().drawnRookie2Gift or {}
        local giftId = checkInt(vo.Id)
        for k, v in pairs(drawnRookie2Gift) do
            if checkInt(v) == giftId then
                status = Constants.GetStatus.Has
                break
            end
        end
        if not (Constants.GetStatus.Has == status)  then
            status = Constants.GetStatus.Can
        end
        if status == Constants.GetStatus.Can then
            if currentLevel >= vo.level then
                self.FontStyleButton:ResetFontStyle("B25", localize("领取"))
            else 
                self.FontStyleButton:ResetFontStyle("B18", localize("领取"))
            end
            KTool.SetActive(self.MaskBlack , false) 
            KTool.SetActive(self.FontStyleButton , true)
            KTool.SetActive(self.ImgCountdown , false)
            KTool.SetActive(self.UIFX_Iteam , true)
        elseif status == Constants.GetStatus.Has then
            KTool.SetActive(self.MaskBlack , true) 
            KTool.SetActive(self.FontStyleButton , true)
            KTool.SetActive(self.ImgFinish , true)
            KTool.SetActive(self.ImgCountdown , false)
            KTool.SetActive(self.UIFX_Iteam , false)
            self.FontStyleButton:ResetFontStyle("B18", localize("已领取"))
        end
    end 
    SetButtonAction(self.FontStyleButton , function ()
        if status == Constants.GetStatus.Can then
            if callback then
                if currentLevel >= vo.level then
                    callback(vo.Id)    
                else 
                    GameUtils.Toast(localize("调查官请加速升级，领取更多奖励"))    
                end
            end
        end
    end)
end

function Draw300TimesCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return Draw300TimesCell
