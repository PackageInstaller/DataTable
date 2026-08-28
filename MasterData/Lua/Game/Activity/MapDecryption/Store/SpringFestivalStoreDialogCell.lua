---
--- Created by Eric.
--- DateTime: 2022/11/16 15:14
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders
local StoreUtils = import('Game.UI.Store.StoreUtils')
local StoreShared = import('Game.UI.Store.StoreShared'):GetInstance()
local StoreConstants = import('Game.UI.Store.StoreConstants')
local cs_coroutine = require 'XLua.cs_coroutine'
------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalStoreDialog.prefab
---@class SpringFestivalStoreDialogCell
---@field Env                           	SpringFestivalStoreDialogCell
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field SpecialNode                   	UnityEngine.RectTransform
---@field ImgSoldBlack                  	UnityEngine.RectTransform
---@field SoldOutNode                   	UnityEngine.RectTransform
---@field Txtprice                      	UnityEngine.RectTransform
---@field Icon                          	UnityEngine.RectTransform
---@field PriceGroup                    	UnityEngine.RectTransform
---@field TextFree                      	UnityEngine.RectTransform
---@field TxtNumber                     	UnityEngine.RectTransform
---@field TxtName                       	UnityEngine.RectTransform
---@field TxtDay                        	UnityEngine.RectTransform
---@field ImgTime                       	UnityEngine.RectTransform
---@field TimeGroup                     	UnityEngine.RectTransform
---@field ImgIcon                       	UnityEngine.RectTransform
---@field ImgQualityBg                  	UnityEngine.RectTransform
---@field ImgBg                         	UnityEngine.RectTransform
---@field BtnCell                       	UnityEngine.RectTransform
local SpringFestivalStoreDialogCell = Class("SpringFestivalStoreDialogCell")
function SpringFestivalStoreDialogCell:__init()
    self.btnAction = nil

end

function SpringFestivalStoreDialogCell:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function SpringFestivalStoreDialogCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function SpringFestivalStoreDialogCell:Awake()
    SetButtonAction(self.BtnCell.gameObject, function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

---刷新cell状态
function SpringFestivalStoreDialogCell:RefreshCellState(data)
    local isSoldOut = StoreUtils.ProductIsSoldOut(data)
    --local isLocked, lockedDescr = StoreUtils.ProductIsLocked(data)

    --local isGray = isSoldOut or isLocked
    --KTool.SetActive(self.DisableMask, isGray)
    --KTool.SetActive(self.LockGroup, isLocked)
    KTool.SetActive(self.SoldOutNode, isSoldOut)
    --
    --if isLocked then
    --    CfUtils.FillText(self.TxtLock, lockedDescr)
    --end
end

---刷新剩余时间
function SpringFestivalStoreDialogCell:RefreshTimeGroup(data)
    KTool.SetActive(self.TimeGroup, data.nextRefreshLeftSeconds > 0)
    if data.nextRefreshLeftSeconds > 0 then
        CfUtils.FillText(self.TxtDay, StoreUtils.FormatTime(data.nextRefreshLeftSeconds, true))
    end
end

function SpringFestivalStoreDialogCell:RefreshGoods(data)
    print("=======>>"..table.dump(data, nil, 3))
    local isSoldOut = StoreUtils.ProductIsSoldOut(data)
    local isFree = StoreUtils.ProductIsFree(data)
    local isNormal = not isFree
    CfUtils.SetUISwitchImage(self.ImgBg, isNormal and 1 or 2)
    CfUtils.SetUISwitchImage(self.ImgSoldBlack, isNormal and 1 or 2)
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(checkNumber(data.icon))
    local idType = GoodsUtils.GetIdType(data.icon)
    if idType == Constants.IDType.Equipment then
        KTool.SetActive(self.TarotFrame.gameObject, true)
        KTool.SetActive(self.ImgIcon2.gameObject, true)
        KTool.SetActive(self.ImgIcon.gameObject, false)
        CfUtils.FillImage(self.ImgIcon2, vo.photoPath)
        local equip = CardConfMgr:GetInstance():GetEquipVoById(data.icon)
        EquipUtils.SetEquipPartBgScale(self.TarotFrame.transform, equip.part)
    else
        KTool.SetActive(self.TarotFrame.gameObject, false)
        KTool.SetActive(self.ImgIcon2.gameObject, false)
        KTool.SetActive(self.ImgIcon.gameObject, true)
        CfUtils.FillImage(self.ImgIcon, vo.photoPath)
    end
    CfUtils.FillImage(self.ImgQualityBg, StoreUtils.GetGoodsBgByQuality(vo.quality))
    local name = vo.name
    if checkInt(data.num) > 1 then
        name = string.format('%s x%d', name, checkInt(data.num))
    end
    CfUtils.FillText(self.TxtName, name)
    local TxtRemainGroup = self.BtnCell:Find('TxtRemainGroup')
    if isNotNull(TxtRemainGroup) then
        if data.currentStock == -1 then
            CfUtils.SetActive(TxtRemainGroup, false)
        else
            local stock = data.currentStock
            CfUtils.SetActive(TxtRemainGroup, true)
            CfUtils.FillText(self.TxtNumber, stock)
        end
    end
    KTool.SetActive(self.PriceGroup, not isFree)
    KTool.SetActive(self.TextFree, isFree)
    KTool.SetActive(self.SpecialNode, (not isNormal) and (not isSoldOut))
    if not isFree then
        if data.prices[1] then
            local currencyVo = GoodsConfMgr:GetInstance():GetGoodsVoById(checkNumber(data.prices[1].currency))
            CfUtils.FillImage(self.Icon, currencyVo.photoPath)
            CfUtils.FillText(self.Txtprice, data.prices[1].current)
        else
            printError("%s未配prices", data.goodsId)
        end
    end
    
    
end


function SpringFestivalStoreDialogCell:FreshBaseUI(data)
    self._cellData = data
    self:RefreshCellState(data)
    self:RefreshTimeGroup(data)
    self:RefreshGoods(data)
    self:StartTimer()
end

---开启定时器
function SpringFestivalStoreDialogCell:StartTimer()
    self:CloseTimer()

    if checkInt(self._cellData.tab) == StoreConstants.StoreGiftType.Daily then
        self._tickHandler = Bind(self, self.OnTimeTick)
        StoreShared:RegisterTimer(self._tickHandler)
    else
        CfUtils.SetActive(self.TimeGroup, false)
    end

end

---关闭定时器
function SpringFestivalStoreDialogCell:CloseTimer()
    if self._tickHandler ~= nil then
        StoreShared:UnRegisterTimer(self._tickHandler)
    end
end

---定时器处理
function SpringFestivalStoreDialogCell:OnTimeTick()
    self:RefreshTimeGroup(self._cellData)
end




function SpringFestivalStoreDialogCell:OnDestroy()
    self:CloseTimer()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return SpringFestivalStoreDialogCell