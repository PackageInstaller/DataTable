local KTool = CS.Engine.Lib.KTool
--- from: Assets/BundleResources/Prefabs/DailyCheck/DailyCheckCalendarDialog.prefab > name: Cell
---@class SignCalendarCell
---@field Env                           	SignCalendarCell                        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgBg                         	UnityEngine.RectTransform               	@ 0    
---@field BtnNode                       	UnityEngine.RectTransform               	@ 1    
---@field ImgSymbol                     	UnityEngine.RectTransform               	@ 2    
---@field TextDesc                      	UnityEngine.RectTransform               	@ 3    
---@field TextNumber                    	UnityEngine.RectTransform               	@ 4    
---@field StatusFinish                  	UnityEngine.RectTransform               	@ 5    
local SignCalendarCell = Class('SignCalendarCell')


function SignCalendarCell:__init()
    self.day = nil
    self.isSelect = false 
    self.isSign = false
    self.isUnlock = nil
    self.cb = nil
end


function SignCalendarCell:__delete()
    self.day = nil
    self.cb = nil
    self.isSelect = nil 
    self.isSign = nil
    self.isUnlock = nil
end


function SignCalendarCell:Awake()
    SetButtonAction(self.BtnNode , function ()
        if isNull(self.day) then
            return
        end
        if self.isSign then
            GameUtils.Toast(localize("当前日期已签到") )
            return
        end
        if not self.isUnlock then
            GameUtils.Toast(localize("当前日期不可补签"))
            return 
        end
        if self.isSelect then
            self.isSelect = false
            CfUtils.SetUISwitchImage(self.ImgBg , 2)
            CfUtils.SetUISwitchText(self.TextDesc , 2)
            CfUtils.SetUISwitchText(self.TextNumber , 2)
        else 
            self.isSelect = true 
            CfUtils.SetUISwitchImage(self.ImgBg , 3)
            CfUtils.SetUISwitchText(self.TextDesc , 3)
            CfUtils.SetUISwitchText(self.TextNumber , 3)
        end
        KTool.SetActive(self.StatusFinish , false)
        self.cb(self.day , self.isSelect)
    end)
end


function SignCalendarCell:Start()

end

function SignCalendarCell:SetCallBack(cb)
    self.cb = cb 
end
function SignCalendarCell:RefreshUI(day , isSign, isSelect , isUnlock , notReplaceSign)
    self.day = day 
    self.isUnlock = isUnlock 
    self.isSelect = isSelect
    self.isSign = isSign
    if self.day == "0" then
        KTool.SetActive(self.TextDesc , false)
        KTool.SetActive(self.TextNumber , false)
        CfUtils.SetUISwitchImage(self.ImgBg , 2)
        CfUtils.SetUISwitchText(self.TextNumber , 2)
        KTool.SetActive(self.StatusFinish , false)
        return
    end
    KTool.SetActive(self.TextDesc , true)
    KTool.SetActive(self.TextNumber , true)
    local strs = string.split(day, "-")
    local day = strs[3]
    CfUtils.FillText(self.TextNumber , day)
   
    if isSign then
        CfUtils.SetUISwitchImage(self.ImgBg , 1)
        CfUtils.SetUISwitchText(self.TextDesc , 1)
        CfUtils.SetUISwitchText(self.TextNumber , 1)
        KTool.SetActive(self.StatusFinish , true)
        return
    end
    if isSelect then
        CfUtils.SetUISwitchImage(self.ImgBg , 3)
        CfUtils.SetUISwitchText(self.TextDesc , 3)
        CfUtils.SetUISwitchText(self.TextNumber , 3)
        KTool.SetActive(self.StatusFinish , false)
        return
    end

    if not notReplaceSign then
        CfUtils.SetUISwitchImage(self.ImgBg , 1)
        CfUtils.SetUISwitchText(self.TextDesc , 1)
        CfUtils.SetUISwitchText(self.TextNumber , 1)
        KTool.SetActive(self.StatusFinish , false)
        return
    end
    CfUtils.SetUISwitchText(self.TextNumber , 2)
    CfUtils.SetUISwitchImage(self.ImgBg , 2)
    CfUtils.SetUISwitchText(self.TextDesc , 2)
    KTool.SetActive(self.StatusFinish , false)
end


function SignCalendarCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return SignCalendarCell
