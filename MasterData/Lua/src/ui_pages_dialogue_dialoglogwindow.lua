local page = class("dialogLogWindow", G_UIPageBase)

function page.bind()
  return {
    mainTable = {}
  }
end

function page.methods()
  return {
    onBtnReturn = function(self)
      L_UI:close("DialogLogWindow")
    end,
    onBtnBack = function(self)
      L_UI:close("DialogLogWindow")
    end
  }
end

function page:preOpen(options)
  local dialogueGroup = options.dialogueGroup
  local node = options.node
  self.bind.mainTable:clear()
  if not node then
    return
  end
  printf("ttt", node)
  local tableDatas = {}
  local nodeId = node.id
  repeat
    local node = dialogueGroup:getNode(nodeId)
    local nodeData = node.nodeData
    if node.__cname == "dialogue.actionNode" then
      local itemData = {}
      for _, action in ipairs(nodeData.actions) do
        if action.luaScriptPath == "modules.dialogue.action.dialogueAction" then
          local dialogueContent = action.dialogueContent
          local speakerStr, contentStr
          if dialogueContent.isReadTextId then
            local textId = dialogueContent.textId
            local skey = L_Config:getConfigDirectly("dialogue_text", textId, "speakerName")
            speakerStr = L_Lang:get(skey, {
              playerName = L_PlayerStore:getPlayerName()
            })
            local ckey = L_Config:getConfigDirectly("dialogue_text", textId, "content")
            contentStr = L_Lang:get(ckey, {
              playerName = L_PlayerStore:getPlayerName()
            })
          else
            speakerStr = dialogueContent.speakerName
            contentStr = dialogueContent.content
          end
          itemData.speaker = speakerStr
          itemData.content = contentStr
          local remark = action.speakActor
          local res2D = dialogueGroup:getActorResource("actor2D")
          local res3D = dialogueGroup:getActorResource("actor3D")
          local actor = res2D and res2D:getActor(remark)
          actor = actor or res3D and res3D:getActor(remark)
          if actor then
            do
              local data = actor:getData()
              local roleID = data.actorRoleId
              itemData.headIcon = L_RoleHelper:getHeadPath(roleID)
              itemData.identify = "dialogLogSpeakItem"
              itemData.moduleName = "pages/dialogue/dialogLogSpeakItem"
            end
            break
          end
          itemData.identify = "dialogLogVoiceItem"
          itemData.moduleName = "pages/dialogue/dialogLogVoiceItem"
          break
        end
      end
      if not string.isEmpty(itemData.content) then
        table.insert(tableDatas, itemData)
      end
    end
    nodeId = nodeData.prevNodeIdList and nodeData.prevNodeIdList[1]
  until nodeId == "" or nodeId == nil
  self.bind.mainTable:insert_array(tableDatas)
end

function page:close(options)
end

return page
