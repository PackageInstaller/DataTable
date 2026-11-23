UITool = {}



UITool.Text = "Text"
UITool.Button = "Button"
UITool.GameObject = "GameObject"
UITool.Transform = "Transform"
UITool.RectTransform = "RectTransform"
UITool.Image = "Image"
UITool.RawImage = "RawImage"
UITool.Slider = "Slider"
UITool.Animator = "Animator"
UITool.InputField = "InputField"
UITool.HorizontalLayoutGroup = "HorizontalLayoutGroup"
UITool.CanvasGroup = "CanvasGroup"
UITool.ScrollRect = "ScrollRect"
UITool.Toggle = "Toggle"
UITool.ToggleGroup = "ToggleGroup"

UITool.OnDragEvent = "OnDragEvent"
UITool.OnDragBehaviour = "OnDragBehaviour"
UITool.UIRotateByCurve = "UIRotateByCurve"
UITool.RedIconListener = "RedIconListener"
UITool.DrawingAdjustTool = "DrawingAdjustTool"
UITool.UISpineCharacter = "UISpineCharacter"
UITool.UIVideoPlayer = "UIVideoPlayer"
UITool.UIGray = "UIGray"
UITool.PlayerDynamicAvatar = "PlayerDynamicAvatar"
UITool.GoodsViewModel = "GoodsViewModel"
UITool.ParticleSystem = "ParticleSystem"
UITool.Canvas = "Canvas"
UITool.OutlineEx = "OutlineEx"






UITool.Parse = function (gameObject, this, objs)
    local ui;
    local transform = gameObject.transform;
    for k, v in pairs(objs) do
        if (v.path == "") then
            this[k] = transform:GetComponent(v.type);
        else
            ui = transform:Find(v.path);
            if ui == nil then
                print(v.path, v.type, "not found.");
            end
            if (v.type == "Transform") then
                this[k] = ui;
            elseif (v.type == nil or v.type == "GameObject") then
                this[k] = ui.gameObject;
            else
                this[k] = ui:GetComponent(v.type);
            end
        end
    end
end

