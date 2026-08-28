local View = require("UIGuKaHandbook/UIGuKaHandbookView")
local DataModel = require("UIGuKaHandbook/UIGuKaHandbookDataModel")
local Controller = require("UIGuKaHandbook/UIGuKaHandbookController")
local ViewFunction = {
  GuKaHandbook_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_GuKa.gameObject.activeSelf then
      Controller:OpenType()
    elseif View.Group_Fireworks.gameObject.activeSelf then
      Controller:OpenType()
    elseif View.Group_Event.gameObject.activeSelf then
      Controller:OpenType()
    elseif View.Group_Type.gameObject.activeSelf then
      UIManager:GoBack()
    end
  end,
  GuKaHandbook_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  GuKaHandbook_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  GuKaHandbook_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  GuKaHandbook_Group_Type_Btn_GuKa_Click = function(btn, str)
    Controller:OpenGuKa()
  end,
  GuKaHandbook_Group_Type_Btn_Fireworks_Click = function(btn, str)
    Controller:OpenFireworks()
  end,
  GuKaHandbook_Group_Type_Btn_Event_Click = function(btn, str)
    Controller:OpenEvent()
  end,
  GuKaHandbook_Group_GuKa_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:SetGuKaElement(element, elementIndex)
  end,
  GuKaHandbook_Group_GuKa_ScrollGrid__Group_Item_Btn__Click = function(btn, str)
    Controller:ShowGuKaInfo(tonumber(str))
  end,
  GuKaHandbook_Group_Fireworks_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:SetFireworksElement(element, elementIndex)
  end,
  GuKaHandbook_Group_Event_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetEventElement(element, elementIndex)
  end,
  GuKaHandbook_Group_Event_Group_First_Btn_First_Click = function(btn, str)
    Controller:SelectEventTab(1)
  end,
  GuKaHandbook_Group_Event_Group_Again_Btn_Again_Click = function(btn, str)
    Controller:SelectEventTab(2)
  end,
  GuKaHandbook_Group_Event_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    Controller:ShowEventInfo(tonumber(str))
  end,
  GuKaHandbook_Group_Fireworks_ScrollGrid__Group_Item_Group__Btn__Click = function(btn, str)
    Controller:SelectFireworks(tonumber(str))
  end,
  GuKaHandbook_Group_GuKa_Group_Collect_Btn_Prompt_Click = function(btn, str)
    Controller:ClickGuKaPrompt()
  end,
  GuKaHandbook_Group_Fireworks_Group_Collect_Btn_Prompt_Click = function(btn, str)
    Controller:ClickFireworksPrompt()
  end,
  GuKaHandbook_Group_Event_Group_Collect_Btn_Prompt_Click = function(btn, str)
    Controller:ClickEventPrompt()
  end
}
return ViewFunction
