local KTool = CS.Engine.Lib.KTool
---@type Engine.UI.UIModule
local UIModule = CS.Engine.UI.UIModule

--- from: Assets/BundleResources/Prefabs/Activity/ActivityOpenLatticeRewardPopup1110.prefab > name: ActivityOpenLatticeRewardPopup1110
---@class ActivityOpenGridRewardDetailPopup
---@field Env                           	ActivityOpenGridRewardDetailPopup       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               
---@field TxtNum                        	UnityEngine.RectTransform               
---@field BigReward                     	Engine.Modules.LuaBehaviour               
---@field TxtBigRewardNum               	UnityEngine.RectTransform               
---@field TxtNormalGetNum               	UnityEngine.RectTransform               
---@field NormalRewardGrid              	SuperScrollView.LoopGridView            
local ActivityOpenGridRewardDetailPopup = Class("ActivityOpenGridRewardDetailPopup")

---@class ActivityOpenGridRewardDetailPopup.data
---@field floor number
---@field bigRewardId number
---@field grids number[]

function ActivityOpenGridRewardDetailPopup:__init()
    ---@type ActivityOpenGridRewardDetailPopup.data
    self.data = {}
end

function ActivityOpenGridRewardDetailPopup:__delete()
    self.controller = nil
end

function ActivityOpenGridRewardDetailPopup:Awake()
    SetButtonAction(self.BtnClose , function ()
        UIModule.CloseDialog(self.controller)
        --CfUtils.DialogBack()
    end)
end

function ActivityOpenGridRewardDetailPopup:OnInitialize() --LuaBehaviour 没有
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.data = initParams
        self:RefreshUI()
    end)
end

---@param focus boolean
function ActivityOpenGridRewardDetailPopup:OnFocus(focus) --LuaBehaviour 没有
end

function ActivityOpenGridRewardDetailPopup:RefreshData(data)
    self.data = data
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function ActivityOpenGridRewardDetailPopup:RefreshUI()
    ------ 数据处理
    local ids = CfUtils.GetIdGroupData(AutoIds.IdSetting6129,self.data.floor)
    local totalCount = 0
    local getCount = 0
    local normalRewards = {}
    for i, v in ipairs(ids) do
        ---@type OpenGridRewardVo
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting6129,"OpenGridRewardVo",v)
        normalRewards[vo.id] = {
            goodsId = vo.reward,
            goodsNum = vo.rewardNum,
            stock = vo.stock, 
            getCount = 0,
        }
        totalCount = totalCount + vo.stock
    end

    for i, v in pairs(self.data.grids) do
        if table.haskey(normalRewards,v) then
            normalRewards[v].getCount = normalRewards[v].getCount + 1
            getCount = getCount + 1
        end
    end
    local bigRewardData = normalRewards[self.data.bigRewardId]
    normalRewards[self.data.bigRewardId] = nil
    totalCount = totalCount - bigRewardData.stock
    getCount = getCount - bigRewardData.getCount

    self.normalRewards = {}
    for i, v in pairs(normalRewards) do
        table.insert(self.normalRewards,v)
    end
    ------
    
    ------ refresh big reward
    ---@type GoodNodeMB
    local bigRewardEnv = CfUtils.GetLuaScr(self.BigReward, "Game.Behaviours.GoodNodeMB")
    bigRewardEnv:Reload({
        goodsId = bigRewardData.goodsId,
        isShowNo = true,
        text = "x"..bigRewardData.goodsNum
    })
    bigRewardEnv:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(bigRewardData.goodsId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(self.BigReward.gameObject, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
    CfUtils.FillText(self.TxtBigRewardNum,localize("剩余:_num1_/_num2_",{_num1_ = bigRewardData.stock - bigRewardData.getCount , _num2_ =bigRewardData.stock}) )
    
    CfUtils.FillText(self.TxtNum,string.format("%d/%d",bigRewardData.stock - bigRewardData.getCount,bigRewardData.stock))
    -----
    
    CfUtils.FillText(self.TxtNormalGetNum, string.format("%d/%d",totalCount - getCount,totalCount))
    
    self:RefreshBigRewardLoopView()
end

function ActivityOpenGridRewardDetailPopup:RefreshBigRewardLoopView()
    if not self.NormalRewardGrid.IsListViewInit then
        self.NormalRewardGrid:InitGridView(table.count(self.normalRewards), Bind(self, self.OnGetGridItemByIndex))
    end
end

function ActivityOpenGridRewardDetailPopup:OnGetGridItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    
    local cell = listView:NewListViewItem("RewardNode")
    ---@type GoodNodeMB
    local goodsSrc = CfUtils.GetLuaScr(cell.transform:Find("GoodNode"), "Game.Behaviours.GoodNodeMB")
    local text = cell.transform:Find("ImgBg/TxtNum")
    if goodsSrc then
        local data = self.normalRewards[index + 1]
        goodsSrc:Reload({
            goodsId = data.goodsId,
            text = "x"..data.goodsNum,
            isShowNo = true,
        })
        goodsSrc:SetClickCallback(function() 
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.goodsId)
            if isTable(vo) then
                GameUtils.ShowCommonTipsBoard(goodsSrc.controller.gameObject, vo.name, vo.desc, vo.quality, vo.id)
            end
        end)
        --goodsSrc:SetSanXingGainShow(data.getCount == 1)
        CfUtils.FillText(text,localize("剩余:_num1_/_num2_",{_num1_ = data.stock - data.getCount , _num2_ =data.stock}) )
    end
    
    return cell
end

return ActivityOpenGridRewardDetailPopup