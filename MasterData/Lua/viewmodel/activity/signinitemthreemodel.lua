





SignInItemThreeModel = {}

SignInItemThreeModel.__index = SignInItemThreeModel
SignInItemThreeModel.numPathOne = "Assets/_BundleResources/Images/SignInActivity/PhaseThree/"
local objs = {
    normal = {path = "Normal",type = "GameObject"},

    canGet = {path = "CanGet",type = "GameObject"},
    getBtn = {path = "CanGet/Btn",type = "Button"},
    c_dayText = {path = "CanGet/DayText",type = "Text"},
    n_dayText = {path = "Normal/DayText",type = "Text"},
    already = {path = "Already",type = "GameObject"},
    already_Image = {path = "AlreadyImage",type = "GameObject"},
    a_dayText = {path = "Already/DayText",type = "Text"},
    numImage = {path = "NumImage",type = "RawImage"},
    rewardRoot = {path = "RewardList",type = "RectTransform"},
}

function SignInItemThreeModel.New()
    local self = {}
    setmetatable(self, SignInItemThreeModel)
    return self
end

function SignInItemThreeModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.SignInItemClickGetReward,self.data.id)
    end
    LuaMgr.AddClick(self.getBtn,self.getCommand)
end

function SignInItemThreeModel:SetData(data)
    self.data = data.data.data
    self.index = data.id
    self.state = data.data.state
    

    SetActive(self.normal,self.state == 1)
    SetActive(self.canGet,self.state == 2)
    SetActive(self.already,self.state == 3)
    SetActive(self.already_Image,self.state == 3)


    local numImage = nil
    if self.state ~= 3 then
        numImage = LuaMgr.GetTexture(self.numPathOne.."ui_sczm_sz"..self.index.."a.png")
    else
        numImage = LuaMgr.GetTexture(self.numPathOne.."ui_sczm_sz"..self.index.."b.png")
    end
    self.numImage.texture = numImage
    local dayStr = LuaMgr.GetLangText("SignInItemTwoModel_0")..string.format(ConfigMgr.LangGlobal("10911"),self.index)..LuaMgr.GetLangText("SignInItemTwoModel_1")
    self.n_dayText.text = dayStr
    self.a_dayText.text = dayStr
    self.c_dayText.text = dayStr
    
    self:SetReward()
    
    self.gameObject:SetActive(true)
end

function SignInItemThreeModel:SetReward()
    if TableIsNull(self.data.reward) then
        return
    end
    if TableIsNull(self.rewardList) then
        self.rewardList = {}
    end
    local itemConfig = nil
    for i = 1, #self.data.reward do
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.data.reward[i].id])
        if TableIsNull(itemConfig) then return end
        if #self.rewardList < i then
            table.insert(self.rewardList,GoodsDataItem.New(self.rewardRoot))
        end
        itemConfig["count0"] = self.data.reward[i].count
        self.rewardList[i]:SetData(i,itemConfig,1,false,Vector3(0.55,0.55,0.55),false)
    end
    for i = #self.data.reward + 1, #self.rewardList do
        self.rewardList[i]:Hide()
    end
end








function SignInItemThreeModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function SignInItemThreeModel:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    if not TableIsNull(self.rewardList) then
        for i = 1, #self.rewardList do
            self.rewardList[i]:Clear()
        end
        self.rewardList = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end