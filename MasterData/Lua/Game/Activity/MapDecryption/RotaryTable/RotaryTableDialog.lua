---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'
local ResourceModule = CS.Engine.Modules.ResourceModule
local RotateMode = CS.DG.Tweening.RotateMode
local Ease = CS.DG.Tweening.Ease
local Random = CS.UnityEngine.Random

------------ import ------------

------------ define ------------
local singleRadius = 360/8
------------ define ------------



--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalTurntableDialog.prefab
---@class RotaryTableDialog
---@field Env                           	RotaryTableDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtNumber2                    	UnityEngine.RectTransform
---@field TxtMore                       	UnityEngine.RectTransform
---@field ImgIcon2                      	UnityEngine.RectTransform
---@field BtnMore                       	UnityEngine.RectTransform
---@field TxtNumber1                    	UnityEngine.RectTransform
---@field ImgIcon1                      	UnityEngine.RectTransform
---@field BtnOne                        	UnityEngine.RectTransform
---@field ImgPoint5                     	UnityEngine.RectTransform
---@field ImgPoint4                     	UnityEngine.RectTransform
---@field ImgPoint3                     	UnityEngine.RectTransform
---@field ImgPoint2                     	UnityEngine.RectTransform
---@field ImgPoint1                     	UnityEngine.RectTransform
---@field UIFX_SpringFestival_Turntable_BigBox	UnityEngine.RectTransform
---@field BigBoxGroup                   	UnityEngine.RectTransform
---@field ImgArrowLeft                  	UnityEngine.RectTransform
---@field ImgArrowRight                 	UnityEngine.RectTransform
---@field ContentGroupParent            	UnityEngine.RectTransform
---@field ContentGroup                  	UnityEngine.RectTransform
local RotaryTableDialog = Class("RotaryTableDialog")
function RotaryTableDialog:__init()
    self.poolList = {}
    self.dojo = {}
    self.selectLuaIndex = 1 --当前页数
    self.rewardVoMap = {}--奖励表数据 --key id --value vo
    self.fadeOutRotaryGameObject = nil--用于淡出的当前转盘 
    self.fadeInRotaryGameObject = nil--用于淡入的转盘
    
end

function RotaryTableDialog:__delete()
    self.poolList = nil
    self.dojo = nil
    self.selectLuaIndex = nil
    self.rewardVoMap = nil
    self.fadeOutRotaryGameObject = nil
    self.fadeInRotaryGameObject = nil

    self.controller = nil
end

function RotaryTableDialog:Awake()
    self.__onRequestSuccess = Events.AddListener(MapDecryptionConstants.EventNames.RequestSuccess, Bind(self, self.OnRequestSuccess))


    --self:LoadScene()
end

function RotaryTableDialog:OnRequestSuccess(requestPath, responseData, requestData)
    if not (requestPath == Interfaces.ActivityMapDecryptionLuckyDraw) then
        return
    end
    local actualRotateNum = table.count(responseData.rewardIds)
    local isEarlyEnd = actualRotateNum < requestData.num
    if isEarlyEnd then
        for id, v in pairs(self.dojo[self.poolList[self.selectLuaIndex]]) do
            self.dojo[self.poolList[self.selectLuaIndex]][checkString(id)].num = self.rewardVoMap[id].stock
        end
    else
        for i, v in pairs(responseData.rewardIds) do
            self.dojo[self.poolList[self.selectLuaIndex]][checkString(v)].num = self.dojo[self.poolList[self.selectLuaIndex]][checkString(v)].num + 1
        end
    end
    
    
    
    local currentRotateNum = 1
    local singleRotateTime = (actualRotateNum > 1) and 3 or 5
    local fadeOutGoScr = CfUtils.GetLuaScr(self.fadeOutRotaryGameObject, "Game.Activity.MapDecryption.RotaryTable.RotaryTableNode")
    local circle = fadeOutGoScr:GetCirCle()
    local pointer = fadeOutGoScr:GetPointer()
    local function doRotateAnim(id)
        local resultPos = self.dojo[self.poolList[self.selectLuaIndex]][checkString(id)].pos
        local radius1 = 360*Random.Range(10, 20)--随机转的圈数角度
        local radius2Circle =  Random.Range(singleRadius*(resultPos-1), singleRadius*resultPos)
        local radius2Pointer = -(360-radius2Circle)
        
        circle:DOLocalRotate(Vector3.New(0, 0, radius1 + radius2Circle), singleRotateTime, RotateMode.FastBeyond360):SetEase(Ease.InOutCirc).onComplete = (function ()
            currentRotateNum = currentRotateNum + 1
            if currentRotateNum > actualRotateNum then--完成
                local rewards = responseData.rewards
                UIModule.OpenDialog(
                        {
                            id = Constants.UITypeIds.UICommonRewardPop,
                            parameters = { rewards = rewards, cb = function()
                                if checkNumber(responseData.nowPoolId) ~= checkNumber(requestData.poolId) then--切到下一页
                                    local num = table.keyof(responseData.nowPoolId)-table.keyof(requestData.poolId)
                                    
                                    self:OnClickRotaryTableChange(num)
                                end
                            end }
                        }
                )
                local poolData = MapDecryptionConfMgr:GetRotaryTableConfigVoById(self.poolList[self.selectLuaIndex])
                table.insert(rewards, {goodsId = poolData.consumeId, num = actualRotateNum})
                GoodsUtils.DrawRewards(rewards)
                CS.Engine.UI.UIRaycastBlocker.Instance:RemoveCondition("RotateRotaryTable")
            else
                doRotateAnim(responseData.rewardIds[currentRotateNum])
            end
        end)

        pointer:DOLocalRotate(Vector3.New(0, 0, radius1 + radius2Pointer), singleRotateTime, RotateMode.FastBeyond360):SetEase(Ease.InOutCirc)
        
    end
    
    doRotateAnim(responseData.rewardIds[currentRotateNum])




    --奖励弹出后移除
