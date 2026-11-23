




UICollectorPracticeBuffItem = {}

UICollectorPracticeBuffItem.__index = UICollectorPracticeBuffItem

function UICollectorPracticeBuffItem.New()
    local self = {}
    setmetatable(self, UICollectorPracticeBuffItem)
    return self
end

function UICollectorPracticeBuffItem:Init()
    self.item = nil;
    local uiLink = self.gameObject:GetComponent("UILink");
    self.imgBg = uiLink:Get("imgBg"):GetComponent("Image");
    self.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");
    self.imgBuffFrame = uiLink:Get("imgBuffFrame"):GetComponent("Image");
    self.imgBuffItemSelect = uiLink:Get("imgBuffItemSelect"):GetComponent("Image");
    self.textBuffName = uiLink:Get("textBuffName"):GetComponent("Text");
    self.textBuffIntro = uiLink:Get("textBuffIntro"):GetComponent("Text");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.goefflv = uiLink:Get("goefflv");
    self.goeffhuang = uiLink:Get("goeffhuang");
    self.animator = self.gameObject:GetComponent("Animator");
    self.isChoose=false;
self.cacheType=-1;
    uiLink:AddClickEvent("btnClick", function()
        if self.data.fun~=nil then
self.data.fun(self);
        end
    end)
end


function UICollectorPracticeBuffItem:SetData(data)
    SetActive(self.gameObject, true);
    self.data = data.data
    local buffConfig = json.decode(LuaMgr.GetBuffDes(self.data.Buffid))
    if buffConfig ~= nil and buffConfig ~= "" then
        self.imgBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon",buffConfig.BuffIcon)
        self.textBuffIntro.text = LuaMgr.GetLangText(self.data.BuffDesLan)
        self.textBuffName.text = LuaMgr.GetLangText(self.data.BuffNameLan);
    end
    self:SetBuffType(self.data.Type)
    self.isChoose=self.data.isChoose;
    self:SetChooseState(self.isChoose);
end

function UICollectorPracticeBuffItem:SetBuffType(type)
    if type~=1 then
        self.textBuffIntro.color=UnityEngine.Color(117/255.0,70/255.0,57/255.0,1);
    else
        self.textBuffIntro.color=UnityEngine.Color(63/255.0,87/255.0,66/255.0,1);
    end
    if self.cacheType==type then
        return;
    else
        self.cacheType=type;
    end
    SetActive(self.goefflv,type==1);
    SetActive(self.goeffhuang,type==2);
    self.imgBg.sprite=LuaMgr.GetSprite("CollectorBuffItem","ui_sx_buff"..type);
    self.imgBuffFrame.sprite=LuaMgr.GetSprite("CollectorBuffItem","ui_sx_buff"..type.."_jnk");
    self.imgBuffItemSelect.sprite=LuaMgr.GetSprite("CollectorBuffItem","ui_sx_buff"..type.."_xz");
end

function UICollectorPracticeBuffItem:SetChooseState(state)
    SetActive(self.imgBuffItemSelect.gameObject,state)
end

function UICollectorPracticeBuffItem:BuffTipsShowAnim()
    self.animator:Play("ani_UICollectorPracticeBuffItem_001",0,0);
end

function UICollectorPracticeBuffItem:BuffTipsCloseAnim()
    self.animator:Play("ani_UICollectorPracticeBuffItem_001_02",0,0);
end

function UICollectorPracticeBuffItem:ChooseBuffShowAnim()
    self.animator:Play("ani_UICollectorPracticeBuffItem_002",0,0);
end

function UICollectorPracticeBuffItem:AnimIsPlaying()
    return self.animator:GetCurrentAnimatorStateInfo(0).normalizedTime<1;
end

function UICollectorPracticeBuffItem:Hide()
    SetActive(self.gameObject, false);
end

function UICollectorPracticeBuffItem:Clear()
    self.data = nil
    self.isChoose=false;
    SetActive(self.gameObject, false);
end

function UICollectorPracticeBuffItem:Destroy()
    self.gameObject = nil
	self.transform = nil
    self.imgBg = nil;
    self.imgBuffIcon = nil;
    self.imgBuffFrame = nil;
    self.imgBuffItemSelect = nil;
    self.textBuffName = nil;
    self.textBuffIntro = nil;
    self.btnClick = nil;
    self.animator=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject)
end