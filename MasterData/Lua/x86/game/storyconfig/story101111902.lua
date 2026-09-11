return {
	Play111192001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111192001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111192002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D07 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D07")
				var_4_0.name = "D07"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D07 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D07

				arg_1_1.bgs_.D07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D07" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D07:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD07 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD07 = var_4_4
				end

				arg_1_1.var_.alphaOldValueD07 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD07 then
					arg_1_1.var_.alphaMatValueD07.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD07, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD07.color = arg_1_1.var_.alphaMatValueD07.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD07 then
				arg_1_1.var_.alphaMatValueD07.color.a = 1
				arg_1_1.var_.alphaMatValueD07.color = arg_1_1.var_.alphaMatValueD07.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_7 = 2
			local var_4_8 = 0.65

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_9 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_9:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_10 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111192001).content)

				arg_1_1.text_.text = var_4_10

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_12 = 26 <= 0 and var_4_8 or var_4_8 * (utf8.len(var_4_10) / 26)

				if (26 <= 0 and var_4_8 or var_4_8 * (utf8.len(var_4_10) / 26)) > 0 and var_4_8 < var_4_12 then
					arg_1_1.talkMaxDuration = var_4_12
					var_4_7 = var_4_7 + 0.3

					if var_4_12 + var_4_7 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_12 + var_4_7
					end
				end

				arg_1_1.text_.text = var_4_10
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_13 = var_4_7 + 0.3
			local var_4_14 = math.max(var_4_8, arg_1_1.talkMaxDuration)

			if var_4_7 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_14 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_13) / var_4_14

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_13 + var_4_14 and arg_1_1.time_ < var_4_13 + var_4_14 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111192002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 111192002
		arg_7_1.duration_ = 2

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play111192003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1096ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1096ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1096ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1096ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1096ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1096ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1096ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1096ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1096ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, -1.13, -5.6)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_5 = arg_7_1.actors_["1096ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1096ui_story == nil then
				arg_7_1.var_.characterEffect1096ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect1096ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1096ui_story then
				arg_7_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_10_8 = 0
			local var_10_9 = 0.075

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_10 = arg_7_1:GetWordFromCfg(111192002)
				local var_10_11 = arg_7_1:FormatText(var_10_10.content)

				arg_7_1.text_.text = var_10_11

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_13 = 3 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 3)

				if (3 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 3)) > 0 and var_10_9 < var_10_13 then
					arg_7_1.talkMaxDuration = var_10_13

					if var_10_13 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_8
					end
				end

				arg_7_1.text_.text = var_10_11
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192002", "story_v_out_111192.awb") ~= 0 then
					local var_10_14 = manager.audio:GetVoiceLength("story_v_out_111192", "111192002", "story_v_out_111192.awb") / 1000

					if var_10_14 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_14 + var_10_8
					end

					if var_10_10.prefab_name ~= "" and arg_7_1.actors_[var_10_10.prefab_name] ~= nil then
						local var_10_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_10.prefab_name].transform, "story_v_out_111192", "111192002", "story_v_out_111192.awb")

						arg_7_1:RecordAudio("111192002", var_10_15)
						arg_7_1:RecordAudio("111192002", var_10_15)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_111192", "111192002", "story_v_out_111192.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_111192", "111192002", "story_v_out_111192.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_16 = math.max(var_10_9, arg_7_1.talkMaxDuration)

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_16 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_8) / var_10_16

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_8 + var_10_16 and arg_7_1.time_ < var_10_8 + var_10_16 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play111192003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 111192003
		arg_11_1.duration_ = 2.37

		local var_11_0 = {
			ja = 2.366,
			ko = 1.366,
			zh = 1.466,
			en = 1.133
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play111192004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1096ui_story"]) and arg_11_1.var_.characterEffect1096ui_story == nil then
				arg_11_1.var_.characterEffect1096ui_story = arg_11_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_0 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["1096ui_story"]) then
				if arg_11_1.var_.characterEffect1096ui_story and not isNil(arg_11_1.actors_["1096ui_story"]) then
					arg_11_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_0)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["1096ui_story"]) and arg_11_1.var_.characterEffect1096ui_story then
				arg_11_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_14_1 = 0
			local var_14_2 = 0.125

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_3 = arg_11_1:GetWordFromCfg(111192003)
				local var_14_4 = arg_11_1:FormatText(var_14_3.content)

				arg_11_1.text_.text = var_14_4

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_6 = 5 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_4) / 5)

				if (5 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_4) / 5)) > 0 and var_14_2 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_1
					end
				end

				arg_11_1.text_.text = var_14_4
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192003", "story_v_out_111192.awb") ~= 0 then
					local var_14_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192003", "story_v_out_111192.awb") / 1000

					if var_14_7 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_7 + var_14_1
					end

					if var_14_3.prefab_name ~= "" and arg_11_1.actors_[var_14_3.prefab_name] ~= nil then
						local var_14_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_3.prefab_name].transform, "story_v_out_111192", "111192003", "story_v_out_111192.awb")

						arg_11_1:RecordAudio("111192003", var_14_8)
						arg_11_1:RecordAudio("111192003", var_14_8)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_111192", "111192003", "story_v_out_111192.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_111192", "111192003", "story_v_out_111192.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_9 = math.max(var_14_2, arg_11_1.talkMaxDuration)

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_9 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_1) / var_14_9

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_1 + var_14_9 and arg_11_1.time_ < var_14_1 + var_14_9 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play111192004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 111192004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play111192005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.775

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(111192004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 31 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 31)

				if (31 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 31)) > 0 and var_18_0 < var_18_3 then
					arg_15_1.talkMaxDuration = var_18_3

					if var_18_3 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_3 + 0
					end
				end

				arg_15_1.text_.text = var_18_1
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_4 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_4

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play111192005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 111192005
		arg_19_1.duration_ = 4.1

		local var_19_0 = {
			ja = 3.433,
			ko = 3.4,
			zh = 4.1,
			en = 3.366
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play111192006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_22_0 = arg_19_1.actors_["1096ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1096ui_story == nil then
				arg_19_1.var_.characterEffect1096ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_1 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 and not isNil(var_22_0) then
				if arg_19_1.var_.characterEffect1096ui_story and not isNil(var_22_0) then
					arg_19_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1096ui_story then
				arg_19_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:AudioAction("play", "music", "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story.awb")

				local var_22_5 = manager.audio:GetAudioName("bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story")

				if "" ~= "" then
					if arg_19_1.bgmTxt_.text ~= var_22_5 and arg_19_1.bgmTxt_.text ~= "" then
						if arg_19_1.bgmTxt2_.text ~= "" then
							arg_19_1.bgmTxt_.text = arg_19_1.bgmTxt2_.text
						end

						arg_19_1.bgmTxt2_.text = var_22_5

						arg_19_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_19_1.bgmTxt_.text = var_22_5
						arg_19_1.bgmTxt2_.text = var_22_5
					end

					if arg_19_1.bgmTimer then
						arg_19_1.bgmTimer:Stop()

						arg_19_1.bgmTimer = nil
					end

					if arg_19_1.settingData.show_music_name == 1 then
						arg_19_1.musicController:SetSelectedState("show")
						arg_19_1.musicAnimator_:Play("open", 0, 0)

						if arg_19_1.settingData.music_time ~= 0 then
							arg_19_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_19_1.settingData.music_time), function()
								if arg_19_1 == nil or isNil(arg_19_1.bgmTxt_) then
									return
								end

								arg_19_1.musicController:SetSelectedState("hide")
								arg_19_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_22_6 = 0
			local var_22_7 = 0.5

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_8 = arg_19_1:GetWordFromCfg(111192005)
				local var_22_9 = arg_19_1:FormatText(var_22_8.content)

				arg_19_1.text_.text = var_22_9

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_11 = 20 <= 0 and var_22_7 or var_22_7 * (utf8.len(var_22_9) / 20)

				if (20 <= 0 and var_22_7 or var_22_7 * (utf8.len(var_22_9) / 20)) > 0 and var_22_7 < var_22_11 then
					arg_19_1.talkMaxDuration = var_22_11

					if var_22_11 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_11 + var_22_6
					end
				end

				arg_19_1.text_.text = var_22_9
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192005", "story_v_out_111192.awb") ~= 0 then
					local var_22_12 = manager.audio:GetVoiceLength("story_v_out_111192", "111192005", "story_v_out_111192.awb") / 1000

					if var_22_12 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_6
					end

					if var_22_8.prefab_name ~= "" and arg_19_1.actors_[var_22_8.prefab_name] ~= nil then
						local var_22_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_8.prefab_name].transform, "story_v_out_111192", "111192005", "story_v_out_111192.awb")

						arg_19_1:RecordAudio("111192005", var_22_13)
						arg_19_1:RecordAudio("111192005", var_22_13)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_111192", "111192005", "story_v_out_111192.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_111192", "111192005", "story_v_out_111192.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_14 = math.max(var_22_7, arg_19_1.talkMaxDuration)

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_14 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_6) / var_22_14

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_6 + var_22_14 and arg_19_1.time_ < var_22_6 + var_22_14 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play111192006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111192006
		arg_24_1.duration_ = 2.7

		local var_24_0 = {
			ja = 2.333,
			ko = 2.7,
			zh = 2.533,
			en = 2.2
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111192007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1096ui_story"]) and arg_24_1.var_.characterEffect1096ui_story == nil then
				arg_24_1.var_.characterEffect1096ui_story = arg_24_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1096ui_story"]) then
				if arg_24_1.var_.characterEffect1096ui_story and not isNil(arg_24_1.actors_["1096ui_story"]) then
					arg_24_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1096ui_story"]) and arg_24_1.var_.characterEffect1096ui_story then
				arg_24_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(111192006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 11 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 11)

				if (11 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 11)) > 0 and var_27_2 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192006", "story_v_out_111192.awb") ~= 0 then
					local var_27_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192006", "story_v_out_111192.awb") / 1000

					if var_27_7 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_1
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_111192", "111192006", "story_v_out_111192.awb")

						arg_24_1:RecordAudio("111192006", var_27_8)
						arg_24_1:RecordAudio("111192006", var_27_8)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111192", "111192006", "story_v_out_111192.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111192", "111192006", "story_v_out_111192.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_9 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_9 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_9

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_9 and arg_24_1.time_ < var_27_1 + var_27_9 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111192007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111192007
		arg_28_1.duration_ = 8.57

		local var_28_0 = {
			ja = 8.566,
			ko = 4.4,
			zh = 3.7,
			en = 3.733
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111192008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_0 = arg_28_1.actors_["1096ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1096ui_story == nil then
				arg_28_1.var_.characterEffect1096ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_1 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_1 and not isNil(var_31_0) then
				if arg_28_1.var_.characterEffect1096ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1096ui_story then
				arg_28_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_1")
			end

			local var_31_3 = 0
			local var_31_4 = 0.475

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:GetWordFromCfg(111192007)
				local var_31_6 = arg_28_1:FormatText(var_31_5.content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 14 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 14)

				if (14 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 14)) > 0 and var_31_4 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192007", "story_v_out_111192.awb") ~= 0 then
					local var_31_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192007", "story_v_out_111192.awb") / 1000

					if var_31_9 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_3
					end

					if var_31_5.prefab_name ~= "" and arg_28_1.actors_[var_31_5.prefab_name] ~= nil then
						local var_31_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_5.prefab_name].transform, "story_v_out_111192", "111192007", "story_v_out_111192.awb")

						arg_28_1:RecordAudio("111192007", var_31_10)
						arg_28_1:RecordAudio("111192007", var_31_10)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111192", "111192007", "story_v_out_111192.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111192", "111192007", "story_v_out_111192.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_11 and arg_28_1.time_ < var_31_3 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111192008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111192008
		arg_32_1.duration_ = 3.73

		local var_32_0 = {
			ja = 3.733,
			ko = 2.733,
			zh = 2.633,
			en = 2.466
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play111192009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1096ui_story"]) and arg_32_1.var_.characterEffect1096ui_story == nil then
				arg_32_1.var_.characterEffect1096ui_story = arg_32_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1096ui_story"]) then
				if arg_32_1.var_.characterEffect1096ui_story and not isNil(arg_32_1.actors_["1096ui_story"]) then
					arg_32_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1096ui_story"]) and arg_32_1.var_.characterEffect1096ui_story then
				arg_32_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(111192008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 9 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 9)

				if (9 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 9)) > 0 and var_35_2 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192008", "story_v_out_111192.awb") ~= 0 then
					local var_35_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192008", "story_v_out_111192.awb") / 1000

					if var_35_7 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_1
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_111192", "111192008", "story_v_out_111192.awb")

						arg_32_1:RecordAudio("111192008", var_35_8)
						arg_32_1:RecordAudio("111192008", var_35_8)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111192", "111192008", "story_v_out_111192.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111192", "111192008", "story_v_out_111192.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_9 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_9 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_9

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_9 and arg_32_1.time_ < var_35_1 + var_35_9 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111192009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111192009
		arg_36_1.duration_ = 6.23

		local var_36_0 = {
			ja = 4.8,
			ko = 6.233,
			zh = 5.3,
			en = 5.8
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111192010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_39_0 = arg_36_1.actors_["1096ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1096ui_story == nil then
				arg_36_1.var_.characterEffect1096ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_1 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 and not isNil(var_39_0) then
				if arg_36_1.var_.characterEffect1096ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1096ui_story then
				arg_36_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_2")
			end

			local var_39_3 = 0
			local var_39_4 = 0.775

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:GetWordFromCfg(111192009)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_8 = 31 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_6) / 31)

				if (31 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_6) / 31)) > 0 and var_39_4 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_3
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192009", "story_v_out_111192.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192009", "story_v_out_111192.awb") / 1000

					if var_39_9 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_3
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_out_111192", "111192009", "story_v_out_111192.awb")

						arg_36_1:RecordAudio("111192009", var_39_10)
						arg_36_1:RecordAudio("111192009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111192", "111192009", "story_v_out_111192.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111192", "111192009", "story_v_out_111192.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_4, arg_36_1.talkMaxDuration)

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_3) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_3 + var_39_11 and arg_36_1.time_ < var_39_3 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111192010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111192010
		arg_40_1.duration_ = 2.97

		local var_40_0 = {
			ja = 2.966,
			ko = 1.3,
			zh = 1.666,
			en = 1.766
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111192011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1096ui_story"]) and arg_40_1.var_.characterEffect1096ui_story == nil then
				arg_40_1.var_.characterEffect1096ui_story = arg_40_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1096ui_story"]) then
				if arg_40_1.var_.characterEffect1096ui_story and not isNil(arg_40_1.actors_["1096ui_story"]) then
					arg_40_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1096ui_story"]) and arg_40_1.var_.characterEffect1096ui_story then
				arg_40_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.15

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(111192010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 6 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 6)

				if (6 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 6)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192010", "story_v_out_111192.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192010", "story_v_out_111192.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_111192", "111192010", "story_v_out_111192.awb")

						arg_40_1:RecordAudio("111192010", var_43_8)
						arg_40_1:RecordAudio("111192010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111192", "111192010", "story_v_out_111192.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111192", "111192010", "story_v_out_111192.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_9 and arg_40_1.time_ < var_43_1 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111192011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111192011
		arg_44_1.duration_ = 7.93

		local var_44_0 = {
			ja = 7.933,
			ko = 6.5,
			zh = 5.9,
			en = 6.533
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play111192012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1096ui_story"]) and arg_44_1.var_.characterEffect1096ui_story == nil then
				arg_44_1.var_.characterEffect1096ui_story = arg_44_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1096ui_story"]) then
				if arg_44_1.var_.characterEffect1096ui_story and not isNil(arg_44_1.actors_["1096ui_story"]) then
					arg_44_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1096ui_story"]) and arg_44_1.var_.characterEffect1096ui_story then
				arg_44_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_47_2 = 0
			local var_47_3 = 0.825

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(111192011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 33 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 33)

				if (33 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 33)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192011", "story_v_out_111192.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_111192", "111192011", "story_v_out_111192.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_111192", "111192011", "story_v_out_111192.awb")

						arg_44_1:RecordAudio("111192011", var_47_9)
						arg_44_1:RecordAudio("111192011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111192", "111192011", "story_v_out_111192.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111192", "111192011", "story_v_out_111192.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111192012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111192012
		arg_48_1.duration_ = 4.03

		local var_48_0 = {
			ja = 3.966,
			ko = 2.933,
			zh = 3.666,
			en = 4.033
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111192013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_51_0 = 0
			local var_51_1 = 0.45

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(111192012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 18 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 18)

				if (18 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 18)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192012", "story_v_out_111192.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_111192", "111192012", "story_v_out_111192.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_111192", "111192012", "story_v_out_111192.awb")

						arg_48_1:RecordAudio("111192012", var_51_7)
						arg_48_1:RecordAudio("111192012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_111192", "111192012", "story_v_out_111192.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_111192", "111192012", "story_v_out_111192.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play111192013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111192013
		arg_52_1.duration_ = 7.23

		local var_52_0 = {
			ja = 7.133,
			ko = 5.666,
			zh = 5.033,
			en = 7.233
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play111192014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_55_0 = 0
			local var_55_1 = 0.625

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(111192013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 25 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 25)

				if (25 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 25)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192013", "story_v_out_111192.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_111192", "111192013", "story_v_out_111192.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_111192", "111192013", "story_v_out_111192.awb")

						arg_52_1:RecordAudio("111192013", var_55_7)
						arg_52_1:RecordAudio("111192013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111192", "111192013", "story_v_out_111192.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111192", "111192013", "story_v_out_111192.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111192014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111192014
		arg_56_1.duration_ = 6.47

		local var_56_0 = {
			ja = 4.533,
			ko = 6.466,
			zh = 5.366,
			en = 5.533
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play111192015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1096ui_story"]) and arg_56_1.var_.characterEffect1096ui_story == nil then
				arg_56_1.var_.characterEffect1096ui_story = arg_56_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1096ui_story"]) then
				if arg_56_1.var_.characterEffect1096ui_story and not isNil(arg_56_1.actors_["1096ui_story"]) then
					arg_56_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1096ui_story"]) and arg_56_1.var_.characterEffect1096ui_story then
				arg_56_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.75

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(111192014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 30 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 30)

				if (30 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 30)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192014", "story_v_out_111192.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192014", "story_v_out_111192.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_111192", "111192014", "story_v_out_111192.awb")

						arg_56_1:RecordAudio("111192014", var_59_8)
						arg_56_1:RecordAudio("111192014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111192", "111192014", "story_v_out_111192.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111192", "111192014", "story_v_out_111192.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111192015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111192015
		arg_60_1.duration_ = 5.83

		local var_60_0 = {
			ja = 4.866,
			ko = 4.666,
			zh = 5.833,
			en = 4.9
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play111192016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action2_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_63_0 = arg_60_1.actors_["1096ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1096ui_story == nil then
				arg_60_1.var_.characterEffect1096ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_1 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 and not isNil(var_63_0) then
				if arg_60_1.var_.characterEffect1096ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1096ui_story then
				arg_60_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_63_3 = 0
			local var_63_4 = 0.475

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:GetWordFromCfg(111192015)
				local var_63_6 = arg_60_1:FormatText(var_63_5.content)

				arg_60_1.text_.text = var_63_6

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_8 = 15 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_6) / 15)

				if (15 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_6) / 15)) > 0 and var_63_4 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8

					if var_63_8 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_3
					end
				end

				arg_60_1.text_.text = var_63_6
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192015", "story_v_out_111192.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192015", "story_v_out_111192.awb") / 1000

					if var_63_9 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_3
					end

					if var_63_5.prefab_name ~= "" and arg_60_1.actors_[var_63_5.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_5.prefab_name].transform, "story_v_out_111192", "111192015", "story_v_out_111192.awb")

						arg_60_1:RecordAudio("111192015", var_63_10)
						arg_60_1:RecordAudio("111192015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_111192", "111192015", "story_v_out_111192.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_111192", "111192015", "story_v_out_111192.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_4, arg_60_1.talkMaxDuration)

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_3) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_3 + var_63_11 and arg_60_1.time_ < var_63_3 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111192016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111192016
		arg_64_1.duration_ = 10.13

		local var_64_0 = {
			ja = 9.633,
			ko = 10.133,
			zh = 7.6,
			en = 6.166
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111192017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1096ui_story"]) and arg_64_1.var_.characterEffect1096ui_story == nil then
				arg_64_1.var_.characterEffect1096ui_story = arg_64_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1096ui_story"]) then
				if arg_64_1.var_.characterEffect1096ui_story and not isNil(arg_64_1.actors_["1096ui_story"]) then
					arg_64_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1096ui_story"]) and arg_64_1.var_.characterEffect1096ui_story then
				arg_64_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.975

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(111192016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 39 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 39)

				if (39 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 39)) > 0 and var_67_2 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192016", "story_v_out_111192.awb") ~= 0 then
					local var_67_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192016", "story_v_out_111192.awb") / 1000

					if var_67_7 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_1
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_111192", "111192016", "story_v_out_111192.awb")

						arg_64_1:RecordAudio("111192016", var_67_8)
						arg_64_1:RecordAudio("111192016", var_67_8)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_111192", "111192016", "story_v_out_111192.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_111192", "111192016", "story_v_out_111192.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_9 and arg_64_1.time_ < var_67_1 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111192017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111192017
		arg_68_1.duration_ = 8.2

		local var_68_0 = {
			ja = 5.966,
			ko = 8.2,
			zh = 6.9,
			en = 5.333
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play111192018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.975

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(111192017)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 39 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 39)

				if (39 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 39)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192017", "story_v_out_111192.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192017", "story_v_out_111192.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_111192", "111192017", "story_v_out_111192.awb")

						arg_68_1:RecordAudio("111192017", var_71_6)
						arg_68_1:RecordAudio("111192017", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111192", "111192017", "story_v_out_111192.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111192", "111192017", "story_v_out_111192.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111192018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111192018
		arg_72_1.duration_ = 3.2

		local var_72_0 = {
			ja = 3.2,
			ko = 1.999999999999,
			zh = 2.6,
			en = 2.433
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play111192019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action424")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_75_0 = arg_72_1.actors_["1096ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1096ui_story == nil then
				arg_72_1.var_.characterEffect1096ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_1 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 and not isNil(var_75_0) then
				if arg_72_1.var_.characterEffect1096ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1096ui_story then
				arg_72_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_75_3 = 0
			local var_75_4 = 0.125

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(111192018)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_8 = 5 <= 0 and var_75_4 or var_75_4 * (utf8.len(var_75_6) / 5)

				if (5 <= 0 and var_75_4 or var_75_4 * (utf8.len(var_75_6) / 5)) > 0 and var_75_4 < var_75_8 then
					arg_72_1.talkMaxDuration = var_75_8

					if var_75_8 + var_75_3 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_3
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192018", "story_v_out_111192.awb") ~= 0 then
					local var_75_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192018", "story_v_out_111192.awb") / 1000

					if var_75_9 + var_75_3 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_3
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_out_111192", "111192018", "story_v_out_111192.awb")

						arg_72_1:RecordAudio("111192018", var_75_10)
						arg_72_1:RecordAudio("111192018", var_75_10)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_111192", "111192018", "story_v_out_111192.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_111192", "111192018", "story_v_out_111192.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_11 = math.max(var_75_4, arg_72_1.talkMaxDuration)

			if var_75_3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_3 + var_75_11 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_3) / var_75_11

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_3 + var_75_11 and arg_72_1.time_ < var_75_3 + var_75_11 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play111192019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111192019
		arg_76_1.duration_ = 7

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111192020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1096ui_story = arg_76_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1096ui_story"].transform.position).z)
				arg_76_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1096ui_story"].transform.localEulerAngles = arg_76_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1096ui_story"].transform.position).z)
				arg_76_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1096ui_story"].transform.localEulerAngles = arg_76_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				local var_79_1 = arg_76_1.bgs_.D07:GetComponent("SpriteRenderer")

				if var_79_1 then
					arg_76_1.var_.alphaOldValueD07 = var_79_1.color.a
					arg_76_1.var_.alphaMatValueD07 = var_79_1
				end

				arg_76_1.var_.alphaOldValueD07 = 1
			end

			local var_79_2 = 1.5

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 then
				if arg_76_1.var_.alphaMatValueD07 then
					arg_76_1.var_.alphaMatValueD07.color.a = Mathf.Lerp(arg_76_1.var_.alphaOldValueD07, 0, (arg_76_1.time_ - 0) / var_79_2)
					arg_76_1.var_.alphaMatValueD07.color = arg_76_1.var_.alphaMatValueD07.color
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and arg_76_1.var_.alphaMatValueD07 then
				arg_76_1.var_.alphaMatValueD07.color.a = 0
				arg_76_1.var_.alphaMatValueD07.color = arg_76_1.var_.alphaMatValueD07.color
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_3 = 2
			local var_79_4 = 1.625

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_5 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_5:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(111192019).content)

				arg_76_1.text_.text = var_79_6

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_8 = 65 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_6) / 65)

				if (65 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_6) / 65)) > 0 and var_79_4 < var_79_8 then
					arg_76_1.talkMaxDuration = var_79_8
					var_79_3 = var_79_3 + 0.3

					if var_79_8 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_3
					end
				end

				arg_76_1.text_.text = var_79_6
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = var_79_3 + 0.3
			local var_79_10 = math.max(var_79_4, arg_76_1.talkMaxDuration)

			if var_79_3 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_9) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play111192020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111192020
		arg_82_1.duration_ = 4.6

		local var_82_0 = {
			ja = 4.6,
			ko = 2,
			zh = 3.266,
			en = 2.3
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111192021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.375

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(111192020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 11 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 11)

				if (11 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 11)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192020", "story_v_out_111192.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192020", "story_v_out_111192.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_111192", "111192020", "story_v_out_111192.awb")

						arg_82_1:RecordAudio("111192020", var_85_6)
						arg_82_1:RecordAudio("111192020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_111192", "111192020", "story_v_out_111192.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_111192", "111192020", "story_v_out_111192.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111192021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111192021
		arg_86_1.duration_ = 2.13

		local var_86_0 = {
			ja = 2.133,
			ko = 1.566,
			zh = 1.1,
			en = 1.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play111192022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.075

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(111192021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 3 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 3)

				if (3 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 3)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192021", "story_v_out_111192.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192021", "story_v_out_111192.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_111192", "111192021", "story_v_out_111192.awb")

						arg_86_1:RecordAudio("111192021", var_89_6)
						arg_86_1:RecordAudio("111192021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111192", "111192021", "story_v_out_111192.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111192", "111192021", "story_v_out_111192.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111192022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111192022
		arg_90_1.duration_ = 3.97

		local var_90_0 = {
			ja = 1.8,
			ko = 2.7,
			zh = 3.966,
			en = 2.166
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play111192023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.275

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[173].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(111192022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 11 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 11)

				if (11 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 11)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192022", "story_v_out_111192.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192022", "story_v_out_111192.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_111192", "111192022", "story_v_out_111192.awb")

						arg_90_1:RecordAudio("111192022", var_93_6)
						arg_90_1:RecordAudio("111192022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_111192", "111192022", "story_v_out_111192.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_111192", "111192022", "story_v_out_111192.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play111192023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111192023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111192024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.125

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(111192023).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 45 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 45)

				if (45 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 45)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111192024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111192024
		arg_98_1.duration_ = 3.07

		local var_98_0 = {
			ja = 3.066,
			ko = 2.2,
			zh = 1.933,
			en = 2.133
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111192025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.275

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(111192024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 11 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 11)

				if (11 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 11)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192024", "story_v_out_111192.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192024", "story_v_out_111192.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_111192", "111192024", "story_v_out_111192.awb")

						arg_98_1:RecordAudio("111192024", var_101_6)
						arg_98_1:RecordAudio("111192024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_111192", "111192024", "story_v_out_111192.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_111192", "111192024", "story_v_out_111192.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play111192025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111192025
		arg_102_1.duration_ = 4.3

		local var_102_0 = {
			ja = 4,
			ko = 4.3,
			zh = 4.066,
			en = 3.7
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play111192026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.4

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(111192025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 16 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 16)

				if (16 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 16)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192025", "story_v_out_111192.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192025", "story_v_out_111192.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_111192", "111192025", "story_v_out_111192.awb")

						arg_102_1:RecordAudio("111192025", var_105_6)
						arg_102_1:RecordAudio("111192025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111192", "111192025", "story_v_out_111192.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111192", "111192025", "story_v_out_111192.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play111192026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111192026
		arg_106_1.duration_ = 7.9

		local var_106_0 = {
			ja = 5.6,
			ko = 4.866,
			zh = 7.9,
			en = 5.6
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play111192027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.625

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[173].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(111192026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 25 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 25)

				if (25 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 25)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192026", "story_v_out_111192.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192026", "story_v_out_111192.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_111192", "111192026", "story_v_out_111192.awb")

						arg_106_1:RecordAudio("111192026", var_109_6)
						arg_106_1:RecordAudio("111192026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_111192", "111192026", "story_v_out_111192.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_111192", "111192026", "story_v_out_111192.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play111192027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111192027
		arg_110_1.duration_ = 11.7

		local var_110_0 = {
			ja = 7.4,
			ko = 8.2,
			zh = 8.866,
			en = 11.7
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111192028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 1.075

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[173].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(111192027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 43 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 43)

				if (43 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 43)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192027", "story_v_out_111192.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192027", "story_v_out_111192.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_111192", "111192027", "story_v_out_111192.awb")

						arg_110_1:RecordAudio("111192027", var_113_6)
						arg_110_1:RecordAudio("111192027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_111192", "111192027", "story_v_out_111192.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_111192", "111192027", "story_v_out_111192.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play111192028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 111192028
		arg_114_1.duration_ = 9.3

		local var_114_0 = {
			ja = 9.3,
			ko = 5.1,
			zh = 7.966,
			en = 8.533
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play111192029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.525

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(111192028)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 21 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 21)

				if (21 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 21)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192028", "story_v_out_111192.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192028", "story_v_out_111192.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_111192", "111192028", "story_v_out_111192.awb")

						arg_114_1:RecordAudio("111192028", var_117_6)
						arg_114_1:RecordAudio("111192028", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_111192", "111192028", "story_v_out_111192.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_111192", "111192028", "story_v_out_111192.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play111192029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 111192029
		arg_118_1.duration_ = 7.3

		local var_118_0 = {
			ja = 6.9,
			ko = 6,
			zh = 7.3,
			en = 5.233
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play111192030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_0 = 1
			local var_121_1 = 0.525

			if 1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_2 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_2:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[173].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(111192029)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_6 = 13 <= 0 and var_121_1 or var_121_1 * (utf8.len(var_121_4) / 13)

				if (13 <= 0 and var_121_1 or var_121_1 * (utf8.len(var_121_4) / 13)) > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6
					var_121_0 = var_121_0 + 0.3

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192029", "story_v_out_111192.awb") ~= 0 then
					local var_121_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192029", "story_v_out_111192.awb") / 1000

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_111192", "111192029", "story_v_out_111192.awb")

						arg_118_1:RecordAudio("111192029", var_121_8)
						arg_118_1:RecordAudio("111192029", var_121_8)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_111192", "111192029", "story_v_out_111192.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_111192", "111192029", "story_v_out_111192.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_9 = var_121_0 + 0.3
			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_9) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play111192030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 111192030
		arg_124_1.duration_ = 11.47

		local var_124_0 = {
			ja = 5.6,
			ko = 6.933,
			zh = 11.466,
			en = 6.8
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play111192031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.6

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[173].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(111192030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 16 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 16)

				if (16 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 16)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192030", "story_v_out_111192.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192030", "story_v_out_111192.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_111192", "111192030", "story_v_out_111192.awb")

						arg_124_1:RecordAudio("111192030", var_127_6)
						arg_124_1:RecordAudio("111192030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_111192", "111192030", "story_v_out_111192.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_111192", "111192030", "story_v_out_111192.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play111192031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 111192031
		arg_128_1.duration_ = 4.77

		local var_128_0 = {
			ja = 4.666,
			ko = 4.566,
			zh = 4.1,
			en = 4.766
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play111192032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				local var_131_0 = arg_128_1.bgs_.D07

				arg_128_1.bgs_.D07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_131_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_1 = var_131_0:GetComponent("SpriteRenderer")

				if var_131_1 and var_131_1.sprite then
					local var_131_2 = 2 * (var_131_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_131_0.transform.localScale = Vector3.New(var_131_2 / var_131_1.sprite.bounds.size.y < var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x and var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x or var_131_2 / var_131_1.sprite.bounds.size.y, var_131_2 / var_131_1.sprite.bounds.size.y < var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x and var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x or var_131_2 / var_131_1.sprite.bounds.size.y, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "D07" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				local var_131_3 = arg_128_1.bgs_.D07:GetComponent("SpriteRenderer")

				if var_131_3 then
					arg_128_1.var_.alphaOldValueD07 = var_131_3.color.a
					arg_128_1.var_.alphaMatValueD07 = var_131_3
				end

				arg_128_1.var_.alphaOldValueD07 = 0
			end

			local var_131_4 = 1.5

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				if arg_128_1.var_.alphaMatValueD07 then
					arg_128_1.var_.alphaMatValueD07.color.a = Mathf.Lerp(arg_128_1.var_.alphaOldValueD07, 1, (arg_128_1.time_ - 0) / var_131_4)
					arg_128_1.var_.alphaMatValueD07.color = arg_128_1.var_.alphaMatValueD07.color
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and arg_128_1.var_.alphaMatValueD07 then
				arg_128_1.var_.alphaMatValueD07.color.a = 1
				arg_128_1.var_.alphaMatValueD07.color = arg_128_1.var_.alphaMatValueD07.color
			end

			local var_131_5 = 2
			local var_131_6 = 0.4

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_7 = arg_128_1:GetWordFromCfg(111192031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 12 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 12)

				if (12 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 12)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192031", "story_v_out_111192.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_111192", "111192031", "story_v_out_111192.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_111192", "111192031", "story_v_out_111192.awb")

						arg_128_1:RecordAudio("111192031", var_131_12)
						arg_128_1:RecordAudio("111192031", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_111192", "111192031", "story_v_out_111192.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_111192", "111192031", "story_v_out_111192.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play111192032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 111192032
		arg_132_1.duration_ = 10.7

		local var_132_0 = {
			ja = 10.3,
			ko = 9.866,
			zh = 10.7,
			en = 8.933
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play111192033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1096ui_story = arg_132_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1096ui_story"].transform.position).z)
				arg_132_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1096ui_story"].transform.localEulerAngles = arg_132_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, -1.13, -5.6)
				arg_132_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1096ui_story"].transform.position).z)
				arg_132_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1096ui_story"].transform.localEulerAngles = arg_132_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_135_1 = arg_132_1.actors_["1096ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1096ui_story == nil then
				arg_132_1.var_.characterEffect1096ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1096ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1096ui_story then
				arg_132_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_135_4 = 0
			local var_135_5 = 0.875

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(111192032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 31 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 31)

				if (31 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 31)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192032", "story_v_out_111192.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_111192", "111192032", "story_v_out_111192.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_111192", "111192032", "story_v_out_111192.awb")

						arg_132_1:RecordAudio("111192032", var_135_11)
						arg_132_1:RecordAudio("111192032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_111192", "111192032", "story_v_out_111192.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_111192", "111192032", "story_v_out_111192.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play111192033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 111192033
		arg_136_1.duration_ = 11.4

		local var_136_0 = {
			ja = 8.9,
			ko = 11.1,
			zh = 8.766,
			en = 11.4
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play111192034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1096ui_story"]) and arg_136_1.var_.characterEffect1096ui_story == nil then
				arg_136_1.var_.characterEffect1096ui_story = arg_136_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1096ui_story"]) then
				if arg_136_1.var_.characterEffect1096ui_story and not isNil(arg_136_1.actors_["1096ui_story"]) then
					arg_136_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1096ui_story"]) and arg_136_1.var_.characterEffect1096ui_story then
				arg_136_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 1.225

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(111192033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_6 = 49 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_4) / 49)

				if (49 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_4) / 49)) > 0 and var_139_2 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192033", "story_v_out_111192.awb") ~= 0 then
					local var_139_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192033", "story_v_out_111192.awb") / 1000

					if var_139_7 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_1
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_111192", "111192033", "story_v_out_111192.awb")

						arg_136_1:RecordAudio("111192033", var_139_8)
						arg_136_1:RecordAudio("111192033", var_139_8)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_111192", "111192033", "story_v_out_111192.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_111192", "111192033", "story_v_out_111192.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_9 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_9 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_9

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_9 and arg_136_1.time_ < var_139_1 + var_139_9 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play111192034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 111192034
		arg_140_1.duration_ = 6.37

		local var_140_0 = {
			ja = 6.366,
			ko = 4.866,
			zh = 4.033,
			en = 6.266
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play111192035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action446")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_143_0 = arg_140_1.actors_["1096ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1096ui_story == nil then
				arg_140_1.var_.characterEffect1096ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_1 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 and not isNil(var_143_0) then
				if arg_140_1.var_.characterEffect1096ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1096ui_story then
				arg_140_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_143_3 = 0
			local var_143_4 = 0.725

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_3 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_5 = arg_140_1:GetWordFromCfg(111192034)
				local var_143_6 = arg_140_1:FormatText(var_143_5.content)

				arg_140_1.text_.text = var_143_6

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_8 = 22 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_6) / 22)

				if (22 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_6) / 22)) > 0 and var_143_4 < var_143_8 then
					arg_140_1.talkMaxDuration = var_143_8

					if var_143_8 + var_143_3 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_3
					end
				end

				arg_140_1.text_.text = var_143_6
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192034", "story_v_out_111192.awb") ~= 0 then
					local var_143_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192034", "story_v_out_111192.awb") / 1000

					if var_143_9 + var_143_3 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_3
					end

					if var_143_5.prefab_name ~= "" and arg_140_1.actors_[var_143_5.prefab_name] ~= nil then
						local var_143_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_5.prefab_name].transform, "story_v_out_111192", "111192034", "story_v_out_111192.awb")

						arg_140_1:RecordAudio("111192034", var_143_10)
						arg_140_1:RecordAudio("111192034", var_143_10)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_111192", "111192034", "story_v_out_111192.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_111192", "111192034", "story_v_out_111192.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_11 = math.max(var_143_4, arg_140_1.talkMaxDuration)

			if var_143_3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_3 + var_143_11 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_3) / var_143_11

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_3 + var_143_11 and arg_140_1.time_ < var_143_3 + var_143_11 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play111192035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 111192035
		arg_144_1.duration_ = 9.37

		local var_144_0 = {
			ja = 7.2,
			ko = 9.366,
			zh = 8.233,
			en = 8.3
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play111192036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1096ui_story"]) and arg_144_1.var_.characterEffect1096ui_story == nil then
				arg_144_1.var_.characterEffect1096ui_story = arg_144_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1096ui_story"]) then
				if arg_144_1.var_.characterEffect1096ui_story and not isNil(arg_144_1.actors_["1096ui_story"]) then
					arg_144_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1096ui_story"]) and arg_144_1.var_.characterEffect1096ui_story then
				arg_144_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.975

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(111192035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_6 = 35 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 35)

				if (35 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 35)) > 0 and var_147_2 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192035", "story_v_out_111192.awb") ~= 0 then
					local var_147_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192035", "story_v_out_111192.awb") / 1000

					if var_147_7 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_1
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_111192", "111192035", "story_v_out_111192.awb")

						arg_144_1:RecordAudio("111192035", var_147_8)
						arg_144_1:RecordAudio("111192035", var_147_8)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_111192", "111192035", "story_v_out_111192.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_111192", "111192035", "story_v_out_111192.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_9 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_9 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_9

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_9 and arg_144_1.time_ < var_147_1 + var_147_9 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play111192036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 111192036
		arg_148_1.duration_ = 4

		local var_148_0 = {
			ja = 4,
			ko = 2.8,
			zh = 2.5,
			en = 2.066
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play111192037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1096ui_story"]) and arg_148_1.var_.characterEffect1096ui_story == nil then
				arg_148_1.var_.characterEffect1096ui_story = arg_148_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1096ui_story"]) then
				if arg_148_1.var_.characterEffect1096ui_story and not isNil(arg_148_1.actors_["1096ui_story"]) then
					arg_148_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1096ui_story"]) and arg_148_1.var_.characterEffect1096ui_story then
				arg_148_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action6_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_151_2 = 0
			local var_151_3 = 0.3

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(111192036)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 12 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 12)

				if (12 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 12)) > 0 and var_151_3 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192036", "story_v_out_111192.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_111192", "111192036", "story_v_out_111192.awb") / 1000

					if var_151_8 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_2
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_111192", "111192036", "story_v_out_111192.awb")

						arg_148_1:RecordAudio("111192036", var_151_9)
						arg_148_1:RecordAudio("111192036", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_111192", "111192036", "story_v_out_111192.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_111192", "111192036", "story_v_out_111192.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_10 and arg_148_1.time_ < var_151_2 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play111192037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 111192037
		arg_152_1.duration_ = 11.77

		local var_152_0 = {
			ja = 7.133,
			ko = 10.7,
			zh = 9.366,
			en = 11.766
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play111192038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1096ui_story"]) and arg_152_1.var_.characterEffect1096ui_story == nil then
				arg_152_1.var_.characterEffect1096ui_story = arg_152_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1096ui_story"]) then
				if arg_152_1.var_.characterEffect1096ui_story and not isNil(arg_152_1.actors_["1096ui_story"]) then
					arg_152_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1096ui_story"]) and arg_152_1.var_.characterEffect1096ui_story then
				arg_152_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_155_1 = 0
			local var_155_2 = 1.2

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(111192037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_6 = 44 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_4) / 44)

				if (44 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_4) / 44)) > 0 and var_155_2 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192037", "story_v_out_111192.awb") ~= 0 then
					local var_155_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192037", "story_v_out_111192.awb") / 1000

					if var_155_7 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_1
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_111192", "111192037", "story_v_out_111192.awb")

						arg_152_1:RecordAudio("111192037", var_155_8)
						arg_152_1:RecordAudio("111192037", var_155_8)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_111192", "111192037", "story_v_out_111192.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_111192", "111192037", "story_v_out_111192.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_9 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_9 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_9

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_9 and arg_152_1.time_ < var_155_1 + var_155_9 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play111192038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 111192038
		arg_156_1.duration_ = 13.67

		local var_156_0 = {
			ja = 10.366,
			ko = 12.4,
			zh = 9.6,
			en = 13.666
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play111192039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.25

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(111192038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 50 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 50)

				if (50 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 50)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192038", "story_v_out_111192.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192038", "story_v_out_111192.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_111192", "111192038", "story_v_out_111192.awb")

						arg_156_1:RecordAudio("111192038", var_159_6)
						arg_156_1:RecordAudio("111192038", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_111192", "111192038", "story_v_out_111192.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_111192", "111192038", "story_v_out_111192.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play111192039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 111192039
		arg_160_1.duration_ = 6.57

		local var_160_0 = {
			ja = 5.9,
			ko = 5.066,
			zh = 5.266,
			en = 6.566
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play111192040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_163_0 = arg_160_1.actors_["1096ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1096ui_story == nil then
				arg_160_1.var_.characterEffect1096ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_1 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 and not isNil(var_163_0) then
				if arg_160_1.var_.characterEffect1096ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1096ui_story then
				arg_160_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_163_3 = 0
			local var_163_4 = 0.675

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(111192039)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_8 = 27 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_6) / 27)

				if (27 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_6) / 27)) > 0 and var_163_4 < var_163_8 then
					arg_160_1.talkMaxDuration = var_163_8

					if var_163_8 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_3
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192039", "story_v_out_111192.awb") ~= 0 then
					local var_163_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192039", "story_v_out_111192.awb") / 1000

					if var_163_9 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_3
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_out_111192", "111192039", "story_v_out_111192.awb")

						arg_160_1:RecordAudio("111192039", var_163_10)
						arg_160_1:RecordAudio("111192039", var_163_10)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_111192", "111192039", "story_v_out_111192.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_111192", "111192039", "story_v_out_111192.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_4, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_3) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_11 and arg_160_1.time_ < var_163_3 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play111192040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 111192040
		arg_164_1.duration_ = 13.5

		local var_164_0 = {
			ja = 6.166,
			ko = 13.5,
			zh = 9.633,
			en = 11.333
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play111192041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1096ui_story"]) and arg_164_1.var_.characterEffect1096ui_story == nil then
				arg_164_1.var_.characterEffect1096ui_story = arg_164_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1096ui_story"]) then
				if arg_164_1.var_.characterEffect1096ui_story and not isNil(arg_164_1.actors_["1096ui_story"]) then
					arg_164_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1096ui_story"]) and arg_164_1.var_.characterEffect1096ui_story then
				arg_164_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 1.225

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(111192040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_6 = 49 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_4) / 49)

				if (49 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_4) / 49)) > 0 and var_167_2 < var_167_6 then
					arg_164_1.talkMaxDuration = var_167_6

					if var_167_6 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192040", "story_v_out_111192.awb") ~= 0 then
					local var_167_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192040", "story_v_out_111192.awb") / 1000

					if var_167_7 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_1
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_111192", "111192040", "story_v_out_111192.awb")

						arg_164_1:RecordAudio("111192040", var_167_8)
						arg_164_1:RecordAudio("111192040", var_167_8)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_111192", "111192040", "story_v_out_111192.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_111192", "111192040", "story_v_out_111192.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_9 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_9 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_9

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_9 and arg_164_1.time_ < var_167_1 + var_167_9 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play111192041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 111192041
		arg_168_1.duration_ = 3.7

		local var_168_0 = {
			ja = 3.7,
			ko = 3.166,
			zh = 2.3,
			en = 2.5
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play111192042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_171_0 = arg_168_1.actors_["1096ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1096ui_story == nil then
				arg_168_1.var_.characterEffect1096ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_1 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 and not isNil(var_171_0) then
				if arg_168_1.var_.characterEffect1096ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1096ui_story then
				arg_168_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_171_3 = 0
			local var_171_4 = 0.3

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_5 = arg_168_1:GetWordFromCfg(111192041)
				local var_171_6 = arg_168_1:FormatText(var_171_5.content)

				arg_168_1.text_.text = var_171_6

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_8 = 12 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_6) / 12)

				if (12 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_6) / 12)) > 0 and var_171_4 < var_171_8 then
					arg_168_1.talkMaxDuration = var_171_8

					if var_171_8 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_3
					end
				end

				arg_168_1.text_.text = var_171_6
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192041", "story_v_out_111192.awb") ~= 0 then
					local var_171_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192041", "story_v_out_111192.awb") / 1000

					if var_171_9 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_3
					end

					if var_171_5.prefab_name ~= "" and arg_168_1.actors_[var_171_5.prefab_name] ~= nil then
						local var_171_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_5.prefab_name].transform, "story_v_out_111192", "111192041", "story_v_out_111192.awb")

						arg_168_1:RecordAudio("111192041", var_171_10)
						arg_168_1:RecordAudio("111192041", var_171_10)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_111192", "111192041", "story_v_out_111192.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_111192", "111192041", "story_v_out_111192.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_4, arg_168_1.talkMaxDuration)

			if var_171_3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_3 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_3) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_3 + var_171_11 and arg_168_1.time_ < var_171_3 + var_171_11 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play111192042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 111192042
		arg_172_1.duration_ = 7.63

		local var_172_0 = {
			ja = 7.633,
			ko = 5.8,
			zh = 5.733,
			en = 4.4
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play111192043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1096ui_story"]) and arg_172_1.var_.characterEffect1096ui_story == nil then
				arg_172_1.var_.characterEffect1096ui_story = arg_172_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1096ui_story"]) then
				if arg_172_1.var_.characterEffect1096ui_story and not isNil(arg_172_1.actors_["1096ui_story"]) then
					arg_172_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1096ui_story"]) and arg_172_1.var_.characterEffect1096ui_story then
				arg_172_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.775

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(111192042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 32 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_4) / 32)

				if (32 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_4) / 32)) > 0 and var_175_2 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192042", "story_v_out_111192.awb") ~= 0 then
					local var_175_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192042", "story_v_out_111192.awb") / 1000

					if var_175_7 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_1
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_111192", "111192042", "story_v_out_111192.awb")

						arg_172_1:RecordAudio("111192042", var_175_8)
						arg_172_1:RecordAudio("111192042", var_175_8)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_111192", "111192042", "story_v_out_111192.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_111192", "111192042", "story_v_out_111192.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_9 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_9 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_9

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_9 and arg_172_1.time_ < var_175_1 + var_175_9 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play111192043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 111192043
		arg_176_1.duration_ = 15.47

		local var_176_0 = {
			ja = 15.466,
			ko = 13.6,
			zh = 8.833,
			en = 10.566
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play111192044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.175

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:GetWordFromCfg(111192043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 48 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 48)

				if (48 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 48)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192043", "story_v_out_111192.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192043", "story_v_out_111192.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_111192", "111192043", "story_v_out_111192.awb")

						arg_176_1:RecordAudio("111192043", var_179_6)
						arg_176_1:RecordAudio("111192043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_111192", "111192043", "story_v_out_111192.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_111192", "111192043", "story_v_out_111192.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play111192044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 111192044
		arg_180_1.duration_ = 3.8

		local var_180_0 = {
			ja = 3.366,
			ko = 3.6,
			zh = 2.633,
			en = 3.8
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play111192045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_183_0 = arg_180_1.actors_["1096ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1096ui_story == nil then
				arg_180_1.var_.characterEffect1096ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_1 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 and not isNil(var_183_0) then
				if arg_180_1.var_.characterEffect1096ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1096ui_story then
				arg_180_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_183_3 = 0
			local var_183_4 = 0.35

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(111192044)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_8 = 10 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_6) / 10)

				if (10 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_6) / 10)) > 0 and var_183_4 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_3
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192044", "story_v_out_111192.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192044", "story_v_out_111192.awb") / 1000

					if var_183_9 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_3
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_111192", "111192044", "story_v_out_111192.awb")

						arg_180_1:RecordAudio("111192044", var_183_10)
						arg_180_1:RecordAudio("111192044", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_111192", "111192044", "story_v_out_111192.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_111192", "111192044", "story_v_out_111192.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_4, arg_180_1.talkMaxDuration)

			if var_183_3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_3 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_3) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_3 + var_183_11 and arg_180_1.time_ < var_183_3 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play111192045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 111192045
		arg_184_1.duration_ = 2

		local var_184_0 = {
			ja = 2,
			ko = 0.999999999999,
			zh = 1.3,
			en = 0.999999999999
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play111192046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1096ui_story"]) and arg_184_1.var_.characterEffect1096ui_story == nil then
				arg_184_1.var_.characterEffect1096ui_story = arg_184_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1096ui_story"]) then
				if arg_184_1.var_.characterEffect1096ui_story and not isNil(arg_184_1.actors_["1096ui_story"]) then
					arg_184_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1096ui_story"]) and arg_184_1.var_.characterEffect1096ui_story then
				arg_184_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.075

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(111192045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 3 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_4) / 3)

				if (3 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_4) / 3)) > 0 and var_187_2 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192045", "story_v_out_111192.awb") ~= 0 then
					local var_187_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192045", "story_v_out_111192.awb") / 1000

					if var_187_7 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_1
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_111192", "111192045", "story_v_out_111192.awb")

						arg_184_1:RecordAudio("111192045", var_187_8)
						arg_184_1:RecordAudio("111192045", var_187_8)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_111192", "111192045", "story_v_out_111192.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_111192", "111192045", "story_v_out_111192.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_9 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_9 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_9

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_9 and arg_184_1.time_ < var_187_1 + var_187_9 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play111192046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 111192046
		arg_188_1.duration_ = 8.93

		local var_188_0 = {
			ja = 6.266,
			ko = 7.866,
			zh = 8.933,
			en = 7.7
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play111192047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1096ui_story"]) and arg_188_1.var_.characterEffect1096ui_story == nil then
				arg_188_1.var_.characterEffect1096ui_story = arg_188_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1096ui_story"]) then
				if arg_188_1.var_.characterEffect1096ui_story and not isNil(arg_188_1.actors_["1096ui_story"]) then
					arg_188_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1096ui_story"]) and arg_188_1.var_.characterEffect1096ui_story then
				arg_188_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_191_2 = 0
			local var_191_3 = 1.175

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(111192046)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 47 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 47)

				if (47 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 47)) > 0 and var_191_3 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192046", "story_v_out_111192.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_111192", "111192046", "story_v_out_111192.awb") / 1000

					if var_191_8 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_2
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_out_111192", "111192046", "story_v_out_111192.awb")

						arg_188_1:RecordAudio("111192046", var_191_9)
						arg_188_1:RecordAudio("111192046", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_111192", "111192046", "story_v_out_111192.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_111192", "111192046", "story_v_out_111192.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_10 and arg_188_1.time_ < var_191_2 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play111192047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 111192047
		arg_192_1.duration_ = 9.6

		local var_192_0 = {
			ja = 3.633,
			ko = 6.933,
			zh = 6.6,
			en = 9.6
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play111192048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action6_1")
			end

			local var_195_0 = 0
			local var_195_1 = 0.8

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_2 = arg_192_1:GetWordFromCfg(111192047)
				local var_195_3 = arg_192_1:FormatText(var_195_2.content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 33 <= 0 and var_195_1 or var_195_1 * (utf8.len(var_195_3) / 33)

				if (33 <= 0 and var_195_1 or var_195_1 * (utf8.len(var_195_3) / 33)) > 0 and var_195_1 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192047", "story_v_out_111192.awb") ~= 0 then
					local var_195_6 = manager.audio:GetVoiceLength("story_v_out_111192", "111192047", "story_v_out_111192.awb") / 1000

					if var_195_6 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_0
					end

					if var_195_2.prefab_name ~= "" and arg_192_1.actors_[var_195_2.prefab_name] ~= nil then
						local var_195_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_2.prefab_name].transform, "story_v_out_111192", "111192047", "story_v_out_111192.awb")

						arg_192_1:RecordAudio("111192047", var_195_7)
						arg_192_1:RecordAudio("111192047", var_195_7)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_111192", "111192047", "story_v_out_111192.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_111192", "111192047", "story_v_out_111192.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_8 and arg_192_1.time_ < var_195_0 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play111192048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 111192048
		arg_196_1.duration_ = 12.03

		local var_196_0 = {
			ja = 11.1,
			ko = 10.2,
			zh = 8.733,
			en = 12.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play111192049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1096ui_story"]) and arg_196_1.var_.characterEffect1096ui_story == nil then
				arg_196_1.var_.characterEffect1096ui_story = arg_196_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1096ui_story"]) then
				if arg_196_1.var_.characterEffect1096ui_story and not isNil(arg_196_1.actors_["1096ui_story"]) then
					arg_196_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_0)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1096ui_story"]) and arg_196_1.var_.characterEffect1096ui_story then
				arg_196_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_199_1 = 0
			local var_199_2 = 1.125

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(111192048)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 45 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_4) / 45)

				if (45 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_4) / 45)) > 0 and var_199_2 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192048", "story_v_out_111192.awb") ~= 0 then
					local var_199_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192048", "story_v_out_111192.awb") / 1000

					if var_199_7 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_1
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_111192", "111192048", "story_v_out_111192.awb")

						arg_196_1:RecordAudio("111192048", var_199_8)
						arg_196_1:RecordAudio("111192048", var_199_8)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_111192", "111192048", "story_v_out_111192.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_111192", "111192048", "story_v_out_111192.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_9 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_9 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_9

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_9 and arg_196_1.time_ < var_199_1 + var_199_9 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play111192049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 111192049
		arg_200_1.duration_ = 9.63

		local var_200_0 = {
			ja = 5.5,
			ko = 6.966,
			zh = 4.866,
			en = 9.633
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play111192050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.675

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:GetWordFromCfg(111192049)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 27 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 27)

				if (27 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 27)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192049", "story_v_out_111192.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_111192", "111192049", "story_v_out_111192.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_111192", "111192049", "story_v_out_111192.awb")

						arg_200_1:RecordAudio("111192049", var_203_6)
						arg_200_1:RecordAudio("111192049", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_111192", "111192049", "story_v_out_111192.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_111192", "111192049", "story_v_out_111192.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play111192050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 111192050
		arg_204_1.duration_ = 7.8

		local var_204_0 = {
			ja = 7.8,
			ko = 3.8,
			zh = 2.966,
			en = 3.033
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play111192051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1096ui_story"]) and arg_204_1.var_.characterEffect1096ui_story == nil then
				arg_204_1.var_.characterEffect1096ui_story = arg_204_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1096ui_story"]) then
				if arg_204_1.var_.characterEffect1096ui_story and not isNil(arg_204_1.actors_["1096ui_story"]) then
					arg_204_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1096ui_story"]) and arg_204_1.var_.characterEffect1096ui_story then
				arg_204_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_207_2 = 0
			local var_207_3 = 0.325

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_4 = arg_204_1:GetWordFromCfg(111192050)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 13 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 13)

				if (13 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 13)) > 0 and var_207_3 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192050", "story_v_out_111192.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_111192", "111192050", "story_v_out_111192.awb") / 1000

					if var_207_8 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_2
					end

					if var_207_4.prefab_name ~= "" and arg_204_1.actors_[var_207_4.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_4.prefab_name].transform, "story_v_out_111192", "111192050", "story_v_out_111192.awb")

						arg_204_1:RecordAudio("111192050", var_207_9)
						arg_204_1:RecordAudio("111192050", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_111192", "111192050", "story_v_out_111192.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_111192", "111192050", "story_v_out_111192.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_10 and arg_204_1.time_ < var_207_2 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play111192051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 111192051
		arg_208_1.duration_ = 8.4

		local var_208_0 = {
			ja = 8.4,
			ko = 5.7,
			zh = 4.4,
			en = 6.3
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play111192052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1096ui_story"]) and arg_208_1.var_.characterEffect1096ui_story == nil then
				arg_208_1.var_.characterEffect1096ui_story = arg_208_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1096ui_story"]) then
				if arg_208_1.var_.characterEffect1096ui_story and not isNil(arg_208_1.actors_["1096ui_story"]) then
					arg_208_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1096ui_story"]) and arg_208_1.var_.characterEffect1096ui_story then
				arg_208_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 0.575

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(111192051)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 23 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 23)

				if (23 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 23)) > 0 and var_211_2 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192051", "story_v_out_111192.awb") ~= 0 then
					local var_211_7 = manager.audio:GetVoiceLength("story_v_out_111192", "111192051", "story_v_out_111192.awb") / 1000

					if var_211_7 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_1
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_111192", "111192051", "story_v_out_111192.awb")

						arg_208_1:RecordAudio("111192051", var_211_8)
						arg_208_1:RecordAudio("111192051", var_211_8)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_111192", "111192051", "story_v_out_111192.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_111192", "111192051", "story_v_out_111192.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_9 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_9 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_9

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_9 and arg_208_1.time_ < var_211_1 + var_211_9 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play111192052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 111192052
		arg_212_1.duration_ = 3.4

		local var_212_0 = {
			ja = 3.133,
			ko = 2.7,
			zh = 3.066,
			en = 3.4
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play111192053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action6_2")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_215_0 = arg_212_1.actors_["1096ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1096ui_story == nil then
				arg_212_1.var_.characterEffect1096ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_1 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 and not isNil(var_215_0) then
				if arg_212_1.var_.characterEffect1096ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1096ui_story then
				arg_212_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_215_3 = 0
			local var_215_4 = 0.325

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_3 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_5 = arg_212_1:GetWordFromCfg(111192052)
				local var_215_6 = arg_212_1:FormatText(var_215_5.content)

				arg_212_1.text_.text = var_215_6

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_8 = 13 <= 0 and var_215_4 or var_215_4 * (utf8.len(var_215_6) / 13)

				if (13 <= 0 and var_215_4 or var_215_4 * (utf8.len(var_215_6) / 13)) > 0 and var_215_4 < var_215_8 then
					arg_212_1.talkMaxDuration = var_215_8

					if var_215_8 + var_215_3 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_3
					end
				end

				arg_212_1.text_.text = var_215_6
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192052", "story_v_out_111192.awb") ~= 0 then
					local var_215_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192052", "story_v_out_111192.awb") / 1000

					if var_215_9 + var_215_3 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_3
					end

					if var_215_5.prefab_name ~= "" and arg_212_1.actors_[var_215_5.prefab_name] ~= nil then
						local var_215_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_5.prefab_name].transform, "story_v_out_111192", "111192052", "story_v_out_111192.awb")

						arg_212_1:RecordAudio("111192052", var_215_10)
						arg_212_1:RecordAudio("111192052", var_215_10)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_111192", "111192052", "story_v_out_111192.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_111192", "111192052", "story_v_out_111192.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_11 = math.max(var_215_4, arg_212_1.talkMaxDuration)

			if var_215_3 <= arg_212_1.time_ and arg_212_1.time_ < var_215_3 + var_215_11 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_3) / var_215_11

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_3 + var_215_11 and arg_212_1.time_ < var_215_3 + var_215_11 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play111192053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 111192053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play111192054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1096ui_story"]) and arg_216_1.var_.characterEffect1096ui_story == nil then
				arg_216_1.var_.characterEffect1096ui_story = arg_216_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1096ui_story"]) then
				if arg_216_1.var_.characterEffect1096ui_story and not isNil(arg_216_1.actors_["1096ui_story"]) then
					arg_216_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1096ui_story"]) and arg_216_1.var_.characterEffect1096ui_story then
				arg_216_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.5

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(111192053).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 20 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 20)

				if (20 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 20)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play111192054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 111192054
		arg_220_1.duration_ = 3.73

		local var_220_0 = {
			ja = 3.733,
			ko = 3.2,
			zh = 3.133,
			en = 3.3
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
			arg_220_1.auto_ = false
		end

		function arg_220_1.playNext_(arg_222_0)
			arg_220_1.onStoryFinished_()
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_223_0 = arg_220_1.actors_["1096ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1096ui_story == nil then
				arg_220_1.var_.characterEffect1096ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_1 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 and not isNil(var_223_0) then
				if arg_220_1.var_.characterEffect1096ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1096ui_story then
				arg_220_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_223_3 = 0
			local var_223_4 = 0.375

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_3 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_5 = arg_220_1:GetWordFromCfg(111192054)
				local var_223_6 = arg_220_1:FormatText(var_223_5.content)

				arg_220_1.text_.text = var_223_6

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_8 = 15 <= 0 and var_223_4 or var_223_4 * (utf8.len(var_223_6) / 15)

				if (15 <= 0 and var_223_4 or var_223_4 * (utf8.len(var_223_6) / 15)) > 0 and var_223_4 < var_223_8 then
					arg_220_1.talkMaxDuration = var_223_8

					if var_223_8 + var_223_3 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_3
					end
				end

				arg_220_1.text_.text = var_223_6
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111192", "111192054", "story_v_out_111192.awb") ~= 0 then
					local var_223_9 = manager.audio:GetVoiceLength("story_v_out_111192", "111192054", "story_v_out_111192.awb") / 1000

					if var_223_9 + var_223_3 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_3
					end

					if var_223_5.prefab_name ~= "" and arg_220_1.actors_[var_223_5.prefab_name] ~= nil then
						local var_223_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_5.prefab_name].transform, "story_v_out_111192", "111192054", "story_v_out_111192.awb")

						arg_220_1:RecordAudio("111192054", var_223_10)
						arg_220_1:RecordAudio("111192054", var_223_10)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_111192", "111192054", "story_v_out_111192.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_111192", "111192054", "story_v_out_111192.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_11 = math.max(var_223_4, arg_220_1.talkMaxDuration)

			if var_223_3 <= arg_220_1.time_ and arg_220_1.time_ < var_223_3 + var_223_11 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_3) / var_223_11

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_3 + var_223_11 and arg_220_1.time_ < var_223_3 + var_223_11 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D07"
	},
	voices = {
		"story_v_out_111192.awb"
	}
}
