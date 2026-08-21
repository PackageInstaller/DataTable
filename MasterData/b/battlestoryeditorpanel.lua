---@class BattleStoryEditorPanel : BattleStoryEditorPanel_Generate
---##################### 【BattleStoryEditorPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleStoryEditorPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleStoryEditorPanel = require "BattleStoryEditorPanel_Generate"
local BattleCore = require "BattleCore"
local Screen = UnityEngine.Screen

function BattleStoryEditorPanel:InitLogic(data)
    self.nowSelectBlock = nil

    self.originalBlock = nil

    self.isSelectBlock = false

    self.actionType = nil

    self.inputParamValueList = {}

    self.storyActionCHS = {
        [GE.BattleStoryAction.RoleMove] = "角色移动",
        [GE.BattleStoryAction.RoleTurn] = "角色转向",
        [GE.BattleStoryAction.RoleAction] = "角色动作",
        [GE.BattleStoryAction.RoleSpeak] = "角色对话",
        [GE.BattleStoryAction.RoleEmote] = "角色表情",
        [GE.BattleStoryAction.CameraMove] = "相机移动",
        [GE.BattleStoryAction.CameraZoom] = "相机缩放",
        [GE.BattleStoryAction.Wait] = "等待",
        [GE.BattleStoryAction.SetBGM] = "背景音乐",
        [GE.BattleStoryAction.PlaySE] = "播放音效",
        [GE.BattleStoryAction.GalStory] = "AVG",
        [GE.BattleStoryAction.EndStory] = "结束剧情",
        [GE.BattleStoryAction.InitRole] = "初始化角色",
        [GE.BattleStoryAction.InitCamera] = "初始化相机",
        [GE.BattleStoryAction.InitMap] = "初始化地图",
        [GE.BattleStoryAction.RoleVisible] = "角色可见性",
        [GE.BattleStoryAction.RoleAttack] = "角色攻击",
        [GE.BattleStoryAction.ShowEffect] = "显示特效",
    }

    self.xlSTitleTypeData = {
        [GE.BattleStoryAction.RoleMove] = {
            paramTextList = {
                "起始格子",
                "终点格子",
                "移动动作",
                "停止动作",
            }
        },
        [GE.BattleStoryAction.RoleTurn] = {
            paramTextList = {
                "朝向",
            }
        },
        [GE.BattleStoryAction.RoleAction] = {
            paramNum = 2,
            paramTextList = {
                "重复次数",
                "动作名称",
                "动作类型",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.RoleSpeak] = {
            paramNum = 6,
            paramTextList = {
                "气泡类型",
                "气泡位置",
                "额外时长",
                "对话内容",
                "头像表情",
                "发言者",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.RoleEmote] = {
            paramNum = 1,
            paramTextList = {
                "表情名称",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.CameraMove] = {
            paramTextList = {
                "相机位置",
                "移动时间",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.CameraZoom] = {
            paramTextList = {
                "缩放系数",
                "缩放时间",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.Wait] = {
            paramTextList = {
                "等待时间",
            },
        },
        [GE.BattleStoryAction.EndStory] = {
            paramTextList = {
                "结束方式",
            },
        },
        [GE.BattleStoryAction.InitRole] = {
            paramTextList = {
                "初始位置",
                "初始朝向",
                "初始动作",
                "是否显示",
                "替换资源",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.InitCamera] = {
            paramNum = 2,
            paramTextList = {
                "相机位置",
                "缩放系数",
            },
            needInputParam = true,
        },
        [GE.BattleStoryAction.InitMap] = {
            paramNum = 0,
            paramTextList = {
            },
        },
        [GE.BattleStoryAction.RoleVisible] = {
            paramNum = 1,
            paramTextList = {
                "角色状态",
            },
        },
        [GE.BattleStoryAction.RoleAttack] = {
            paramNum = 2,
            paramTextList = {
                "角色技能",
                "受击目标",
            },
        },
        [GE.BattleStoryAction.ShowEffect] = {
            paramNum = 3,
            paramTextList = {
                "特效名称",
                "延迟时间",
                "屏幕震动",
            },
        },
    }
end

function BattleStoryEditorPanel:resetData()
    self.nowSelectBlock = nil

    self.originalBlock = nil

    self.isSelectBlock = false

    self.actionType = nil

    self.inputParamValueList = {}

    if self.selectAreaObj then
        PoolMgr.Free(self.selectAreaObj)
    end
end

function BattleStoryEditorPanel:Update()
    if Input.GetMouseButtonDown(0) then
        if (self._battleMgr:isPointerOverUIObject()) then
			-- 检测到UI
			return
		end
        if self.isSelectBlock then
            local camera = self._showMgr.camera
            if self.selectAreaObj then
                PoolMgr.Free(self.selectAreaObj)
            end
            if (camera) then
                local ray, hit = UnityEngine.Physics.Raycast(camera.main:ScreenPointToRay(Input.mousePosition), nil, 9999, LayerMask.GetMask("Square"))
                if (hit ~= nil) then
                    local hitObj = hit.transform.gameObject
                    local block = self._showMgr:getBlockByObj(hitObj)
                    if not block then
                        return
                    end
                    PoolMgr:Get(Config.PrefabPath.SkillArea, function (obj)
                        obj.transform.localScale = Vector3.New(0.5, 0.5, 0.5)
                        self.selectAreaObj = obj
                        self.nowSelectBlock = self._showMgr:getBlockObj(block.id)
                        self.selectAreaObj.transform.position = self.nowSelectBlock.transform.position
                        self.selectAreaObj:SetActive(true)
                    end)
                end
            end
        end
    end
end

--初始化操作面板
function BattleStoryEditorPanel:InitNewAction()
    --设置弹窗位置
    local blockObj = self._showMgr:getBlockObj(self.originalBlock.id)
	local sreenPoint = self._showMgr.cameraObj:GetComponent(typeof(UnityEngine.Camera)):WorldToScreenPoint(blockObj.transform.position)
	local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
		UIMgr.uiCanvas:GetComponent(TypeInfo.RectTransform), Vector2.New(sreenPoint.x, sreenPoint.y), GameObject.Find("UICamera").gameObject:GetComponent("Camera"), nil)

    self.actionList.transform.localPosition = screenPos + Vector3.New(280, 100, 0)
        + Vector3.New(screenPos.x * 0.025, -screenPos.y * 0.05, 0)
    self.inputParamList.transform.localPosition = screenPos + Vector3.New(150, 100, 0)
    + Vector3.New(screenPos.x * 0.025, -screenPos.y * 0.05, 0)

    --根据格子信息显示功能按钮
    local hasRole = self.originalBlock.roleId and true or false
    self.confirmBtn:SetActive(false)
    self.cancelBtn:SetActive(false)
    self.creatRoleBtn:SetActive(not hasRole)
    self.roleMoveBtn:SetActive(hasRole)
    self.roleTurnBtn:SetActive(hasRole)
    self.roleActionBtn:SetActive(hasRole)
    self.roleEmoteBtn:SetActive(hasRole)
    self.roleSpeakBtn:SetActive(hasRole)
    self.cameraMoveBtn:SetActive(true)
    self.cameraZoomBtn:SetActive(true)
end

--显示编辑界面菜单
function BattleStoryEditorPanel:showNewAction(data)
    self.newAction:SetActive(true)
    self.originalBlock = data.block
    self:InitNewAction()
end

--隐藏编辑界面菜单
function BattleStoryEditorPanel:hideNewAction()
    self.bg:SetActive(true)
    self.newAction:SetActive(false)
    self.actionList:SetActive(true)
    self.confirmBtn:SetActive(true)
    self.cancelBtn:SetActive(true)
    self.inputParamList:SetActive(false)
    self:resetData()
end

--初始化操作面板
function BattleStoryEditorPanel:InitEditorAction()
    local nowCutId = -1
    local colorType = 0
    self:FillTemplateContent(self.actionBox, self.actionBoxList, #self.storyScript, function (index,actionBox)
        local scriptData = self.storyScript[index]
        actionBox.iDInputField.inputField.text = scriptData.id
        actionBox.cutIDInputField.inputField.text = scriptData.cutId

        actionBox.actionTypeInputField.inputField.text = scriptData.actType
        actionBox.actionTypeInputField.inputField.onEndEdit:RemoveAllListeners()
        actionBox.actionTypeInputField.inputField.onEndEdit:AddListener(function ()
            scriptData.actType = actionBox.actionTypeInputField.inputField.text
            self:saveStoryScript(index)
        end)

        actionBox.targetInputField.inputField.text = scriptData.target
        actionBox.targetInputField.inputField.onEndEdit:RemoveAllListeners()
        actionBox.targetInputField.inputField.onEndEdit:AddListener(function ()
            scriptData.target = actionBox.targetInputField.inputField.text
            self:saveStoryScript(index)
        end)

        for i = 1, 7 do
            actionBox["param"..i.."InputField"].inputField.text = scriptData["parameter"..i]
            local xlsTitleData = self.xlSTitleTypeData[scriptData.actType]
            actionBox.actionTypeText.text.text = self.storyActionCHS[scriptData.actType] or "未知类型"
            if xlsTitleData and xlsTitleData.paramTextList[i] then
                actionBox["param"..i.."Text"].text.text = xlsTitleData.paramTextList[i]
            end
            if not xlsTitleData then
                LuaLogger.ds("没有此类型！",scriptData.actType)
            end
            actionBox["param"..i.."InputField"].inputField.onEndEdit:RemoveAllListeners()
            actionBox["param"..i.."InputField"].inputField.onEndEdit:AddListener(function ()
                scriptData["parameter"..i] = actionBox["param"..i.."InputField"].inputField.text
                self:saveStoryScript(index)
            end)
        end
        --颜色区分不同cut内容
        if nowCutId ~= scriptData.cutId then
            colorType = colorType + 1
            if colorType == 4 then
                colorType = 1
            end
            nowCutId = scriptData.cutId
        end
        if colorType == 1 then
            actionBox.image.color = Color.NewFromStr("ECE7C3")
        elseif colorType == 2 then
            actionBox.image.color = Color.NewFromStr("C3ECC4")
        elseif colorType == 3 then
            actionBox.image.color = Color.NewFromStr("C3D8EC")
        end
    end)

    self.scrollView.rectTransform.anchoredPosition = Vector3.New(-1040, 0, 0) 
end

--选择格子
function BattleStoryEditorPanel:changeSelectBlockState(isSelect)
    self.isSelectBlock = isSelect
end

--选择对应功能通用设置
function BattleStoryEditorPanel:setPanelShowByType(actionType)
    self.bg:SetActive(false)
    self.actionList:SetActive(false)
    self.confirmBtn:SetActive(true)
    self.cancelBtn:SetActive(true)
    self.actionType = actionType

    local paramNum = self.xlSTitleTypeData[actionType].paramNum
    local paramTextList = self.xlSTitleTypeData[actionType].paramTextList
    local needInputParam = self.xlSTitleTypeData[actionType].needInputParam

    --部分类型编辑器中自动获取部分参数，修改需要填入的参数数量
    if actionType == GE.BattleStoryAction.CameraMove then
        paramNum = 1
        paramTextList = {
            "移动时间",
        }
    elseif actionType == GE.BattleStoryAction.CameraZoom then
        paramNum = 1
        paramTextList = {
            "缩放时间",
        }
    elseif actionType == GE.BattleStoryAction.CameraZoom then
        paramNum = 3
        paramTextList = {
            "角色id",
            "初始朝向",
            "初始动作",
        }
    end
    if needInputParam then
        self:FillTemplateContent(self.inputParam, self.inputParamList, paramNum, function (index,inputParam)
            inputParam.inputField.placeholder.text = paramTextList[index]
            inputParam.inputField.text = ""
            inputParam.inputField.onEndEdit:AddListener(function()
                self.inputParamValueList[index] = inputParam.inputField.text
            end)
        end)
    end
end

--保存剧情lua文件
function BattleStoryEditorPanel:saveStoryScript(index)
    --删除空字段
    for _, actionData in pairs(self.storyScript) do
        for k, value in pairs(actionData) do
            if value == "" then
                actionData[k] = nil
            end
        end
    end
    --排序
    local saveData = clone(self.storyScript)
    table.sort(saveData, function(a, b)
        return a.id < b.id
    end)
    --LuaLogger.ds("^^^^^^^????^^^^^^^", tablex.dump(saveData))
    --保存文件
    local name = self.storyName
    local fileName = string.format("%s.lua", name)
    local path = string.format(Config.StoryLuaPath, fileName)
    local file = io.open(path,"w")
    io.output(file)
    tablex.dumpSetting.ShowIndex = true
    io.write("local "..name.." =  "..tablex.dump(saveData).."\nreturn "..name)
    io.close(file)

    --生成CSV文件
    local needData = {
        {"id(CS)", "画面(CS)", "演出类型(CS)", "目标(CS)", "参数1(CS)", "参数2(CS)", "参数3(CS)", "参数4(CS)", "参数5(CS)", "参数6(CS)", "参数7(CS)", "剧情编号(CS)", "文本多语言(CS)", "发言者多语言(CS)"},
        {"id", "cutId", "actType", "target", "parameter1", "parameter2", "parameter3", "parameter4", "parameter5", "parameter6", "parameter7", "secenid", "localization1", "localization2"},
        {"int", "int", "int", "table", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"},
    }

    for k, data in pairs(saveData) do   
        needData[3 + k] = {}
        needData[3 + k][1] = data.id or ""
        needData[3 + k][2] = data.cutId or ""
        needData[3 + k][3] = data.actType or ""
        needData[3 + k][4] = data.target or ""
        needData[3 + k][5] = data.parameter1 or ""
        needData[3 + k][6] = data.parameter2 or ""
        needData[3 + k][7] = data.parameter3 or ""
        needData[3 + k][8] = data.parameter4 or ""
        needData[3 + k][9] = data.parameter5 or ""
        needData[3 + k][10] = data.parameter6 or ""
        needData[3 + k][11] = data.parameter7 or ""
        needData[3 + k][12] = data.secenid or ""
        needData[3 + k][13] = data.localization1 or ""
        needData[3 + k][14] = data.localization2 or ""
    end
    LuaLogger.ds("^^^^^^^????^^^^^^^", tablex.dump(needData))

    local name = "Battle_transfer"
    local fileName = string.format("%s.csv", name)
    local path = string.format("C:/Users/%s/Desktop/%s", os.getenv("USERNAME"), fileName)
    local file = io.open(path,"w")
    file:write("\239\187\191")

    for _, row in ipairs(needData) do
        local line = ""
        for j, cell in ipairs(row) do
            line = line .. tostring(cell)
            if j < #row then
                line = line .. "," -- 添加逗号分隔符
            end
        end
        file:write(line .. "\n") -- 写入一行并换行
    end

    io.close(file)

    --设置上次修改位置
    -- if index then
    --     self.lastAlterText.text.text = index
    -- end
end

--function BattleStoryEditorPanel:StartCreating(time)
--
--end

--function BattleStoryEditorPanel:StartEnter(time)
--
--end

--function BattleStoryEditorPanel:StartRemoving(time)
--
--end

--function BattleStoryEditorPanel:StartExit(time)
--
--end

function BattleStoryEditorPanel:OnOpen(data, initiative)
    if initiative then
        self._battleMgr = BattleCore:getBattleMgr()
        self._showMgr = self._battleMgr:getShowManager()
        self._map = self._battleMgr:getMap()
        self._storyMgr = BattleCore:getBattleStoryManager()
        self:hideNewAction()

        --读取文件
        self.storyName = data.storyName
        local fileName = string.format("%s.lua", self.storyName)
        local path = string.format(Config.StoryLuaPath, fileName)
        local file = io.open(path, "r")
        if not file then
            return nil
        end
        self.storyScript = loadstring(file:read("*a"))()
        file:close()

        self:InitEditorAction()
    end
end

--function BattleStoryEditorPanel:OnClose(initiative)
--
--end

--function BattleStoryEditorPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleStoryEditorPanel:OnRefresh(data)
--
--end

--[[
/EditorAction/ScrollView/ShowEditorActionBtn onClick 
--]]
function BattleStoryEditorPanel:showEditorActionBtn_Button_onClick(showEditorActionBtn)
    if showEditorActionBtn.transform.localRotation.z == 0 then
        self.scrollView.rectTransform:DOAnchorPos(Vector2.zero, 1)
        showEditorActionBtn.transform.localRotation = Vector3.New(0, 0, 180)
    else
        self.scrollView.rectTransform:DOAnchorPos(Vector2.New(-1040, 0), 1)
        showEditorActionBtn.transform.localRotation = Vector3.New(0, 0, 0)
    end
end

--[[
/EditorAction/ScrollView/NextCutBtn onClick 
--]]
function BattleStoryEditorPanel:nextCutBtn_Button_onClick(nextCutBtn)
    --此为播放下一cut内容，而非下一句话
    self._storyMgr:DoPlayOneCut()
end

--[[
/Bg onClick 
--]]
function BattleStoryEditorPanel:bg_Button_onClick(bg)
    self:hideNewAction()
end

--[[
/CancelBtn onClick 
--]]
function BattleStoryEditorPanel:cancelBtn_ScaleButton_onClick(cancelBtn)
    self:hideNewAction()
end

--[[
/ConfirmBtn onClick 
--]]
function BattleStoryEditorPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    if self.actionType == GE.BattleStoryAction.RoleMove then
        local nowblock = self._showMgr:getBlockByObj(self.nowSelectBlock)
        local data = {
            target = self.originalBlock.roleId,
            parameter1 = self.originalBlock.cid,
            parameter2 = nowblock.cid,
        }
        self._storyMgr:doRoleMove(data)

        self:changeSelectBlockState(false)
        if self.selectAreaObj then
            PoolMgr.Free(self.selectAreaObj)
        end
    elseif self.actionType == GE.BattleStoryAction.RoleTurn then
        local nowblock = self._showMgr:getBlockByObj(self.nowSelectBlock)
	    local direction = self._showMgr:getFaceToBlockDirection(self.originalBlock, nowblock)
        local data = {
            target = self.originalBlock.roleId,
            parameter1 = direction,
        }
        self._storyMgr:doRoleTurn(data)

        self:changeSelectBlockState(false)
        if self.selectAreaObj then
            PoolMgr.Free(self.selectAreaObj)
        end
    elseif self.actionType == GE.BattleStoryAction.RoleAction then
        local data = {
            target = self.originalBlock.roleId,
            parameter1 = self.inputParamValueList[1],
            parameter2 = self.inputParamValueList[2],
        }
        self._storyMgr:doRoleAction(data)
    elseif self.actionType == GE.BattleStoryAction.RoleEmote then
        local data = {
            target = self.originalBlock.roleId,
            parameter1 = self.inputParamValueList[1],
        }
        self._storyMgr:doRoleEmoteBubbles(data)
    elseif self.actionType == GE.BattleStoryAction.RoleSpeak then
        local data = {
            target = self.originalBlock.roleId,
            parameter1 = self.inputParamValueList[1],
            parameter2 = self.inputParamValueList[2],
            parameter3 = self.inputParamValueList[3],
            parameter4 = self.inputParamValueList[4],
            parameter5 = self.inputParamValueList[5],
            parameter6 = self.inputParamValueList[6],
            parameter7 = self.inputParamValueList[7],
        }
        self._storyMgr:doRoleSpeak(data)
    elseif self.actionType == GE.BattleStoryAction.CameraMove then
        -- local nowblock = self._showMgr:getBlockByObj(self.nowSelectBlock)
        local data = {
            parameter1 = self.originalBlock.cid,
            parameter2 = self.inputParamValueList[1],
        }
        self._storyMgr:doCameraMove(data)

        self:changeSelectBlockState(false)
        if self.selectAreaObj then
            PoolMgr.Free(self.selectAreaObj)
        end
    elseif self.actionType == GE.BattleStoryAction.CameraZoom then
        local camera = self._showMgr.camera
        local data = {
            parameter1 = -camera.transform.localPosition.z,
            parameter2 = self.inputParamValueList[1],
        }
        self._storyMgr:doCameraZoom(data)
    elseif self.actionType == GE.BattleStoryAction.InitRole then
        local roleData = {
            target = tonumber(self.inputParamValueList[1]),
            parameter1 = self.originalBlock.cid,
            parameter2 = self.inputParamValueList[2],
            parameter3 = self.inputParamValueList[3],
        }
        self._storyMgr:initCreatRole(roleData)
    end
    self:hideNewAction()
end

--[[
/CreatRoleBtn onClick 
--]]
function BattleStoryEditorPanel:creatRoleBtn_ScaleButton_onClick(creatRoleBtn)
    self.inputParamList:SetActive(true)
    self:setPanelShowByType(GE.BattleStoryAction.InitRole)
end

--[[
/ActionList/RoleMoveBtn onClick 
--]]
function BattleStoryEditorPanel:roleMoveBtn_ScaleButton_onClick(roleMoveBtn)
    self:changeSelectBlockState(true)
    self:setPanelShowByType(GE.BattleStoryAction.RoleMove)
end

--[[
/ActionList/RoleTurnBtn onClick 
--]]
function BattleStoryEditorPanel:roleTurnBtn_ScaleButton_onClick(roleTurnBtn)
    self:changeSelectBlockState(true)
    self:setPanelShowByType(GE.BattleStoryAction.RoleTurn)
end

--[[
/ActionList/RoleActionBtn onClick 
--]]
function BattleStoryEditorPanel:roleActionBtn_ScaleButton_onClick(roleActionBtn)
    self.inputParamList:SetActive(true)
    self:setPanelShowByType(GE.BattleStoryAction.RoleAction)
end

--[[
/ActionList/RoleEmoteBtn onClick 
--]]
function BattleStoryEditorPanel:roleEmoteBtn_ScaleButton_onClick(roleEmoteBtn)
    self.inputParamList:SetActive(true)
    self:setPanelShowByType(GE.BattleStoryAction.RoleEmote)
end

--[[
/ActionList/RoleSpeakBtn onClick 
--]]
function BattleStoryEditorPanel:roleSpeakBtn_ScaleButton_onClick(roleSpeakBtn)
    self.inputParamList:SetActive(true)
    self:setPanelShowByType(GE.BattleStoryAction.RoleSpeak)
end

--[[
/ActionList/CameraMoveBtn onClick 
--]]
function BattleStoryEditorPanel:cameraMoveBtn_ScaleButton_onClick(cameraMoveBtn)
    self:changeSelectBlockState(true)
    self.inputParamList:SetActive(true)
    self:setPanelShowByType(GE.BattleStoryAction.CameraMove)
end

--[[
/ActionList/CameraZoomBtn onClick 
--]]
function BattleStoryEditorPanel:cameraZoomBtn_ScaleButton_onClick(cameraZoomBtn)
    self.inputParamList:SetActive(true)
    self:setPanelShowByType(GE.BattleStoryAction.CameraZoom)
end

--[[
/EditorAction/ScrollView/ReLoadBtn onClick 
--]]
function BattleStoryEditorPanel:reLoadBtn_Button_onClick(reLoadBtn)
    UIMgr:closeUI("BattleStoryPanel")
    UIMgr:closeUI(self)
    GameObject.Destroy(self._showMgr.battleRoot)
	self._battleMgr:clear()
    self._storyMgr:clear()
    DLuaTimer:DoAfter(0.1, function()
        self._battleMgr:storyEditorStart()
    end)
end

--[[
/EditorAction/ScrollView/AutoBtn onClick 
--]]
function BattleStoryEditorPanel:autoBtn_Button_onClick(autoBtn)
    self._storyMgr:ChangeAutoPlay()
    self.nowAuto:SetActive(self._storyMgr._autoPlay)
end

--[[
/EditorAction/ScrollView/NewActionBtn onClick 
--]]
function BattleStoryEditorPanel:newActionBtn_Button_onClick(newActionBtn)
    self.storyScript[#self.storyScript + 1] = {
        id = #self.storyScript + 1,
        cutId = self.storyScript[#self.storyScript].cutId + 1
    }
    self:saveStoryScript()
    self:InitEditorAction()
end

--[[
/CloseBtn onClick 
--]]
function BattleStoryEditorPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI("BattleStoryPanel")
    UIMgr:closeUI(self)
    self._storyMgr:setEditorMode(false)
    self._storyMgr:clear()
	self._battleMgr:clear()
    GV.StoryEditorFileName = nil
    StateMgr:ChangeToState(GameFlowState.LoginState)
end

return BattleStoryEditorPanel
