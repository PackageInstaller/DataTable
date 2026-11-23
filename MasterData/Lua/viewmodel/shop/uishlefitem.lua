
UIShlefItem = {}
UIShlefItem.__index = UIShlefItem

function UIShlefItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIShlefItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    self.goClose = uiLink:Get("goClose");
    self.goOpen = uiLink:Get("goOpen");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.textLable = uiLink:Get("textLable"):GetComponent("Text");
    self.textName2 = uiLink:Get("textName2"):GetComponent("Text");
    self.textLable2 = uiLink:Get("textLable2"):GetComponent("Text");
    self.imgBg = uiLink:Get("imgBg"):GetComponent("Image");
    self.goRedPoint=self.gameObject:GetComponent("RedIconListener");

    uiLink:AddClickEvent("rectContent", function()
        if  self.fun ~=nil and not self.isOn then
            self.fun(self.index)
        end
    end)
    return self
end


function UIShlefItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.rectContent = nil;
    self.goClose = nil;
    self.goOpen = nil;
    self.textName = nil;
    self.textLable = nil;
    self.textName2 = nil;
    self.textLable2 = nil;
    self.imgBg = nil;
end

function UIShlefItem:SetData(data,index,isOn,fun)
    self.data=data;
    self.fun=fun;
    self.index=index
    self.isOn=isOn;
    SetActive( self.goOpen,isOn)
    SetActive( self.goClose,not isOn)
    self.textName.text=LuaMgr.GetLangText(data.NameLan)
    self.textName2.text=self.textName.text;
    self.textLable.text=self.textName.text;
    self.textLable2.text=self.textName.text;
    self.goRedPoint.RedId="1146_"..index;
end

function UIShlefItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end