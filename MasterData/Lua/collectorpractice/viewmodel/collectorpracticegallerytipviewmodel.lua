



local this = { }

require("CollectorPractice/Common/UICollectorChipItem")
require("CollectorPractice/Common/UICollectorCardItem")
local gallerytype=nil;
local PosLimit = { }
local tarGameObject = nil;
local tarRect = nil;
local rectBody=nil;
local onDrag;
local localPosition = nil;
local textMuseumName =nil;
local textFullName=nil;
local uiCollectorCardItem=nil;
local textDes=nil;
local reawImage=nil;
local rectIcon=nil;
local goMenumItem=nil;
local sliderValue=nil;
local chipItems={};
local rectContent =nil;
local textMessage=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    rectBody=uiLink:Get("rectBody"):GetComponent("RectTransform");
    onDrag=uiLink:Get("rectBody"):GetComponent("OnDragBehaviour");
    textMuseumName=uiLink:Get("textMuseumName"):GetComponent("Text");
    textFullName=uiLink:Get("textFullName"):GetComponent("Text");
    textDes=uiLink:Get("textDes"):GetComponent("Text");
    reawImage=uiLink:Get("rawImage"):GetComponent("RawImage");
    rectIcon=uiLink:Get("rawImage"):GetComponent("RectTransform");
    goMenumItem=uiLink:Get("goMenumItem");
    sliderValue=uiLink:Get("sliderValue"):GetComponent("Slider");
    rectContent=uiLink:Get("rectContent"):GetComponent("RectTransform");
    textMessage=uiLink:Get("textMessage"):GetComponent("Text");
    
    uiCollectorCardItem=UICollectorCardItem.New(uiLink:Get("rectPoint"):GetComponent("RectTransform"),Vector3(1,1,1))
    
    onDrag.onDrag = this.OnDrag
    onDrag.onPointerDown = this.PointerDown
    
    PosLimit = { LuaMgr.ScreenWidth() / 2, -(LuaMgr.ScreenWidth() / 2), 512, -512 }
    
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.CollectorPracticeGalleryTipViewModel)
    end)

    uiLink:AddClickEvent("btnReture",function()
        SetActive(goMenumItem,false);
        rectBody.anchoredPosition = Vector2.zero;
    end)
    
    uiLink:AddClickEvent("btnBig",function()
        SetActive(goMenumItem,true);
        sliderValue.value = 0.01
        rectIcon.localScale = Vector3.one
    end)
    
    uiLink:AddSliderEvent("sliderValue",function(param)
        rectIcon.localScale = Vector3.one + Vector3(param, param, 0)
    end)
end

this.Clear = function()

    for i = 1, #chipItems do
        chipItems[i]:Destroy();
    end

    chipItems=nil;
    tarGameObject = nil
    tarRect = nil
    rectBody=nil;
    onDrag=nil;
    localPosition=nil;
    textMuseumName=nil;
    uiCollectorCardItem:Destroy();
    uiCollectorCardItem=nil;
    textFullName=nil;
    textDes=nil;
    reawImage=nil;
    rectIcon=nil;
    sliderValue=nil;
    rectContent=nil;
    textMessage=nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            local data = vm.behaviour.Params[0]
            gallerytype = vm.behaviour.Params[1]
            local chipId=nil;
if vm.behaviour.Params.Length>2 then
                chipId= vm.behaviour.Params[2]
            end
            if data == nil then
                print("InitShowMessage tabledatas is err")
                return ;
            end
if chipId~=nil and CollectorPracticeMgr.HaveThisCard(chipId) then
                data.Achieve=true;
            end
            SetActive(goMenumItem, false);
            rectBody.anchoredPosition = Vector2.zero
            sliderValue.value = 0.01
            local GALLERY_PAth = "Assets/_BundleResources/Images/CollectorGallery/";
            reawImage.texture = LuaMgr.GetTexture(GALLERY_PAth .. data.RelicsId .. ".png")
            uiCollectorCardItem:SetData(data);
            textFullName.text = LuaMgr.GetLangText(data.FullNameLan)
            textDes.text = LuaMgr.GetLangText(data.RelicTextLan)
            textMuseumName.text = LuaMgr.GetLangText(data.MuseumNameLan)
            textMessage.text=LuaMgr.GetLangText(ConfigMgr.Config.OriginsTalentMap[data.OriginsID].OtNameLan)

            local len=data.ActivateType==1 and #data.ActivateParam1 or 0;
            for i = 1, len do
                if i>#chipItems then
                    table.insert(chipItems,UICollectorChipItem.New(rectContent))
                end
                SetActive(chipItems[i].gameObject,true)
                chipItems[i]:SetData(data.ActivateParam1[i],data.Achieve,true);
            end

            for i = len+1, #chipItems do
                chipItems[i]:Clear();
            end
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/window_S.mp3");
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if gallerytype == 2 then
                LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorCloseGalleryTip);
            end
            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedOpenEffect);
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.CloseCollectorCloseGalleryTip);
    end,
    before_destroy = function(vm)
        this.Clear();
    end
}

this.PointerDown = function(eventData)
    localPosition = LuaMgr.Screen2Local(eventData.position, rectBody)
end

this.OnDrag = function(eventData)
    local tarPos = LuaMgr.Screen2Local(eventData.position, rectBody)
    local dirVector = tarPos - localPosition
    if rectBody.anchoredPosition.x > PosLimit[1] and dirVector.x > 0 then
        dirVector = Vector2(0, dirVector.y)
    end
    if rectBody.anchoredPosition.x < PosLimit[2] and dirVector.x < 0 then
        dirVector = Vector2(0, dirVector.y)
    end
    if rectBody.anchoredPosition.y > PosLimit[3] and dirVector.y > 0 then
        dirVector = Vector2(dirVector.x, 0)
    end
    if rectBody.anchoredPosition.y < PosLimit[4] and dirVector.y < 0 then
        dirVector = Vector2(dirVector.x, 0)
    end

    rectBody.anchoredPosition = rectBody.anchoredPosition + dirVector
end

return vm({
    hook = hook
})