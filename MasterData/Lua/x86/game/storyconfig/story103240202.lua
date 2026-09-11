return {
	Play324022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324022001
		arg_1_1.duration_ = 8.13

		local var_1_0 = {
			zh = 4.96456520445645,
			ja = 8.13056520445645
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J13f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13f")
				var_4_0.name = "J13f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J13f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J13f

				arg_1_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J13f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.36456520445645

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1070ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 1.36456520445645
			local var_4_19 = 0.225

			if 1.36456520445645 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_7")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_21 = arg_1_1:GetWordFromCfg(324022001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 9 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 9)

				if (9 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 9)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022001", "story_v_out_324022.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_324022", "324022001", "story_v_out_324022.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_324022", "324022001", "story_v_out_324022.awb")

						arg_1_1:RecordAudio("324022001", var_4_26)
						arg_1_1:RecordAudio("324022001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324022", "324022001", "story_v_out_324022.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324022", "324022001", "story_v_out_324022.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324022002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324022002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324022003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1070ui_story"]) and arg_7_1.var_.characterEffect1070ui_story == nil then
				arg_7_1.var_.characterEffect1070ui_story = arg_7_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1070ui_story"]) then
				if arg_7_1.var_.characterEffect1070ui_story and not isNil(arg_7_1.actors_["1070ui_story"]) then
					arg_7_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1070ui_story"]) and arg_7_1.var_.characterEffect1070ui_story then
				arg_7_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0.6 < arg_7_1.time_ and arg_7_1.time_ <= 0.6 + arg_10_0 then
				arg_7_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_10_2 = 0
			local var_10_3 = 1.45

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_2 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_4 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(324022002).content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_6 = 58 <= 0 and var_10_3 or var_10_3 * (utf8.len(var_10_4) / 58)

				if (58 <= 0 and var_10_3 or var_10_3 * (utf8.len(var_10_4) / 58)) > 0 and var_10_3 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_2 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_2
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_3, arg_7_1.talkMaxDuration)

			if var_10_2 <= arg_7_1.time_ and arg_7_1.time_ < var_10_2 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_2) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_2 + var_10_7 and arg_7_1.time_ < var_10_2 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play324022003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 324022003
		arg_11_1.duration_ = 4.7

		local var_11_0 = {
			zh = 2.3,
			ja = 4.7
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
				arg_11_0:Play324022004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1070ui_story = arg_11_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1070ui_story"].transform.position).z)
				arg_11_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1070ui_story"].transform.localEulerAngles = arg_11_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_11_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1070ui_story"].transform.position).z)
				arg_11_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1070ui_story"].transform.localEulerAngles = arg_11_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1070ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1070ui_story == nil then
				arg_11_1.var_.characterEffect1070ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and not isNil(var_14_1) then
				if arg_11_1.var_.characterEffect1070ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1070ui_story then
				arg_11_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_14_4 = 0
			local var_14_5 = 0.3

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:GetWordFromCfg(324022003)
				local var_14_7 = arg_11_1:FormatText(var_14_6.content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_9 = 12 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 12)

				if (12 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 12)) > 0 and var_14_5 < var_14_9 then
					arg_11_1.talkMaxDuration = var_14_9

					if var_14_9 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_9 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022003", "story_v_out_324022.awb") ~= 0 then
					local var_14_10 = manager.audio:GetVoiceLength("story_v_out_324022", "324022003", "story_v_out_324022.awb") / 1000

					if var_14_10 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_4
					end

					if var_14_6.prefab_name ~= "" and arg_11_1.actors_[var_14_6.prefab_name] ~= nil then
						local var_14_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_6.prefab_name].transform, "story_v_out_324022", "324022003", "story_v_out_324022.awb")

						arg_11_1:RecordAudio("324022003", var_14_11)
						arg_11_1:RecordAudio("324022003", var_14_11)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_324022", "324022003", "story_v_out_324022.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_324022", "324022003", "story_v_out_324022.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_12 = math.max(var_14_5, arg_11_1.talkMaxDuration)

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_12 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_4) / var_14_12

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_4 + var_14_12 and arg_11_1.time_ < var_14_4 + var_14_12 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play324022004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 324022004
		arg_15_1.duration_ = 12.13

		local var_15_0 = {
			zh = 6.033,
			ja = 12.133
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play324022005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.6

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(324022004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 24 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 24)

				if (24 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 24)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022004", "story_v_out_324022.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022004", "story_v_out_324022.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_324022", "324022004", "story_v_out_324022.awb")

						arg_15_1:RecordAudio("324022004", var_18_6)
						arg_15_1:RecordAudio("324022004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_324022", "324022004", "story_v_out_324022.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_324022", "324022004", "story_v_out_324022.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play324022005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 324022005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play324022006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1070ui_story"]) and arg_19_1.var_.characterEffect1070ui_story == nil then
				arg_19_1.var_.characterEffect1070ui_story = arg_19_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1070ui_story"]) then
				if arg_19_1.var_.characterEffect1070ui_story and not isNil(arg_19_1.actors_["1070ui_story"]) then
					arg_19_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1070ui_story"]) and arg_19_1.var_.characterEffect1070ui_story then
				arg_19_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_22_1 = 0
			local var_22_2 = 0.55

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(324022005).content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 22 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 22)

				if (22 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 22)) > 0 and var_22_2 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_6 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_6 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_6

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_6 and arg_19_1.time_ < var_22_1 + var_22_6 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play324022006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 324022006
		arg_23_1.duration_ = 6.03

		local var_23_0 = {
			zh = 5.2,
			ja = 6.033
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play324022007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1070ui_story"]) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = arg_23_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1070ui_story"]) then
				if arg_23_1.var_.characterEffect1070ui_story and not isNil(arg_23_1.actors_["1070ui_story"]) then
					arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1070ui_story"]) and arg_23_1.var_.characterEffect1070ui_story then
				arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_26_2 = 0
			local var_26_3 = 0.6

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_4 = arg_23_1:GetWordFromCfg(324022006)
				local var_26_5 = arg_23_1:FormatText(var_26_4.content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 24 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 24)

				if (24 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 24)) > 0 and var_26_3 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022006", "story_v_out_324022.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022006", "story_v_out_324022.awb") / 1000

					if var_26_8 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_2
					end

					if var_26_4.prefab_name ~= "" and arg_23_1.actors_[var_26_4.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_4.prefab_name].transform, "story_v_out_324022", "324022006", "story_v_out_324022.awb")

						arg_23_1:RecordAudio("324022006", var_26_9)
						arg_23_1:RecordAudio("324022006", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_324022", "324022006", "story_v_out_324022.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_324022", "324022006", "story_v_out_324022.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play324022007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 324022007
		arg_27_1.duration_ = 5.4

		local var_27_0 = {
			zh = 3.233,
			ja = 5.4
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play324022008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.35

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:GetWordFromCfg(324022007)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 14 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 14)

				if (14 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 14)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022007", "story_v_out_324022.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022007", "story_v_out_324022.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_324022", "324022007", "story_v_out_324022.awb")

						arg_27_1:RecordAudio("324022007", var_30_6)
						arg_27_1:RecordAudio("324022007", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_324022", "324022007", "story_v_out_324022.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_324022", "324022007", "story_v_out_324022.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play324022008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 324022008
		arg_31_1.duration_ = 7.2

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play324022009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.bgs_.ST2009 == nil then
				local var_34_0 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2009")
				var_34_0.name = "ST2009"
				var_34_0.transform.parent = arg_31_1.stage_.transform
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_.ST2009 = var_34_0
			end

			if 1.23333333333333 < arg_31_1.time_ and arg_31_1.time_ <= 1.23333333333333 + arg_34_0 then
				local var_34_1 = arg_31_1.bgs_.ST2009

				arg_31_1.bgs_.ST2009.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_34_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_2 = var_34_1:GetComponent("SpriteRenderer")

				if var_34_2 and var_34_2.sprite then
					local var_34_3 = 2 * (var_34_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_34_1.transform.localScale = Vector3.New(var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "ST2009" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_4 = 1.23333333333333

			if 1.23333333333333 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			if arg_31_1.time_ >= var_34_4 + 0.3 and arg_31_1.time_ < var_34_4 + 0.3 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			local var_34_5 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_6 = 1.3

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 then
				local var_34_7 = Color.New(0, 0, 0)

				var_34_7.a = Mathf.Lerp(0, 1, (arg_31_1.time_ - var_34_5) / var_34_6)
				arg_31_1.mask_.color = var_34_7
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 then
				local var_34_8 = Color.New(0, 0, 0)

				var_34_8.a = 1
				arg_31_1.mask_.color = var_34_8
			end

			local var_34_9 = 1.3

			if 1.3 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_10 = 1.3

			if var_34_9 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_10 then
				local var_34_11 = Color.New(0, 0, 0)

				var_34_11.a = Mathf.Lerp(1, 0, (arg_31_1.time_ - var_34_9) / var_34_10)
				arg_31_1.mask_.color = var_34_11
			end

			if arg_31_1.time_ >= var_34_9 + var_34_10 and arg_31_1.time_ < var_34_9 + var_34_10 + arg_34_0 then
				local var_34_12 = Color.New(0, 0, 0)

				arg_31_1.mask_.enabled = false
				var_34_12.a = 0
				arg_31_1.mask_.color = var_34_12
			end

			local var_34_13 = arg_31_1.actors_["1070ui_story"].transform

			if 1.26666666666667 < arg_31_1.time_ and arg_31_1.time_ <= 1.26666666666667 + arg_34_0 then
				arg_31_1.var_.moveOldPos1070ui_story = var_34_13.localPosition
			end

			local var_34_14 = 0.001

			if 1.26666666666667 <= arg_31_1.time_ and arg_31_1.time_ < 1.26666666666667 + var_34_14 then
				var_34_13.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 1.26666666666667) / var_34_14)
				var_34_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_13.position).x, (manager.ui.mainCamera.transform.position - var_34_13.position).y, (manager.ui.mainCamera.transform.position - var_34_13.position).z)
				var_34_13.localEulerAngles.z = 0
				var_34_13.localEulerAngles.x = 0
				var_34_13.localEulerAngles = var_34_13.localEulerAngles
			end

			if arg_31_1.time_ >= 1.26666666666667 + var_34_14 and arg_31_1.time_ < 1.26666666666667 + var_34_14 + arg_34_0 then
				var_34_13.localPosition = Vector3.New(0, 100, 0)
				var_34_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_13.position).x, (manager.ui.mainCamera.transform.position - var_34_13.position).y, (manager.ui.mainCamera.transform.position - var_34_13.position).z)
				var_34_13.localEulerAngles.z = 0
				var_34_13.localEulerAngles.x = 0
				var_34_13.localEulerAngles = var_34_13.localEulerAngles
			end

			local var_34_15 = arg_31_1.actors_["1070ui_story"]

			if 1.26666666666667 < arg_31_1.time_ and arg_31_1.time_ <= 1.26666666666667 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect1070ui_story == nil then
				arg_31_1.var_.characterEffect1070ui_story = var_34_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_16 = 0.200000002980232

			if 1.26666666666667 <= arg_31_1.time_ and arg_31_1.time_ < 1.26666666666667 + var_34_16 and not isNil(var_34_15) then
				if arg_31_1.var_.characterEffect1070ui_story and not isNil(var_34_15) then
					arg_31_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 1.26666666666667) / var_34_16)
				end
			end

			if arg_31_1.time_ >= 1.26666666666667 + var_34_16 and arg_31_1.time_ < 1.26666666666667 + var_34_16 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect1070ui_story then
				arg_31_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_31_1.time_ and arg_31_1.time_ <= 1.2 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0.1 < arg_31_1.time_ and arg_31_1.time_ <= 0.1 + arg_34_0 then
				arg_31_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:AudioAction("play", "music", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun.awb")

				local var_34_21 = manager.audio:GetAudioName("bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun")

				if "" ~= "" then
					if arg_31_1.bgmTxt_.text ~= var_34_21 and arg_31_1.bgmTxt_.text ~= "" then
						if arg_31_1.bgmTxt2_.text ~= "" then
							arg_31_1.bgmTxt_.text = arg_31_1.bgmTxt2_.text
						end

						arg_31_1.bgmTxt2_.text = var_34_21

						arg_31_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_31_1.bgmTxt_.text = var_34_21
						arg_31_1.bgmTxt2_.text = var_34_21
					end

					if arg_31_1.bgmTimer then
						arg_31_1.bgmTimer:Stop()

						arg_31_1.bgmTimer = nil
					end

					if arg_31_1.settingData.show_music_name == 1 then
						arg_31_1.musicController:SetSelectedState("show")
						arg_31_1.musicAnimator_:Play("open", 0, 0)

						if arg_31_1.settingData.music_time ~= 0 then
							arg_31_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_31_1.settingData.music_time), function()
								if arg_31_1 == nil or isNil(arg_31_1.bgmTxt_) then
									return
								end

								arg_31_1.musicController:SetSelectedState("hide")
								arg_31_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_22 = 2.2
			local var_34_23 = 1.125

			if 2.2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_22 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_24 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_24:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_31_1.dialogCg_.alpha = arg_36_0
				end))
				var_34_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_25 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(324022008).content)

				arg_31_1.text_.text = var_34_25

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_27 = 45 <= 0 and var_34_23 or var_34_23 * (utf8.len(var_34_25) / 45)

				if (45 <= 0 and var_34_23 or var_34_23 * (utf8.len(var_34_25) / 45)) > 0 and var_34_23 < var_34_27 then
					arg_31_1.talkMaxDuration = var_34_27
					var_34_22 = var_34_22 + 0.3

					if var_34_27 + var_34_22 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_27 + var_34_22
					end
				end

				arg_31_1.text_.text = var_34_25
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_28 = var_34_22 + 0.3
			local var_34_29 = math.max(var_34_23, arg_31_1.talkMaxDuration)

			if var_34_22 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_28 + var_34_29 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_28) / var_34_29

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_28 + var_34_29 and arg_31_1.time_ < var_34_28 + var_34_29 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.26666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play324022009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324022009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324022010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1.55

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(324022009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 62 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 62)

				if (62 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 62)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play324022010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324022010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play324022011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.3

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(324022010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 52 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 52)

				if (52 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 52)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324022011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324022011
		arg_46_1.duration_ = 5.32

		local var_46_0 = {
			zh = 5.32433333333333,
			ja = 4.92433333333333
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324022012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.bgs_.MS2401 == nil then
				local var_49_0 = Object.Instantiate(arg_46_1.paintGo_)

				var_49_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2401")
				var_49_0.name = "MS2401"
				var_49_0.transform.parent = arg_46_1.stage_.transform
				var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.bgs_.MS2401 = var_49_0
			end

			if 1.85 < arg_46_1.time_ and arg_46_1.time_ <= 1.85 + arg_49_0 then
				local var_49_1 = arg_46_1.bgs_.MS2401

				arg_46_1.bgs_.MS2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_49_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_2 = var_49_1:GetComponent("SpriteRenderer")

				if var_49_2 and var_49_2.sprite then
					local var_49_3 = 2 * (var_49_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_49_1.transform.localScale = Vector3.New(var_49_3 / var_49_2.sprite.bounds.size.y < var_49_3 * manager.ui.mainCameraCom_.aspect / var_49_2.sprite.bounds.size.x and var_49_3 * manager.ui.mainCameraCom_.aspect / var_49_2.sprite.bounds.size.x or var_49_3 / var_49_2.sprite.bounds.size.y, var_49_3 / var_49_2.sprite.bounds.size.y < var_49_3 * manager.ui.mainCameraCom_.aspect / var_49_2.sprite.bounds.size.x and var_49_3 * manager.ui.mainCameraCom_.aspect / var_49_2.sprite.bounds.size.x or var_49_3 / var_49_2.sprite.bounds.size.y, 0)
				end

				for iter_49_0, iter_49_1 in pairs(arg_46_1.bgs_) do
					if iter_49_0 ~= "MS2401" then
						iter_49_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_49_4 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			if arg_46_1.time_ >= var_49_4 + 0.3 and arg_46_1.time_ < var_49_4 + 0.3 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end

			local var_49_5 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_6 = 1.86666666666667

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 then
				local var_49_7 = Color.New(0, 0, 0)

				var_49_7.a = Mathf.Lerp(0, 1, (arg_46_1.time_ - var_49_5) / var_49_6)
				arg_46_1.mask_.color = var_49_7
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 then
				local var_49_8 = Color.New(0, 0, 0)

				var_49_8.a = 1
				arg_46_1.mask_.color = var_49_8
			end

			local var_49_9 = 1.86666666666667

			if 1.86666666666667 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_10 = 1.79166666666667

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_10 then
				local var_49_11 = Color.New(0, 0, 0)

				var_49_11.a = Mathf.Lerp(1, 0, (arg_46_1.time_ - var_49_9) / var_49_10)
				arg_46_1.mask_.color = var_49_11
			end

			if arg_46_1.time_ >= var_49_9 + var_49_10 and arg_46_1.time_ < var_49_9 + var_49_10 + arg_49_0 then
				local var_49_12 = Color.New(0, 0, 0)

				arg_46_1.mask_.enabled = false
				var_49_12.a = 0
				arg_46_1.mask_.color = var_49_12
			end

			local var_49_13 = arg_46_1.actors_["1070ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_13) and arg_46_1.var_.characterEffect1070ui_story == nil then
				arg_46_1.var_.characterEffect1070ui_story = var_49_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_14 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_14 and not isNil(var_49_13) then
				if arg_46_1.var_.characterEffect1070ui_story and not isNil(var_49_13) then
					arg_46_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_14 and arg_46_1.time_ < 0 + var_49_14 + arg_49_0 and not isNil(var_49_13) and arg_46_1.var_.characterEffect1070ui_story then
				arg_46_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_49_16 = arg_46_1.bgs_.MS2401.transform

			if 1.86666666666667 < arg_46_1.time_ and arg_46_1.time_ <= 1.86666666666667 + arg_49_0 then
				arg_46_1.var_.moveOldPosMS2401 = var_49_16.localPosition
			end

			local var_49_17 = 1.79166666666667

			if 1.86666666666667 <= arg_46_1.time_ and arg_46_1.time_ < 1.86666666666667 + var_49_17 then
				var_49_16.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPosMS2401, Vector3.New(0, 1, 10), (arg_46_1.time_ - 1.86666666666667) / var_49_17)
			end

			if arg_46_1.time_ >= 1.86666666666667 + var_49_17 and arg_46_1.time_ < 1.86666666666667 + var_49_17 + arg_49_0 then
				var_49_16.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_18 = 3.65833333333333
			local var_49_19 = 0.075

			if 3.65833333333333 < arg_46_1.time_ and arg_46_1.time_ <= var_49_18 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_20 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_20:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_21 = arg_46_1:GetWordFromCfg(324022011)
				local var_49_22 = arg_46_1:FormatText(var_49_21.content)

				arg_46_1.text_.text = var_49_22

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_24 = 3 <= 0 and var_49_19 or var_49_19 * (utf8.len(var_49_22) / 3)

				if (3 <= 0 and var_49_19 or var_49_19 * (utf8.len(var_49_22) / 3)) > 0 and var_49_19 < var_49_24 then
					arg_46_1.talkMaxDuration = var_49_24
					var_49_18 = var_49_18 + 0.3

					if var_49_24 + var_49_18 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_24 + var_49_18
					end
				end

				arg_46_1.text_.text = var_49_22
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022011", "story_v_out_324022.awb") ~= 0 then
					local var_49_25 = manager.audio:GetVoiceLength("story_v_out_324022", "324022011", "story_v_out_324022.awb") / 1000

					if var_49_25 + var_49_18 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_25 + var_49_18
					end

					if var_49_21.prefab_name ~= "" and arg_46_1.actors_[var_49_21.prefab_name] ~= nil then
						local var_49_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_21.prefab_name].transform, "story_v_out_324022", "324022011", "story_v_out_324022.awb")

						arg_46_1:RecordAudio("324022011", var_49_26)
						arg_46_1:RecordAudio("324022011", var_49_26)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_324022", "324022011", "story_v_out_324022.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_324022", "324022011", "story_v_out_324022.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_27 = var_49_18 + 0.3
			local var_49_28 = math.max(var_49_19, arg_46_1.talkMaxDuration)

			if var_49_18 + 0.3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_27 + var_49_28 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_27) / var_49_28

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_27 + var_49_28 and arg_46_1.time_ < var_49_27 + var_49_28 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play324022012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324022012
		arg_52_1.duration_ = 4.17

		local var_52_0 = {
			zh = 4.166,
			ja = 3.933
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
				arg_52_0:Play324022013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1070ui_story"]) and arg_52_1.var_.characterEffect1070ui_story == nil then
				arg_52_1.var_.characterEffect1070ui_story = arg_52_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1070ui_story"]) then
				if arg_52_1.var_.characterEffect1070ui_story and not isNil(arg_52_1.actors_["1070ui_story"]) then
					arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1070ui_story"]) and arg_52_1.var_.characterEffect1070ui_story then
				arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(324022012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 12 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 12)

				if (12 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 12)) > 0 and var_55_2 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022012", "story_v_out_324022.awb") ~= 0 then
					local var_55_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022012", "story_v_out_324022.awb") / 1000

					if var_55_7 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_1
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_324022", "324022012", "story_v_out_324022.awb")

						arg_52_1:RecordAudio("324022012", var_55_8)
						arg_52_1:RecordAudio("324022012", var_55_8)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324022", "324022012", "story_v_out_324022.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324022", "324022012", "story_v_out_324022.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_9 and arg_52_1.time_ < var_55_1 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324022013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324022013
		arg_56_1.duration_ = 4.83

		local var_56_0 = {
			zh = 3.8,
			ja = 4.833
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
				arg_56_0:Play324022014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1070ui_story"]) and arg_56_1.var_.characterEffect1070ui_story == nil then
				arg_56_1.var_.characterEffect1070ui_story = arg_56_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1070ui_story"]) then
				if arg_56_1.var_.characterEffect1070ui_story and not isNil(arg_56_1.actors_["1070ui_story"]) then
					arg_56_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1070ui_story"]) and arg_56_1.var_.characterEffect1070ui_story then
				arg_56_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_59_2 = 0
			local var_59_3 = 0.35

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(324022013)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 14 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 14)

				if (14 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 14)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022013", "story_v_out_324022.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022013", "story_v_out_324022.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_324022", "324022013", "story_v_out_324022.awb")

						arg_56_1:RecordAudio("324022013", var_59_9)
						arg_56_1:RecordAudio("324022013", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324022", "324022013", "story_v_out_324022.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324022", "324022013", "story_v_out_324022.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324022014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324022014
		arg_60_1.duration_ = 8.6

		local var_60_0 = {
			zh = 8.6,
			ja = 8.3
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
				arg_60_0:Play324022015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1070ui_story"]) and arg_60_1.var_.characterEffect1070ui_story == nil then
				arg_60_1.var_.characterEffect1070ui_story = arg_60_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1070ui_story"]) then
				if arg_60_1.var_.characterEffect1070ui_story and not isNil(arg_60_1.actors_["1070ui_story"]) then
					arg_60_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1070ui_story"]) and arg_60_1.var_.characterEffect1070ui_story then
				arg_60_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.8

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(324022014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 32 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 32)

				if (32 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 32)) > 0 and var_63_2 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022014", "story_v_out_324022.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022014", "story_v_out_324022.awb") / 1000

					if var_63_7 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_1
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_324022", "324022014", "story_v_out_324022.awb")

						arg_60_1:RecordAudio("324022014", var_63_8)
						arg_60_1:RecordAudio("324022014", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324022", "324022014", "story_v_out_324022.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324022", "324022014", "story_v_out_324022.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_9 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_9

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_9 and arg_60_1.time_ < var_63_1 + var_63_9 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324022015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324022015
		arg_64_1.duration_ = 6.67

		local var_64_0 = {
			zh = 5.3,
			ja = 6.666
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
				arg_64_0:Play324022016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1070ui_story"]) and arg_64_1.var_.characterEffect1070ui_story == nil then
				arg_64_1.var_.characterEffect1070ui_story = arg_64_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1070ui_story"]) then
				if arg_64_1.var_.characterEffect1070ui_story and not isNil(arg_64_1.actors_["1070ui_story"]) then
					arg_64_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1070ui_story"]) and arg_64_1.var_.characterEffect1070ui_story then
				arg_64_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_67_2 = 0
			local var_67_3 = 0.65

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(324022015)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 26 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 26)

				if (26 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 26)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022015", "story_v_out_324022.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022015", "story_v_out_324022.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_324022", "324022015", "story_v_out_324022.awb")

						arg_64_1:RecordAudio("324022015", var_67_9)
						arg_64_1:RecordAudio("324022015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324022", "324022015", "story_v_out_324022.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324022", "324022015", "story_v_out_324022.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324022016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324022016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324022017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1070ui_story"]) and arg_68_1.var_.characterEffect1070ui_story == nil then
				arg_68_1.var_.characterEffect1070ui_story = arg_68_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1070ui_story"]) then
				if arg_68_1.var_.characterEffect1070ui_story and not isNil(arg_68_1.actors_["1070ui_story"]) then
					arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1070ui_story"]) and arg_68_1.var_.characterEffect1070ui_story then
				arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 1.45

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(324022016).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 58 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 58)

				if (58 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 58)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324022017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324022017
		arg_72_1.duration_ = 8.57

		local var_72_0 = {
			zh = 5.6,
			ja = 8.566
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
				arg_72_0:Play324022018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.55

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(324022017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 22 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 22)

				if (22 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 22)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022017", "story_v_out_324022.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022017", "story_v_out_324022.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_324022", "324022017", "story_v_out_324022.awb")

						arg_72_1:RecordAudio("324022017", var_75_6)
						arg_72_1:RecordAudio("324022017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324022", "324022017", "story_v_out_324022.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324022", "324022017", "story_v_out_324022.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324022018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324022018
		arg_76_1.duration_ = 7.17

		local var_76_0 = {
			zh = 6.533,
			ja = 7.166
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324022019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) and arg_76_1.var_.characterEffect1070ui_story == nil then
				arg_76_1.var_.characterEffect1070ui_story = arg_76_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) then
				if arg_76_1.var_.characterEffect1070ui_story and not isNil(arg_76_1.actors_["1070ui_story"]) then
					arg_76_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) and arg_76_1.var_.characterEffect1070ui_story then
				arg_76_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_79_2 = 0
			local var_79_3 = 0.725

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(324022018)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 29 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 29)

				if (29 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 29)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022018", "story_v_out_324022.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022018", "story_v_out_324022.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_324022", "324022018", "story_v_out_324022.awb")

						arg_76_1:RecordAudio("324022018", var_79_9)
						arg_76_1:RecordAudio("324022018", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324022", "324022018", "story_v_out_324022.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324022", "324022018", "story_v_out_324022.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324022019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324022019
		arg_80_1.duration_ = 14.2

		local var_80_0 = {
			zh = 12.533,
			ja = 14.2
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324022020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1070ui_story"]) and arg_80_1.var_.characterEffect1070ui_story == nil then
				arg_80_1.var_.characterEffect1070ui_story = arg_80_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1070ui_story"]) then
				if arg_80_1.var_.characterEffect1070ui_story and not isNil(arg_80_1.actors_["1070ui_story"]) then
					arg_80_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1070ui_story"]) and arg_80_1.var_.characterEffect1070ui_story then
				arg_80_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 1.275

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(324022019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 51 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 51)

				if (51 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 51)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022019", "story_v_out_324022.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022019", "story_v_out_324022.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_324022", "324022019", "story_v_out_324022.awb")

						arg_80_1:RecordAudio("324022019", var_83_8)
						arg_80_1:RecordAudio("324022019", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324022", "324022019", "story_v_out_324022.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324022", "324022019", "story_v_out_324022.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play324022020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324022020
		arg_84_1.duration_ = 3.67

		local var_84_0 = {
			zh = 2.833,
			ja = 3.666
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324022021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1070ui_story"]) and arg_84_1.var_.characterEffect1070ui_story == nil then
				arg_84_1.var_.characterEffect1070ui_story = arg_84_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1070ui_story"]) then
				if arg_84_1.var_.characterEffect1070ui_story and not isNil(arg_84_1.actors_["1070ui_story"]) then
					arg_84_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1070ui_story"]) and arg_84_1.var_.characterEffect1070ui_story then
				arg_84_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_87_2 = 0
			local var_87_3 = 0.225

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(324022020)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 9 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 9)

				if (9 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 9)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022020", "story_v_out_324022.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022020", "story_v_out_324022.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_324022", "324022020", "story_v_out_324022.awb")

						arg_84_1:RecordAudio("324022020", var_87_9)
						arg_84_1:RecordAudio("324022020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324022", "324022020", "story_v_out_324022.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324022", "324022020", "story_v_out_324022.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324022021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324022021
		arg_88_1.duration_ = 14.5

		local var_88_0 = {
			zh = 11.933,
			ja = 14.5
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324022022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1070ui_story"]) and arg_88_1.var_.characterEffect1070ui_story == nil then
				arg_88_1.var_.characterEffect1070ui_story = arg_88_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1070ui_story"]) then
				if arg_88_1.var_.characterEffect1070ui_story and not isNil(arg_88_1.actors_["1070ui_story"]) then
					arg_88_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1070ui_story"]) and arg_88_1.var_.characterEffect1070ui_story then
				arg_88_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 1.075

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(324022021)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_6 = 43 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 43)

				if (43 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 43)) > 0 and var_91_2 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022021", "story_v_out_324022.awb") ~= 0 then
					local var_91_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022021", "story_v_out_324022.awb") / 1000

					if var_91_7 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_1
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_324022", "324022021", "story_v_out_324022.awb")

						arg_88_1:RecordAudio("324022021", var_91_8)
						arg_88_1:RecordAudio("324022021", var_91_8)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324022", "324022021", "story_v_out_324022.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324022", "324022021", "story_v_out_324022.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_9 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_9 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_9

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_9 and arg_88_1.time_ < var_91_1 + var_91_9 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324022022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324022022
		arg_92_1.duration_ = 11.8

		local var_92_0 = {
			zh = 11.666,
			ja = 11.8
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324022023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 1.075

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(324022022)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 43 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 43)

				if (43 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 43)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022022", "story_v_out_324022.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022022", "story_v_out_324022.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_324022", "324022022", "story_v_out_324022.awb")

						arg_92_1:RecordAudio("324022022", var_95_6)
						arg_92_1:RecordAudio("324022022", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324022", "324022022", "story_v_out_324022.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324022", "324022022", "story_v_out_324022.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play324022023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324022023
		arg_96_1.duration_ = 9.93

		local var_96_0 = {
			zh = 9.933,
			ja = 7.666
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324022024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 1

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(324022023)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 40 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 40)

				if (40 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 40)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022023", "story_v_out_324022.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022023", "story_v_out_324022.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_324022", "324022023", "story_v_out_324022.awb")

						arg_96_1:RecordAudio("324022023", var_99_6)
						arg_96_1:RecordAudio("324022023", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324022", "324022023", "story_v_out_324022.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324022", "324022023", "story_v_out_324022.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324022024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324022024
		arg_100_1.duration_ = 4.93

		local var_100_0 = {
			zh = 3.466,
			ja = 4.933
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324022025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) and arg_100_1.var_.characterEffect1070ui_story == nil then
				arg_100_1.var_.characterEffect1070ui_story = arg_100_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) then
				if arg_100_1.var_.characterEffect1070ui_story and not isNil(arg_100_1.actors_["1070ui_story"]) then
					arg_100_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) and arg_100_1.var_.characterEffect1070ui_story then
				arg_100_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_103_2 = 0
			local var_103_3 = 0.4

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(324022024)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 16 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 16)

				if (16 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 16)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022024", "story_v_out_324022.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022024", "story_v_out_324022.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_324022", "324022024", "story_v_out_324022.awb")

						arg_100_1:RecordAudio("324022024", var_103_9)
						arg_100_1:RecordAudio("324022024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324022", "324022024", "story_v_out_324022.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324022", "324022024", "story_v_out_324022.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324022025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324022025
		arg_104_1.duration_ = 13.1

		local var_104_0 = {
			zh = 11.566,
			ja = 13.1
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324022026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1070ui_story"]) and arg_104_1.var_.characterEffect1070ui_story == nil then
				arg_104_1.var_.characterEffect1070ui_story = arg_104_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1070ui_story"]) then
				if arg_104_1.var_.characterEffect1070ui_story and not isNil(arg_104_1.actors_["1070ui_story"]) then
					arg_104_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1070ui_story"]) and arg_104_1.var_.characterEffect1070ui_story then
				arg_104_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(324022025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_6 = 40 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_4) / 40)

				if (40 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_4) / 40)) > 0 and var_107_2 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022025", "story_v_out_324022.awb") ~= 0 then
					local var_107_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022025", "story_v_out_324022.awb") / 1000

					if var_107_7 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_1
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_324022", "324022025", "story_v_out_324022.awb")

						arg_104_1:RecordAudio("324022025", var_107_8)
						arg_104_1:RecordAudio("324022025", var_107_8)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_324022", "324022025", "story_v_out_324022.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_324022", "324022025", "story_v_out_324022.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_9 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_9 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_9

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_9 and arg_104_1.time_ < var_107_1 + var_107_9 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324022026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324022026
		arg_108_1.duration_ = 3.03

		local var_108_0 = {
			zh = 2.833,
			ja = 3.033
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324022027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.275

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(324022026)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 11 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 11)

				if (11 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 11)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022026", "story_v_out_324022.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022026", "story_v_out_324022.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_324022", "324022026", "story_v_out_324022.awb")

						arg_108_1:RecordAudio("324022026", var_111_6)
						arg_108_1:RecordAudio("324022026", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324022", "324022026", "story_v_out_324022.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324022", "324022026", "story_v_out_324022.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324022027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324022027
		arg_112_1.duration_ = 6.7

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324022028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPosMS2401 = arg_112_1.bgs_.MS2401.transform.localPosition
			end

			local var_115_0 = 1.3

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.bgs_.MS2401.transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPosMS2401, Vector3.New(0, 0.59, 7), (arg_112_1.time_ - 0) / var_115_0)
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.bgs_.MS2401.transform.localPosition = Vector3.New(0, 0.59, 7)
			end

			local var_115_1 = 0

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.allBtn_.enabled = false
			end

			if arg_112_1.time_ >= var_115_1 + 1.79166666666667 and arg_112_1.time_ < var_115_1 + 1.79166666666667 + arg_115_0 then
				arg_112_1.allBtn_.enabled = true
			end

			local var_115_2 = arg_112_1.bgs_.MS2401.transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPosMS2401 = var_115_2.localPosition
			end

			local var_115_3 = 1.79166666666667

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPosMS2401, Vector3.New(-1.01, 0.33, 5.28), (arg_112_1.time_ - 0) / var_115_3)
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(-1.01, 0.33, 5.28)
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_4 = 1.7
			local var_115_5 = 0.875

			if 1.7 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_6 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_6:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(324022027).content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 35 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 35)

				if (35 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 35)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9
					var_115_4 = var_115_4 + 0.3

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = var_115_4 + 0.3
			local var_115_11 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 + 0.3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_10) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.59, 7),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play324022028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324022028
		arg_118_1.duration_ = 6.8

		local var_118_0 = {
			zh = 6.366,
			ja = 6.8
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
				arg_118_0:Play324022029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.675

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(324022028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 27 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 27)

				if (27 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 27)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022028", "story_v_out_324022.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022028", "story_v_out_324022.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_324022", "324022028", "story_v_out_324022.awb")

						arg_118_1:RecordAudio("324022028", var_121_6)
						arg_118_1:RecordAudio("324022028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_324022", "324022028", "story_v_out_324022.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_324022", "324022028", "story_v_out_324022.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324022029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324022029
		arg_122_1.duration_ = 7.77

		local var_122_0 = {
			zh = 5.533,
			ja = 7.766
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324022030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1070ui_story"]) and arg_122_1.var_.characterEffect1070ui_story == nil then
				arg_122_1.var_.characterEffect1070ui_story = arg_122_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1070ui_story"]) then
				if arg_122_1.var_.characterEffect1070ui_story and not isNil(arg_122_1.actors_["1070ui_story"]) then
					arg_122_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1070ui_story"]) and arg_122_1.var_.characterEffect1070ui_story then
				arg_122_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_125_2 = 0
			local var_125_3 = 0.65

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(324022029)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 26 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 26)

				if (26 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 26)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022029", "story_v_out_324022.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022029", "story_v_out_324022.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_324022", "324022029", "story_v_out_324022.awb")

						arg_122_1:RecordAudio("324022029", var_125_9)
						arg_122_1:RecordAudio("324022029", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_324022", "324022029", "story_v_out_324022.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_324022", "324022029", "story_v_out_324022.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play324022030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324022030
		arg_126_1.duration_ = 7.7

		local var_126_0 = {
			zh = 5.133,
			ja = 7.7
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324022031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(324022030)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 24 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 24)

				if (24 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 24)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022030", "story_v_out_324022.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022030", "story_v_out_324022.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_324022", "324022030", "story_v_out_324022.awb")

						arg_126_1:RecordAudio("324022030", var_129_6)
						arg_126_1:RecordAudio("324022030", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_324022", "324022030", "story_v_out_324022.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_324022", "324022030", "story_v_out_324022.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play324022031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 324022031
		arg_130_1.duration_ = 4.73

		local var_130_0 = {
			zh = 3.566,
			ja = 4.733
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play324022032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1070ui_story"]) and arg_130_1.var_.characterEffect1070ui_story == nil then
				arg_130_1.var_.characterEffect1070ui_story = arg_130_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1070ui_story"]) then
				if arg_130_1.var_.characterEffect1070ui_story and not isNil(arg_130_1.actors_["1070ui_story"]) then
					arg_130_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1070ui_story"]) and arg_130_1.var_.characterEffect1070ui_story then
				arg_130_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_133_1 = 0
			local var_133_2 = 0.375

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:GetWordFromCfg(324022031)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 15 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_4) / 15)

				if (15 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_4) / 15)) > 0 and var_133_2 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022031", "story_v_out_324022.awb") ~= 0 then
					local var_133_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022031", "story_v_out_324022.awb") / 1000

					if var_133_7 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_1
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_324022", "324022031", "story_v_out_324022.awb")

						arg_130_1:RecordAudio("324022031", var_133_8)
						arg_130_1:RecordAudio("324022031", var_133_8)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_324022", "324022031", "story_v_out_324022.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_324022", "324022031", "story_v_out_324022.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_9 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_9 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_9

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_9 and arg_130_1.time_ < var_133_1 + var_133_9 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play324022032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 324022032
		arg_134_1.duration_ = 3.33

		local var_134_0 = {
			zh = 3.333,
			ja = 2.166
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play324022033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1070ui_story"]) and arg_134_1.var_.characterEffect1070ui_story == nil then
				arg_134_1.var_.characterEffect1070ui_story = arg_134_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1070ui_story"]) then
				if arg_134_1.var_.characterEffect1070ui_story and not isNil(arg_134_1.actors_["1070ui_story"]) then
					arg_134_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1070ui_story"]) and arg_134_1.var_.characterEffect1070ui_story then
				arg_134_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_137_2 = 0
			local var_137_3 = 0.15

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(324022032)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 6 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 6)

				if (6 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 6)) > 0 and var_137_3 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022032", "story_v_out_324022.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022032", "story_v_out_324022.awb") / 1000

					if var_137_8 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_2
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_324022", "324022032", "story_v_out_324022.awb")

						arg_134_1:RecordAudio("324022032", var_137_9)
						arg_134_1:RecordAudio("324022032", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_324022", "324022032", "story_v_out_324022.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_324022", "324022032", "story_v_out_324022.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_10 and arg_134_1.time_ < var_137_2 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play324022033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 324022033
		arg_138_1.duration_ = 8.9

		local var_138_0 = {
			zh = 7.066,
			ja = 8.9
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play324022034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1070ui_story"]) and arg_138_1.var_.characterEffect1070ui_story == nil then
				arg_138_1.var_.characterEffect1070ui_story = arg_138_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1070ui_story"]) then
				if arg_138_1.var_.characterEffect1070ui_story and not isNil(arg_138_1.actors_["1070ui_story"]) then
					arg_138_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1070ui_story"]) and arg_138_1.var_.characterEffect1070ui_story then
				arg_138_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.625

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_3 = arg_138_1:GetWordFromCfg(324022033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 25 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 25)

				if (25 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 25)) > 0 and var_141_2 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022033", "story_v_out_324022.awb") ~= 0 then
					local var_141_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022033", "story_v_out_324022.awb") / 1000

					if var_141_7 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_1
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_324022", "324022033", "story_v_out_324022.awb")

						arg_138_1:RecordAudio("324022033", var_141_8)
						arg_138_1:RecordAudio("324022033", var_141_8)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_324022", "324022033", "story_v_out_324022.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_324022", "324022033", "story_v_out_324022.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_9 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_9 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_9

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_9 and arg_138_1.time_ < var_141_1 + var_141_9 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play324022034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324022034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play324022035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.45

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(324022034).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 18 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 18)

				if (18 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 18)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play324022035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324022035
		arg_146_1.duration_ = 11.6

		local var_146_0 = {
			zh = 8.766,
			ja = 11.6
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324022036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.95

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:GetWordFromCfg(324022035)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 38 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 38)

				if (38 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 38)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022035", "story_v_out_324022.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022035", "story_v_out_324022.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_324022", "324022035", "story_v_out_324022.awb")

						arg_146_1:RecordAudio("324022035", var_149_6)
						arg_146_1:RecordAudio("324022035", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_324022", "324022035", "story_v_out_324022.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_324022", "324022035", "story_v_out_324022.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324022036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 324022036
		arg_150_1.duration_ = 1.43

		local var_150_0 = {
			zh = 1.3,
			ja = 1.433
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play324022037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.1

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(324022036)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 4 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 4)

				if (4 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 4)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022036", "story_v_out_324022.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022036", "story_v_out_324022.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_324022", "324022036", "story_v_out_324022.awb")

						arg_150_1:RecordAudio("324022036", var_153_6)
						arg_150_1:RecordAudio("324022036", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_324022", "324022036", "story_v_out_324022.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_324022", "324022036", "story_v_out_324022.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play324022037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 324022037
		arg_154_1.duration_ = 6.13

		local var_154_0 = {
			zh = 3.8,
			ja = 6.133
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play324022038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.425

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:GetWordFromCfg(324022037)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 17 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 17)

				if (17 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 17)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022037", "story_v_out_324022.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022037", "story_v_out_324022.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_324022", "324022037", "story_v_out_324022.awb")

						arg_154_1:RecordAudio("324022037", var_157_6)
						arg_154_1:RecordAudio("324022037", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_324022", "324022037", "story_v_out_324022.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_324022", "324022037", "story_v_out_324022.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play324022038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 324022038
		arg_158_1.duration_ = 9.17

		local var_158_0 = {
			zh = 5.766,
			ja = 9.166
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play324022039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.675

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:GetWordFromCfg(324022038)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 27 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 27)

				if (27 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 27)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022038", "story_v_out_324022.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022038", "story_v_out_324022.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_324022", "324022038", "story_v_out_324022.awb")

						arg_158_1:RecordAudio("324022038", var_161_6)
						arg_158_1:RecordAudio("324022038", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_324022", "324022038", "story_v_out_324022.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_324022", "324022038", "story_v_out_324022.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play324022039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 324022039
		arg_162_1.duration_ = 1.97

		local var_162_0 = {
			zh = 1,
			ja = 1.966
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play324022040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1070ui_story"]) and arg_162_1.var_.characterEffect1070ui_story == nil then
				arg_162_1.var_.characterEffect1070ui_story = arg_162_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1070ui_story"]) then
				if arg_162_1.var_.characterEffect1070ui_story and not isNil(arg_162_1.actors_["1070ui_story"]) then
					arg_162_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1070ui_story"]) and arg_162_1.var_.characterEffect1070ui_story then
				arg_162_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_165_2 = 0
			local var_165_3 = 0.05

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:GetWordFromCfg(324022039)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_7 = 2 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 2)

				if (2 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 2)) > 0 and var_165_3 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022039", "story_v_out_324022.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022039", "story_v_out_324022.awb") / 1000

					if var_165_8 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_2
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_out_324022", "324022039", "story_v_out_324022.awb")

						arg_162_1:RecordAudio("324022039", var_165_9)
						arg_162_1:RecordAudio("324022039", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_324022", "324022039", "story_v_out_324022.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_324022", "324022039", "story_v_out_324022.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_10 and arg_162_1.time_ < var_165_2 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play324022040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 324022040
		arg_166_1.duration_ = 7.63

		local var_166_0 = {
			zh = 5.4,
			ja = 7.633
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play324022041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1070ui_story"]) and arg_166_1.var_.characterEffect1070ui_story == nil then
				arg_166_1.var_.characterEffect1070ui_story = arg_166_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1070ui_story"]) then
				if arg_166_1.var_.characterEffect1070ui_story and not isNil(arg_166_1.actors_["1070ui_story"]) then
					arg_166_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1070ui_story"]) and arg_166_1.var_.characterEffect1070ui_story then
				arg_166_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.75

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:GetWordFromCfg(324022040)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_6 = 30 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_4) / 30)

				if (30 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_4) / 30)) > 0 and var_169_2 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022040", "story_v_out_324022.awb") ~= 0 then
					local var_169_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022040", "story_v_out_324022.awb") / 1000

					if var_169_7 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_1
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_324022", "324022040", "story_v_out_324022.awb")

						arg_166_1:RecordAudio("324022040", var_169_8)
						arg_166_1:RecordAudio("324022040", var_169_8)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_324022", "324022040", "story_v_out_324022.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_324022", "324022040", "story_v_out_324022.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_9 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_9 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_9

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_9 and arg_166_1.time_ < var_169_1 + var_169_9 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play324022041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 324022041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play324022042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.7

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(324022041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 28 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 28)

				if (28 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 28)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play324022042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 324022042
		arg_174_1.duration_ = 3.27

		local var_174_0 = {
			zh = 3.266,
			ja = 2.933
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play324022043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.3

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:GetWordFromCfg(324022042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 12 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 12)

				if (12 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 12)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022042", "story_v_out_324022.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022042", "story_v_out_324022.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_324022", "324022042", "story_v_out_324022.awb")

						arg_174_1:RecordAudio("324022042", var_177_6)
						arg_174_1:RecordAudio("324022042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_324022", "324022042", "story_v_out_324022.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_324022", "324022042", "story_v_out_324022.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play324022043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 324022043
		arg_178_1.duration_ = 2.7

		local var_178_0 = {
			zh = 2.6,
			ja = 2.7
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play324022044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.25

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:GetWordFromCfg(324022043)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 10 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 10)

				if (10 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 10)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022043", "story_v_out_324022.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022043", "story_v_out_324022.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_324022", "324022043", "story_v_out_324022.awb")

						arg_178_1:RecordAudio("324022043", var_181_6)
						arg_178_1:RecordAudio("324022043", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_324022", "324022043", "story_v_out_324022.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_324022", "324022043", "story_v_out_324022.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play324022044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 324022044
		arg_182_1.duration_ = 7.33

		local var_182_0 = {
			zh = 6.133,
			ja = 7.333
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play324022045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.9

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(324022044)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 36 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 36)

				if (36 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 36)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022044", "story_v_out_324022.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022044", "story_v_out_324022.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_324022", "324022044", "story_v_out_324022.awb")

						arg_182_1:RecordAudio("324022044", var_185_6)
						arg_182_1:RecordAudio("324022044", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_324022", "324022044", "story_v_out_324022.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_324022", "324022044", "story_v_out_324022.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play324022045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 324022045
		arg_186_1.duration_ = 5.13

		local var_186_0 = {
			zh = 3.866,
			ja = 5.133
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play324022046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.525

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:GetWordFromCfg(324022045)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 21 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 21)

				if (21 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 21)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022045", "story_v_out_324022.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022045", "story_v_out_324022.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_324022", "324022045", "story_v_out_324022.awb")

						arg_186_1:RecordAudio("324022045", var_189_6)
						arg_186_1:RecordAudio("324022045", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_324022", "324022045", "story_v_out_324022.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_324022", "324022045", "story_v_out_324022.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play324022046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 324022046
		arg_190_1.duration_ = 7.97

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play324022047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 1.56666666666667 < arg_190_1.time_ and arg_190_1.time_ <= 1.56666666666667 + arg_193_0 then
				local var_193_0 = arg_190_1.bgs_.ST2009

				arg_190_1.bgs_.ST2009.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_193_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_1 = var_193_0:GetComponent("SpriteRenderer")

				if var_193_1 and var_193_1.sprite then
					local var_193_2 = 2 * (var_193_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_193_0.transform.localScale = Vector3.New(var_193_2 / var_193_1.sprite.bounds.size.y < var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x and var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x or var_193_2 / var_193_1.sprite.bounds.size.y, var_193_2 / var_193_1.sprite.bounds.size.y < var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x and var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x or var_193_2 / var_193_1.sprite.bounds.size.y, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "ST2009" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_3 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			if arg_190_1.time_ >= var_193_3 + 0.3 and arg_190_1.time_ < var_193_3 + 0.3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_4 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_5 = 1.56666666666667

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_5 then
				local var_193_6 = Color.New(0, 0, 0)

				var_193_6.a = Mathf.Lerp(0, 1, (arg_190_1.time_ - var_193_4) / var_193_5)
				arg_190_1.mask_.color = var_193_6
			end

			if arg_190_1.time_ >= var_193_4 + var_193_5 and arg_190_1.time_ < var_193_4 + var_193_5 + arg_193_0 then
				local var_193_7 = Color.New(0, 0, 0)

				var_193_7.a = 1
				arg_190_1.mask_.color = var_193_7
			end

			local var_193_8 = 1.56666666666667

			if 1.56666666666667 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_9 = 1.56666666666667

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_9 then
				local var_193_10 = Color.New(0, 0, 0)

				var_193_10.a = Mathf.Lerp(1, 0, (arg_190_1.time_ - var_193_8) / var_193_9)
				arg_190_1.mask_.color = var_193_10
			end

			if arg_190_1.time_ >= var_193_8 + var_193_9 and arg_190_1.time_ < var_193_8 + var_193_9 + arg_193_0 then
				local var_193_11 = Color.New(0, 0, 0)

				arg_190_1.mask_.enabled = false
				var_193_11.a = 0
				arg_190_1.mask_.color = var_193_11
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_12 = 2.96666666666667
			local var_193_13 = 1.025

			if 2.96666666666667 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_14 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_14:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_15 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(324022046).content)

				arg_190_1.text_.text = var_193_15

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_17 = 41 <= 0 and var_193_13 or var_193_13 * (utf8.len(var_193_15) / 41)

				if (41 <= 0 and var_193_13 or var_193_13 * (utf8.len(var_193_15) / 41)) > 0 and var_193_13 < var_193_17 then
					arg_190_1.talkMaxDuration = var_193_17
					var_193_12 = var_193_12 + 0.3

					if var_193_17 + var_193_12 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_17 + var_193_12
					end
				end

				arg_190_1.text_.text = var_193_15
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_18 = var_193_12 + 0.3
			local var_193_19 = math.max(var_193_13, arg_190_1.talkMaxDuration)

			if var_193_12 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_18 + var_193_19 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_18) / var_193_19

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_18 + var_193_19 and arg_190_1.time_ < var_193_18 + var_193_19 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play324022047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324022047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324022048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0.5 < arg_196_1.time_ and arg_196_1.time_ <= 0.5 + arg_199_0 then
				arg_196_1:AudioAction("play", "effect", "se_story_150", "se_story_150_build", "")
			end

			local var_199_1 = 0
			local var_199_2 = 1.025

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(324022047).content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 41 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 41)

				if (41 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 41)) > 0 and var_199_2 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_6 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_6 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_6

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_6 and arg_196_1.time_ < var_199_1 + var_199_6 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324022048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324022048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324022049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.725

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(324022048).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 29 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 29)

				if (29 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 29)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play324022049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324022049
		arg_204_1.duration_ = 3.9

		local var_204_0 = {
			zh = 3.833,
			ja = 3.9
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
				arg_204_0:Play324022050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1070ui_story = arg_204_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_207_0 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 then
				arg_204_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_204_1.time_ - 0) / var_207_0)
				arg_204_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).z)
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles = arg_204_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 then
				arg_204_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_204_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).z)
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles = arg_204_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_207_1 = arg_204_1.actors_["1070ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1070ui_story == nil then
				arg_204_1.var_.characterEffect1070ui_story = var_207_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 and not isNil(var_207_1) then
				if arg_204_1.var_.characterEffect1070ui_story and not isNil(var_207_1) then
					arg_204_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1070ui_story then
				arg_204_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_207_4 = 0
			local var_207_5 = 0.4

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(324022049)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 16 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 16)

				if (16 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 16)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022049", "story_v_out_324022.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_324022", "324022049", "story_v_out_324022.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_324022", "324022049", "story_v_out_324022.awb")

						arg_204_1:RecordAudio("324022049", var_207_11)
						arg_204_1:RecordAudio("324022049", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324022", "324022049", "story_v_out_324022.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324022", "324022049", "story_v_out_324022.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play324022050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324022050
		arg_208_1.duration_ = 14.03

		local var_208_0 = {
			zh = 13.133,
			ja = 14.033
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
				arg_208_0:Play324022051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1070ui_story"]) and arg_208_1.var_.characterEffect1070ui_story == nil then
				arg_208_1.var_.characterEffect1070ui_story = arg_208_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1070ui_story"]) then
				if arg_208_1.var_.characterEffect1070ui_story and not isNil(arg_208_1.actors_["1070ui_story"]) then
					arg_208_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1070ui_story"]) and arg_208_1.var_.characterEffect1070ui_story then
				arg_208_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 1.25

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(324022050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 50 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 50)

				if (50 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 50)) > 0 and var_211_2 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022050", "story_v_out_324022.awb") ~= 0 then
					local var_211_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022050", "story_v_out_324022.awb") / 1000

					if var_211_7 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_1
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_324022", "324022050", "story_v_out_324022.awb")

						arg_208_1:RecordAudio("324022050", var_211_8)
						arg_208_1:RecordAudio("324022050", var_211_8)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324022", "324022050", "story_v_out_324022.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324022", "324022050", "story_v_out_324022.awb")
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
	Play324022051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324022051
		arg_212_1.duration_ = 17.67

		local var_212_0 = {
			zh = 17.666,
			ja = 12.4
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
				arg_212_0:Play324022052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 1.6

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:GetWordFromCfg(324022051)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 64 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 64)

				if (64 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 64)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022051", "story_v_out_324022.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022051", "story_v_out_324022.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_324022", "324022051", "story_v_out_324022.awb")

						arg_212_1:RecordAudio("324022051", var_215_6)
						arg_212_1:RecordAudio("324022051", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324022", "324022051", "story_v_out_324022.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324022", "324022051", "story_v_out_324022.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324022052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324022052
		arg_216_1.duration_ = 4.6

		local var_216_0 = {
			zh = 2.966,
			ja = 4.6
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324022053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1070ui_story"]) and arg_216_1.var_.characterEffect1070ui_story == nil then
				arg_216_1.var_.characterEffect1070ui_story = arg_216_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1070ui_story"]) then
				if arg_216_1.var_.characterEffect1070ui_story and not isNil(arg_216_1.actors_["1070ui_story"]) then
					arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1070ui_story"]) and arg_216_1.var_.characterEffect1070ui_story then
				arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_219_2 = 0
			local var_219_3 = 0.25

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_4 = arg_216_1:GetWordFromCfg(324022052)
				local var_219_5 = arg_216_1:FormatText(var_219_4.content)

				arg_216_1.text_.text = var_219_5

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_7 = 10 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 10)

				if (10 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 10)) > 0 and var_219_3 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_5
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022052", "story_v_out_324022.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022052", "story_v_out_324022.awb") / 1000

					if var_219_8 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_2
					end

					if var_219_4.prefab_name ~= "" and arg_216_1.actors_[var_219_4.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_4.prefab_name].transform, "story_v_out_324022", "324022052", "story_v_out_324022.awb")

						arg_216_1:RecordAudio("324022052", var_219_9)
						arg_216_1:RecordAudio("324022052", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324022", "324022052", "story_v_out_324022.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324022", "324022052", "story_v_out_324022.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_10 and arg_216_1.time_ < var_219_2 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play324022053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324022053
		arg_220_1.duration_ = 13.33

		local var_220_0 = {
			zh = 8.866,
			ja = 13.333
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
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324022054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1070ui_story"]) and arg_220_1.var_.characterEffect1070ui_story == nil then
				arg_220_1.var_.characterEffect1070ui_story = arg_220_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1070ui_story"]) then
				if arg_220_1.var_.characterEffect1070ui_story and not isNil(arg_220_1.actors_["1070ui_story"]) then
					arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_0)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1070ui_story"]) and arg_220_1.var_.characterEffect1070ui_story then
				arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_223_1 = 0
			local var_223_2 = 0.975

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:GetWordFromCfg(324022053)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_6 = 39 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_4) / 39)

				if (39 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_4) / 39)) > 0 and var_223_2 < var_223_6 then
					arg_220_1.talkMaxDuration = var_223_6

					if var_223_6 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_1
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022053", "story_v_out_324022.awb") ~= 0 then
					local var_223_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022053", "story_v_out_324022.awb") / 1000

					if var_223_7 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_1
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_out_324022", "324022053", "story_v_out_324022.awb")

						arg_220_1:RecordAudio("324022053", var_223_8)
						arg_220_1:RecordAudio("324022053", var_223_8)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324022", "324022053", "story_v_out_324022.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324022", "324022053", "story_v_out_324022.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_9 = math.max(var_223_2, arg_220_1.talkMaxDuration)

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_9 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_1) / var_223_9

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_1 + var_223_9 and arg_220_1.time_ < var_223_1 + var_223_9 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play324022054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324022054
		arg_224_1.duration_ = 5.97

		local var_224_0 = {
			zh = 5.966,
			ja = 5.366
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324022055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1070ui_story"]) and arg_224_1.var_.characterEffect1070ui_story == nil then
				arg_224_1.var_.characterEffect1070ui_story = arg_224_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1070ui_story"]) then
				if arg_224_1.var_.characterEffect1070ui_story and not isNil(arg_224_1.actors_["1070ui_story"]) then
					arg_224_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1070ui_story"]) and arg_224_1.var_.characterEffect1070ui_story then
				arg_224_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_227_2 = 0
			local var_227_3 = 0.65

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_2 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_4 = arg_224_1:GetWordFromCfg(324022054)
				local var_227_5 = arg_224_1:FormatText(var_227_4.content)

				arg_224_1.text_.text = var_227_5

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_7 = 26 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_5) / 26)

				if (26 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_5) / 26)) > 0 and var_227_3 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_2
					end
				end

				arg_224_1.text_.text = var_227_5
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022054", "story_v_out_324022.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022054", "story_v_out_324022.awb") / 1000

					if var_227_8 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_2
					end

					if var_227_4.prefab_name ~= "" and arg_224_1.actors_[var_227_4.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_4.prefab_name].transform, "story_v_out_324022", "324022054", "story_v_out_324022.awb")

						arg_224_1:RecordAudio("324022054", var_227_9)
						arg_224_1:RecordAudio("324022054", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324022", "324022054", "story_v_out_324022.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324022", "324022054", "story_v_out_324022.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_3, arg_224_1.talkMaxDuration)

			if var_227_2 <= arg_224_1.time_ and arg_224_1.time_ < var_227_2 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_2) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_2 + var_227_10 and arg_224_1.time_ < var_227_2 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324022055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324022055
		arg_228_1.duration_ = 11.5

		local var_228_0 = {
			zh = 8.866,
			ja = 11.5
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324022056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1.125

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(324022055)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 45 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 45)

				if (45 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 45)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022055", "story_v_out_324022.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022055", "story_v_out_324022.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_324022", "324022055", "story_v_out_324022.awb")

						arg_228_1:RecordAudio("324022055", var_231_6)
						arg_228_1:RecordAudio("324022055", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324022", "324022055", "story_v_out_324022.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324022", "324022055", "story_v_out_324022.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324022056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324022056
		arg_232_1.duration_ = 6.07

		local var_232_0 = {
			zh = 5.333,
			ja = 6.066
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324022057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1070ui_story"]) and arg_232_1.var_.characterEffect1070ui_story == nil then
				arg_232_1.var_.characterEffect1070ui_story = arg_232_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1070ui_story"]) then
				if arg_232_1.var_.characterEffect1070ui_story and not isNil(arg_232_1.actors_["1070ui_story"]) then
					arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_0)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1070ui_story"]) and arg_232_1.var_.characterEffect1070ui_story then
				arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_235_1 = 0
			local var_235_2 = 0.45

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:GetWordFromCfg(324022056)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_6 = 18 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_4) / 18)

				if (18 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_4) / 18)) > 0 and var_235_2 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022056", "story_v_out_324022.awb") ~= 0 then
					local var_235_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022056", "story_v_out_324022.awb") / 1000

					if var_235_7 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_1
					end

					if var_235_3.prefab_name ~= "" and arg_232_1.actors_[var_235_3.prefab_name] ~= nil then
						local var_235_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_3.prefab_name].transform, "story_v_out_324022", "324022056", "story_v_out_324022.awb")

						arg_232_1:RecordAudio("324022056", var_235_8)
						arg_232_1:RecordAudio("324022056", var_235_8)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324022", "324022056", "story_v_out_324022.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324022", "324022056", "story_v_out_324022.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_9 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_9 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_9

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_9 and arg_232_1.time_ < var_235_1 + var_235_9 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324022057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324022057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324022058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1070ui_story = arg_236_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1070ui_story"].transform.position).z)
				arg_236_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1070ui_story"].transform.localEulerAngles = arg_236_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1070ui_story"].transform.position).z)
				arg_236_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1070ui_story"].transform.localEulerAngles = arg_236_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_239_1 = 0
			local var_239_2 = 1.2

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(324022057).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 48 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 48)

				if (48 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 48)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play324022058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324022058
		arg_240_1.duration_ = 10.2

		local var_240_0 = {
			zh = 9.733,
			ja = 10.2
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324022059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.775

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:GetWordFromCfg(324022058)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 31 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 31)

				if (31 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 31)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022058", "story_v_out_324022.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022058", "story_v_out_324022.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_324022", "324022058", "story_v_out_324022.awb")

						arg_240_1:RecordAudio("324022058", var_243_6)
						arg_240_1:RecordAudio("324022058", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324022", "324022058", "story_v_out_324022.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324022", "324022058", "story_v_out_324022.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play324022059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324022059
		arg_244_1.duration_ = 2.47

		local var_244_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324022060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1070ui_story = arg_244_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1070ui_story"].transform.position).z)
				arg_244_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1070ui_story"].transform.localEulerAngles = arg_244_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_244_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1070ui_story"].transform.position).z)
				arg_244_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1070ui_story"].transform.localEulerAngles = arg_244_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1070ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1070ui_story == nil then
				arg_244_1.var_.characterEffect1070ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1070ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1070ui_story then
				arg_244_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_247_4 = 0
			local var_247_5 = 0.1

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(324022059)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 4 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 4)

				if (4 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 4)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022059", "story_v_out_324022.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_324022", "324022059", "story_v_out_324022.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_324022", "324022059", "story_v_out_324022.awb")

						arg_244_1:RecordAudio("324022059", var_247_11)
						arg_244_1:RecordAudio("324022059", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324022", "324022059", "story_v_out_324022.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324022", "324022059", "story_v_out_324022.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play324022060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324022060
		arg_248_1.duration_ = 4.7

		local var_248_0 = {
			zh = 4.7,
			ja = 3.9
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324022061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1070ui_story"]) and arg_248_1.var_.characterEffect1070ui_story == nil then
				arg_248_1.var_.characterEffect1070ui_story = arg_248_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1070ui_story"]) then
				if arg_248_1.var_.characterEffect1070ui_story and not isNil(arg_248_1.actors_["1070ui_story"]) then
					arg_248_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1070ui_story"]) and arg_248_1.var_.characterEffect1070ui_story then
				arg_248_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_251_1 = 0
			local var_251_2 = 0.425

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(324022060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_6 = 17 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_4) / 17)

				if (17 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_4) / 17)) > 0 and var_251_2 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022060", "story_v_out_324022.awb") ~= 0 then
					local var_251_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022060", "story_v_out_324022.awb") / 1000

					if var_251_7 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_1
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_324022", "324022060", "story_v_out_324022.awb")

						arg_248_1:RecordAudio("324022060", var_251_8)
						arg_248_1:RecordAudio("324022060", var_251_8)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_324022", "324022060", "story_v_out_324022.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_324022", "324022060", "story_v_out_324022.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_9 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_9 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_9

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_9 and arg_248_1.time_ < var_251_1 + var_251_9 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play324022061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324022061
		arg_252_1.duration_ = 3.4

		local var_252_0 = {
			zh = 3.3,
			ja = 3.4
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324022062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1070ui_story"]) and arg_252_1.var_.characterEffect1070ui_story == nil then
				arg_252_1.var_.characterEffect1070ui_story = arg_252_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1070ui_story"]) then
				if arg_252_1.var_.characterEffect1070ui_story and not isNil(arg_252_1.actors_["1070ui_story"]) then
					arg_252_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1070ui_story"]) and arg_252_1.var_.characterEffect1070ui_story then
				arg_252_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_255_2 = 0
			local var_255_3 = 0.4

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_4 = arg_252_1:GetWordFromCfg(324022061)
				local var_255_5 = arg_252_1:FormatText(var_255_4.content)

				arg_252_1.text_.text = var_255_5

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 16 <= 0 and var_255_3 or var_255_3 * (utf8.len(var_255_5) / 16)

				if (16 <= 0 and var_255_3 or var_255_3 * (utf8.len(var_255_5) / 16)) > 0 and var_255_3 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_2 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_2
					end
				end

				arg_252_1.text_.text = var_255_5
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022061", "story_v_out_324022.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022061", "story_v_out_324022.awb") / 1000

					if var_255_8 + var_255_2 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_2
					end

					if var_255_4.prefab_name ~= "" and arg_252_1.actors_[var_255_4.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_4.prefab_name].transform, "story_v_out_324022", "324022061", "story_v_out_324022.awb")

						arg_252_1:RecordAudio("324022061", var_255_9)
						arg_252_1:RecordAudio("324022061", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324022", "324022061", "story_v_out_324022.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324022", "324022061", "story_v_out_324022.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_3, arg_252_1.talkMaxDuration)

			if var_255_2 <= arg_252_1.time_ and arg_252_1.time_ < var_255_2 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_2) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_2 + var_255_10 and arg_252_1.time_ < var_255_2 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play324022062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324022062
		arg_256_1.duration_ = 8.87

		local var_256_0 = {
			zh = 8.866,
			ja = 7.533
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324022063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1070ui_story"]) and arg_256_1.var_.characterEffect1070ui_story == nil then
				arg_256_1.var_.characterEffect1070ui_story = arg_256_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1070ui_story"]) then
				if arg_256_1.var_.characterEffect1070ui_story and not isNil(arg_256_1.actors_["1070ui_story"]) then
					arg_256_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_0)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1070ui_story"]) and arg_256_1.var_.characterEffect1070ui_story then
				arg_256_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_259_1 = 0
			local var_259_2 = 0.725

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:GetWordFromCfg(324022062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_6 = 29 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_4) / 29)

				if (29 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_4) / 29)) > 0 and var_259_2 < var_259_6 then
					arg_256_1.talkMaxDuration = var_259_6

					if var_259_6 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022062", "story_v_out_324022.awb") ~= 0 then
					local var_259_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022062", "story_v_out_324022.awb") / 1000

					if var_259_7 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_1
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_324022", "324022062", "story_v_out_324022.awb")

						arg_256_1:RecordAudio("324022062", var_259_8)
						arg_256_1:RecordAudio("324022062", var_259_8)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_324022", "324022062", "story_v_out_324022.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_324022", "324022062", "story_v_out_324022.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_9 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_9 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_9

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_9 and arg_256_1.time_ < var_259_1 + var_259_9 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play324022063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324022063
		arg_260_1.duration_ = 15.47

		local var_260_0 = {
			zh = 14.4,
			ja = 15.466
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324022064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 1.45

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_1 = arg_260_1:GetWordFromCfg(324022063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 58 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 58)

				if (58 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 58)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022063", "story_v_out_324022.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022063", "story_v_out_324022.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_324022", "324022063", "story_v_out_324022.awb")

						arg_260_1:RecordAudio("324022063", var_263_6)
						arg_260_1:RecordAudio("324022063", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_324022", "324022063", "story_v_out_324022.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_324022", "324022063", "story_v_out_324022.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play324022064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324022064
		arg_264_1.duration_ = 13.67

		local var_264_0 = {
			zh = 13.4,
			ja = 13.666
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play324022065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 1.05

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:GetWordFromCfg(324022064)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 42 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 42)

				if (42 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 42)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022064", "story_v_out_324022.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_324022", "324022064", "story_v_out_324022.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_324022", "324022064", "story_v_out_324022.awb")

						arg_264_1:RecordAudio("324022064", var_267_6)
						arg_264_1:RecordAudio("324022064", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324022", "324022064", "story_v_out_324022.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324022", "324022064", "story_v_out_324022.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play324022065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324022065
		arg_268_1.duration_ = 3.23

		local var_268_0 = {
			zh = 1.999999999999,
			ja = 3.233
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324022066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1070ui_story"]) and arg_268_1.var_.characterEffect1070ui_story == nil then
				arg_268_1.var_.characterEffect1070ui_story = arg_268_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1070ui_story"]) then
				if arg_268_1.var_.characterEffect1070ui_story and not isNil(arg_268_1.actors_["1070ui_story"]) then
					arg_268_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1070ui_story"]) and arg_268_1.var_.characterEffect1070ui_story then
				arg_268_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_271_2 = 0
			local var_271_3 = 0.175

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_4 = arg_268_1:GetWordFromCfg(324022065)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 7 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 7)

				if (7 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 7)) > 0 and var_271_3 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022065", "story_v_out_324022.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022065", "story_v_out_324022.awb") / 1000

					if var_271_8 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_2
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_out_324022", "324022065", "story_v_out_324022.awb")

						arg_268_1:RecordAudio("324022065", var_271_9)
						arg_268_1:RecordAudio("324022065", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_324022", "324022065", "story_v_out_324022.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_324022", "324022065", "story_v_out_324022.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_10 and arg_268_1.time_ < var_271_2 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play324022066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324022066
		arg_272_1.duration_ = 3.73

		local var_272_0 = {
			zh = 2.266,
			ja = 3.733
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324022067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1070ui_story"]) and arg_272_1.var_.characterEffect1070ui_story == nil then
				arg_272_1.var_.characterEffect1070ui_story = arg_272_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1070ui_story"]) then
				if arg_272_1.var_.characterEffect1070ui_story and not isNil(arg_272_1.actors_["1070ui_story"]) then
					arg_272_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_0)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1070ui_story"]) and arg_272_1.var_.characterEffect1070ui_story then
				arg_272_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_275_1 = 0
			local var_275_2 = 0.15

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(324022066)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_6 = 6 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_4) / 6)

				if (6 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_4) / 6)) > 0 and var_275_2 < var_275_6 then
					arg_272_1.talkMaxDuration = var_275_6

					if var_275_6 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_6 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022066", "story_v_out_324022.awb") ~= 0 then
					local var_275_7 = manager.audio:GetVoiceLength("story_v_out_324022", "324022066", "story_v_out_324022.awb") / 1000

					if var_275_7 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_1
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_324022", "324022066", "story_v_out_324022.awb")

						arg_272_1:RecordAudio("324022066", var_275_8)
						arg_272_1:RecordAudio("324022066", var_275_8)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324022", "324022066", "story_v_out_324022.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324022", "324022066", "story_v_out_324022.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_9 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_9 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_9

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_9 and arg_272_1.time_ < var_275_1 + var_275_9 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324022067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324022067
		arg_276_1.duration_ = 8.63

		local var_276_0 = {
			zh = 6.8,
			ja = 8.633
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
			arg_276_1.auto_ = false
		end

		function arg_276_1.playNext_(arg_278_0)
			arg_276_1.onStoryFinished_()
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1070ui_story"]) and arg_276_1.var_.characterEffect1070ui_story == nil then
				arg_276_1.var_.characterEffect1070ui_story = arg_276_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1070ui_story"]) then
				if arg_276_1.var_.characterEffect1070ui_story and not isNil(arg_276_1.actors_["1070ui_story"]) then
					arg_276_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1070ui_story"]) and arg_276_1.var_.characterEffect1070ui_story then
				arg_276_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_279_2 = 0
			local var_279_3 = 0.8

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(324022067)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 32 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 32)

				if (32 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 32)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324022", "324022067", "story_v_out_324022.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_324022", "324022067", "story_v_out_324022.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_out_324022", "324022067", "story_v_out_324022.awb")

						arg_276_1:RecordAudio("324022067", var_279_9)
						arg_276_1:RecordAudio("324022067", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324022", "324022067", "story_v_out_324022.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324022", "324022067", "story_v_out_324022.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_3, arg_276_1.talkMaxDuration)

			if var_279_2 <= arg_276_1.time_ and arg_276_1.time_ < var_279_2 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_2) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_2 + var_279_10 and arg_276_1.time_ < var_279_2 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J13f",
		"TextureConfig/Background/ST2009",
		"TextureConfig/Background/MS2401"
	},
	voices = {
		"story_v_out_324022.awb"
	}
}
