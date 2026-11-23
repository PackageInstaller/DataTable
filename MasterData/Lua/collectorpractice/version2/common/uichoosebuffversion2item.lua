UIChooseBuffVersion2Item = {}

UIChooseBuffVersion2Item.__index = UIChooseBuffVersion2Item

function UIChooseBuffVersion2Item.New()
    local self = {}
    setmetatable(self, UIChooseBuffVersion2Item)
    return self
end

function UIChooseBuffVersion2Item:Init()
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");
		self.textBuffName = uiLink:Get("textBuffName"):GetComponent("Text");
		self.textBuffIntro = uiLink:Get("textBuffIntro"):GetComponent("Text");
		self.goIsSelected = uiLink:Get("goIsSelected");
        self.animator=uiLink:Get("root"):GetComponent("Animator");
        self.btnClick= uiLink:Get("btnClick"):GetComponent("Button");
        self.goNormalBG=uiLink:Get("goNormalBG");
        self.goSpecialBG=uiLink:Get("goSpecialBG");
        self.ScrollView=uiLink:Get("ScrollView"):GetComponent("HAndVScrollEventThrough");
        self.isChoose=false;
        self.groupIndex=0;
        self.data = nil;
        self.isInitHVScroll=true;
    uiLink:AddClickEvent("btnClick", function()
        if self.data.fun~=nil then
self.data.fun(self);
        end
    end)
end


function UIChooseBuffVersion2Item:SetData(data)
    SetActive(self.gameObject, true);
    self.data = data.data
    self.groupIndex=self.data.groupIndex;
    self.imgBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon",self.data.BuffIcon)
    self.textBuffIntro.text = LuaMgr.GetLangText(self.data.BuffDesLan)
    self.textBuffName.text = LuaMgr.GetLangText(self.data.BuffNameLan);
    self.isChoose=self.data.isChoose;
    self:SetChooseState(self.isChoose);
    local tempFun=function ()
        if self.data.fun~=nil then
self.data.fun(self);
        end
    end
    self.ScrollView:GetComponent("EventTriggerListener").onClick=tempFun;

    if self.data.fun==nil then
        SetActive(self.btnClick.gameObject,false);
    else
        SetActive(self.btnClick.gameObject,true);
    end
    local type=CollectorPracticeMgrVersion2.GetBuffType(self.data.Id);
    if type==2 then
        SetActive(self.goNormalBG,false);
        SetActive(self.goSpecialBG,true);
    else
        SetActive(self.goNormalBG,true);
        SetActive(self.goSpecialBG,false);
    end
if self.isInitHVScroll then
        self:SetParentScroll(self.data.scrollRect);
        self.isInitHVScroll=false;
    end
end

function UIChooseBuffVersion2Item:SetParentScroll(parentScroll)
    self.ScrollView:SetParentAndInit(parentScroll);
end

function UIChooseBuffVersion2Item:SetChooseState(state)
    self.isChoose=state;
    SetActive(self.goIsSelected,state)
end

function UIChooseBuffVersion2Item:ShowFirstAnimation()
    self.animator:Play("ani_UIChooseBuffVersion2Item_enter",0,0);
end

function UIChooseBuffVersion2Item:Hide()
    SetActive(self.gameObject, false);
end

function UIChooseBuffVersion2Item:Clear()
    self.isChoose=nil;
    self.data = nil;
    SetActive(self.gameObject, false);
end

function UIChooseBuffVersion2Item:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
	self.transform = nil
    self.groupIndex=nil;
		self.imgBuffIcon = nil;
		self.textBuffName = nil;
		self.textBuffIntro = nil;
		self.goIsSelected = nil;
        self.animator=nil;
        self.goNormalBG=nil;
        self.goSpecialBG=nil;
        self.isInitHVScroll=nil;
    end