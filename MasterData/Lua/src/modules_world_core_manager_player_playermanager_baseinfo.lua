local this = {}

function this:modifyName()
  local lastChangeNameTime = L_PlayerStore:getLastChangeNameTime()
  local canEdit = L_TimeUtil.getServerTime() >= lastChangeNameTime + 604800
  if not canEdit then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_changename_cd", {
      time = L_TimeUtil.secondToString(lastChangeNameTime + 604800 - L_TimeUtil.getServerTime(), L_TimeUtil.secondToStringShowType.TWO_UNIT)
    }))
    return
  end
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_playercard_changesignature"),
    placeHolder = L_WordsTpl:getValue("ui_playercard_inputnewname"),
    txtContent = L_PlayerStore:getPlayerName(),
    limit = 7,
    tip = L_WordsTpl:getValue("ui_playercard_changenamecd"),
    textBoxType = L_Const.CommonTextBoxType.Rename,
    keepPageOpen = true,
    ignoreBgClose = true,
    confirmCallback = function(txt)
      if string.isEmpty(string.trim(txt)) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_emptyname"))
        return
      end
      if string.gsub(txt, " ", "") ~= txt then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_changename_nospace"))
        return
      end
      if txt == L_PlayerStore:getPlayerName() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_samename"))
        return
      end
      local data = {
        txtContent = L_WordsTpl:getValue("ui_playercard_determine_changename", {name = txt}),
        confirmCallback = function()
          L_PlayerStore:req_modifyName(txt, function()
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_changename_success"))
            L_UI:close("pageCommonTextBox")
          end)
        end
      }
      L_GameUtil.showCommonTip(data)
    end
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:modifySign()
  local data = {
    txtTitle = L_WordsTpl:getValue("ui_playercard_changename"),
    placeHolder = L_WordsTpl:getValue("ui_playercard_inputnewsignature"),
    txtContent = L_PlayerStore:getSign(),
    limit = 20,
    textBoxType = L_Const.CommonTextBoxType.Signature,
    keepPageOpen = true,
    confirmCallback = function(txt)
      L_PlayerStore:req_modifySign(txt, function()
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_changesignature_success"))
        L_UI:close("pageCommonTextBox")
      end)
    end,
    ignoreBgClose = true
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:copyUid(uid)
  Unity.GUIUtility.systemCopyBuffer = uid
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_playercard_copyplayerid"))
end

return this