end





function RotaryTableDialog:OnFocus(focus)
end

function RotaryTableDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        
    end))
    return coWait
end

function RotaryTableDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitData()
        self:FreshBaseUI()
    end))
    return coWait
end                          

function RotaryTableDialog:InitData()
    self.poolList = {}
    local comp = MapDecryptionMgr:GetComponent()
    self.dojo = comp:GetRotaryTableData()
    for poolId, map in pairs(self.dojo) do
        table.insert(self.poolList, poolId)
        for id, v in pairs(map) do
            if isNull(self.rewardVoMap[id]) then
                self.rewardVoMap[id] = MapDecryptionConfMgr:GetRotaryTableRewardVoById(id)
            end
        end
    end
    table.sort(self.poolList, function (a,b)--按天数进行排序
        if a ~= b then
            return a < b
        end
        return false    
    end)
    self.fadeOutRotaryGameObject = self.ContentGroup
    self:SetDefaultSelectIndex()
    self:FreshPagePoint(self.selectLuaIndex, true)
    self:SetRotaryGameObject()
    self:SetBtnAction()
end


function RotaryTableDialog:SetBtnAction()
    SetButtonAction(self.ImgArrowLeft, function()
        self:OnClickRotaryTableChange(-1)
    end)
    SetButtonAction(self.ImgArrowRight, function()
        self:OnClickRotaryTableChange(1)
    end)
    SetButtonAction(self.BtnOne, function()
        self:OnClickRotate(1)
        
    end)
    SetButtonAction(self.BtnMore, function()
        self:OnClickRotate(10)

    end)
    
    
end

function RotaryTableDialog:OnClickRotate(num)
    local defaultLuaIndex = self:GetDefaultSelectIndex()
    if self.selectLuaIndex ~= defaultLuaIndex then
        return 
    end
    local poolData = MapDecryptionConfMgr:GetRotaryTableConfigVoById(self.poolList[self.selectLuaIndex])
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(poolData.consumeId)
    local num1 = GoodsUtils.GetThingNo(poolData.consumeId)--拥有道具数量
    local num2 = num1 / poolData.consumeNumSingle--拥有道具可抽取多少次
    --local num3 = Mathf.Clamp(num2, 1, 10)--实际抽取次数
    if num2 < num  then
        GameUtils.Toast(localize("_name_不足",{_name_ = goodsVo.name}))
        return
    end
    CS.Engine.UI.UIRaycastBlocker.Instance:AddCondition("RotateRotaryTable")
    MapDecryptionMgr:RequestRotaryTable(self.poolList[self.selectLuaIndex], num)
    
end

---@param num number 左切一页-1 右切一页1  可支持跨页切换
function RotaryTableDialog:OnClickRotaryTableChange(num)
    if (self:IsMin(self.selectLuaIndex) and num < 0) or (self:IsMax(self.selectLuaIndex) and num > 0) then
        return
    end
    self:FreshPagePoint(self.selectLuaIndex, false)
    self.selectLuaIndex = self.selectLuaIndex + num
    self:FreshPagePoint(self.selectLuaIndex, true)
    local fadeInGoScr = CfUtils.GetLuaScr(self.fadeInRotaryGameObject, "Game.Activity.MapDecryption.RotaryTable.RotaryTableNode")
    local data = self.dojo[self.poolList[self.selectLuaIndex]]
    fadeInGoScr:FreshBaseUI(data)
    local defaultLuaIndex = self:GetDefaultSelectIndex()
    local isGet = self.selectLuaIndex < defaultLuaIndex
    local isLock = self.selectLuaIndex > defaultLuaIndex
    fadeInGoScr:SetGetNodeActive(isGet)
    fadeInGoScr:SetLockNodeActive(isLock)
    

    KTool.SetActive(self.fadeInRotaryGameObject, true)
    
    if num > 0  then
        CfUtils.PlayAnimation(self.fadeOutRotaryGameObject, "SpringFestival_Turntable_R0")
        CfUtils.PlayAnimation(self.fadeInRotaryGameObject, "SpringFestival_Turntable_R1")
    elseif num < 0 then
        CfUtils.PlayAnimation(self.fadeOutRotaryGameObject,"SpringFestival_Turntable_L0")
        CfUtils.PlayAnimation(self.fadeInRotaryGameObject,"SpringFestival_Turntable_L1")
    end

    --swap
    local tmp = self.fadeOutRotaryGameObject
    self.fadeOutRotaryGameObject = self.fadeInRotaryGameObject
    self.fadeInRotaryGameObject = tmp

    --resetRotate
    self.fadeInRotaryGameObject.transform.localRotation = Quaternion.identity
    self.fadeOutRotaryGameObject.transform.localRotation = Quaternion.identity
