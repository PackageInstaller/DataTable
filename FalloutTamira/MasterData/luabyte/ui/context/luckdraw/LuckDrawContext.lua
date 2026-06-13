local LuckDrawContext = BaseClass( "LuckDrawContext" , BaseContext )
local M = LuckDrawContext
local MessageId = Proto.MessageId
local tInsert = table.insert

function M:Init()
    -- self._notifyUpdateLottoCallback = function(messageId,result,msg)
    --     if result ~= 0 then
    --         --GameHelper.Tips(CS.PlatformRuntime.MessageId.NotifyUpdateLottoRec .. "ErrorCode :" ..result)
    --         return 
    --     end
    --     self:_Broadcast(UIMessageNames.UPDATE_LOTTERY_DATA,msg.m_nType,msg.m_nData)
    -- end
    self._configs = nil 
    self._isLoading = false 
end

function M:Open(luckdrawShowAction)
    self._luckdrawShowAction = luckdrawShowAction
    if self._requestLuckDrawCallbackHandler then 
        NetPack:UnRegistResponse(MessageId.ResponseGameLotto,self._requestLuckDrawCallbackHandler)
    end
    self.isOpen = true

    self._requestLuckDrawCallbackHandler = NetPack:RegistResponse(MessageId.ResponseGameLotto,Bind( self,self._requestLuckDrawCallback ))
    -- NetPack:RegistResponse(CS.PlatformRuntime.MessageId.NotifyUpdateLottoRec,
    -- self._notifyUpdateLottoCallback )
    self.items ={}
    self.itemsNumber ={}
    self:_initCfg()
    self:_Show()
end

function M:OnClose()
    NetPack:UnRegistResponse( MessageId.ResponseGameLotto,self._requestLuckDrawCallbackHandler)
    self._requestLuckDrawCallbackHandler = nil 
    self.isOpen = false
    self._luckdrawShowAction = nil
    -- NetPack:UnRegistResponse(CS.PlatformRuntime.MessageId.NotifyUpdateLottoRec,
    -- self._notifyUpdateLottoCallback  )
    self:_Close()
end

function M:_Destory()

end

--抽卡
function M:Lotto(lottotId,times)
    if self._isLoading then
        return 
    end
    local items = LotteryHelper.CheckLotteryCost(lottotId, times == 1)
    local itemIds = {}
    for key, value in pairs(items) do
        tInsert(itemIds,value.Id)
    end
    local hasSpCost = LotteryHelper.CheckSpecialCost(lottotId, times == 1,itemIds) --检测是否有需要提示的道具
    if #items > 1 or hasSpCost then --当混合付费或有特殊道具时则提示
        local language = ConfigHelper.GetLocalString(1284)
        local tipstr = " " 
        for i = 1, #items do
            local itemcfg = ConfigHelper.GetCfg("item",items[i].Id)
            local itemName = ConfigHelper.GetLocalString(itemcfg.name)
            tipstr = tipstr..itemName .." x " ..items[i].Cnt .." "
        end
        GameHelper.Confirm(string.replace(language,"{0}",tipstr) ,
        function(ok)
            if ok then
                self:LottoRequest(lottotId,times,items)
            end
        end
        )    else
        self:LottoRequest(lottotId,times,items)
    end

end

function M:LottoRequest(lottotId,times,items)
    self._isLoading = true
    local request = {}
    request.LottoId = lottotId
    request.Times = times
    request.Items = items
    NetPack:SendMessage( MessageId.RequestGameLotto, request)
end



function M:_initCfg()
    if self._configs ~= nil then
        return
    end
    self._configs = {}
    local arr = ConfigHelper.GetCfgsByLua("luckDraw",{type = 2})
    for index, cfg in ipairs(arr) do
        if self._configs[cfg.id] == nil then
            self._configs[cfg.id] = cfg
        end
    end
end

function M:_requestLuckDrawCallback(messageId,result,msg)
    if not self.isOpen then
        return
    end

    local lottoId = msg.LottoId
    local curCfg = ConfigHelper.GetCfg("luckDraw",lottoId)
    if curCfg == nil or curCfg.type ~= 2 then
        return 
    end

    if result ~= 0 then
    self._isLoading = false 
    --GameHelper.Tips(CS.PlatformRuntime.MessageId.ResponseGameLotto .. "ErrorCode :" ..result)
        return 
    end

    self.items ={}
    self.itemsNumber = {}
    --print("msg length :" ..msg.Length)

    for i,v in ipairs(msg.Data) do
        print("ItemId : "..v.ObjId )
        tInsert(self.items,v.ObjId)
        -- v.ChipId 碎片ID
        tInsert(self.itemsNumber,v.ObjNum)
    end


    --观光资源
    local temItem = {}
    if not IsNull(msg.Other) and #msg.Other ~= 0 then
    for i = 1, #msg.Other do
        local data = msg.Other[i]
        if temItem[data.Id] ~= nil then
            temItem[data.Id] = temItem[data.Id]  + data.Cnt 
        else
            temItem[data.Id] = data.Cnt 
        end
        end
    end

    if temItem ~= nil and #temItem ~= 0 then
        for key, value in pairs(temItem) do
            tInsert(self.items,key)
            tInsert(self.itemsNumber,value)
        end
    end

    if #self.items == 0 then
        return
    end

    --UIContextMgr:GetInstance():Show("LuckDrawSignIn")
    if self._luckdrawShowAction ~= nil then
        self._luckdrawShowAction(self.items, self.itemsNumber)
    end

    self._isLoading = false 

    --GameHelper.ShowGetItemsById(self.items,nil,nil)
    --存储抽卡记录
    for key, value in pairs(temItem) do
        GameHelper.SaveLuckDrawData(curCfg.type,curCfg.id,key,value)
    end

end


return LuckDrawContext