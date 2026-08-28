--- from: Assets/BundleResources/Prefabs/ResidentEvent/ResidentUpgradeBenefits.prefab > name: ResidentUpgradeBenefits
---@class Draw300TimesDialog
---@field Env                           	Draw300TimesDialog                      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PlayerTextNumber              	UnityEngine.RectTransform               	@ 0    
---@field ItermLvTextNumber1            	UnityEngine.RectTransform               	@ 1    
---@field ItermLvTextNumber2            	UnityEngine.RectTransform               	@ 2    
---@field ItermLvTextNumber3            	UnityEngine.RectTransform               	@ 3    
---@field Item1                         	UnityEngine.RectTransform               	@ 4    
---@field Item2                         	UnityEngine.RectTransform               	@ 5    
---@field Item3                         	UnityEngine.RectTransform               	@ 6    
---@field Slider                        	UnityEngine.UI.Slider                   	@ 7    
local Draw300TimesDialog = Class('Draw300TimesDialog')
---@type PlayerComponent
local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
function Draw300TimesDialog:__init()
    self.sliderPercentages = {0.314 , 0.662 ,1 }
    self.vos = {}
end


function Draw300TimesDialog:__delete()

end


function Draw300TimesDialog:Awake()
    ---@type FeiXingDraw300TimesVo[]
    local FeiXingDraw300TimesVos = CfUtils.GetWholeVo(AutoIds.IdSetting8943,"FeiXingDraw300TimesVo")
    if table.count(self.vos) == 0 then
        for k, v in ipairs(FeiXingDraw300TimesVos) do
            self.vos[#self.vos+1] = v 
        end
    end
end


function Draw300TimesDialog:Start()

end
function Draw300TimesDialog:Refresh(data)
    self:UpdateUI()
end
function Draw300TimesDialog:UpdateUI()
    ---@type PlayerDojo
    local playerDojo = PlayerComponent:GetPlayerDojo()
    local level = checkInt(playerDojo.level) 
    CfUtils.FillText(self.PlayerTextNumber , "Lv."  ..level )
    local currentTime = checkInt(playerDojo:GetServerTime()) 
    local loginServerTime = checkInt(playerDojo:GetLoginServerTime()) 
    local createDay = checkInt(playerDojo.loginDayNum) 
    local loginDay =  os.date("%Y.%m.%d", loginServerTime)
    local currentDay =  os.date("%Y.%m.%d", currentTime)
    if currentDay ~= loginDay then
        createDay = createDay + 1
        playerDojo.loginDayNum = createDay
    end
    local index =  #self.vos + 1
    for k, v in pairs(self.vos) do
        if checkInt(v.level) > level then
            index = k 
            break
        end
    end

    local percentValue = 1
    if index <= table.count(self.vos) then
        if index == 1 then
            ---@type FeiXingDraw300TimesVo
            local FeiXingDraw300TimesVo = self.vos[index]
            percentValue = checkInt(level)/FeiXingDraw300TimesVo.level * self.sliderPercentages[index]
        else
            ---@type FeiXingDraw300TimesVo
            local PreFeiXingDraw300TimesVo = self.vos[index-1]
            ---@type FeiXingDraw300TimesVo
            local FeiXingDraw300TimesVo = self.vos[index]
            local distanceLevel = FeiXingDraw300TimesVo.level - PreFeiXingDraw300TimesVo.level 
            percentValue = (level - PreFeiXingDraw300TimesVo.level)/ distanceLevel * (self.sliderPercentages[index] - self.sliderPercentages[index-1])  + self.sliderPercentages[index-1]
        end
    end
    self.Slider.value = percentValue
    self.levelLabels = {self.ItermLvTextNumber1 ,self.ItermLvTextNumber2, self.ItermLvTextNumber3}
    for k, gameObject in ipairs(self.levelLabels) do
        CfUtils.FillText(gameObject , "Lv." .. self.vos[k].level) 
    end
    self.items = { self.Item1 , self.Item2 , self.Item3}
    for i =1 , #self.items ,1 do
        ---@type Draw300TimesCell
        local item = CfUtils.GetLuaScr(self.items[i] , "Game.UI.Welfare.Draw300TimesCell")
        if isNotNull(item) then
            item:RefreshUI(self.vos[i] , createDay , level , function (id)
                GameUtils.Request(Interfaces.OverseaPlayerDrawRookieGift ,{giftId = id} ,function(request, response)
                    if checkNumber(response.errCode) == 0 then
                        ---@type PlayerComponent
                        local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
                        local drawnRookie2Gift = PlayerComponent:GetPlayerDojo().drawnRookie2Gift 
                        if not drawnRookie2Gift then
                            PlayerComponent:GetPlayerDojo().drawnRookie2Gift  = {}
                        end
                        table.insert(PlayerComponent:GetPlayerDojo().drawnRookie2Gift , id)
                        local rewards = response.data.rewards
                        GoodsUtils.DrawRewards(rewards, true)
                        CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewards , cb = function()
                            item:RefreshUI(self.vos[i] , createDay , level)
                        end })
                        if PlayerComponent:GetPlayerDojo().loginDayNum > table.count(PlayerComponent:GetPlayerDojo().drawnRookie2Gift) then
                            GameUtils.SetRedPointNum(Constants.RedPointConst.Draw300Times , 1)
                        else 
                            GameUtils.SetRedPointNum(Constants.RedPointConst.Draw300Times , 0)                            
                        end
                        GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.Draw300Times )
                    end     
                end)
            end)
        end
    end
end


function Draw300TimesDialog:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return Draw300TimesDialog