end

function RotaryTableDialog:SetRotaryGameObject()
    if isNull(self.fadeInRotaryGameObject) then
        self.fadeInRotaryGameObject = CfUtils.InstantiateGo(self.ContentGroup, self.ContentGroupParent.gameObject)
        KTool.SetActive(self.fadeInRotaryGameObject, false)
    end
    if isNull(self.fadeOutRotaryGameObject) then
        self.fadeOutRotaryGameObject = self.ContentGroup
    end
end


function RotaryTableDialog:IsMin(luaIndex)
    return luaIndex <= 1
end

function RotaryTableDialog:IsMax(luaIndex)
    return luaIndex >= #self.poolList
end


function RotaryTableDialog:SetDefaultSelectIndex()
    for page, poolId in pairs(self.poolList) do
        local data = self.dojo[poolId]
        for id, v in pairs(data) do
            if v.num == 0 then
                self.selectLuaIndex = page
                return
            end
        end
    end
    self.selectLuaIndex = #self.poolList
end

function RotaryTableDialog:GetDefaultSelectIndex()
    local luaIndex = #self.poolList
    for page, poolId in pairs(self.poolList) do
        local data = self.dojo[poolId]
        for id, v in pairs(data) do
            if v.num == 0 then
                luaIndex = page
                return luaIndex
            end
        end
    end
    return luaIndex
end

function RotaryTableDialog:FreshPagePoint(luaIndex, isActive)
    CfUtils.SetUISwitchImage(self["ImgPoint"..luaIndex], isActive and 2 or 1)
end


function RotaryTableDialog:FreshBaseUI()
    local scr = CfUtils.GetLuaScr(self.fadeOutRotaryGameObject, "Game.Activity.MapDecryption.RotaryTable.RotaryTableNode")
    if scr then
        local data = self.dojo[self.poolList[self.selectLuaIndex]]
        scr:FreshBaseUI(data)
        local defaultLuaIndex = self:GetDefaultSelectIndex()
        local isGet = self.selectLuaIndex < defaultLuaIndex
        local isLock = self.selectLuaIndex > defaultLuaIndex
        scr:SetGetNodeActive(isGet)
        scr:SetLockNodeActive(isLock)
    end
    
    
    local poolData = MapDecryptionConfMgr:GetRotaryTableConfigVoById(self.poolList[self.selectLuaIndex])
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(poolData.consumeId)
    CfUtils.FillImage(self.ImgIcon1, goodsVo.photoPath)
    CfUtils.FillImage(self.ImgIcon2, goodsVo.photoPath)
    CfUtils.FillText(self.TxtNumber1, poolData.consumeNumSingle)
    CfUtils.FillText(self.TxtNumber2, poolData.consumeNumSingle*10)

end

--function RotaryTableDialog:FreshRotaryTable(GameObject, poolId)
--    local scr = CfUtils.GetLuaScr(GameObject, "Game.Activity.MapDecryption.RotaryTable.RotaryTableNode")
--    if scr then
--        scr:FreshBaseUI(vo.rewards)
--    end
--end


--function RotaryTableDialog:LoadScene()
--    if not isNull(self.sceneGo) then
--        printInfo("sceneGo not null")
--        return
--    end
--    local co = cs_coroutine.start(function ()
--        xTry(function()
--            local loader = ResourceModule.LoadBundleAsync("Arts/Prefab_item/staffRoom.prefab", nil, true)
--            while not loader.IsSuccess do
--                cs_coroutine.yield_return()
--            end
--            if not loader.IsError then
--                local go = loader:Instantiate()
--                CS.UnityEngine.GameObject.DontDestroyOnLoad(go)
--                go.name = "RoleClothesScene"
--                self.sceneGo = go
--            end
--            loader:Release()
--            loader = nil
--        end
--        )
--    end)
--    return co
--end
--
--function RotaryTableDialog:DisposeLoadRes()
--    if not isNull(self.sceneGo)  then
--        CS.UnityEngine.GameObject.Destroy(self.sceneGo)
--    end
--end

function RotaryTableDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.__onRequestSuccess then
            Events.RemoveListener(MapDecryptionConstants.EventNames.RequestSuccess, self.__onRequestSuccess)
        end
        --self:DisposeLoadRes()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return RotaryTableDialog