--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/CatGirlPKRoleHeadSmallNode.prefab > name: CatGirlPKRoleHeadSmallNode
---@class CatGirlPKRoleHeadSmallNode
---@field Env                           	CatGirlPKRoleHeadSmallNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgCardHead                   	UnityEngine.RectTransform               	@ 0    
---@field BtnRoot                       	UnityEngine.RectTransform               	@ 1    
---@field TxtNO                         	UnityEngine.RectTransform               	@ 2    
---@field TxtName                       	UnityEngine.RectTransform               	@ 3    
---@field Imgbg3                        	UnityEngine.RectTransform               	@ 4    
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 5    
---@field TxtNumber                     	UnityEngine.RectTransform               	@ 6    
---@field Imgbg5                        	UnityEngine.RectTransform               	@ 7    
local CatGirlPKRoleHeadSmallNode = Class('CatGirlPKRoleHeadSmallNode')
local KTool = CS.Engine.Lib.KTool
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
function CatGirlPKRoleHeadSmallNode:__init()
end


function CatGirlPKRoleHeadSmallNode:__delete()
end


function CatGirlPKRoleHeadSmallNode:Awake()

end


function CatGirlPKRoleHeadSmallNode:Start()

end
function CatGirlPKRoleHeadSmallNode:ThroughGame(data)
    ---@type CardVo
    local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , data.cardId)
    ---@type CardSkinVo
    local cardSkinVo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", cardVo.defaultSkin)
    local path = CfUtils.GetImageFullPath(checkString(cardSkinVo.buffHead)) 
    CfUtils.FillImage(self.ImgCardHead , path,true)
    CfUtils.SetScale(self.ImgCardHead , Vector3(1.1,1.1,1.1))
    -- CfUtils.SetScale(self.ImgCardHead , Vector3(0.6,0.6,0.6))
    KTool.SetActive(self.TxtName , true)
    CfUtils.FillText(self.TxtName , cardSkinVo.name)
    KTool.SetActive(self.TxtNO , false)
    KTool.SetActive(self.Imgbg5 , false)
    KTool.SetActive(self.Imgbg3 , false)
end


function CatGirlPKRoleHeadSmallNode:WeedOutRefresh(data ,index , callback)
    ---@type CardVo
    local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , data.cardId)
    ---@type CardSkinVo
    local cardSkinVo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", cardVo.defaultSkin)
    local path = CfUtils.GetImageFullPath(checkString(cardSkinVo.buffHead)) 
    CfUtils.FillImage(self.ImgCardHead , path,true)
    KTool.SetActive(self.TxtNO , true)
    KTool.SetActive(self.TxtName , true)
    KTool.SetActive(self.Imgbg5 , true)
    KTool.SetActive(self.Imgbg3 , true)
    CfUtils.SetScale(self.ImgCardHead , Vector3(1.1,1.1,1.1))
    CfUtils.FillText(self.TxtNumber ,  data.value)
    CfUtils.FillText(self.TxtNO ,  "NO." .. index)
    CfUtils.FillImage(self.ImgIcon , GoodsConfMgr:GetInstance():GetPhotoPathById(ActivityVoteComponent:GetVoteGoodsId())) 
    CfUtils.FillText(self.TxtName , cardSkinVo.name)
    SetButtonAction(self.BtnRoot , function ()
        if ActivityVoteComponent:GetDojo().status > 1 then
            GameUtils.Toast(localize("当前赛事投票已结束"))
            return
        end 
        callback(data.cardId)
    end)
end

function CatGirlPKRoleHeadSmallNode:filterRefresh(roleId,callback)
    ---@type RolesVo
    local roleVo = CfUtils.GetCfVo(AutoIds.IdSetting19, "RolesVo", roleId)
    local roleHeadPath = CfUtils.GetImageFullPath(roleVo.cardHeadList) 
    CfUtils.FillImage(self.ImgCardHead , roleHeadPath ,true)
    CfUtils.SetScale(self.ImgCardHead , Vector3(0.6,0.6,0.6))
    KTool.SetActive(self.Imgbg5 , false)
    KTool.SetActive(self.TxtNO , false)
    KTool.SetActive(self.Imgbg3 , false)
    CfUtils.FillText(self.TxtName , roleVo.name )
    KTool.SetActive(self.TxtName , true)
    SetButtonAction(self.BtnRoot , function ()
        if ActivityVoteComponent:GetDojo().status > 1 then
            GameUtils.Toast(localize("当前赛事投票已结束"))
            return
        end
        callback(roleId)
    end)
end
function CatGirlPKRoleHeadSmallNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return CatGirlPKRoleHeadSmallNode
