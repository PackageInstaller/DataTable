---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingSkinCell.prefab > name: OverseaClubFeedingSkinCell
---@class OverseaClubFeedingSkinPanelCell
---@field Env                           	OverseaClubFeedingSkinPanelCell         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtTitle                      	UnityEngine.RectTransform               	@ 0    
---@field ImgRootBg                     	UnityEngine.RectTransform               	@ 1    
---@field TxtName                       	UnityEngine.RectTransform               	@ 2    
---@field TxtLock                       	UnityEngine.RectTransform               	@ 3    
---@field ImgBg                         	Game.Native.Common.UISwitchImage        	@ 4    
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 5    
---@field consume                       	UnityEngine.RectTransform               	@ 6    
---@field IconConsum                    	UnityEngine.RectTransform               	@ 7    
---@field TitleNum                      	UnityEngine.RectTransform               	@ 8    
---@field Sel                           	UnityEngine.RectTransform               	@ 9    
local OverseaClubFeedingSkinPanelCell = Class("OverseaClubFeedingSkinPanelCell")

---@class OverseaClubFeedingSkinPanelCell.InputData
---@field partType number    1  2  3 对应部位
---@field skinId number     
---@field select boolean

function OverseaClubFeedingSkinPanelCell:__init()
    self.controller = nil
end

function OverseaClubFeedingSkinPanelCell:__delete()
    self.controller = nil
end

function OverseaClubFeedingSkinPanelCell:Awake()
    SetButtonAction(self.ImgRootBg, Bind(self, self.OnClick))
end

---@param inData OverseaClubFeedingSkinPanelCell.InputData
function OverseaClubFeedingSkinPanelCell:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingSkinPanelCell:SetSelectCallback(callback)
    self.onSelect = callback
end

function OverseaClubFeedingSkinPanelCell:RefreshUI()
    
    CfUtils.SetActive(self.Sel,self.inData.select)
    local skinVo = Utils.GetSkinVo(self.inData.skinId)
    local goodsId = skinVo and skinVo.itemId or 0
    if self:IsUnLock() then
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if goodsVo then
            CfUtils.FillText(self.TxtName,goodsVo.name)
            CfUtils.FillImage(self.ImgIcon,goodsVo.photoPath)
            CfUtils.SetUISwitchImage(self.ImgBg,goodsVo.quality)
            CfUtils.SetActive(self.ImgIcon,true)
        else
            CfUtils.FillText(self.TxtName,"")
            CfUtils.SetActive(self.ImgIcon,false)
            CfUtils.SetUISwitchImage(self.ImgBg,1)
        end
        
        CfUtils.SetActive(self.consume,true)
        local consumeVo = GoodsConfMgr:GetInstance():GetGoodsVoById(Constants.Currency.ClubFeedCatSkinCoin)
        if consumeVo then
            CfUtils.FillImage(self.IconConsum,consumeVo.photoPath)    
        end
        CfUtils.FillText(self.TitleNum,Utils.GetRefineConsum(self.inData.partType))
        CfUtils.SetUISwitchImage(self.ImgRootBg,1) --unlock
        CfUtils.SetActive(self.TxtLock,false)
    else
        CfUtils.SetActive(self.TxtLock,true)
        CfUtils.SetActive(self.consume,false)
        CfUtils.SetActive(self.ImgIcon,false)
        CfUtils.FillText(self.TxtName,"")
        CfUtils.SetUISwitchImage(self.ImgRootBg,2)
        CfUtils.SetUISwitchImage(self.ImgBg,"lock")

        if self.inData.partType == 1 then  --1阶段特殊   未解锁也要显示皮肤
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
            if goodsVo then
                CfUtils.FillText(self.TxtName,goodsVo.name)
                CfUtils.FillImage(self.ImgIcon,goodsVo.photoPath)
                CfUtils.SetUISwitchImage(self.ImgBg,goodsVo.quality)
                CfUtils.SetActive(self.ImgIcon,true)
            else
                CfUtils.FillText(self.TxtName,"")
                CfUtils.SetActive(self.ImgIcon,false)
                CfUtils.SetUISwitchImage(self.ImgBg,1)
            end
        end
    end
end

function OverseaClubFeedingSkinPanelCell:IsUnLock()
    return Mgr:IsUnlockSkinPart(self.inData.partType)
end

function OverseaClubFeedingSkinPanelCell:OnClick()
    if self:IsUnLock() then
        if self.onSelect then
            self.onSelect(self.inData.partType)
        end
    end
end

function OverseaClubFeedingSkinPanelCell:IsUnfinished()
    return self.inData.partType >= 2
end

return OverseaClubFeedingSkinPanelCell