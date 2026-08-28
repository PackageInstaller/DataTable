local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
--- from: Assets/BundleResources/Prefabs/DailyCheck/DayCell3.prefab > name: DayCell1
---@class OneSignCell
---@field Env                           	OneSignCell                         I    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field GoodNode                      	Engine.Modules.LuaBehaviour             	@ 1    
---@field Repair                        	UnityEngine.RectTransform               	@ 2    
---@field Finish                        	UnityEngine.RectTransform               	@ 3    
---@field CheckAnim                     	UnityEngine.RectTransform               	@ 4    
---@field TextDate                      	UnityEngine.RectTransform               	@ 5    
---@field ImgReceive                    	UnityEngine.RectTransform               	@ 6    
---@field ImgSelect                     	UnityEngine.RectTransform               	@ 7    
---@field dialog                     	    SignTotalDialog
local OneSignCell = Class('OneSignCell')
local WeekDescr = {
    localize("周一"),
    localize("周二"),
    localize("周三"),
    localize("周四"),
    localize("周五"),
    localize("周六"),
    localize("周日"),
}
function OneSignCell:__init()
    self.day = nil
    self.dayTime = nil
    self.currentTime = nil
    self.unlockTime = nil
    self.status = nil
    self.type  = nil
    self.rewards = nil
    self.dialog = nil

end


function OneSignCell:__delete()
    self.day = nil
    self.dayTime = nil
    self.currentTime = nil
    self.unlockTime = nil
    self.status = nil
    self.type  = nil
    self.rewards = nil
    self.dialog = nil 
end

function OneSignCell:Awake()

end


---@param status Constants.GetStatus
function OneSignCell:RefeshUI( day , dayTime , unlockTime, currentTime , type , status , rewards , dialog)
    self.day = day
    self.dayTime = dayTime
    self.unlockTime = unlockTime
    self.currentTime = currentTime
    self.dialog = dialog
    self.type = type
    self.status = status
    self.rewards = rewards
    ---@type GoodNodeMB
    local ENV =  self.GoodNode.Env
    if isNull(self.GoodNode.Env) then
        self.GoodNode:Init()
        ENV = self.GoodNode.Env
    end
    ENV:Reload({
        goodsId = rewards[1].goodsId , 
        isShowNo = true , 
        text = "x" .. rewards[1].num  , 
    })
    -- 1. 已经领取
    if status == Constants.GetStatus.Has then
        KTool.SetActive(self.Finish , true)
        ENV:SetMarkGrayAlpha(true , 0.6)
        KTool.SetActive(self.Repair.gameObject ,false)
        CfUtils.FillText(self.TextDate , "")
        -- KTool.SetActive(self.CheckAnim , false)
        return
    end
    CfUtils.FillText(self.TextDate ,WeekDescr[day] )
    KTool.SetActive(self.GoodNode , true)
    -- 2. 可以补签
    if (currentTime - dayTime)  >= 86400 and (dayTime - unlockTime) >= 0 then   
        KTool.SetActive(self.Finish , false)
        ENV:SetMarkGrayAlpha(false , 1)
        KTool.SetActive(self.Repair , true)
        KTool.SetActive(self.CheckAnim , false)
        return
    end
    -- 2. 可以领取
    if (currentTime - dayTime) >= 0 and (currentTime - dayTime) < 86400 then
        KTool.SetActive(self.Repair , false)
        -- KTool.SetActive(self.CheckAnim , true)
        KTool.SetActive(self.Finish , false)
        ENV:SetMarkGrayAlpha(false , 1)
        self:Request()
        return
    end
    -- 3. 不可领取 不可补签
    KTool.SetActive(self.Repair , false)
    -- KTool.SetActive(self.CheckAnim , false)
    KTool.SetActive(self.Finish , false)
    ENV:SetMarkGrayAlpha(false , 1)

end

function OneSignCell:Start()
    ---@type GoodNodeMB
    local Env = self.GoodNode.Env
    Env:SetClickCallback(function ()
        self:Request()
    end)
end


function OneSignCell:Request()
    if self.status ==  Constants.GetStatus.Has  or
        (self.unlockTime - self.dayTime > 0) or 
        (self.dayTime - self.currentTime) > 0 then  
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(self.rewards[1].goodsId)
        GameUtils.ShowCommonTipsBoard(self.controller, vo.name, vo.desc, vo.quality, vo.id, true)   
        return 
    end
    -- 可以补签 

    if self.currentTime - self.dayTime >= 86400  and (self.dayTime - self.unlockTime) >= 0 then
        ---@type ContactSignInParamterVo
        local ContactSignInParamterVo =  CfUtils.GetCfVo(AutoIds.IdSetting6306,"ContactSignInParamterVo" , "1")
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(ContactSignInParamterVo.expend)
        GameUtils.SecondConfirm(localize('确认消耗<color=#e71f55>_num_ _name_</color>补签', {_num_ = ContactSignInParamterVo.num , _name_ = goodsVo.name}) , function ()
            local haveNo = GoodsUtils.GetThingNo(ContactSignInParamterVo.expend)
            local costNum = checkInt(ContactSignInParamterVo.num)
            if haveNo < costNum then
                GameUtils.Toast(localize('当前扩展所需的_name_不足', { _name_ = tostring(goodsVo.name)}))
                return
            end
            local dayNum = checkInt((self.dayTime - self.unlockTime)/86400 + 1) 
            GameUtils.Request(Interfaces.ContactSignWeeklySupplement ,{
                day = self.day ,
                type = self.type,
                continuousDay = dayNum 

            } ,  function(request, response)
                if checkNumber(response.errCode) ~= 0 then return end
                local jsonData = response.data
                local rewards = checkTable(jsonData.rewards)
                
                if #rewards > 0 then
                    
                    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })
                    local rewardsData = clone(rewards)
                    rewardsData[#rewardsData+1] = {
                        goodsId = ContactSignInParamterVo.expend , 
                        num =    - ContactSignInParamterVo.num 
                    }
                    GoodsUtils.DrawRewards(rewardsData)
                end
                self.dialog:Refresh()
                -- self.dialog:UpdateDrawSignRewardsUI(self.type , dayNum , self.day)
                self:RefeshUI(self.day , self.dayTime , self.unlockTime, self.currentTime , self.type ,Constants.GetStatus.Has  , self.rewards , self.dialog)
            end)
        end , nil ,nil ,6,{{goodsId = ContactSignInParamterVo.expend , num = ContactSignInParamterVo.num}})
        return
    end
    if self.currentTime - self.dayTime >= 0 and self.currentTime - self.dayTime < 86400  then
        GameUtils.Request(Interfaces.ContactSignIn ,{} ,  function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            local jsonData = response.data
            local rewards = checkTable(jsonData.rewards)
            if #rewards > 0 then
                GoodsUtils.DrawRewards(rewards)
                CfUtils.PlayAnimation(self.controller.gameObject)
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })
            end
            -- local dayNum = checkInt((self.dayTime - self.unlockTime)/86400) + 1
            -- self.dialog:UpdateDrawSignRewardsUI(self.type , dayNum , self.day)
            self.dialog:Refresh()
            self:RefeshUI(self.day , self.dayTime , self.unlockTime, self.currentTime , self.type ,Constants.GetStatus.Has  , self.rewards , self.dialog)
        end)
    end
end

function OneSignCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return OneSignCell
