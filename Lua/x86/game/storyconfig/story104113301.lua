return {
	Play411331001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411331001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411331002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07a"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.I07a

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.4

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_28 = 0.666666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[904].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(411331001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 40
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411331002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411331002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411331003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.475

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(411331002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 59
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play411331003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411331003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411331004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "4040ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["4040ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos4040ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.55, -5.5)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4040ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["4040ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect4040ui_story == nil then
				arg_13_1.var_.characterEffect4040ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect4040ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect4040ui_story then
				arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.125

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[905].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(411331003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 5
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_28 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_28 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_28

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_28 and arg_13_1.time_ < var_16_20 + var_16_28 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play411331004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411331004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411331005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["4040ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect4040ui_story == nil then
				arg_17_1.var_.characterEffect4040ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect4040ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_17_1.var_.characterEffect4040ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect4040ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_17_1.var_.characterEffect4040ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 1.075

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[904].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(411331004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 43
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play411331005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411331005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411331006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["4040ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos4040ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.55, -5.5)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos4040ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["4040ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect4040ui_story == nil then
				arg_21_1.var_.characterEffect4040ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect4040ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect4040ui_story then
				arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_15 = 0
			local var_24_16 = 0.15

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[905].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(411331005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 6
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_23 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_23 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_23

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_23 and arg_21_1.time_ < var_24_15 + var_24_23 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play411331006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411331006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411331007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["4040ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect4040ui_story == nil then
				arg_25_1.var_.characterEffect4040ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect4040ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_25_1.var_.characterEffect4040ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect4040ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_25_1.var_.characterEffect4040ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.4

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[904].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(411331006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 56
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411331007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411331007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411331008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["4040ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos4040ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -1.55, -5.5)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4040ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["4040ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect4040ui_story then
				arg_29_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_32_13 = 0
			local var_32_14 = 0.725

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_15 = arg_29_1:FormatText(StoryNameCfg[905].name)

				arg_29_1.leftNameTxt_.text = var_32_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_16 = arg_29_1:GetWordFromCfg(411331007)
				local var_32_17 = arg_29_1:FormatText(var_32_16.content)

				arg_29_1.text_.text = var_32_17

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 29
				local var_32_19 = utf8.len(var_32_17)
				local var_32_20 = var_32_18 <= 0 and var_32_14 or var_32_14 * (var_32_19 / var_32_18)

				if var_32_20 > 0 and var_32_14 < var_32_20 then
					arg_29_1.talkMaxDuration = var_32_20

					if var_32_20 + var_32_13 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_13
					end
				end

				arg_29_1.text_.text = var_32_17
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_14, arg_29_1.talkMaxDuration)

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_13) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_13 + var_32_21 and arg_29_1.time_ < var_32_13 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play411331008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411331008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411331009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["4040ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect4040ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4040ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect4040ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4040ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.525

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[904].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(411331008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 21
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play411331009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411331009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411331010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["4040ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1.55, -5.5)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["4040ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_40_13 = 0
			local var_40_14 = 0.75

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_15 = arg_37_1:FormatText(StoryNameCfg[905].name)

				arg_37_1.leftNameTxt_.text = var_40_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:GetWordFromCfg(411331009)
				local var_40_17 = arg_37_1:FormatText(var_40_16.content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_18 = 30
				local var_40_19 = utf8.len(var_40_17)
				local var_40_20 = var_40_18 <= 0 and var_40_14 or var_40_14 * (var_40_19 / var_40_18)

				if var_40_20 > 0 and var_40_14 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20

					if var_40_20 + var_40_13 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_13
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_14, arg_37_1.talkMaxDuration)

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_13) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_13 + var_40_21 and arg_37_1.time_ < var_40_13 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411331010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411331010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play411331011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["4040ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos4040ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4040ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["4040ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect4040ui_story == nil then
				arg_41_1.var_.characterEffect4040ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect4040ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4040ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect4040ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4040ui_story.fillRatio = var_44_14
			end

			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = false

				arg_41_1:SetGaussion(false)
			end

			local var_44_16 = 0.366666666666667

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16
				local var_44_18 = Color.New(0, 0, 0)

				var_44_18.a = Mathf.Lerp(1, 0, var_44_17)
				arg_41_1.mask_.color = var_44_18
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 then
				local var_44_19 = Color.New(0, 0, 0)
				local var_44_20 = 0

				arg_41_1.mask_.enabled = false
				var_44_19.a = var_44_20
				arg_41_1.mask_.color = var_44_19
			end

			local var_44_21 = 0
			local var_44_22 = 1.475

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_23 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_23:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_24 = arg_41_1:GetWordFromCfg(411331010)
				local var_44_25 = arg_41_1:FormatText(var_44_24.content)

				arg_41_1.text_.text = var_44_25

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_26 = 59
				local var_44_27 = utf8.len(var_44_25)
				local var_44_28 = var_44_26 <= 0 and var_44_22 or var_44_22 * (var_44_27 / var_44_26)

				if var_44_28 > 0 and var_44_22 < var_44_28 then
					arg_41_1.talkMaxDuration = var_44_28
					var_44_21 = var_44_21 + 0.3

					if var_44_28 + var_44_21 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_28 + var_44_21
					end
				end

				arg_41_1.text_.text = var_44_25
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_29 = var_44_21 + 0.3
			local var_44_30 = math.max(var_44_22, arg_41_1.talkMaxDuration)

			if var_44_29 <= arg_41_1.time_ and arg_41_1.time_ < var_44_29 + var_44_30 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_29) / var_44_30

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_29 + var_44_30 and arg_41_1.time_ < var_44_29 + var_44_30 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411331011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411331011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play411331012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.2

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[904].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(411331011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 8
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play411331012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411331012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play411331013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1.4

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(411331012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 56
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play411331013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411331013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play411331014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.15

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[904].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(411331013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 6
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play411331014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411331014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play411331015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.6

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(411331014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 24
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play411331015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411331015
		arg_63_1.duration_ = 3.2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play411331016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "STblack"

			if arg_63_1.bgs_[var_66_0] == nil then
				local var_66_1 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_0)
				var_66_1.name = var_66_0
				var_66_1.transform.parent = arg_63_1.stage_.transform
				var_66_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_0] = var_66_1
			end

			local var_66_2 = 2

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				local var_66_3 = manager.ui.mainCamera.transform.localPosition
				local var_66_4 = Vector3.New(0, 0, 10) + Vector3.New(var_66_3.x, var_66_3.y, 0)
				local var_66_5 = arg_63_1.bgs_.STblack

				var_66_5.transform.localPosition = var_66_4
				var_66_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_6 = var_66_5:GetComponent("SpriteRenderer")

				if var_66_6 and var_66_6.sprite then
					local var_66_7 = (var_66_5.transform.localPosition - var_66_3).z
					local var_66_8 = manager.ui.mainCameraCom_
					local var_66_9 = 2 * var_66_7 * Mathf.Tan(var_66_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_66_10 = var_66_9 * var_66_8.aspect
					local var_66_11 = var_66_6.sprite.bounds.size.x
					local var_66_12 = var_66_6.sprite.bounds.size.y
					local var_66_13 = var_66_10 / var_66_11
					local var_66_14 = var_66_9 / var_66_12
					local var_66_15 = var_66_14 < var_66_13 and var_66_13 or var_66_14

					var_66_5.transform.localScale = Vector3.New(var_66_15, var_66_15, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "STblack" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_17 = 2

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17
				local var_66_19 = Color.New(0, 0, 0)

				var_66_19.a = Mathf.Lerp(0, 1, var_66_18)
				arg_63_1.mask_.color = var_66_19
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				local var_66_20 = Color.New(0, 0, 0)

				var_66_20.a = 1
				arg_63_1.mask_.color = var_66_20
			end

			local var_66_21 = 2

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_22 = 1.03333333333333

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				local var_66_23 = (arg_63_1.time_ - var_66_21) / var_66_22
				local var_66_24 = Color.New(0, 0, 0)

				var_66_24.a = Mathf.Lerp(1, 0, var_66_23)
				arg_63_1.mask_.color = var_66_24
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				local var_66_25 = Color.New(0, 0, 0)
				local var_66_26 = 0

				arg_63_1.mask_.enabled = false
				var_66_25.a = var_66_26
				arg_63_1.mask_.color = var_66_25
			end

			local var_66_27 = 2

			if var_66_27 < arg_63_1.time_ and arg_63_1.time_ <= var_66_27 + arg_66_0 then
				arg_63_1.fswbg_:SetActive(true)
				arg_63_1.dialog_:SetActive(false)

				arg_63_1.fswtw_.percent = 0

				local var_66_28 = arg_63_1:GetWordFromCfg(411331015)
				local var_66_29 = arg_63_1:FormatText(var_66_28.content)

				arg_63_1.fswt_.text = var_66_29

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.fswt_)

				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_63_1.fswtw_:SetDirty()

				arg_63_1.typewritterCharCountI18N = 0

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_30 = 2.53333333333333

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_31 = 10
			local var_66_32 = 0.666666666666667
			local var_66_33 = arg_63_1:GetWordFromCfg(411331015)
			local var_66_34 = arg_63_1:FormatText(var_66_33.content)
			local var_66_35, var_66_36 = arg_63_1:GetPercentByPara(var_66_34, 1)

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				local var_66_37 = var_66_31 <= 0 and var_66_32 or var_66_32 * ((var_66_36 - arg_63_1.typewritterCharCountI18N) / var_66_31)

				if var_66_37 > 0 and var_66_32 < var_66_37 then
					arg_63_1.talkMaxDuration = var_66_37

					if var_66_37 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_37 + var_66_30
					end
				end
			end

			local var_66_38 = 0.666666666666667
			local var_66_39 = math.max(var_66_38, arg_63_1.talkMaxDuration)

			if var_66_30 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_39 then
				local var_66_40 = (arg_63_1.time_ - var_66_30) / var_66_39

				arg_63_1.fswtw_.percent = Mathf.Lerp(arg_63_1.var_.oldValueTypewriter, var_66_35, var_66_40)
				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_63_1.fswtw_:SetDirty()
			end

			if arg_63_1.time_ >= var_66_30 + var_66_39 and arg_63_1.time_ < var_66_30 + var_66_39 + arg_66_0 then
				arg_63_1.fswtw_.percent = var_66_35

				arg_63_1.fswtw_:SetDirty()
				arg_63_1:ShowNextGo(true)

				arg_63_1.typewritterCharCountI18N = var_66_36
			end

			local var_66_41 = 2

			if var_66_41 < arg_63_1.time_ and arg_63_1.time_ <= var_66_41 + arg_66_0 then
				local var_66_42 = arg_63_1.fswbg_.transform:Find("textbox/adapt/content") or arg_63_1.fswbg_.transform:Find("textbox/content")
				local var_66_43 = arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_66_44 = var_66_42:GetComponent("Text")
				local var_66_45 = var_66_42:GetComponent("RectTransform")

				var_66_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_66_45.offsetMin = Vector2.New(0, 0)
				var_66_45.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play411331016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411331016
		arg_67_1.duration_ = 2.53

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play411331017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.var_.oldValueTypewriter = arg_67_1.fswtw_.percent

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_1 = 38
			local var_70_2 = 2.53333333333333
			local var_70_3 = arg_67_1:GetWordFromCfg(411331015)
			local var_70_4 = arg_67_1:FormatText(var_70_3.content)
			local var_70_5, var_70_6 = arg_67_1:GetPercentByPara(var_70_4, 2)

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				local var_70_7 = var_70_1 <= 0 and var_70_2 or var_70_2 * ((var_70_6 - arg_67_1.typewritterCharCountI18N) / var_70_1)

				if var_70_7 > 0 and var_70_2 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end
			end

			local var_70_8 = 2.53333333333333
			local var_70_9 = math.max(var_70_8, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_9 then
				local var_70_10 = (arg_67_1.time_ - var_70_0) / var_70_9

				arg_67_1.fswtw_.percent = Mathf.Lerp(arg_67_1.var_.oldValueTypewriter, var_70_5, var_70_10)
				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_67_1.fswtw_:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_9 and arg_67_1.time_ < var_70_0 + var_70_9 + arg_70_0 then
				arg_67_1.fswtw_.percent = var_70_5

				arg_67_1.fswtw_:SetDirty()
				arg_67_1:ShowNextGo(true)

				arg_67_1.typewritterCharCountI18N = var_70_6
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play411331017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411331017
		arg_71_1.duration_ = 1.67

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play411331018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_1 = 25
			local var_74_2 = 1.66666666666667
			local var_74_3 = arg_71_1:GetWordFromCfg(411331015)
			local var_74_4 = arg_71_1:FormatText(var_74_3.content)
			local var_74_5, var_74_6 = arg_71_1:GetPercentByPara(var_74_4, 3)

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_7 = var_74_1 <= 0 and var_74_2 or var_74_2 * ((var_74_6 - arg_71_1.typewritterCharCountI18N) / var_74_1)

				if var_74_7 > 0 and var_74_2 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end
			end

			local var_74_8 = 1.66666666666667
			local var_74_9 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_9 then
				local var_74_10 = (arg_71_1.time_ - var_74_0) / var_74_9

				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_5, var_74_10)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_9 and arg_71_1.time_ < var_74_0 + var_74_9 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_5

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_6
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play411331018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411331018
		arg_75_1.duration_ = 1

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play411331019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_1 = 4
			local var_78_2 = 0.266666666666667
			local var_78_3 = arg_75_1:GetWordFromCfg(411331015)
			local var_78_4 = arg_75_1:FormatText(var_78_3.content)
			local var_78_5, var_78_6 = arg_75_1:GetPercentByPara(var_78_4, 4)

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_7 = var_78_1 <= 0 and var_78_2 or var_78_2 * ((var_78_6 - arg_75_1.typewritterCharCountI18N) / var_78_1)

				if var_78_7 > 0 and var_78_2 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end
			end

			local var_78_8 = 0.266666666666667
			local var_78_9 = math.max(var_78_8, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_9 then
				local var_78_10 = (arg_75_1.time_ - var_78_0) / var_78_9

				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_5, var_78_10)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_9 and arg_75_1.time_ < var_78_0 + var_78_9 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_5

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_6
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play411331019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411331019
		arg_79_1.duration_ = 7.9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411331020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = "I07"

			if arg_79_1.bgs_[var_82_0] == nil then
				local var_82_1 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_82_0)
				var_82_1.name = var_82_0
				var_82_1.transform.parent = arg_79_1.stage_.transform
				var_82_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_[var_82_0] = var_82_1
			end

			local var_82_2 = 1

			if var_82_2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				local var_82_3 = manager.ui.mainCamera.transform.localPosition
				local var_82_4 = Vector3.New(0, 0, 10) + Vector3.New(var_82_3.x, var_82_3.y, 0)
				local var_82_5 = arg_79_1.bgs_.I07

				var_82_5.transform.localPosition = var_82_4
				var_82_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_6 = var_82_5:GetComponent("SpriteRenderer")

				if var_82_6 and var_82_6.sprite then
					local var_82_7 = (var_82_5.transform.localPosition - var_82_3).z
					local var_82_8 = manager.ui.mainCameraCom_
					local var_82_9 = 2 * var_82_7 * Mathf.Tan(var_82_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_10 = var_82_9 * var_82_8.aspect
					local var_82_11 = var_82_6.sprite.bounds.size.x
					local var_82_12 = var_82_6.sprite.bounds.size.y
					local var_82_13 = var_82_10 / var_82_11
					local var_82_14 = var_82_9 / var_82_12
					local var_82_15 = var_82_14 < var_82_13 and var_82_13 or var_82_14

					var_82_5.transform.localScale = Vector3.New(var_82_15, var_82_15, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "I07" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_17 = 1

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 then
				local var_82_18 = (arg_79_1.time_ - var_82_16) / var_82_17
				local var_82_19 = Color.New(0, 0, 0)

				var_82_19.a = Mathf.Lerp(0, 1, var_82_18)
				arg_79_1.mask_.color = var_82_19
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
				local var_82_20 = Color.New(0, 0, 0)

				var_82_20.a = 1
				arg_79_1.mask_.color = var_82_20
			end

			local var_82_21 = 1

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_22 = 2

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_22 then
				local var_82_23 = (arg_79_1.time_ - var_82_21) / var_82_22
				local var_82_24 = Color.New(0, 0, 0)

				var_82_24.a = Mathf.Lerp(1, 0, var_82_23)
				arg_79_1.mask_.color = var_82_24
			end

			if arg_79_1.time_ >= var_82_21 + var_82_22 and arg_79_1.time_ < var_82_21 + var_82_22 + arg_82_0 then
				local var_82_25 = Color.New(0, 0, 0)
				local var_82_26 = 0

				arg_79_1.mask_.enabled = false
				var_82_25.a = var_82_26
				arg_79_1.mask_.color = var_82_25
			end

			local var_82_27 = arg_79_1.actors_["4040ui_story"].transform
			local var_82_28 = 2.7

			if var_82_28 < arg_79_1.time_ and arg_79_1.time_ <= var_82_28 + arg_82_0 then
				arg_79_1.var_.moveOldPos4040ui_story = var_82_27.localPosition
			end

			local var_82_29 = 0.001

			if var_82_28 <= arg_79_1.time_ and arg_79_1.time_ < var_82_28 + var_82_29 then
				local var_82_30 = (arg_79_1.time_ - var_82_28) / var_82_29
				local var_82_31 = Vector3.New(0, -1.55, -5.5)

				var_82_27.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos4040ui_story, var_82_31, var_82_30)

				local var_82_32 = manager.ui.mainCamera.transform.position - var_82_27.position

				var_82_27.forward = Vector3.New(var_82_32.x, var_82_32.y, var_82_32.z)

				local var_82_33 = var_82_27.localEulerAngles

				var_82_33.z = 0
				var_82_33.x = 0
				var_82_27.localEulerAngles = var_82_33
			end

			if arg_79_1.time_ >= var_82_28 + var_82_29 and arg_79_1.time_ < var_82_28 + var_82_29 + arg_82_0 then
				var_82_27.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_82_34 = manager.ui.mainCamera.transform.position - var_82_27.position

				var_82_27.forward = Vector3.New(var_82_34.x, var_82_34.y, var_82_34.z)

				local var_82_35 = var_82_27.localEulerAngles

				var_82_35.z = 0
				var_82_35.x = 0
				var_82_27.localEulerAngles = var_82_35
			end

			local var_82_36 = arg_79_1.actors_["4040ui_story"]
			local var_82_37 = 2.7

			if var_82_37 < arg_79_1.time_ and arg_79_1.time_ <= var_82_37 + arg_82_0 and not isNil(var_82_36) and arg_79_1.var_.characterEffect4040ui_story == nil then
				arg_79_1.var_.characterEffect4040ui_story = var_82_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_38 = 0.200000002980232

			if var_82_37 <= arg_79_1.time_ and arg_79_1.time_ < var_82_37 + var_82_38 and not isNil(var_82_36) then
				local var_82_39 = (arg_79_1.time_ - var_82_37) / var_82_38

				if arg_79_1.var_.characterEffect4040ui_story and not isNil(var_82_36) then
					arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_37 + var_82_38 and arg_79_1.time_ < var_82_37 + var_82_38 + arg_82_0 and not isNil(var_82_36) and arg_79_1.var_.characterEffect4040ui_story then
				arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_82_40 = 2.7

			if var_82_40 < arg_79_1.time_ and arg_79_1.time_ <= var_82_40 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_82_41 = 2.7

			if var_82_41 < arg_79_1.time_ and arg_79_1.time_ <= var_82_41 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_42 = 1

			if var_82_42 < arg_79_1.time_ and arg_79_1.time_ <= var_82_42 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(false)
				arg_79_1.dialog_:SetActive(false)
				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_43 = 1.13333333333333

			if var_82_43 < arg_79_1.time_ and arg_79_1.time_ <= var_82_43 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(false)
				arg_79_1.dialog_:SetActive(false)
				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_44 = 1

			if var_82_44 < arg_79_1.time_ and arg_79_1.time_ <= var_82_44 + arg_82_0 then
				local var_82_45 = arg_79_1.fswbg_.transform:Find("textbox/adapt/content") or arg_79_1.fswbg_.transform:Find("textbox/content")
				local var_82_46 = arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_82_47 = var_82_45:GetComponent("Text")
				local var_82_48 = var_82_45:GetComponent("RectTransform")

				var_82_47.alignment = UnityEngine.TextAnchor.UpperLeft
				var_82_48.offsetMin = Vector2.New(0, 0)
				var_82_48.offsetMax = Vector2.New(0, 0)
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_49 = 2.90000000298023
			local var_82_50 = 0.625

			if var_82_49 < arg_79_1.time_ and arg_79_1.time_ <= var_82_49 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_51 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_51:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_52 = arg_79_1:FormatText(StoryNameCfg[905].name)

				arg_79_1.leftNameTxt_.text = var_82_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_53 = arg_79_1:GetWordFromCfg(411331019)
				local var_82_54 = arg_79_1:FormatText(var_82_53.content)

				arg_79_1.text_.text = var_82_54

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_55 = 25
				local var_82_56 = utf8.len(var_82_54)
				local var_82_57 = var_82_55 <= 0 and var_82_50 or var_82_50 * (var_82_56 / var_82_55)

				if var_82_57 > 0 and var_82_50 < var_82_57 then
					arg_79_1.talkMaxDuration = var_82_57
					var_82_49 = var_82_49 + 0.3

					if var_82_57 + var_82_49 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_57 + var_82_49
					end
				end

				arg_79_1.text_.text = var_82_54
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_58 = var_82_49 + 0.3
			local var_82_59 = math.max(var_82_50, arg_79_1.talkMaxDuration)

			if var_82_58 <= arg_79_1.time_ and arg_79_1.time_ < var_82_58 + var_82_59 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_58) / var_82_59

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_58 + var_82_59 and arg_79_1.time_ < var_82_58 + var_82_59 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play411331020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 411331020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play411331021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["4040ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4040ui_story == nil then
				arg_85_1.var_.characterEffect4040ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect4040ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_85_1.var_.characterEffect4040ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4040ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_85_1.var_.characterEffect4040ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.625

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[904].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(411331020)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 25
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play411331021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 411331021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play411331022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["4040ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos4040ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -1.55, -5.5)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos4040ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["4040ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect4040ui_story == nil then
				arg_89_1.var_.characterEffect4040ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect4040ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect4040ui_story then
				arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_92_13 = 0
			local var_92_14 = 0.2

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_15 = arg_89_1:FormatText(StoryNameCfg[905].name)

				arg_89_1.leftNameTxt_.text = var_92_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_16 = arg_89_1:GetWordFromCfg(411331021)
				local var_92_17 = arg_89_1:FormatText(var_92_16.content)

				arg_89_1.text_.text = var_92_17

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_18 = 8
				local var_92_19 = utf8.len(var_92_17)
				local var_92_20 = var_92_18 <= 0 and var_92_14 or var_92_14 * (var_92_19 / var_92_18)

				if var_92_20 > 0 and var_92_14 < var_92_20 then
					arg_89_1.talkMaxDuration = var_92_20

					if var_92_20 + var_92_13 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_13
					end
				end

				arg_89_1.text_.text = var_92_17
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = math.max(var_92_14, arg_89_1.talkMaxDuration)

			if var_92_13 <= arg_89_1.time_ and arg_89_1.time_ < var_92_13 + var_92_21 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_13) / var_92_21

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_13 + var_92_21 and arg_89_1.time_ < var_92_13 + var_92_21 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play411331022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411331022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play411331023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["4040ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect4040ui_story == nil then
				arg_93_1.var_.characterEffect4040ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect4040ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_93_1.var_.characterEffect4040ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect4040ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_93_1.var_.characterEffect4040ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.55

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[904].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(411331022)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 22
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play411331023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411331023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play411331024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["4040ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos4040ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -1.55, -5.5)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos4040ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["4040ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect4040ui_story == nil then
				arg_97_1.var_.characterEffect4040ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect4040ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect4040ui_story then
				arg_97_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_15 = 0
			local var_100_16 = 1.125

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[905].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(411331023)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 45
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_23 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_23 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_23

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_23 and arg_97_1.time_ < var_100_15 + var_100_23 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play411331024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411331024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play411331025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["4040ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect4040ui_story == nil then
				arg_101_1.var_.characterEffect4040ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect4040ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_101_1.var_.characterEffect4040ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect4040ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_101_1.var_.characterEffect4040ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.725

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[904].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(411331024)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 29
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play411331025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411331025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411331026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["4040ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos4040ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, -1.55, -5.5)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos4040ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["4040ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect4040ui_story == nil then
				arg_105_1.var_.characterEffect4040ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect4040ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect4040ui_story then
				arg_105_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_15 = 0
			local var_108_16 = 0.15

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[905].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(411331025)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 6
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_23 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_23 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_23

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_23 and arg_105_1.time_ < var_108_15 + var_108_23 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play411331026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411331026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play411331027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["4040ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos4040ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos4040ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["4040ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect4040ui_story == nil then
				arg_109_1.var_.characterEffect4040ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect4040ui_story and not isNil(var_112_9) then
					local var_112_13 = Mathf.Lerp(0, 0.5, var_112_12)

					arg_109_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_109_1.var_.characterEffect4040ui_story.fillRatio = var_112_13
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect4040ui_story then
				local var_112_14 = 0.5

				arg_109_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_109_1.var_.characterEffect4040ui_story.fillRatio = var_112_14
			end

			local var_112_15 = 0
			local var_112_16 = 1.4

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_17 = arg_109_1:GetWordFromCfg(411331026)
				local var_112_18 = arg_109_1:FormatText(var_112_17.content)

				arg_109_1.text_.text = var_112_18

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_19 = 56
				local var_112_20 = utf8.len(var_112_18)
				local var_112_21 = var_112_19 <= 0 and var_112_16 or var_112_16 * (var_112_20 / var_112_19)

				if var_112_21 > 0 and var_112_16 < var_112_21 then
					arg_109_1.talkMaxDuration = var_112_21

					if var_112_21 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_21 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_18
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_22 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_22 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_22

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_22 and arg_109_1.time_ < var_112_15 + var_112_22 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play411331027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 411331027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play411331028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.4

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[904].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(411331027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 16
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play411331028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411331028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play411331029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1.05

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(411331028)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 42
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411331029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411331029
		arg_121_1.duration_ = 6

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411331030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = false

				arg_121_1:SetGaussion(false)
			end

			local var_124_1 = 0.1

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_1 then
				local var_124_2 = (arg_121_1.time_ - var_124_0) / var_124_1
				local var_124_3 = Color.New(1, 1, 1)

				var_124_3.a = Mathf.Lerp(1, 0, var_124_2)
				arg_121_1.mask_.color = var_124_3
			end

			if arg_121_1.time_ >= var_124_0 + var_124_1 and arg_121_1.time_ < var_124_0 + var_124_1 + arg_124_0 then
				local var_124_4 = Color.New(1, 1, 1)
				local var_124_5 = 0

				arg_121_1.mask_.enabled = false
				var_124_4.a = var_124_5
				arg_121_1.mask_.color = var_124_4
			end

			local var_124_6 = 0.233333333333333

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = false

				arg_121_1:SetGaussion(false)
			end

			local var_124_7 = 0.133333333333333

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_7 then
				local var_124_8 = (arg_121_1.time_ - var_124_6) / var_124_7
				local var_124_9 = Color.New(1, 1, 1)

				var_124_9.a = Mathf.Lerp(1, 0, var_124_8)
				arg_121_1.mask_.color = var_124_9
			end

			if arg_121_1.time_ >= var_124_6 + var_124_7 and arg_121_1.time_ < var_124_6 + var_124_7 + arg_124_0 then
				local var_124_10 = Color.New(1, 1, 1)
				local var_124_11 = 0

				arg_121_1.mask_.enabled = false
				var_124_10.a = var_124_11
				arg_121_1.mask_.color = var_124_10
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_12 = 1
			local var_124_13 = 0.7

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_14 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_14:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(411331029)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 28
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19
					var_124_12 = var_124_12 + 0.3

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = var_124_12 + 0.3
			local var_124_21 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_20 <= arg_121_1.time_ and arg_121_1.time_ < var_124_20 + var_124_21 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_20) / var_124_21

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_20 + var_124_21 and arg_121_1.time_ < var_124_20 + var_124_21 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play411331030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411331030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411331031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.25

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[906].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(411331030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 10
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411331031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411331031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411331032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.225

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(411331031)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 49
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play411331032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411331032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play411331033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.65

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(411331032)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 26
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play411331033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411331033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411331034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.325

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[904].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(411331033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 13
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play411331034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411331034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411331035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.825

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(411331034)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 33
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411331035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411331035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play411331036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.2

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[906].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(411331035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 8
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411331036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411331036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411331037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.35

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[906].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(411331036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 14
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play411331037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411331037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play411331038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.675

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(411331037)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 67
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play411331038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411331038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play411331039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.2

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[906].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(411331038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 8
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411331039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411331039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play411331040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["4040ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos4040ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -1.55, -5.5)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4040ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["4040ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect4040ui_story == nil then
				arg_163_1.var_.characterEffect4040ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect4040ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect4040ui_story then
				arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_166_15 = 0
			local var_166_16 = 0.2

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[905].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(411331039)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 8
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_23 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_23 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_23

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_23 and arg_163_1.time_ < var_166_15 + var_166_23 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play411331040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411331040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411331041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["4040ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect4040ui_story == nil then
				arg_167_1.var_.characterEffect4040ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect4040ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_167_1.var_.characterEffect4040ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect4040ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_167_1.var_.characterEffect4040ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 1.175

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[904].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(411331040)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 47
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play411331041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411331041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411331042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.95

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[904].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(411331041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 38
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play411331042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411331042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411331043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["4040ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos4040ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos4040ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["4040ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect4040ui_story == nil then
				arg_175_1.var_.characterEffect4040ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect4040ui_story and not isNil(var_178_9) then
					local var_178_13 = Mathf.Lerp(0, 0.5, var_178_12)

					arg_175_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_175_1.var_.characterEffect4040ui_story.fillRatio = var_178_13
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect4040ui_story then
				local var_178_14 = 0.5

				arg_175_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_175_1.var_.characterEffect4040ui_story.fillRatio = var_178_14
			end

			local var_178_15 = 0
			local var_178_16 = 0.9

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_17 = arg_175_1:GetWordFromCfg(411331042)
				local var_178_18 = arg_175_1:FormatText(var_178_17.content)

				arg_175_1.text_.text = var_178_18

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_19 = 36
				local var_178_20 = utf8.len(var_178_18)
				local var_178_21 = var_178_19 <= 0 and var_178_16 or var_178_16 * (var_178_20 / var_178_19)

				if var_178_21 > 0 and var_178_16 < var_178_21 then
					arg_175_1.talkMaxDuration = var_178_21

					if var_178_21 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_21 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_18
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_22 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_22 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_22

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_22 and arg_175_1.time_ < var_178_15 + var_178_22 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play411331043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411331043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411331044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.125

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_2 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_2:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(411331043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 45
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7
					var_182_0 = var_182_0 + 0.3

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = var_182_0 + 0.3
			local var_182_9 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_9 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_9

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_9 and arg_179_1.time_ < var_182_8 + var_182_9 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411331044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 411331044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play411331045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.4

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[904].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(411331044)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 16
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play411331045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 411331045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play411331046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.875

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(411331045)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 35
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play411331046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 411331046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play411331047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["4040ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos4040ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -1.55, -5.5)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos4040ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["4040ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect4040ui_story == nil then
				arg_193_1.var_.characterEffect4040ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect4040ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect4040ui_story then
				arg_193_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_196_15 = 0
			local var_196_16 = 0.575

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[905].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(411331046)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 23
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_23 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_23 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_23

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_23 and arg_193_1.time_ < var_196_15 + var_196_23 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play411331047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 411331047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play411331048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["4040ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect4040ui_story == nil then
				arg_197_1.var_.characterEffect4040ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect4040ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_197_1.var_.characterEffect4040ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect4040ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_197_1.var_.characterEffect4040ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.85

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[904].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_9 = arg_197_1:GetWordFromCfg(411331047)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 34
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play411331048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 411331048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play411331049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["4040ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos4040ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, -1.55, -5.5)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos4040ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["4040ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect4040ui_story == nil then
				arg_201_1.var_.characterEffect4040ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect4040ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect4040ui_story then
				arg_201_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			local var_204_14 = 0
			local var_204_15 = 0.225

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_16 = arg_201_1:FormatText(StoryNameCfg[905].name)

				arg_201_1.leftNameTxt_.text = var_204_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_17 = arg_201_1:GetWordFromCfg(411331048)
				local var_204_18 = arg_201_1:FormatText(var_204_17.content)

				arg_201_1.text_.text = var_204_18

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_19 = 9
				local var_204_20 = utf8.len(var_204_18)
				local var_204_21 = var_204_19 <= 0 and var_204_15 or var_204_15 * (var_204_20 / var_204_19)

				if var_204_21 > 0 and var_204_15 < var_204_21 then
					arg_201_1.talkMaxDuration = var_204_21

					if var_204_21 + var_204_14 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_21 + var_204_14
					end
				end

				arg_201_1.text_.text = var_204_18
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_22 = math.max(var_204_15, arg_201_1.talkMaxDuration)

			if var_204_14 <= arg_201_1.time_ and arg_201_1.time_ < var_204_14 + var_204_22 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_14) / var_204_22

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_14 + var_204_22 and arg_201_1.time_ < var_204_14 + var_204_22 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play411331049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 411331049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play411331050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.825

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[905].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(411331049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 33
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play411331050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 411331050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play411331051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["4040ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos4040ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, -1.55, -5.5)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos4040ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["4040ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect4040ui_story == nil then
				arg_209_1.var_.characterEffect4040ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect4040ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect4040ui_story then
				arg_209_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_212_14 = 0
			local var_212_15 = 0.825

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_16 = arg_209_1:FormatText(StoryNameCfg[905].name)

				arg_209_1.leftNameTxt_.text = var_212_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_17 = arg_209_1:GetWordFromCfg(411331050)
				local var_212_18 = arg_209_1:FormatText(var_212_17.content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_19 = 33
				local var_212_20 = utf8.len(var_212_18)
				local var_212_21 = var_212_19 <= 0 and var_212_15 or var_212_15 * (var_212_20 / var_212_19)

				if var_212_21 > 0 and var_212_15 < var_212_21 then
					arg_209_1.talkMaxDuration = var_212_21

					if var_212_21 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_21 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_22 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_22 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_14) / var_212_22

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_14 + var_212_22 and arg_209_1.time_ < var_212_14 + var_212_22 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play411331051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 411331051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play411331052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["4040ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos4040ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, 100, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos4040ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, 100, 0)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["4040ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect4040ui_story == nil then
				arg_213_1.var_.characterEffect4040ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect4040ui_story and not isNil(var_216_9) then
					local var_216_13 = Mathf.Lerp(0, 0.5, var_216_12)

					arg_213_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_213_1.var_.characterEffect4040ui_story.fillRatio = var_216_13
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect4040ui_story then
				local var_216_14 = 0.5

				arg_213_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_213_1.var_.characterEffect4040ui_story.fillRatio = var_216_14
			end

			local var_216_15 = 0
			local var_216_16 = 1.175

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_17 = arg_213_1:GetWordFromCfg(411331051)
				local var_216_18 = arg_213_1:FormatText(var_216_17.content)

				arg_213_1.text_.text = var_216_18

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_19 = 47
				local var_216_20 = utf8.len(var_216_18)
				local var_216_21 = var_216_19 <= 0 and var_216_16 or var_216_16 * (var_216_20 / var_216_19)

				if var_216_21 > 0 and var_216_16 < var_216_21 then
					arg_213_1.talkMaxDuration = var_216_21

					if var_216_21 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_21 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_18
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_22 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_22

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_22 and arg_213_1.time_ < var_216_15 + var_216_22 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play411331052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 411331052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play411331053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.525

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[904].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(411331052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 21
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play411331053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 411331053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play411331054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.1

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[904].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(411331053)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 4
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play411331054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 411331054
		arg_225_1.duration_ = 3.33

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play411331055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 2

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_1 = manager.ui.mainCamera.transform.localPosition
				local var_228_2 = Vector3.New(0, 0, 10) + Vector3.New(var_228_1.x, var_228_1.y, 0)
				local var_228_3 = arg_225_1.bgs_.STblack

				var_228_3.transform.localPosition = var_228_2
				var_228_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_4 = var_228_3:GetComponent("SpriteRenderer")

				if var_228_4 and var_228_4.sprite then
					local var_228_5 = (var_228_3.transform.localPosition - var_228_1).z
					local var_228_6 = manager.ui.mainCameraCom_
					local var_228_7 = 2 * var_228_5 * Mathf.Tan(var_228_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_228_8 = var_228_7 * var_228_6.aspect
					local var_228_9 = var_228_4.sprite.bounds.size.x
					local var_228_10 = var_228_4.sprite.bounds.size.y
					local var_228_11 = var_228_8 / var_228_9
					local var_228_12 = var_228_7 / var_228_10
					local var_228_13 = var_228_12 < var_228_11 and var_228_11 or var_228_12

					var_228_3.transform.localScale = Vector3.New(var_228_13, var_228_13, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "STblack" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_15 = 2

			if var_228_14 <= arg_225_1.time_ and arg_225_1.time_ < var_228_14 + var_228_15 then
				local var_228_16 = (arg_225_1.time_ - var_228_14) / var_228_15
				local var_228_17 = Color.New(0, 0, 0)

				var_228_17.a = Mathf.Lerp(0, 1, var_228_16)
				arg_225_1.mask_.color = var_228_17
			end

			if arg_225_1.time_ >= var_228_14 + var_228_15 and arg_225_1.time_ < var_228_14 + var_228_15 + arg_228_0 then
				local var_228_18 = Color.New(0, 0, 0)

				var_228_18.a = 1
				arg_225_1.mask_.color = var_228_18
			end

			local var_228_19 = 2

			if var_228_19 < arg_225_1.time_ and arg_225_1.time_ <= var_228_19 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_20 = 1.03333333333333

			if var_228_19 <= arg_225_1.time_ and arg_225_1.time_ < var_228_19 + var_228_20 then
				local var_228_21 = (arg_225_1.time_ - var_228_19) / var_228_20
				local var_228_22 = Color.New(0, 0, 0)

				var_228_22.a = Mathf.Lerp(1, 0, var_228_21)
				arg_225_1.mask_.color = var_228_22
			end

			if arg_225_1.time_ >= var_228_19 + var_228_20 and arg_225_1.time_ < var_228_19 + var_228_20 + arg_228_0 then
				local var_228_23 = Color.New(0, 0, 0)
				local var_228_24 = 0

				arg_225_1.mask_.enabled = false
				var_228_23.a = var_228_24
				arg_225_1.mask_.color = var_228_23
			end

			local var_228_25 = 2

			if var_228_25 < arg_225_1.time_ and arg_225_1.time_ <= var_228_25 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(true)
				arg_225_1.dialog_:SetActive(false)

				arg_225_1.fswtw_.percent = 0

				local var_228_26 = arg_225_1:GetWordFromCfg(411331054)
				local var_228_27 = arg_225_1:FormatText(var_228_26.content)

				arg_225_1.fswt_.text = var_228_27

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.fswt_)

				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_225_1.fswtw_:SetDirty()

				arg_225_1.typewritterCharCountI18N = 0

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_28 = 2.53333333333333

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_29 = 12
			local var_228_30 = 0.8
			local var_228_31 = arg_225_1:GetWordFromCfg(411331054)
			local var_228_32 = arg_225_1:FormatText(var_228_31.content)
			local var_228_33, var_228_34 = arg_225_1:GetPercentByPara(var_228_32, 1)

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_35 = var_228_29 <= 0 and var_228_30 or var_228_30 * ((var_228_34 - arg_225_1.typewritterCharCountI18N) / var_228_29)

				if var_228_35 > 0 and var_228_30 < var_228_35 then
					arg_225_1.talkMaxDuration = var_228_35

					if var_228_35 + var_228_28 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_35 + var_228_28
					end
				end
			end

			local var_228_36 = 0.8
			local var_228_37 = math.max(var_228_36, arg_225_1.talkMaxDuration)

			if var_228_28 <= arg_225_1.time_ and arg_225_1.time_ < var_228_28 + var_228_37 then
				local var_228_38 = (arg_225_1.time_ - var_228_28) / var_228_37

				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_33, var_228_38)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= var_228_28 + var_228_37 and arg_225_1.time_ < var_228_28 + var_228_37 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_33

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_34
			end

			local var_228_39 = 2

			if var_228_39 < arg_225_1.time_ and arg_225_1.time_ <= var_228_39 + arg_228_0 then
				local var_228_40 = arg_225_1.fswbg_.transform:Find("textbox/adapt/content") or arg_225_1.fswbg_.transform:Find("textbox/content")
				local var_228_41 = arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_228_42 = var_228_40:GetComponent("Text")
				local var_228_43 = var_228_40:GetComponent("RectTransform")

				var_228_42.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_228_43.offsetMin = Vector2.New(0, 0)
				var_228_43.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play411331055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 411331055
		arg_229_1.duration_ = 2.53

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play411331056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.var_.oldValueTypewriter = arg_229_1.fswtw_.percent

				SetActive(arg_229_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_229_1:ShowNextGo(false)
			end

			local var_232_1 = 38
			local var_232_2 = 2.53333333333333
			local var_232_3 = arg_229_1:GetWordFromCfg(411331054)
			local var_232_4 = arg_229_1:FormatText(var_232_3.content)
			local var_232_5, var_232_6 = arg_229_1:GetPercentByPara(var_232_4, 2)

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				local var_232_7 = var_232_1 <= 0 and var_232_2 or var_232_2 * ((var_232_6 - arg_229_1.typewritterCharCountI18N) / var_232_1)

				if var_232_7 > 0 and var_232_2 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end
			end

			local var_232_8 = 2.53333333333333
			local var_232_9 = math.max(var_232_8, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_9 then
				local var_232_10 = (arg_229_1.time_ - var_232_0) / var_232_9

				arg_229_1.fswtw_.percent = Mathf.Lerp(arg_229_1.var_.oldValueTypewriter, var_232_5, var_232_10)
				arg_229_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_229_1.fswtw_:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_9 and arg_229_1.time_ < var_232_0 + var_232_9 + arg_232_0 then
				arg_229_1.fswtw_.percent = var_232_5

				arg_229_1.fswtw_:SetDirty()
				arg_229_1:ShowNextGo(true)

				arg_229_1.typewritterCharCountI18N = var_232_6
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play411331056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 411331056
		arg_233_1.duration_ = 7.43

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play411331057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				local var_236_1 = manager.ui.mainCamera.transform.localPosition
				local var_236_2 = Vector3.New(0, 0, 10) + Vector3.New(var_236_1.x, var_236_1.y, 0)
				local var_236_3 = arg_233_1.bgs_.STblack

				var_236_3.transform.localPosition = var_236_2
				var_236_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_4 = var_236_3:GetComponent("SpriteRenderer")

				if var_236_4 and var_236_4.sprite then
					local var_236_5 = (var_236_3.transform.localPosition - var_236_1).z
					local var_236_6 = manager.ui.mainCameraCom_
					local var_236_7 = 2 * var_236_5 * Mathf.Tan(var_236_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_8 = var_236_7 * var_236_6.aspect
					local var_236_9 = var_236_4.sprite.bounds.size.x
					local var_236_10 = var_236_4.sprite.bounds.size.y
					local var_236_11 = var_236_8 / var_236_9
					local var_236_12 = var_236_7 / var_236_10
					local var_236_13 = var_236_12 < var_236_11 and var_236_11 or var_236_12

					var_236_3.transform.localScale = Vector3.New(var_236_13, var_236_13, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "STblack" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_15 = 1

			if var_236_14 <= arg_233_1.time_ and arg_233_1.time_ < var_236_14 + var_236_15 then
				local var_236_16 = (arg_233_1.time_ - var_236_14) / var_236_15
				local var_236_17 = Color.New(0, 0, 0)

				var_236_17.a = Mathf.Lerp(0, 1, var_236_16)
				arg_233_1.mask_.color = var_236_17
			end

			if arg_233_1.time_ >= var_236_14 + var_236_15 and arg_233_1.time_ < var_236_14 + var_236_15 + arg_236_0 then
				local var_236_18 = Color.New(0, 0, 0)

				var_236_18.a = 1
				arg_233_1.mask_.color = var_236_18
			end

			local var_236_19 = 1

			if var_236_19 < arg_233_1.time_ and arg_233_1.time_ <= var_236_19 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_20 = 2

			if var_236_19 <= arg_233_1.time_ and arg_233_1.time_ < var_236_19 + var_236_20 then
				local var_236_21 = (arg_233_1.time_ - var_236_19) / var_236_20
				local var_236_22 = Color.New(0, 0, 0)

				var_236_22.a = Mathf.Lerp(1, 0, var_236_21)
				arg_233_1.mask_.color = var_236_22
			end

			if arg_233_1.time_ >= var_236_19 + var_236_20 and arg_233_1.time_ < var_236_19 + var_236_20 + arg_236_0 then
				local var_236_23 = Color.New(0, 0, 0)
				local var_236_24 = 0

				arg_233_1.mask_.enabled = false
				var_236_23.a = var_236_24
				arg_233_1.mask_.color = var_236_23
			end

			local var_236_25 = 1

			if var_236_25 < arg_233_1.time_ and arg_233_1.time_ <= var_236_25 + arg_236_0 then
				arg_233_1.fswbg_:SetActive(false)
				arg_233_1.dialog_:SetActive(false)
				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_26 = 1.1

			if var_236_26 < arg_233_1.time_ and arg_233_1.time_ <= var_236_26 + arg_236_0 then
				arg_233_1.fswbg_:SetActive(false)
				arg_233_1.dialog_:SetActive(false)
				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_233_1:ShowNextGo(false)
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_27 = 2.43333333333333
			local var_236_28 = 0.475

			if var_236_27 < arg_233_1.time_ and arg_233_1.time_ <= var_236_27 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_29 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_29:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_30 = arg_233_1:GetWordFromCfg(411331056)
				local var_236_31 = arg_233_1:FormatText(var_236_30.content)

				arg_233_1.text_.text = var_236_31

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_32 = 19
				local var_236_33 = utf8.len(var_236_31)
				local var_236_34 = var_236_32 <= 0 and var_236_28 or var_236_28 * (var_236_33 / var_236_32)

				if var_236_34 > 0 and var_236_28 < var_236_34 then
					arg_233_1.talkMaxDuration = var_236_34
					var_236_27 = var_236_27 + 0.3

					if var_236_34 + var_236_27 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_34 + var_236_27
					end
				end

				arg_233_1.text_.text = var_236_31
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_35 = var_236_27 + 0.3
			local var_236_36 = math.max(var_236_28, arg_233_1.talkMaxDuration)

			if var_236_35 <= arg_233_1.time_ and arg_233_1.time_ < var_236_35 + var_236_36 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_35) / var_236_36

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_35 + var_236_36 and arg_233_1.time_ < var_236_35 + var_236_36 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play411331057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411331057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play411331058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.025

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(411331057)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 41
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play411331058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411331058
		arg_243_1.duration_ = 6.83

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play411331059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_1 = manager.ui.mainCamera.transform.localPosition
				local var_246_2 = Vector3.New(0, 0, 10) + Vector3.New(var_246_1.x, var_246_1.y, 0)
				local var_246_3 = arg_243_1.bgs_.I07a

				var_246_3.transform.localPosition = var_246_2
				var_246_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_4 = var_246_3:GetComponent("SpriteRenderer")

				if var_246_4 and var_246_4.sprite then
					local var_246_5 = (var_246_3.transform.localPosition - var_246_1).z
					local var_246_6 = manager.ui.mainCameraCom_
					local var_246_7 = 2 * var_246_5 * Mathf.Tan(var_246_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_8 = var_246_7 * var_246_6.aspect
					local var_246_9 = var_246_4.sprite.bounds.size.x
					local var_246_10 = var_246_4.sprite.bounds.size.y
					local var_246_11 = var_246_8 / var_246_9
					local var_246_12 = var_246_7 / var_246_10
					local var_246_13 = var_246_12 < var_246_11 and var_246_11 or var_246_12

					var_246_3.transform.localScale = Vector3.New(var_246_13, var_246_13, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "I07a" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_15 = 2

			if var_246_14 <= arg_243_1.time_ and arg_243_1.time_ < var_246_14 + var_246_15 then
				local var_246_16 = (arg_243_1.time_ - var_246_14) / var_246_15
				local var_246_17 = Color.New(0, 0, 0)

				var_246_17.a = Mathf.Lerp(1, 0, var_246_16)
				arg_243_1.mask_.color = var_246_17
			end

			if arg_243_1.time_ >= var_246_14 + var_246_15 and arg_243_1.time_ < var_246_14 + var_246_15 + arg_246_0 then
				local var_246_18 = Color.New(0, 0, 0)
				local var_246_19 = 0

				arg_243_1.mask_.enabled = false
				var_246_18.a = var_246_19
				arg_243_1.mask_.color = var_246_18
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_20 = 1.83333333333333
			local var_246_21 = 0.675

			if var_246_20 < arg_243_1.time_ and arg_243_1.time_ <= var_246_20 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_22 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_22:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_23 = arg_243_1:GetWordFromCfg(411331058)
				local var_246_24 = arg_243_1:FormatText(var_246_23.content)

				arg_243_1.text_.text = var_246_24

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_25 = 27
				local var_246_26 = utf8.len(var_246_24)
				local var_246_27 = var_246_25 <= 0 and var_246_21 or var_246_21 * (var_246_26 / var_246_25)

				if var_246_27 > 0 and var_246_21 < var_246_27 then
					arg_243_1.talkMaxDuration = var_246_27
					var_246_20 = var_246_20 + 0.3

					if var_246_27 + var_246_20 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_27 + var_246_20
					end
				end

				arg_243_1.text_.text = var_246_24
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_28 = var_246_20 + 0.3
			local var_246_29 = math.max(var_246_21, arg_243_1.talkMaxDuration)

			if var_246_28 <= arg_243_1.time_ and arg_243_1.time_ < var_246_28 + var_246_29 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_28) / var_246_29

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_28 + var_246_29 and arg_243_1.time_ < var_246_28 + var_246_29 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play411331059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 411331059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play411331060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["4040ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos4040ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, -1.55, -5.5)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos4040ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["4040ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect4040ui_story == nil then
				arg_249_1.var_.characterEffect4040ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect4040ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect4040ui_story then
				arg_249_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_252_13 = 0

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_15 = 0
			local var_252_16 = 0.525

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[905].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(411331059)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 21
				local var_252_21 = utf8.len(var_252_19)
				local var_252_22 = var_252_20 <= 0 and var_252_16 or var_252_16 * (var_252_21 / var_252_20)

				if var_252_22 > 0 and var_252_16 < var_252_22 then
					arg_249_1.talkMaxDuration = var_252_22

					if var_252_22 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_22 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_19
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_23 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_23 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_23

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_23 and arg_249_1.time_ < var_252_15 + var_252_23 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play411331060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 411331060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play411331061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["4040ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect4040ui_story == nil then
				arg_253_1.var_.characterEffect4040ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect4040ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_253_1.var_.characterEffect4040ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect4040ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_253_1.var_.characterEffect4040ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.225

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[907].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(411331060)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 9
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play411331061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 411331061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play411331062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["4040ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos4040ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, 100, 0)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos4040ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, 100, 0)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["4040ui_story"]
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect4040ui_story == nil then
				arg_257_1.var_.characterEffect4040ui_story = var_260_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_11 = 0.200000002980232

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 and not isNil(var_260_9) then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11

				if arg_257_1.var_.characterEffect4040ui_story and not isNil(var_260_9) then
					local var_260_13 = Mathf.Lerp(0, 0.5, var_260_12)

					arg_257_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_257_1.var_.characterEffect4040ui_story.fillRatio = var_260_13
				end
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect4040ui_story then
				local var_260_14 = 0.5

				arg_257_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_257_1.var_.characterEffect4040ui_story.fillRatio = var_260_14
			end

			local var_260_15 = 0
			local var_260_16 = 1.175

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_17 = arg_257_1:GetWordFromCfg(411331061)
				local var_260_18 = arg_257_1:FormatText(var_260_17.content)

				arg_257_1.text_.text = var_260_18

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_19 = 35
				local var_260_20 = utf8.len(var_260_18)
				local var_260_21 = var_260_19 <= 0 and var_260_16 or var_260_16 * (var_260_20 / var_260_19)

				if var_260_21 > 0 and var_260_16 < var_260_21 then
					arg_257_1.talkMaxDuration = var_260_21

					if var_260_21 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_21 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_18
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_22 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_22 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_22

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_22 and arg_257_1.time_ < var_260_15 + var_260_22 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play411331062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 411331062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play411331063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.325

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_2 = arg_261_1:GetWordFromCfg(411331062)
				local var_264_3 = arg_261_1:FormatText(var_264_2.content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 25
				local var_264_5 = utf8.len(var_264_3)
				local var_264_6 = var_264_4 <= 0 and var_264_1 or var_264_1 * (var_264_5 / var_264_4)

				if var_264_6 > 0 and var_264_1 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_7 and arg_261_1.time_ < var_264_0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play411331063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 411331063
		arg_265_1.duration_ = 9

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play411331064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 2

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				local var_268_1 = manager.ui.mainCamera.transform.localPosition
				local var_268_2 = Vector3.New(0, 0, 10) + Vector3.New(var_268_1.x, var_268_1.y, 0)
				local var_268_3 = arg_265_1.bgs_.I07

				var_268_3.transform.localPosition = var_268_2
				var_268_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_4 = var_268_3:GetComponent("SpriteRenderer")

				if var_268_4 and var_268_4.sprite then
					local var_268_5 = (var_268_3.transform.localPosition - var_268_1).z
					local var_268_6 = manager.ui.mainCameraCom_
					local var_268_7 = 2 * var_268_5 * Mathf.Tan(var_268_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_268_8 = var_268_7 * var_268_6.aspect
					local var_268_9 = var_268_4.sprite.bounds.size.x
					local var_268_10 = var_268_4.sprite.bounds.size.y
					local var_268_11 = var_268_8 / var_268_9
					local var_268_12 = var_268_7 / var_268_10
					local var_268_13 = var_268_12 < var_268_11 and var_268_11 or var_268_12

					var_268_3.transform.localScale = Vector3.New(var_268_13, var_268_13, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "I07" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_15 = 2

			if var_268_14 <= arg_265_1.time_ and arg_265_1.time_ < var_268_14 + var_268_15 then
				local var_268_16 = (arg_265_1.time_ - var_268_14) / var_268_15
				local var_268_17 = Color.New(0, 0, 0)

				var_268_17.a = Mathf.Lerp(0, 1, var_268_16)
				arg_265_1.mask_.color = var_268_17
			end

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 then
				local var_268_18 = Color.New(0, 0, 0)

				var_268_18.a = 1
				arg_265_1.mask_.color = var_268_18
			end

			local var_268_19 = 2

			if var_268_19 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_20 = 2

			if var_268_19 <= arg_265_1.time_ and arg_265_1.time_ < var_268_19 + var_268_20 then
				local var_268_21 = (arg_265_1.time_ - var_268_19) / var_268_20
				local var_268_22 = Color.New(0, 0, 0)

				var_268_22.a = Mathf.Lerp(1, 0, var_268_21)
				arg_265_1.mask_.color = var_268_22
			end

			if arg_265_1.time_ >= var_268_19 + var_268_20 and arg_265_1.time_ < var_268_19 + var_268_20 + arg_268_0 then
				local var_268_23 = Color.New(0, 0, 0)
				local var_268_24 = 0

				arg_265_1.mask_.enabled = false
				var_268_23.a = var_268_24
				arg_265_1.mask_.color = var_268_23
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_25 = 4
			local var_268_26 = 0.725

			if var_268_25 < arg_265_1.time_ and arg_265_1.time_ <= var_268_25 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_27 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_27:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_28 = arg_265_1:GetWordFromCfg(411331063)
				local var_268_29 = arg_265_1:FormatText(var_268_28.content)

				arg_265_1.text_.text = var_268_29

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_30 = 29
				local var_268_31 = utf8.len(var_268_29)
				local var_268_32 = var_268_30 <= 0 and var_268_26 or var_268_26 * (var_268_31 / var_268_30)

				if var_268_32 > 0 and var_268_26 < var_268_32 then
					arg_265_1.talkMaxDuration = var_268_32
					var_268_25 = var_268_25 + 0.3

					if var_268_32 + var_268_25 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_32 + var_268_25
					end
				end

				arg_265_1.text_.text = var_268_29
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = var_268_25 + 0.3
			local var_268_34 = math.max(var_268_26, arg_265_1.talkMaxDuration)

			if var_268_33 <= arg_265_1.time_ and arg_265_1.time_ < var_268_33 + var_268_34 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_33) / var_268_34

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_33 + var_268_34 and arg_265_1.time_ < var_268_33 + var_268_34 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play411331064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411331064
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play411331065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 1.375

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(411331064)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 55
				local var_274_5 = utf8.len(var_274_3)
				local var_274_6 = var_274_4 <= 0 and var_274_1 or var_274_1 * (var_274_5 / var_274_4)

				if var_274_6 > 0 and var_274_1 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_7 and arg_271_1.time_ < var_274_0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411331065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411331065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play411331066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.3

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_2 = arg_275_1:GetWordFromCfg(411331065)
				local var_278_3 = arg_275_1:FormatText(var_278_2.content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 12
				local var_278_5 = utf8.len(var_278_3)
				local var_278_6 = var_278_4 <= 0 and var_278_1 or var_278_1 * (var_278_5 / var_278_4)

				if var_278_6 > 0 and var_278_1 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_7 and arg_275_1.time_ < var_278_0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play411331066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411331066
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play411331067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["4040ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos4040ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, -1.55, -5.5)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos4040ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["4040ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect4040ui_story == nil then
				arg_279_1.var_.characterEffect4040ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect4040ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect4040ui_story then
				arg_279_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_282_15 = 0
			local var_282_16 = 0.075

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[905].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(411331066)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 3
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_23 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_23 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_23

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_23 and arg_279_1.time_ < var_282_15 + var_282_23 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play411331067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 411331067
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play411331068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["4040ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect4040ui_story == nil then
				arg_283_1.var_.characterEffect4040ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect4040ui_story and not isNil(var_286_0) then
					local var_286_4 = Mathf.Lerp(0, 0.5, var_286_3)

					arg_283_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_283_1.var_.characterEffect4040ui_story.fillRatio = var_286_4
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect4040ui_story then
				local var_286_5 = 0.5

				arg_283_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_283_1.var_.characterEffect4040ui_story.fillRatio = var_286_5
			end

			local var_286_6 = 0
			local var_286_7 = 0.85

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(411331067)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 34
				local var_286_11 = utf8.len(var_286_9)
				local var_286_12 = var_286_10 <= 0 and var_286_7 or var_286_7 * (var_286_11 / var_286_10)

				if var_286_12 > 0 and var_286_7 < var_286_12 then
					arg_283_1.talkMaxDuration = var_286_12

					if var_286_12 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_13 and arg_283_1.time_ < var_286_6 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play411331068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 411331068
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play411331069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["4040ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos4040ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, -1.55, -5.5)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos4040ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["4040ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect4040ui_story == nil then
				arg_287_1.var_.characterEffect4040ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect4040ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect4040ui_story then
				arg_287_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_290_13 = 0
			local var_290_14 = 0.375

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_15 = arg_287_1:FormatText(StoryNameCfg[905].name)

				arg_287_1.leftNameTxt_.text = var_290_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_16 = arg_287_1:GetWordFromCfg(411331068)
				local var_290_17 = arg_287_1:FormatText(var_290_16.content)

				arg_287_1.text_.text = var_290_17

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_18 = 15
				local var_290_19 = utf8.len(var_290_17)
				local var_290_20 = var_290_18 <= 0 and var_290_14 or var_290_14 * (var_290_19 / var_290_18)

				if var_290_20 > 0 and var_290_14 < var_290_20 then
					arg_287_1.talkMaxDuration = var_290_20

					if var_290_20 + var_290_13 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_20 + var_290_13
					end
				end

				arg_287_1.text_.text = var_290_17
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_21 = math.max(var_290_14, arg_287_1.talkMaxDuration)

			if var_290_13 <= arg_287_1.time_ and arg_287_1.time_ < var_290_13 + var_290_21 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_13) / var_290_21

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_13 + var_290_21 and arg_287_1.time_ < var_290_13 + var_290_21 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play411331069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 411331069
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play411331070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["4040ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect4040ui_story == nil then
				arg_291_1.var_.characterEffect4040ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect4040ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_291_1.var_.characterEffect4040ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect4040ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_291_1.var_.characterEffect4040ui_story.fillRatio = var_294_5
			end

			local var_294_6 = 0
			local var_294_7 = 0.3

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_8 = arg_291_1:FormatText(StoryNameCfg[904].name)

				arg_291_1.leftNameTxt_.text = var_294_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_9 = arg_291_1:GetWordFromCfg(411331069)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 12
				local var_294_12 = utf8.len(var_294_10)
				local var_294_13 = var_294_11 <= 0 and var_294_7 or var_294_7 * (var_294_12 / var_294_11)

				if var_294_13 > 0 and var_294_7 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play411331070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 411331070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play411331071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 1.2

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[904].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(411331070)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 48
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play411331071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 411331071
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play411331072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 1.275

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_2 = arg_299_1:GetWordFromCfg(411331071)
				local var_302_3 = arg_299_1:FormatText(var_302_2.content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 51
				local var_302_5 = utf8.len(var_302_3)
				local var_302_6 = var_302_4 <= 0 and var_302_1 or var_302_1 * (var_302_5 / var_302_4)

				if var_302_6 > 0 and var_302_1 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_7 and arg_299_1.time_ < var_302_0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play411331072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 411331072
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play411331073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["4040ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos4040ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(0, 100, 0)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos4040ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, 100, 0)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = manager.ui.mainCamera.transform
			local var_306_10 = 0.3

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1.var_.shakeOldPos = var_306_9.localPosition
			end

			local var_306_11 = 0.466666666666667

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / 0.066
				local var_306_13, var_306_14 = math.modf(var_306_12)

				var_306_9.localPosition = Vector3.New(var_306_14 * 0.13, var_306_14 * 0.13, var_306_14 * 0.13) + arg_303_1.var_.shakeOldPos
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 then
				var_306_9.localPosition = arg_303_1.var_.shakeOldPos
			end

			local var_306_15 = 0

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = false

				arg_303_1:SetGaussion(false)
			end

			local var_306_16 = 0.3

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_16 then
				local var_306_17 = (arg_303_1.time_ - var_306_15) / var_306_16
				local var_306_18 = Color.New(1, 1, 1)

				var_306_18.a = Mathf.Lerp(1, 0, var_306_17)
				arg_303_1.mask_.color = var_306_18
			end

			if arg_303_1.time_ >= var_306_15 + var_306_16 and arg_303_1.time_ < var_306_15 + var_306_16 + arg_306_0 then
				local var_306_19 = Color.New(1, 1, 1)
				local var_306_20 = 0

				arg_303_1.mask_.enabled = false
				var_306_19.a = var_306_20
				arg_303_1.mask_.color = var_306_19
			end

			local var_306_21 = 0

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 then
				arg_303_1.allBtn_.enabled = false
			end

			local var_306_22 = 0.766666666666667

			if arg_303_1.time_ >= var_306_21 + var_306_22 and arg_303_1.time_ < var_306_21 + var_306_22 + arg_306_0 then
				arg_303_1.allBtn_.enabled = true
			end

			local var_306_23 = 0
			local var_306_24 = 0.725

			if var_306_23 < arg_303_1.time_ and arg_303_1.time_ <= var_306_23 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_25 = arg_303_1:GetWordFromCfg(411331072)
				local var_306_26 = arg_303_1:FormatText(var_306_25.content)

				arg_303_1.text_.text = var_306_26

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_27 = 29
				local var_306_28 = utf8.len(var_306_26)
				local var_306_29 = var_306_27 <= 0 and var_306_24 or var_306_24 * (var_306_28 / var_306_27)

				if var_306_29 > 0 and var_306_24 < var_306_29 then
					arg_303_1.talkMaxDuration = var_306_29

					if var_306_29 + var_306_23 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_29 + var_306_23
					end
				end

				arg_303_1.text_.text = var_306_26
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_30 = math.max(var_306_24, arg_303_1.talkMaxDuration)

			if var_306_23 <= arg_303_1.time_ and arg_303_1.time_ < var_306_23 + var_306_30 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_23) / var_306_30

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_23 + var_306_30 and arg_303_1.time_ < var_306_23 + var_306_30 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play411331073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 411331073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play411331074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.125

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(411331073)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 5
				local var_310_5 = utf8.len(var_310_3)
				local var_310_6 = var_310_4 <= 0 and var_310_1 or var_310_1 * (var_310_5 / var_310_4)

				if var_310_6 > 0 and var_310_1 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_7 and arg_307_1.time_ < var_310_0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play411331074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 411331074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play411331075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.2

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[904].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(411331074)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 8
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_8 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_8 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_8

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_8 and arg_311_1.time_ < var_314_0 + var_314_8 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play411331075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 411331075
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play411331076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["4040ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos4040ui_story = var_318_0.localPosition
			end

			local var_318_2 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2
				local var_318_4 = Vector3.New(0, 100, 0)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos4040ui_story, var_318_4, var_318_3)

				local var_318_5 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_5.x, var_318_5.y, var_318_5.z)

				local var_318_6 = var_318_0.localEulerAngles

				var_318_6.z = 0
				var_318_6.x = 0
				var_318_0.localEulerAngles = var_318_6
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(0, 100, 0)

				local var_318_7 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_7.x, var_318_7.y, var_318_7.z)

				local var_318_8 = var_318_0.localEulerAngles

				var_318_8.z = 0
				var_318_8.x = 0
				var_318_0.localEulerAngles = var_318_8
			end

			local var_318_9 = arg_315_1.actors_["4040ui_story"]
			local var_318_10 = 0

			if var_318_10 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect4040ui_story == nil then
				arg_315_1.var_.characterEffect4040ui_story = var_318_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_11 = 0.200000002980232

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_11 and not isNil(var_318_9) then
				local var_318_12 = (arg_315_1.time_ - var_318_10) / var_318_11

				if arg_315_1.var_.characterEffect4040ui_story and not isNil(var_318_9) then
					local var_318_13 = Mathf.Lerp(0, 0.5, var_318_12)

					arg_315_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_315_1.var_.characterEffect4040ui_story.fillRatio = var_318_13
				end
			end

			if arg_315_1.time_ >= var_318_10 + var_318_11 and arg_315_1.time_ < var_318_10 + var_318_11 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect4040ui_story then
				local var_318_14 = 0.5

				arg_315_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_315_1.var_.characterEffect4040ui_story.fillRatio = var_318_14
			end

			local var_318_15 = 0.175
			local var_318_16 = 0.4

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				local var_318_17 = "play"
				local var_318_18 = "effect"

				arg_315_1:AudioAction(var_318_17, var_318_18, "se_story_122_01", "se_story_122_01_door02", "")
			end

			local var_318_19 = 0
			local var_318_20 = 0.575

			if var_318_19 < arg_315_1.time_ and arg_315_1.time_ <= var_318_19 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_21 = arg_315_1:GetWordFromCfg(411331075)
				local var_318_22 = arg_315_1:FormatText(var_318_21.content)

				arg_315_1.text_.text = var_318_22

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_23 = 23
				local var_318_24 = utf8.len(var_318_22)
				local var_318_25 = var_318_23 <= 0 and var_318_20 or var_318_20 * (var_318_24 / var_318_23)

				if var_318_25 > 0 and var_318_20 < var_318_25 then
					arg_315_1.talkMaxDuration = var_318_25

					if var_318_25 + var_318_19 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_25 + var_318_19
					end
				end

				arg_315_1.text_.text = var_318_22
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_26 = math.max(var_318_20, arg_315_1.talkMaxDuration)

			if var_318_19 <= arg_315_1.time_ and arg_315_1.time_ < var_318_19 + var_318_26 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_19) / var_318_26

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_19 + var_318_26 and arg_315_1.time_ < var_318_19 + var_318_26 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play411331076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 411331076
		arg_319_1.duration_ = 9

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play411331077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 2

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				local var_322_1 = manager.ui.mainCamera.transform.localPosition
				local var_322_2 = Vector3.New(0, 0, 10) + Vector3.New(var_322_1.x, var_322_1.y, 0)
				local var_322_3 = arg_319_1.bgs_.STblack

				var_322_3.transform.localPosition = var_322_2
				var_322_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_322_4 = var_322_3:GetComponent("SpriteRenderer")

				if var_322_4 and var_322_4.sprite then
					local var_322_5 = (var_322_3.transform.localPosition - var_322_1).z
					local var_322_6 = manager.ui.mainCameraCom_
					local var_322_7 = 2 * var_322_5 * Mathf.Tan(var_322_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_322_8 = var_322_7 * var_322_6.aspect
					local var_322_9 = var_322_4.sprite.bounds.size.x
					local var_322_10 = var_322_4.sprite.bounds.size.y
					local var_322_11 = var_322_8 / var_322_9
					local var_322_12 = var_322_7 / var_322_10
					local var_322_13 = var_322_12 < var_322_11 and var_322_11 or var_322_12

					var_322_3.transform.localScale = Vector3.New(var_322_13, var_322_13, 0)
				end

				for iter_322_0, iter_322_1 in pairs(arg_319_1.bgs_) do
					if iter_322_0 ~= "STblack" then
						iter_322_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_322_14 = 0

			if var_322_14 < arg_319_1.time_ and arg_319_1.time_ <= var_322_14 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_15 = 2

			if var_322_14 <= arg_319_1.time_ and arg_319_1.time_ < var_322_14 + var_322_15 then
				local var_322_16 = (arg_319_1.time_ - var_322_14) / var_322_15
				local var_322_17 = Color.New(0, 0, 0)

				var_322_17.a = Mathf.Lerp(0, 1, var_322_16)
				arg_319_1.mask_.color = var_322_17
			end

			if arg_319_1.time_ >= var_322_14 + var_322_15 and arg_319_1.time_ < var_322_14 + var_322_15 + arg_322_0 then
				local var_322_18 = Color.New(0, 0, 0)

				var_322_18.a = 1
				arg_319_1.mask_.color = var_322_18
			end

			local var_322_19 = 2

			if var_322_19 < arg_319_1.time_ and arg_319_1.time_ <= var_322_19 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_20 = 2

			if var_322_19 <= arg_319_1.time_ and arg_319_1.time_ < var_322_19 + var_322_20 then
				local var_322_21 = (arg_319_1.time_ - var_322_19) / var_322_20
				local var_322_22 = Color.New(0, 0, 0)

				var_322_22.a = Mathf.Lerp(1, 0, var_322_21)
				arg_319_1.mask_.color = var_322_22
			end

			if arg_319_1.time_ >= var_322_19 + var_322_20 and arg_319_1.time_ < var_322_19 + var_322_20 + arg_322_0 then
				local var_322_23 = Color.New(0, 0, 0)
				local var_322_24 = 0

				arg_319_1.mask_.enabled = false
				var_322_23.a = var_322_24
				arg_319_1.mask_.color = var_322_23
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_25 = 4
			local var_322_26 = 0.475

			if var_322_25 < arg_319_1.time_ and arg_319_1.time_ <= var_322_25 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_27 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_27:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_28 = arg_319_1:GetWordFromCfg(411331076)
				local var_322_29 = arg_319_1:FormatText(var_322_28.content)

				arg_319_1.text_.text = var_322_29

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_30 = 19
				local var_322_31 = utf8.len(var_322_29)
				local var_322_32 = var_322_30 <= 0 and var_322_26 or var_322_26 * (var_322_31 / var_322_30)

				if var_322_32 > 0 and var_322_26 < var_322_32 then
					arg_319_1.talkMaxDuration = var_322_32
					var_322_25 = var_322_25 + 0.3

					if var_322_32 + var_322_25 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_32 + var_322_25
					end
				end

				arg_319_1.text_.text = var_322_29
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_33 = var_322_25 + 0.3
			local var_322_34 = math.max(var_322_26, arg_319_1.talkMaxDuration)

			if var_322_33 <= arg_319_1.time_ and arg_319_1.time_ < var_322_33 + var_322_34 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_33) / var_322_34

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_33 + var_322_34 and arg_319_1.time_ < var_322_33 + var_322_34 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play411331077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 411331077
		arg_325_1.duration_ = 7

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play411331078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				local var_328_1 = manager.ui.mainCamera.transform.localPosition
				local var_328_2 = Vector3.New(0, 0, 10) + Vector3.New(var_328_1.x, var_328_1.y, 0)
				local var_328_3 = arg_325_1.bgs_.I07a

				var_328_3.transform.localPosition = var_328_2
				var_328_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_4 = var_328_3:GetComponent("SpriteRenderer")

				if var_328_4 and var_328_4.sprite then
					local var_328_5 = (var_328_3.transform.localPosition - var_328_1).z
					local var_328_6 = manager.ui.mainCameraCom_
					local var_328_7 = 2 * var_328_5 * Mathf.Tan(var_328_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_328_8 = var_328_7 * var_328_6.aspect
					local var_328_9 = var_328_4.sprite.bounds.size.x
					local var_328_10 = var_328_4.sprite.bounds.size.y
					local var_328_11 = var_328_8 / var_328_9
					local var_328_12 = var_328_7 / var_328_10
					local var_328_13 = var_328_12 < var_328_11 and var_328_11 or var_328_12

					var_328_3.transform.localScale = Vector3.New(var_328_13, var_328_13, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "I07a" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_14 = 0

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_15 = 2

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_15 then
				local var_328_16 = (arg_325_1.time_ - var_328_14) / var_328_15
				local var_328_17 = Color.New(0, 0, 0)

				var_328_17.a = Mathf.Lerp(1, 0, var_328_16)
				arg_325_1.mask_.color = var_328_17
			end

			if arg_325_1.time_ >= var_328_14 + var_328_15 and arg_325_1.time_ < var_328_14 + var_328_15 + arg_328_0 then
				local var_328_18 = Color.New(0, 0, 0)
				local var_328_19 = 0

				arg_325_1.mask_.enabled = false
				var_328_18.a = var_328_19
				arg_325_1.mask_.color = var_328_18
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_20 = 2
			local var_328_21 = 1

			if var_328_20 < arg_325_1.time_ and arg_325_1.time_ <= var_328_20 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_22 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_22:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_23 = arg_325_1:GetWordFromCfg(411331077)
				local var_328_24 = arg_325_1:FormatText(var_328_23.content)

				arg_325_1.text_.text = var_328_24

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_25 = 40
				local var_328_26 = utf8.len(var_328_24)
				local var_328_27 = var_328_25 <= 0 and var_328_21 or var_328_21 * (var_328_26 / var_328_25)

				if var_328_27 > 0 and var_328_21 < var_328_27 then
					arg_325_1.talkMaxDuration = var_328_27
					var_328_20 = var_328_20 + 0.3

					if var_328_27 + var_328_20 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_27 + var_328_20
					end
				end

				arg_325_1.text_.text = var_328_24
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_28 = var_328_20 + 0.3
			local var_328_29 = math.max(var_328_21, arg_325_1.talkMaxDuration)

			if var_328_28 <= arg_325_1.time_ and arg_325_1.time_ < var_328_28 + var_328_29 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_28) / var_328_29

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_28 + var_328_29 and arg_325_1.time_ < var_328_28 + var_328_29 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play411331078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 411331078
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play411331079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.65

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(411331078)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 26
				local var_334_5 = utf8.len(var_334_3)
				local var_334_6 = var_334_4 <= 0 and var_334_1 or var_334_1 * (var_334_5 / var_334_4)

				if var_334_6 > 0 and var_334_1 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_7 and arg_331_1.time_ < var_334_0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play411331079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 411331079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play411331080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["4040ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos4040ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(0, -1.55, -5.5)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos4040ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["4040ui_story"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect4040ui_story == nil then
				arg_335_1.var_.characterEffect4040ui_story = var_338_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_11 = 0.200000002980232

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 and not isNil(var_338_9) then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11

				if arg_335_1.var_.characterEffect4040ui_story and not isNil(var_338_9) then
					arg_335_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect4040ui_story then
				arg_335_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_338_13 = 0

			if var_338_13 < arg_335_1.time_ and arg_335_1.time_ <= var_338_13 + arg_338_0 then
				arg_335_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_338_14 = 0

			if var_338_14 < arg_335_1.time_ and arg_335_1.time_ <= var_338_14 + arg_338_0 then
				arg_335_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_338_15 = 0
			local var_338_16 = 0.1

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_17 = arg_335_1:FormatText(StoryNameCfg[905].name)

				arg_335_1.leftNameTxt_.text = var_338_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_18 = arg_335_1:GetWordFromCfg(411331079)
				local var_338_19 = arg_335_1:FormatText(var_338_18.content)

				arg_335_1.text_.text = var_338_19

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_20 = 4
				local var_338_21 = utf8.len(var_338_19)
				local var_338_22 = var_338_20 <= 0 and var_338_16 or var_338_16 * (var_338_21 / var_338_20)

				if var_338_22 > 0 and var_338_16 < var_338_22 then
					arg_335_1.talkMaxDuration = var_338_22

					if var_338_22 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_22 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_19
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_23 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_23 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_23

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_23 and arg_335_1.time_ < var_338_15 + var_338_23 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play411331080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 411331080
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play411331081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["4040ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect4040ui_story == nil then
				arg_339_1.var_.characterEffect4040ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect4040ui_story and not isNil(var_342_0) then
					local var_342_4 = Mathf.Lerp(0, 0.5, var_342_3)

					arg_339_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_339_1.var_.characterEffect4040ui_story.fillRatio = var_342_4
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect4040ui_story then
				local var_342_5 = 0.5

				arg_339_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_339_1.var_.characterEffect4040ui_story.fillRatio = var_342_5
			end

			local var_342_6 = 0
			local var_342_7 = 1.425

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(411331080)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 57
				local var_342_11 = utf8.len(var_342_9)
				local var_342_12 = var_342_10 <= 0 and var_342_7 or var_342_7 * (var_342_11 / var_342_10)

				if var_342_12 > 0 and var_342_7 < var_342_12 then
					arg_339_1.talkMaxDuration = var_342_12

					if var_342_12 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_13 and arg_339_1.time_ < var_342_6 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play411331081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 411331081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play411331082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["4040ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos4040ui_story = var_346_0.localPosition
			end

			local var_346_2 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2
				local var_346_4 = Vector3.New(0, -1.55, -5.5)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos4040ui_story, var_346_4, var_346_3)

				local var_346_5 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_5.x, var_346_5.y, var_346_5.z)

				local var_346_6 = var_346_0.localEulerAngles

				var_346_6.z = 0
				var_346_6.x = 0
				var_346_0.localEulerAngles = var_346_6
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_346_7 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_7.x, var_346_7.y, var_346_7.z)

				local var_346_8 = var_346_0.localEulerAngles

				var_346_8.z = 0
				var_346_8.x = 0
				var_346_0.localEulerAngles = var_346_8
			end

			local var_346_9 = arg_343_1.actors_["4040ui_story"]
			local var_346_10 = 0

			if var_346_10 < arg_343_1.time_ and arg_343_1.time_ <= var_346_10 + arg_346_0 and not isNil(var_346_9) and arg_343_1.var_.characterEffect4040ui_story == nil then
				arg_343_1.var_.characterEffect4040ui_story = var_346_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_11 = 0.200000002980232

			if var_346_10 <= arg_343_1.time_ and arg_343_1.time_ < var_346_10 + var_346_11 and not isNil(var_346_9) then
				local var_346_12 = (arg_343_1.time_ - var_346_10) / var_346_11

				if arg_343_1.var_.characterEffect4040ui_story and not isNil(var_346_9) then
					arg_343_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_10 + var_346_11 and arg_343_1.time_ < var_346_10 + var_346_11 + arg_346_0 and not isNil(var_346_9) and arg_343_1.var_.characterEffect4040ui_story then
				arg_343_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_346_13 = 0
			local var_346_14 = 0.2

			if var_346_13 < arg_343_1.time_ and arg_343_1.time_ <= var_346_13 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_15 = arg_343_1:FormatText(StoryNameCfg[905].name)

				arg_343_1.leftNameTxt_.text = var_346_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_16 = arg_343_1:GetWordFromCfg(411331081)
				local var_346_17 = arg_343_1:FormatText(var_346_16.content)

				arg_343_1.text_.text = var_346_17

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_18 = 8
				local var_346_19 = utf8.len(var_346_17)
				local var_346_20 = var_346_18 <= 0 and var_346_14 or var_346_14 * (var_346_19 / var_346_18)

				if var_346_20 > 0 and var_346_14 < var_346_20 then
					arg_343_1.talkMaxDuration = var_346_20

					if var_346_20 + var_346_13 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_20 + var_346_13
					end
				end

				arg_343_1.text_.text = var_346_17
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_21 = math.max(var_346_14, arg_343_1.talkMaxDuration)

			if var_346_13 <= arg_343_1.time_ and arg_343_1.time_ < var_346_13 + var_346_21 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_13) / var_346_21

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_13 + var_346_21 and arg_343_1.time_ < var_346_13 + var_346_21 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play411331082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 411331082
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play411331083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["4040ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect4040ui_story == nil then
				arg_347_1.var_.characterEffect4040ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect4040ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_347_1.var_.characterEffect4040ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect4040ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_347_1.var_.characterEffect4040ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0
			local var_350_7 = 0.275

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_8 = arg_347_1:FormatText(StoryNameCfg[904].name)

				arg_347_1.leftNameTxt_.text = var_350_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_9 = arg_347_1:GetWordFromCfg(411331082)
				local var_350_10 = arg_347_1:FormatText(var_350_9.content)

				arg_347_1.text_.text = var_350_10

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 11
				local var_350_12 = utf8.len(var_350_10)
				local var_350_13 = var_350_11 <= 0 and var_350_7 or var_350_7 * (var_350_12 / var_350_11)

				if var_350_13 > 0 and var_350_7 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_10
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play411331083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 411331083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play411331084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["4040ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos4040ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(0, -1.55, -5.5)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos4040ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["4040ui_story"]
			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect4040ui_story == nil then
				arg_351_1.var_.characterEffect4040ui_story = var_354_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_11 = 0.200000002980232

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_11 and not isNil(var_354_9) then
				local var_354_12 = (arg_351_1.time_ - var_354_10) / var_354_11

				if arg_351_1.var_.characterEffect4040ui_story and not isNil(var_354_9) then
					arg_351_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_11 and arg_351_1.time_ < var_354_10 + var_354_11 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect4040ui_story then
				arg_351_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_354_13 = 0

			if var_354_13 < arg_351_1.time_ and arg_351_1.time_ <= var_354_13 + arg_354_0 then
				arg_351_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_354_14 = 0

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				arg_351_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_354_15 = 0
			local var_354_16 = 0.625

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_17 = arg_351_1:FormatText(StoryNameCfg[905].name)

				arg_351_1.leftNameTxt_.text = var_354_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_18 = arg_351_1:GetWordFromCfg(411331083)
				local var_354_19 = arg_351_1:FormatText(var_354_18.content)

				arg_351_1.text_.text = var_354_19

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_20 = 25
				local var_354_21 = utf8.len(var_354_19)
				local var_354_22 = var_354_20 <= 0 and var_354_16 or var_354_16 * (var_354_21 / var_354_20)

				if var_354_22 > 0 and var_354_16 < var_354_22 then
					arg_351_1.talkMaxDuration = var_354_22

					if var_354_22 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_22 + var_354_15
					end
				end

				arg_351_1.text_.text = var_354_19
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_23 = math.max(var_354_16, arg_351_1.talkMaxDuration)

			if var_354_15 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_23 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_15) / var_354_23

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_15 + var_354_23 and arg_351_1.time_ < var_354_15 + var_354_23 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play411331084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 411331084
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play411331085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["4040ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect4040ui_story == nil then
				arg_355_1.var_.characterEffect4040ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect4040ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_355_1.var_.characterEffect4040ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect4040ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_355_1.var_.characterEffect4040ui_story.fillRatio = var_358_5
			end

			local var_358_6 = 0
			local var_358_7 = 0.4

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_8 = arg_355_1:FormatText(StoryNameCfg[904].name)

				arg_355_1.leftNameTxt_.text = var_358_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_9 = arg_355_1:GetWordFromCfg(411331084)
				local var_358_10 = arg_355_1:FormatText(var_358_9.content)

				arg_355_1.text_.text = var_358_10

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 16
				local var_358_12 = utf8.len(var_358_10)
				local var_358_13 = var_358_11 <= 0 and var_358_7 or var_358_7 * (var_358_12 / var_358_11)

				if var_358_13 > 0 and var_358_7 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_10
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_14 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_14 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_14

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_14 and arg_355_1.time_ < var_358_6 + var_358_14 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play411331085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 411331085
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play411331086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["4040ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos4040ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, -1.55, -5.5)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos4040ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["4040ui_story"]
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect4040ui_story == nil then
				arg_359_1.var_.characterEffect4040ui_story = var_362_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_11 = 0.200000002980232

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 and not isNil(var_362_9) then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11

				if arg_359_1.var_.characterEffect4040ui_story and not isNil(var_362_9) then
					arg_359_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect4040ui_story then
				arg_359_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_362_13 = 0
			local var_362_14 = 0.25

			if var_362_13 < arg_359_1.time_ and arg_359_1.time_ <= var_362_13 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_15 = arg_359_1:FormatText(StoryNameCfg[905].name)

				arg_359_1.leftNameTxt_.text = var_362_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_16 = arg_359_1:GetWordFromCfg(411331085)
				local var_362_17 = arg_359_1:FormatText(var_362_16.content)

				arg_359_1.text_.text = var_362_17

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_18 = 10
				local var_362_19 = utf8.len(var_362_17)
				local var_362_20 = var_362_18 <= 0 and var_362_14 or var_362_14 * (var_362_19 / var_362_18)

				if var_362_20 > 0 and var_362_14 < var_362_20 then
					arg_359_1.talkMaxDuration = var_362_20

					if var_362_20 + var_362_13 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_20 + var_362_13
					end
				end

				arg_359_1.text_.text = var_362_17
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_21 = math.max(var_362_14, arg_359_1.talkMaxDuration)

			if var_362_13 <= arg_359_1.time_ and arg_359_1.time_ < var_362_13 + var_362_21 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_13) / var_362_21

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_13 + var_362_21 and arg_359_1.time_ < var_362_13 + var_362_21 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play411331086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 411331086
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play411331087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["4040ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos4040ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(0, 100, 0)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos4040ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0, 100, 0)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["4040ui_story"]
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect4040ui_story == nil then
				arg_363_1.var_.characterEffect4040ui_story = var_366_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_11 = 0.200000002980232

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 and not isNil(var_366_9) then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11

				if arg_363_1.var_.characterEffect4040ui_story and not isNil(var_366_9) then
					local var_366_13 = Mathf.Lerp(0, 0.5, var_366_12)

					arg_363_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_363_1.var_.characterEffect4040ui_story.fillRatio = var_366_13
				end
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect4040ui_story then
				local var_366_14 = 0.5

				arg_363_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_363_1.var_.characterEffect4040ui_story.fillRatio = var_366_14
			end

			local var_366_15 = 0
			local var_366_16 = 1.3

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_17 = arg_363_1:GetWordFromCfg(411331086)
				local var_366_18 = arg_363_1:FormatText(var_366_17.content)

				arg_363_1.text_.text = var_366_18

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_19 = 52
				local var_366_20 = utf8.len(var_366_18)
				local var_366_21 = var_366_19 <= 0 and var_366_16 or var_366_16 * (var_366_20 / var_366_19)

				if var_366_21 > 0 and var_366_16 < var_366_21 then
					arg_363_1.talkMaxDuration = var_366_21

					if var_366_21 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_21 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_18
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_22 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_22 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_22

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_22 and arg_363_1.time_ < var_366_15 + var_366_22 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play411331087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 411331087
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play411331088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1.225

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(411331087)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 49
				local var_370_5 = utf8.len(var_370_3)
				local var_370_6 = var_370_4 <= 0 and var_370_1 or var_370_1 * (var_370_5 / var_370_4)

				if var_370_6 > 0 and var_370_1 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_7 and arg_367_1.time_ < var_370_0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play411331088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 411331088
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play411331089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.35

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_2 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_2:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_3 = arg_371_1:FormatText(StoryNameCfg[904].name)

				arg_371_1.leftNameTxt_.text = var_374_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_4 = arg_371_1:GetWordFromCfg(411331088)
				local var_374_5 = arg_371_1:FormatText(var_374_4.content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 14
				local var_374_7 = utf8.len(var_374_5)
				local var_374_8 = var_374_6 <= 0 and var_374_1 or var_374_1 * (var_374_7 / var_374_6)

				if var_374_8 > 0 and var_374_1 < var_374_8 then
					arg_371_1.talkMaxDuration = var_374_8
					var_374_0 = var_374_0 + 0.3

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_5
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_9 = var_374_0 + 0.3
			local var_374_10 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_9) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_9 + var_374_10 and arg_371_1.time_ < var_374_9 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play411331089 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 411331089
		arg_377_1.duration_ = 9

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play411331090(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = "D10"

			if arg_377_1.bgs_[var_380_0] == nil then
				local var_380_1 = Object.Instantiate(arg_377_1.paintGo_)

				var_380_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_380_0)
				var_380_1.name = var_380_0
				var_380_1.transform.parent = arg_377_1.stage_.transform
				var_380_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.bgs_[var_380_0] = var_380_1
			end

			local var_380_2 = 2

			if var_380_2 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 then
				local var_380_3 = manager.ui.mainCamera.transform.localPosition
				local var_380_4 = Vector3.New(0, 0, 10) + Vector3.New(var_380_3.x, var_380_3.y, 0)
				local var_380_5 = arg_377_1.bgs_.D10

				var_380_5.transform.localPosition = var_380_4
				var_380_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_6 = var_380_5:GetComponent("SpriteRenderer")

				if var_380_6 and var_380_6.sprite then
					local var_380_7 = (var_380_5.transform.localPosition - var_380_3).z
					local var_380_8 = manager.ui.mainCameraCom_
					local var_380_9 = 2 * var_380_7 * Mathf.Tan(var_380_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_380_10 = var_380_9 * var_380_8.aspect
					local var_380_11 = var_380_6.sprite.bounds.size.x
					local var_380_12 = var_380_6.sprite.bounds.size.y
					local var_380_13 = var_380_10 / var_380_11
					local var_380_14 = var_380_9 / var_380_12
					local var_380_15 = var_380_14 < var_380_13 and var_380_13 or var_380_14

					var_380_5.transform.localScale = Vector3.New(var_380_15, var_380_15, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "D10" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_16 = 0

			if var_380_16 < arg_377_1.time_ and arg_377_1.time_ <= var_380_16 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_17 = 2

			if var_380_16 <= arg_377_1.time_ and arg_377_1.time_ < var_380_16 + var_380_17 then
				local var_380_18 = (arg_377_1.time_ - var_380_16) / var_380_17
				local var_380_19 = Color.New(0, 0, 0)

				var_380_19.a = Mathf.Lerp(0, 1, var_380_18)
				arg_377_1.mask_.color = var_380_19
			end

			if arg_377_1.time_ >= var_380_16 + var_380_17 and arg_377_1.time_ < var_380_16 + var_380_17 + arg_380_0 then
				local var_380_20 = Color.New(0, 0, 0)

				var_380_20.a = 1
				arg_377_1.mask_.color = var_380_20
			end

			local var_380_21 = 2

			if var_380_21 < arg_377_1.time_ and arg_377_1.time_ <= var_380_21 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_22 = 2

			if var_380_21 <= arg_377_1.time_ and arg_377_1.time_ < var_380_21 + var_380_22 then
				local var_380_23 = (arg_377_1.time_ - var_380_21) / var_380_22
				local var_380_24 = Color.New(0, 0, 0)

				var_380_24.a = Mathf.Lerp(1, 0, var_380_23)
				arg_377_1.mask_.color = var_380_24
			end

			if arg_377_1.time_ >= var_380_21 + var_380_22 and arg_377_1.time_ < var_380_21 + var_380_22 + arg_380_0 then
				local var_380_25 = Color.New(0, 0, 0)
				local var_380_26 = 0

				arg_377_1.mask_.enabled = false
				var_380_25.a = var_380_26
				arg_377_1.mask_.color = var_380_25
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_27 = 4
			local var_380_28 = 0.875

			if var_380_27 < arg_377_1.time_ and arg_377_1.time_ <= var_380_27 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_29 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_29:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_30 = arg_377_1:GetWordFromCfg(411331089)
				local var_380_31 = arg_377_1:FormatText(var_380_30.content)

				arg_377_1.text_.text = var_380_31

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_32 = 35
				local var_380_33 = utf8.len(var_380_31)
				local var_380_34 = var_380_32 <= 0 and var_380_28 or var_380_28 * (var_380_33 / var_380_32)

				if var_380_34 > 0 and var_380_28 < var_380_34 then
					arg_377_1.talkMaxDuration = var_380_34
					var_380_27 = var_380_27 + 0.3

					if var_380_34 + var_380_27 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_34 + var_380_27
					end
				end

				arg_377_1.text_.text = var_380_31
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_35 = var_380_27 + 0.3
			local var_380_36 = math.max(var_380_28, arg_377_1.talkMaxDuration)

			if var_380_35 <= arg_377_1.time_ and arg_377_1.time_ < var_380_35 + var_380_36 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_35) / var_380_36

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_35 + var_380_36 and arg_377_1.time_ < var_380_35 + var_380_36 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play411331090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 411331090
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play411331091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 1.075

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_2 = arg_383_1:GetWordFromCfg(411331090)
				local var_386_3 = arg_383_1:FormatText(var_386_2.content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 43
				local var_386_5 = utf8.len(var_386_3)
				local var_386_6 = var_386_4 <= 0 and var_386_1 or var_386_1 * (var_386_5 / var_386_4)

				if var_386_6 > 0 and var_386_1 < var_386_6 then
					arg_383_1.talkMaxDuration = var_386_6

					if var_386_6 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_6 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_7 and arg_383_1.time_ < var_386_0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play411331091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 411331091
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play411331092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = "10014ui_story"

			if arg_387_1.actors_[var_390_0] == nil then
				local var_390_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_390_1) then
					local var_390_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_387_1.stage_.transform)

					var_390_2.name = var_390_0
					var_390_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_387_1.actors_[var_390_0] = var_390_2

					local var_390_3 = var_390_2:GetComponentInChildren(typeof(CharacterEffect))

					var_390_3.enabled = true

					local var_390_4 = GameObjectTools.GetOrAddComponent(var_390_2, typeof(DynamicBoneHelper))

					if var_390_4 then
						var_390_4:EnableDynamicBone(false)
					end

					arg_387_1:ShowWeapon(var_390_3.transform, false)

					arg_387_1.var_[var_390_0 .. "Animator"] = var_390_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_387_1.var_[var_390_0 .. "Animator"].applyRootMotion = true
					arg_387_1.var_[var_390_0 .. "LipSync"] = var_390_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_390_5 = arg_387_1.actors_["10014ui_story"].transform
			local var_390_6 = 0

			if var_390_6 < arg_387_1.time_ and arg_387_1.time_ <= var_390_6 + arg_390_0 then
				arg_387_1.var_.moveOldPos10014ui_story = var_390_5.localPosition
			end

			local var_390_7 = 0.001

			if var_390_6 <= arg_387_1.time_ and arg_387_1.time_ < var_390_6 + var_390_7 then
				local var_390_8 = (arg_387_1.time_ - var_390_6) / var_390_7
				local var_390_9 = Vector3.New(0, -1.06, -6.2)

				var_390_5.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10014ui_story, var_390_9, var_390_8)

				local var_390_10 = manager.ui.mainCamera.transform.position - var_390_5.position

				var_390_5.forward = Vector3.New(var_390_10.x, var_390_10.y, var_390_10.z)

				local var_390_11 = var_390_5.localEulerAngles

				var_390_11.z = 0
				var_390_11.x = 0
				var_390_5.localEulerAngles = var_390_11
			end

			if arg_387_1.time_ >= var_390_6 + var_390_7 and arg_387_1.time_ < var_390_6 + var_390_7 + arg_390_0 then
				var_390_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_390_12 = manager.ui.mainCamera.transform.position - var_390_5.position

				var_390_5.forward = Vector3.New(var_390_12.x, var_390_12.y, var_390_12.z)

				local var_390_13 = var_390_5.localEulerAngles

				var_390_13.z = 0
				var_390_13.x = 0
				var_390_5.localEulerAngles = var_390_13
			end

			local var_390_14 = arg_387_1.actors_["10014ui_story"]
			local var_390_15 = 0

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 and not isNil(var_390_14) and arg_387_1.var_.characterEffect10014ui_story == nil then
				arg_387_1.var_.characterEffect10014ui_story = var_390_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_16 = 0.200000002980232

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_16 and not isNil(var_390_14) then
				local var_390_17 = (arg_387_1.time_ - var_390_15) / var_390_16

				if arg_387_1.var_.characterEffect10014ui_story and not isNil(var_390_14) then
					arg_387_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_15 + var_390_16 and arg_387_1.time_ < var_390_15 + var_390_16 + arg_390_0 and not isNil(var_390_14) and arg_387_1.var_.characterEffect10014ui_story then
				arg_387_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_390_18 = 0

			if var_390_18 < arg_387_1.time_ and arg_387_1.time_ <= var_390_18 + arg_390_0 then
				arg_387_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_390_19 = 0

			if var_390_19 < arg_387_1.time_ and arg_387_1.time_ <= var_390_19 + arg_390_0 then
				arg_387_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_20 = 0
			local var_390_21 = 0.775

			if var_390_20 < arg_387_1.time_ and arg_387_1.time_ <= var_390_20 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_22 = arg_387_1:FormatText(StoryNameCfg[264].name)

				arg_387_1.leftNameTxt_.text = var_390_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_23 = arg_387_1:GetWordFromCfg(411331091)
				local var_390_24 = arg_387_1:FormatText(var_390_23.content)

				arg_387_1.text_.text = var_390_24

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_25 = 31
				local var_390_26 = utf8.len(var_390_24)
				local var_390_27 = var_390_25 <= 0 and var_390_21 or var_390_21 * (var_390_26 / var_390_25)

				if var_390_27 > 0 and var_390_21 < var_390_27 then
					arg_387_1.talkMaxDuration = var_390_27

					if var_390_27 + var_390_20 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_27 + var_390_20
					end
				end

				arg_387_1.text_.text = var_390_24
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_28 = math.max(var_390_21, arg_387_1.talkMaxDuration)

			if var_390_20 <= arg_387_1.time_ and arg_387_1.time_ < var_390_20 + var_390_28 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_20) / var_390_28

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_20 + var_390_28 and arg_387_1.time_ < var_390_20 + var_390_28 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play411331092 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 411331092
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play411331093(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.925

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[264].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:GetWordFromCfg(411331092)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 37
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_8 and arg_391_1.time_ < var_394_0 + var_394_8 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play411331093 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 411331093
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play411331094(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["10014ui_story"].transform
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.var_.moveOldPos10014ui_story = var_398_0.localPosition
			end

			local var_398_2 = 0.001

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2
				local var_398_4 = Vector3.New(0, -1.06, -6.2)

				var_398_0.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10014ui_story, var_398_4, var_398_3)

				local var_398_5 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_5.x, var_398_5.y, var_398_5.z)

				local var_398_6 = var_398_0.localEulerAngles

				var_398_6.z = 0
				var_398_6.x = 0
				var_398_0.localEulerAngles = var_398_6
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 then
				var_398_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_398_7 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_7.x, var_398_7.y, var_398_7.z)

				local var_398_8 = var_398_0.localEulerAngles

				var_398_8.z = 0
				var_398_8.x = 0
				var_398_0.localEulerAngles = var_398_8
			end

			local var_398_9 = arg_395_1.actors_["10014ui_story"]
			local var_398_10 = 0

			if var_398_10 < arg_395_1.time_ and arg_395_1.time_ <= var_398_10 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect10014ui_story == nil then
				arg_395_1.var_.characterEffect10014ui_story = var_398_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_11 = 0.200000002980232

			if var_398_10 <= arg_395_1.time_ and arg_395_1.time_ < var_398_10 + var_398_11 and not isNil(var_398_9) then
				local var_398_12 = (arg_395_1.time_ - var_398_10) / var_398_11

				if arg_395_1.var_.characterEffect10014ui_story and not isNil(var_398_9) then
					arg_395_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_10 + var_398_11 and arg_395_1.time_ < var_398_10 + var_398_11 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect10014ui_story then
				arg_395_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_398_13 = 0

			if var_398_13 < arg_395_1.time_ and arg_395_1.time_ <= var_398_13 + arg_398_0 then
				arg_395_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_1")
			end

			local var_398_14 = 0

			if var_398_14 < arg_395_1.time_ and arg_395_1.time_ <= var_398_14 + arg_398_0 then
				arg_395_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_15 = 0
			local var_398_16 = 0.9

			if var_398_15 < arg_395_1.time_ and arg_395_1.time_ <= var_398_15 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_17 = arg_395_1:FormatText(StoryNameCfg[264].name)

				arg_395_1.leftNameTxt_.text = var_398_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_18 = arg_395_1:GetWordFromCfg(411331093)
				local var_398_19 = arg_395_1:FormatText(var_398_18.content)

				arg_395_1.text_.text = var_398_19

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_20 = 36
				local var_398_21 = utf8.len(var_398_19)
				local var_398_22 = var_398_20 <= 0 and var_398_16 or var_398_16 * (var_398_21 / var_398_20)

				if var_398_22 > 0 and var_398_16 < var_398_22 then
					arg_395_1.talkMaxDuration = var_398_22

					if var_398_22 + var_398_15 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_22 + var_398_15
					end
				end

				arg_395_1.text_.text = var_398_19
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_23 = math.max(var_398_16, arg_395_1.talkMaxDuration)

			if var_398_15 <= arg_395_1.time_ and arg_395_1.time_ < var_398_15 + var_398_23 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_15) / var_398_23

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_15 + var_398_23 and arg_395_1.time_ < var_398_15 + var_398_23 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play411331094 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 411331094
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play411331095(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["10014ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect10014ui_story == nil then
				arg_399_1.var_.characterEffect10014ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect10014ui_story and not isNil(var_402_0) then
					local var_402_4 = Mathf.Lerp(0, 0.5, var_402_3)

					arg_399_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_399_1.var_.characterEffect10014ui_story.fillRatio = var_402_4
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect10014ui_story then
				local var_402_5 = 0.5

				arg_399_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_399_1.var_.characterEffect10014ui_story.fillRatio = var_402_5
			end

			local var_402_6 = 0
			local var_402_7 = 0.725

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_8 = arg_399_1:GetWordFromCfg(411331094)
				local var_402_9 = arg_399_1:FormatText(var_402_8.content)

				arg_399_1.text_.text = var_402_9

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 29
				local var_402_11 = utf8.len(var_402_9)
				local var_402_12 = var_402_10 <= 0 and var_402_7 or var_402_7 * (var_402_11 / var_402_10)

				if var_402_12 > 0 and var_402_7 < var_402_12 then
					arg_399_1.talkMaxDuration = var_402_12

					if var_402_12 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_12 + var_402_6
					end
				end

				arg_399_1.text_.text = var_402_9
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_13 = math.max(var_402_7, arg_399_1.talkMaxDuration)

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_13 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_6) / var_402_13

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_6 + var_402_13 and arg_399_1.time_ < var_402_6 + var_402_13 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play411331095 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 411331095
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play411331096(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["10014ui_story"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos10014ui_story = var_406_0.localPosition
			end

			local var_406_2 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2
				local var_406_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10014ui_story, var_406_4, var_406_3)

				local var_406_5 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_5.x, var_406_5.y, var_406_5.z)

				local var_406_6 = var_406_0.localEulerAngles

				var_406_6.z = 0
				var_406_6.x = 0
				var_406_0.localEulerAngles = var_406_6
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_406_7 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_7.x, var_406_7.y, var_406_7.z)

				local var_406_8 = var_406_0.localEulerAngles

				var_406_8.z = 0
				var_406_8.x = 0
				var_406_0.localEulerAngles = var_406_8
			end

			local var_406_9 = arg_403_1.actors_["10014ui_story"]
			local var_406_10 = 0

			if var_406_10 < arg_403_1.time_ and arg_403_1.time_ <= var_406_10 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect10014ui_story == nil then
				arg_403_1.var_.characterEffect10014ui_story = var_406_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_11 = 0.200000002980232

			if var_406_10 <= arg_403_1.time_ and arg_403_1.time_ < var_406_10 + var_406_11 and not isNil(var_406_9) then
				local var_406_12 = (arg_403_1.time_ - var_406_10) / var_406_11

				if arg_403_1.var_.characterEffect10014ui_story and not isNil(var_406_9) then
					local var_406_13 = Mathf.Lerp(0, 0.5, var_406_12)

					arg_403_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_403_1.var_.characterEffect10014ui_story.fillRatio = var_406_13
				end
			end

			if arg_403_1.time_ >= var_406_10 + var_406_11 and arg_403_1.time_ < var_406_10 + var_406_11 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect10014ui_story then
				local var_406_14 = 0.5

				arg_403_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_403_1.var_.characterEffect10014ui_story.fillRatio = var_406_14
			end

			local var_406_15 = arg_403_1.actors_["4040ui_story"].transform
			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 then
				arg_403_1.var_.moveOldPos4040ui_story = var_406_15.localPosition
			end

			local var_406_17 = 0.001

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_17 then
				local var_406_18 = (arg_403_1.time_ - var_406_16) / var_406_17
				local var_406_19 = Vector3.New(0.7, -1.55, -5.5)

				var_406_15.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos4040ui_story, var_406_19, var_406_18)

				local var_406_20 = manager.ui.mainCamera.transform.position - var_406_15.position

				var_406_15.forward = Vector3.New(var_406_20.x, var_406_20.y, var_406_20.z)

				local var_406_21 = var_406_15.localEulerAngles

				var_406_21.z = 0
				var_406_21.x = 0
				var_406_15.localEulerAngles = var_406_21
			end

			if arg_403_1.time_ >= var_406_16 + var_406_17 and arg_403_1.time_ < var_406_16 + var_406_17 + arg_406_0 then
				var_406_15.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_406_22 = manager.ui.mainCamera.transform.position - var_406_15.position

				var_406_15.forward = Vector3.New(var_406_22.x, var_406_22.y, var_406_22.z)

				local var_406_23 = var_406_15.localEulerAngles

				var_406_23.z = 0
				var_406_23.x = 0
				var_406_15.localEulerAngles = var_406_23
			end

			local var_406_24 = arg_403_1.actors_["4040ui_story"]
			local var_406_25 = 0

			if var_406_25 < arg_403_1.time_ and arg_403_1.time_ <= var_406_25 + arg_406_0 and not isNil(var_406_24) and arg_403_1.var_.characterEffect4040ui_story == nil then
				arg_403_1.var_.characterEffect4040ui_story = var_406_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_26 = 0.200000002980232

			if var_406_25 <= arg_403_1.time_ and arg_403_1.time_ < var_406_25 + var_406_26 and not isNil(var_406_24) then
				local var_406_27 = (arg_403_1.time_ - var_406_25) / var_406_26

				if arg_403_1.var_.characterEffect4040ui_story and not isNil(var_406_24) then
					arg_403_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_25 + var_406_26 and arg_403_1.time_ < var_406_25 + var_406_26 + arg_406_0 and not isNil(var_406_24) and arg_403_1.var_.characterEffect4040ui_story then
				arg_403_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_406_28 = 0

			if var_406_28 < arg_403_1.time_ and arg_403_1.time_ <= var_406_28 + arg_406_0 then
				arg_403_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_406_29 = 0

			if var_406_29 < arg_403_1.time_ and arg_403_1.time_ <= var_406_29 + arg_406_0 then
				arg_403_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_406_30 = 0
			local var_406_31 = 0.4

			if var_406_30 < arg_403_1.time_ and arg_403_1.time_ <= var_406_30 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_32 = arg_403_1:FormatText(StoryNameCfg[905].name)

				arg_403_1.leftNameTxt_.text = var_406_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_33 = arg_403_1:GetWordFromCfg(411331095)
				local var_406_34 = arg_403_1:FormatText(var_406_33.content)

				arg_403_1.text_.text = var_406_34

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_35 = 16
				local var_406_36 = utf8.len(var_406_34)
				local var_406_37 = var_406_35 <= 0 and var_406_31 or var_406_31 * (var_406_36 / var_406_35)

				if var_406_37 > 0 and var_406_31 < var_406_37 then
					arg_403_1.talkMaxDuration = var_406_37

					if var_406_37 + var_406_30 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_37 + var_406_30
					end
				end

				arg_403_1.text_.text = var_406_34
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_38 = math.max(var_406_31, arg_403_1.talkMaxDuration)

			if var_406_30 <= arg_403_1.time_ and arg_403_1.time_ < var_406_30 + var_406_38 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_30) / var_406_38

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_30 + var_406_38 and arg_403_1.time_ < var_406_30 + var_406_38 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play411331096 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 411331096
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play411331097(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["10014ui_story"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos10014ui_story = var_410_0.localPosition
			end

			local var_410_2 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2
				local var_410_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10014ui_story, var_410_4, var_410_3)

				local var_410_5 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_5.x, var_410_5.y, var_410_5.z)

				local var_410_6 = var_410_0.localEulerAngles

				var_410_6.z = 0
				var_410_6.x = 0
				var_410_0.localEulerAngles = var_410_6
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_410_7 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_7.x, var_410_7.y, var_410_7.z)

				local var_410_8 = var_410_0.localEulerAngles

				var_410_8.z = 0
				var_410_8.x = 0
				var_410_0.localEulerAngles = var_410_8
			end

			local var_410_9 = arg_407_1.actors_["10014ui_story"]
			local var_410_10 = 0

			if var_410_10 < arg_407_1.time_ and arg_407_1.time_ <= var_410_10 + arg_410_0 and not isNil(var_410_9) and arg_407_1.var_.characterEffect10014ui_story == nil then
				arg_407_1.var_.characterEffect10014ui_story = var_410_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_11 = 0.200000002980232

			if var_410_10 <= arg_407_1.time_ and arg_407_1.time_ < var_410_10 + var_410_11 and not isNil(var_410_9) then
				local var_410_12 = (arg_407_1.time_ - var_410_10) / var_410_11

				if arg_407_1.var_.characterEffect10014ui_story and not isNil(var_410_9) then
					arg_407_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_10 + var_410_11 and arg_407_1.time_ < var_410_10 + var_410_11 + arg_410_0 and not isNil(var_410_9) and arg_407_1.var_.characterEffect10014ui_story then
				arg_407_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_410_13 = 0

			if var_410_13 < arg_407_1.time_ and arg_407_1.time_ <= var_410_13 + arg_410_0 then
				arg_407_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_2")
			end

			local var_410_14 = 0

			if var_410_14 < arg_407_1.time_ and arg_407_1.time_ <= var_410_14 + arg_410_0 then
				arg_407_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_15 = arg_407_1.actors_["4040ui_story"]
			local var_410_16 = 0

			if var_410_16 < arg_407_1.time_ and arg_407_1.time_ <= var_410_16 + arg_410_0 and not isNil(var_410_15) and arg_407_1.var_.characterEffect4040ui_story == nil then
				arg_407_1.var_.characterEffect4040ui_story = var_410_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_17 = 0.200000002980232

			if var_410_16 <= arg_407_1.time_ and arg_407_1.time_ < var_410_16 + var_410_17 and not isNil(var_410_15) then
				local var_410_18 = (arg_407_1.time_ - var_410_16) / var_410_17

				if arg_407_1.var_.characterEffect4040ui_story and not isNil(var_410_15) then
					local var_410_19 = Mathf.Lerp(0, 0.5, var_410_18)

					arg_407_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_407_1.var_.characterEffect4040ui_story.fillRatio = var_410_19
				end
			end

			if arg_407_1.time_ >= var_410_16 + var_410_17 and arg_407_1.time_ < var_410_16 + var_410_17 + arg_410_0 and not isNil(var_410_15) and arg_407_1.var_.characterEffect4040ui_story then
				local var_410_20 = 0.5

				arg_407_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_407_1.var_.characterEffect4040ui_story.fillRatio = var_410_20
			end

			local var_410_21 = 0
			local var_410_22 = 0.575

			if var_410_21 < arg_407_1.time_ and arg_407_1.time_ <= var_410_21 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_23 = arg_407_1:FormatText(StoryNameCfg[264].name)

				arg_407_1.leftNameTxt_.text = var_410_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_24 = arg_407_1:GetWordFromCfg(411331096)
				local var_410_25 = arg_407_1:FormatText(var_410_24.content)

				arg_407_1.text_.text = var_410_25

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_26 = 23
				local var_410_27 = utf8.len(var_410_25)
				local var_410_28 = var_410_26 <= 0 and var_410_22 or var_410_22 * (var_410_27 / var_410_26)

				if var_410_28 > 0 and var_410_22 < var_410_28 then
					arg_407_1.talkMaxDuration = var_410_28

					if var_410_28 + var_410_21 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_28 + var_410_21
					end
				end

				arg_407_1.text_.text = var_410_25
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_29 = math.max(var_410_22, arg_407_1.talkMaxDuration)

			if var_410_21 <= arg_407_1.time_ and arg_407_1.time_ < var_410_21 + var_410_29 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_21) / var_410_29

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_21 + var_410_29 and arg_407_1.time_ < var_410_21 + var_410_29 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play411331097 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 411331097
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play411331098(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 1.25

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_2 = arg_411_1:FormatText(StoryNameCfg[264].name)

				arg_411_1.leftNameTxt_.text = var_414_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_3 = arg_411_1:GetWordFromCfg(411331097)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 50
				local var_414_6 = utf8.len(var_414_4)
				local var_414_7 = var_414_5 <= 0 and var_414_1 or var_414_1 * (var_414_6 / var_414_5)

				if var_414_7 > 0 and var_414_1 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play411331098 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 411331098
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play411331099(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_418_1 = 0
			local var_418_2 = 0.35

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_3 = arg_415_1:FormatText(StoryNameCfg[264].name)

				arg_415_1.leftNameTxt_.text = var_418_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:GetWordFromCfg(411331098)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_6 = 14
				local var_418_7 = utf8.len(var_418_5)
				local var_418_8 = var_418_6 <= 0 and var_418_2 or var_418_2 * (var_418_7 / var_418_6)

				if var_418_8 > 0 and var_418_2 < var_418_8 then
					arg_415_1.talkMaxDuration = var_418_8

					if var_418_8 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_9 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_9 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_9

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_9 and arg_415_1.time_ < var_418_1 + var_418_9 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play411331099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 411331099
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play411331100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["10014ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos10014ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, 100, 0)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10014ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, 100, 0)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["10014ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect10014ui_story == nil then
				arg_419_1.var_.characterEffect10014ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect10014ui_story and not isNil(var_422_9) then
					local var_422_13 = Mathf.Lerp(0, 0.5, var_422_12)

					arg_419_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_419_1.var_.characterEffect10014ui_story.fillRatio = var_422_13
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect10014ui_story then
				local var_422_14 = 0.5

				arg_419_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_419_1.var_.characterEffect10014ui_story.fillRatio = var_422_14
			end

			local var_422_15 = arg_419_1.actors_["4040ui_story"].transform
			local var_422_16 = 0

			if var_422_16 < arg_419_1.time_ and arg_419_1.time_ <= var_422_16 + arg_422_0 then
				arg_419_1.var_.moveOldPos4040ui_story = var_422_15.localPosition
			end

			local var_422_17 = 0.001

			if var_422_16 <= arg_419_1.time_ and arg_419_1.time_ < var_422_16 + var_422_17 then
				local var_422_18 = (arg_419_1.time_ - var_422_16) / var_422_17
				local var_422_19 = Vector3.New(0, 100, 0)

				var_422_15.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos4040ui_story, var_422_19, var_422_18)

				local var_422_20 = manager.ui.mainCamera.transform.position - var_422_15.position

				var_422_15.forward = Vector3.New(var_422_20.x, var_422_20.y, var_422_20.z)

				local var_422_21 = var_422_15.localEulerAngles

				var_422_21.z = 0
				var_422_21.x = 0
				var_422_15.localEulerAngles = var_422_21
			end

			if arg_419_1.time_ >= var_422_16 + var_422_17 and arg_419_1.time_ < var_422_16 + var_422_17 + arg_422_0 then
				var_422_15.localPosition = Vector3.New(0, 100, 0)

				local var_422_22 = manager.ui.mainCamera.transform.position - var_422_15.position

				var_422_15.forward = Vector3.New(var_422_22.x, var_422_22.y, var_422_22.z)

				local var_422_23 = var_422_15.localEulerAngles

				var_422_23.z = 0
				var_422_23.x = 0
				var_422_15.localEulerAngles = var_422_23
			end

			local var_422_24 = arg_419_1.actors_["4040ui_story"]
			local var_422_25 = 0

			if var_422_25 < arg_419_1.time_ and arg_419_1.time_ <= var_422_25 + arg_422_0 and not isNil(var_422_24) and arg_419_1.var_.characterEffect4040ui_story == nil then
				arg_419_1.var_.characterEffect4040ui_story = var_422_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_26 = 0.200000002980232

			if var_422_25 <= arg_419_1.time_ and arg_419_1.time_ < var_422_25 + var_422_26 and not isNil(var_422_24) then
				local var_422_27 = (arg_419_1.time_ - var_422_25) / var_422_26

				if arg_419_1.var_.characterEffect4040ui_story and not isNil(var_422_24) then
					local var_422_28 = Mathf.Lerp(0, 0.5, var_422_27)

					arg_419_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_419_1.var_.characterEffect4040ui_story.fillRatio = var_422_28
				end
			end

			if arg_419_1.time_ >= var_422_25 + var_422_26 and arg_419_1.time_ < var_422_25 + var_422_26 + arg_422_0 and not isNil(var_422_24) and arg_419_1.var_.characterEffect4040ui_story then
				local var_422_29 = 0.5

				arg_419_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_419_1.var_.characterEffect4040ui_story.fillRatio = var_422_29
			end

			local var_422_30 = 0
			local var_422_31 = 0.75

			if var_422_30 < arg_419_1.time_ and arg_419_1.time_ <= var_422_30 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_32 = arg_419_1:GetWordFromCfg(411331099)
				local var_422_33 = arg_419_1:FormatText(var_422_32.content)

				arg_419_1.text_.text = var_422_33

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_34 = 30
				local var_422_35 = utf8.len(var_422_33)
				local var_422_36 = var_422_34 <= 0 and var_422_31 or var_422_31 * (var_422_35 / var_422_34)

				if var_422_36 > 0 and var_422_31 < var_422_36 then
					arg_419_1.talkMaxDuration = var_422_36

					if var_422_36 + var_422_30 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_36 + var_422_30
					end
				end

				arg_419_1.text_.text = var_422_33
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_37 = math.max(var_422_31, arg_419_1.talkMaxDuration)

			if var_422_30 <= arg_419_1.time_ and arg_419_1.time_ < var_422_30 + var_422_37 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_30) / var_422_37

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_30 + var_422_37 and arg_419_1.time_ < var_422_30 + var_422_37 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play411331100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 411331100
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play411331101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.45

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[908].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(411331100)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 18
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_8 and arg_423_1.time_ < var_426_0 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play411331101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 411331101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play411331102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.55

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[907].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(411331101)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 22
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_8 and arg_427_1.time_ < var_430_0 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play411331102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 411331102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play411331103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 1.425

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(411331102)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 57
				local var_434_5 = utf8.len(var_434_3)
				local var_434_6 = var_434_4 <= 0 and var_434_1 or var_434_1 * (var_434_5 / var_434_4)

				if var_434_6 > 0 and var_434_1 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_7 and arg_431_1.time_ < var_434_0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play411331103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 411331103
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play411331104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.25

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[907].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:GetWordFromCfg(411331103)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 10
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_8 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_8 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_8

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_8 and arg_435_1.time_ < var_438_0 + var_438_8 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play411331104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 411331104
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play411331105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.35

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(411331104)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 14
				local var_442_5 = utf8.len(var_442_3)
				local var_442_6 = var_442_4 <= 0 and var_442_1 or var_442_1 * (var_442_5 / var_442_4)

				if var_442_6 > 0 and var_442_1 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_7 and arg_439_1.time_ < var_442_0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play411331105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 411331105
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play411331106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = manager.ui.mainCamera.transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				local var_446_2 = arg_443_1.var_.effect888
				local var_446_3
				local var_446_4 = var_446_0

				if not var_446_2 then
					var_446_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), var_446_4)
					var_446_2.name = "888"
					arg_443_1.var_.effect888 = var_446_2
				else
					var_446_2.transform:SetParent(var_446_4)
				end

				var_446_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_446_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_446_5 = manager.ui.mainCamera.transform
			local var_446_6 = 1.06666666666667

			if var_446_6 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				local var_446_7 = arg_443_1.var_.effect999
				local var_446_8
				local var_446_9 = var_446_5

				if not var_446_7 then
					var_446_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_446_9)
					var_446_7.name = "999"
					arg_443_1.var_.effect999 = var_446_7
				else
					var_446_7.transform:SetParent(var_446_9)
				end

				var_446_7.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_446_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_446_10 = manager.ui.mainCamera.transform
			local var_446_11 = 1.73333333333333

			if var_446_11 < arg_443_1.time_ and arg_443_1.time_ <= var_446_11 + arg_446_0 then
				local var_446_12 = arg_443_1.var_.effect999

				if var_446_12 then
					Object.Destroy(var_446_12)

					arg_443_1.var_.effect999 = nil
				end
			end

			local var_446_13 = 0

			if var_446_13 < arg_443_1.time_ and arg_443_1.time_ <= var_446_13 + arg_446_0 then
				arg_443_1.allBtn_.enabled = false
			end

			local var_446_14 = 2

			if arg_443_1.time_ >= var_446_13 + var_446_14 and arg_443_1.time_ < var_446_13 + var_446_14 + arg_446_0 then
				arg_443_1.allBtn_.enabled = true
			end

			local var_446_15 = manager.ui.mainCamera.transform
			local var_446_16 = 0

			if var_446_16 < arg_443_1.time_ and arg_443_1.time_ <= var_446_16 + arg_446_0 then
				arg_443_1.var_.shakeOldPos = var_446_15.localPosition
			end

			local var_446_17 = 2

			if var_446_16 <= arg_443_1.time_ and arg_443_1.time_ < var_446_16 + var_446_17 then
				local var_446_18 = (arg_443_1.time_ - var_446_16) / 0.066
				local var_446_19, var_446_20 = math.modf(var_446_18)

				var_446_15.localPosition = Vector3.New(var_446_20 * 0.13, var_446_20 * 0.13, var_446_20 * 0.13) + arg_443_1.var_.shakeOldPos
			end

			if arg_443_1.time_ >= var_446_16 + var_446_17 and arg_443_1.time_ < var_446_16 + var_446_17 + arg_446_0 then
				var_446_15.localPosition = arg_443_1.var_.shakeOldPos
			end

			local var_446_21 = 0
			local var_446_22 = 1

			if var_446_21 < arg_443_1.time_ and arg_443_1.time_ <= var_446_21 + arg_446_0 then
				local var_446_23 = "play"
				local var_446_24 = "effect"

				arg_443_1:AudioAction(var_446_23, var_446_24, "se_story_1211", "se_story_1211_stab2", "")
			end

			local var_446_25 = 0
			local var_446_26 = 1.475

			if var_446_25 < arg_443_1.time_ and arg_443_1.time_ <= var_446_25 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0

				arg_443_1.dialog_:SetActive(true)

				arg_443_1.dialogCg_.alpha = 0

				local var_446_27 = LeanTween.value(arg_443_1.dialog_, 0, 1, 0.3)

				var_446_27:setOnUpdate(LuaHelper.FloatAction(function(arg_447_0)
					arg_443_1.dialogCg_.alpha = arg_447_0
				end))
				var_446_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_443_1.dialog_)
					var_446_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_443_1.duration_ = arg_443_1.duration_ + 0.3

				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_28 = arg_443_1:GetWordFromCfg(411331105)
				local var_446_29 = arg_443_1:FormatText(var_446_28.content)

				arg_443_1.text_.text = var_446_29

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_30 = 59
				local var_446_31 = utf8.len(var_446_29)
				local var_446_32 = var_446_30 <= 0 and var_446_26 or var_446_26 * (var_446_31 / var_446_30)

				if var_446_32 > 0 and var_446_26 < var_446_32 then
					arg_443_1.talkMaxDuration = var_446_32
					var_446_25 = var_446_25 + 0.3

					if var_446_32 + var_446_25 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_32 + var_446_25
					end
				end

				arg_443_1.text_.text = var_446_29
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_33 = var_446_25 + 0.3
			local var_446_34 = math.max(var_446_26, arg_443_1.talkMaxDuration)

			if var_446_33 <= arg_443_1.time_ and arg_443_1.time_ < var_446_33 + var_446_34 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_33) / var_446_34

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_33 + var_446_34 and arg_443_1.time_ < var_446_33 + var_446_34 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play411331106 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 411331106
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play411331107(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["4040ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos4040ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, -1.55, -5.5)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos4040ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["4040ui_story"]
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect4040ui_story == nil then
				arg_449_1.var_.characterEffect4040ui_story = var_452_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_11 = 0.200000002980232

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 and not isNil(var_452_9) then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11

				if arg_449_1.var_.characterEffect4040ui_story and not isNil(var_452_9) then
					arg_449_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect4040ui_story then
				arg_449_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_452_13 = manager.ui.mainCamera.transform
			local var_452_14 = 0

			if var_452_14 < arg_449_1.time_ and arg_449_1.time_ <= var_452_14 + arg_452_0 then
				local var_452_15 = arg_449_1.var_.effect888

				if var_452_15 then
					Object.Destroy(var_452_15)

					arg_449_1.var_.effect888 = nil
				end
			end

			local var_452_16 = manager.ui.mainCamera.transform
			local var_452_17 = 0

			if var_452_17 < arg_449_1.time_ and arg_449_1.time_ <= var_452_17 + arg_452_0 then
				local var_452_18 = arg_449_1.var_.effect999

				if var_452_18 then
					Object.Destroy(var_452_18)

					arg_449_1.var_.effect999 = nil
				end
			end

			local var_452_19 = 0
			local var_452_20 = 0.125

			if var_452_19 < arg_449_1.time_ and arg_449_1.time_ <= var_452_19 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_21 = arg_449_1:FormatText(StoryNameCfg[905].name)

				arg_449_1.leftNameTxt_.text = var_452_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_22 = arg_449_1:GetWordFromCfg(411331106)
				local var_452_23 = arg_449_1:FormatText(var_452_22.content)

				arg_449_1.text_.text = var_452_23

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_24 = 5
				local var_452_25 = utf8.len(var_452_23)
				local var_452_26 = var_452_24 <= 0 and var_452_20 or var_452_20 * (var_452_25 / var_452_24)

				if var_452_26 > 0 and var_452_20 < var_452_26 then
					arg_449_1.talkMaxDuration = var_452_26

					if var_452_26 + var_452_19 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_26 + var_452_19
					end
				end

				arg_449_1.text_.text = var_452_23
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_27 = math.max(var_452_20, arg_449_1.talkMaxDuration)

			if var_452_19 <= arg_449_1.time_ and arg_449_1.time_ < var_452_19 + var_452_27 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_19) / var_452_27

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_19 + var_452_27 and arg_449_1.time_ < var_452_19 + var_452_27 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play411331107 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 411331107
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play411331108(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["4040ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos4040ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, 100, 0)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos4040ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, 100, 0)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["4040ui_story"]
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect4040ui_story == nil then
				arg_453_1.var_.characterEffect4040ui_story = var_456_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_11 = 0.200000002980232

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 and not isNil(var_456_9) then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11

				if arg_453_1.var_.characterEffect4040ui_story and not isNil(var_456_9) then
					local var_456_13 = Mathf.Lerp(0, 0.5, var_456_12)

					arg_453_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_453_1.var_.characterEffect4040ui_story.fillRatio = var_456_13
				end
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect4040ui_story then
				local var_456_14 = 0.5

				arg_453_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_453_1.var_.characterEffect4040ui_story.fillRatio = var_456_14
			end

			local var_456_15 = 0
			local var_456_16 = 1.125

			if var_456_15 < arg_453_1.time_ and arg_453_1.time_ <= var_456_15 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_17 = arg_453_1:GetWordFromCfg(411331107)
				local var_456_18 = arg_453_1:FormatText(var_456_17.content)

				arg_453_1.text_.text = var_456_18

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_19 = 45
				local var_456_20 = utf8.len(var_456_18)
				local var_456_21 = var_456_19 <= 0 and var_456_16 or var_456_16 * (var_456_20 / var_456_19)

				if var_456_21 > 0 and var_456_16 < var_456_21 then
					arg_453_1.talkMaxDuration = var_456_21

					if var_456_21 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_21 + var_456_15
					end
				end

				arg_453_1.text_.text = var_456_18
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_22 = math.max(var_456_16, arg_453_1.talkMaxDuration)

			if var_456_15 <= arg_453_1.time_ and arg_453_1.time_ < var_456_15 + var_456_22 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_15) / var_456_22

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_15 + var_456_22 and arg_453_1.time_ < var_456_15 + var_456_22 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play411331108 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 411331108
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play411331109(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 1.425

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(411331108)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 57
				local var_460_5 = utf8.len(var_460_3)
				local var_460_6 = var_460_4 <= 0 and var_460_1 or var_460_1 * (var_460_5 / var_460_4)

				if var_460_6 > 0 and var_460_1 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_7 and arg_457_1.time_ < var_460_0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play411331109 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 411331109
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play411331110(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.625

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_2 = arg_461_1:GetWordFromCfg(411331109)
				local var_464_3 = arg_461_1:FormatText(var_464_2.content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 25
				local var_464_5 = utf8.len(var_464_3)
				local var_464_6 = var_464_4 <= 0 and var_464_1 or var_464_1 * (var_464_5 / var_464_4)

				if var_464_6 > 0 and var_464_1 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_7 and arg_461_1.time_ < var_464_0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play411331110 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 411331110
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play411331111(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["4040ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos4040ui_story = var_468_0.localPosition
			end

			local var_468_2 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2
				local var_468_4 = Vector3.New(0, 100, 0)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos4040ui_story, var_468_4, var_468_3)

				local var_468_5 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_5.x, var_468_5.y, var_468_5.z)

				local var_468_6 = var_468_0.localEulerAngles

				var_468_6.z = 0
				var_468_6.x = 0
				var_468_0.localEulerAngles = var_468_6
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, 100, 0)

				local var_468_7 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_7.x, var_468_7.y, var_468_7.z)

				local var_468_8 = var_468_0.localEulerAngles

				var_468_8.z = 0
				var_468_8.x = 0
				var_468_0.localEulerAngles = var_468_8
			end

			local var_468_9 = arg_465_1.actors_["4040ui_story"]
			local var_468_10 = 0

			if var_468_10 < arg_465_1.time_ and arg_465_1.time_ <= var_468_10 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect4040ui_story == nil then
				arg_465_1.var_.characterEffect4040ui_story = var_468_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_11 = 0.200000002980232

			if var_468_10 <= arg_465_1.time_ and arg_465_1.time_ < var_468_10 + var_468_11 and not isNil(var_468_9) then
				local var_468_12 = (arg_465_1.time_ - var_468_10) / var_468_11

				if arg_465_1.var_.characterEffect4040ui_story and not isNil(var_468_9) then
					arg_465_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_10 + var_468_11 and arg_465_1.time_ < var_468_10 + var_468_11 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect4040ui_story then
				arg_465_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_468_13 = manager.ui.mainCamera.transform
			local var_468_14 = 0

			if var_468_14 < arg_465_1.time_ and arg_465_1.time_ <= var_468_14 + arg_468_0 then
				arg_465_1.var_.shakeOldPos = var_468_13.localPosition
			end

			local var_468_15 = 0.6

			if var_468_14 <= arg_465_1.time_ and arg_465_1.time_ < var_468_14 + var_468_15 then
				local var_468_16 = (arg_465_1.time_ - var_468_14) / 0.066
				local var_468_17, var_468_18 = math.modf(var_468_16)

				var_468_13.localPosition = Vector3.New(var_468_18 * 0.13, var_468_18 * 0.13, var_468_18 * 0.13) + arg_465_1.var_.shakeOldPos
			end

			if arg_465_1.time_ >= var_468_14 + var_468_15 and arg_465_1.time_ < var_468_14 + var_468_15 + arg_468_0 then
				var_468_13.localPosition = arg_465_1.var_.shakeOldPos
			end

			local var_468_19 = 0

			if var_468_19 < arg_465_1.time_ and arg_465_1.time_ <= var_468_19 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			local var_468_20 = 0.6

			if arg_465_1.time_ >= var_468_19 + var_468_20 and arg_465_1.time_ < var_468_19 + var_468_20 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			local var_468_21 = 0
			local var_468_22 = 0.225

			if var_468_21 < arg_465_1.time_ and arg_465_1.time_ <= var_468_21 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_23 = arg_465_1:FormatText(StoryNameCfg[905].name)

				arg_465_1.leftNameTxt_.text = var_468_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_24 = arg_465_1:GetWordFromCfg(411331110)
				local var_468_25 = arg_465_1:FormatText(var_468_24.content)

				arg_465_1.text_.text = var_468_25

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_26 = 9
				local var_468_27 = utf8.len(var_468_25)
				local var_468_28 = var_468_26 <= 0 and var_468_22 or var_468_22 * (var_468_27 / var_468_26)

				if var_468_28 > 0 and var_468_22 < var_468_28 then
					arg_465_1.talkMaxDuration = var_468_28

					if var_468_28 + var_468_21 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_28 + var_468_21
					end
				end

				arg_465_1.text_.text = var_468_25
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_29 = math.max(var_468_22, arg_465_1.talkMaxDuration)

			if var_468_21 <= arg_465_1.time_ and arg_465_1.time_ < var_468_21 + var_468_29 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_21) / var_468_29

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_21 + var_468_29 and arg_465_1.time_ < var_468_21 + var_468_29 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play411331111 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 411331111
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play411331112(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["4040ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos4040ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0, 100, 0)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos4040ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0, 100, 0)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["4040ui_story"]
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect4040ui_story == nil then
				arg_469_1.var_.characterEffect4040ui_story = var_472_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_11 = 0.200000002980232

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 and not isNil(var_472_9) then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11

				if arg_469_1.var_.characterEffect4040ui_story and not isNil(var_472_9) then
					local var_472_13 = Mathf.Lerp(0, 0.5, var_472_12)

					arg_469_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_469_1.var_.characterEffect4040ui_story.fillRatio = var_472_13
				end
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect4040ui_story then
				local var_472_14 = 0.5

				arg_469_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_469_1.var_.characterEffect4040ui_story.fillRatio = var_472_14
			end

			local var_472_15 = 0
			local var_472_16 = 0.225

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_17 = arg_469_1:GetWordFromCfg(411331111)
				local var_472_18 = arg_469_1:FormatText(var_472_17.content)

				arg_469_1.text_.text = var_472_18

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_19 = 9
				local var_472_20 = utf8.len(var_472_18)
				local var_472_21 = var_472_19 <= 0 and var_472_16 or var_472_16 * (var_472_20 / var_472_19)

				if var_472_21 > 0 and var_472_16 < var_472_21 then
					arg_469_1.talkMaxDuration = var_472_21

					if var_472_21 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_21 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_18
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_22 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_22 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_22

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_22 and arg_469_1.time_ < var_472_15 + var_472_22 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play411331112 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 411331112
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play411331113(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.3

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(411331112)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 12
				local var_476_5 = utf8.len(var_476_3)
				local var_476_6 = var_476_4 <= 0 and var_476_1 or var_476_1 * (var_476_5 / var_476_4)

				if var_476_6 > 0 and var_476_1 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_7 and arg_473_1.time_ < var_476_0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play411331113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 411331113
		arg_477_1.duration_ = 5.85

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play411331114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = manager.ui.mainCamera.transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.shakeOldPos = var_480_0.localPosition
			end

			local var_480_2 = 0.566666666666667

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / 0.066
				local var_480_4, var_480_5 = math.modf(var_480_3)

				var_480_0.localPosition = Vector3.New(var_480_5 * 0.13, var_480_5 * 0.13, var_480_5 * 0.13) + arg_477_1.var_.shakeOldPos
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = arg_477_1.var_.shakeOldPos
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_6 = 0.85
			local var_480_7 = 0.15

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_8 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_8:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_9 = arg_477_1:FormatText(StoryNameCfg[904].name)

				arg_477_1.leftNameTxt_.text = var_480_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_10 = arg_477_1:GetWordFromCfg(411331113)
				local var_480_11 = arg_477_1:FormatText(var_480_10.content)

				arg_477_1.text_.text = var_480_11

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_12 = 6
				local var_480_13 = utf8.len(var_480_11)
				local var_480_14 = var_480_12 <= 0 and var_480_7 or var_480_7 * (var_480_13 / var_480_12)

				if var_480_14 > 0 and var_480_7 < var_480_14 then
					arg_477_1.talkMaxDuration = var_480_14
					var_480_6 = var_480_6 + 0.3

					if var_480_14 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_14 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_11
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_15 = var_480_6 + 0.3
			local var_480_16 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_15 <= arg_477_1.time_ and arg_477_1.time_ < var_480_15 + var_480_16 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_15) / var_480_16

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_15 + var_480_16 and arg_477_1.time_ < var_480_15 + var_480_16 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play411331114 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 411331114
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play411331115(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.275

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(411331114)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 51
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play411331115 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 411331115
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play411331116(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.175

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[907].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(411331115)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 7
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_8 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_8 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_8

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_8 and arg_487_1.time_ < var_490_0 + var_490_8 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play411331116 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 411331116
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play411331117(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.9

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_2 = arg_491_1:GetWordFromCfg(411331116)
				local var_494_3 = arg_491_1:FormatText(var_494_2.content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 36
				local var_494_5 = utf8.len(var_494_3)
				local var_494_6 = var_494_4 <= 0 and var_494_1 or var_494_1 * (var_494_5 / var_494_4)

				if var_494_6 > 0 and var_494_1 < var_494_6 then
					arg_491_1.talkMaxDuration = var_494_6

					if var_494_6 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_6 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_7 and arg_491_1.time_ < var_494_0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play411331117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 411331117
		arg_495_1.duration_ = 5.57

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play411331118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.mask_.enabled = true
				arg_495_1.mask_.raycastTarget = false

				arg_495_1:SetGaussion(false)
			end

			local var_498_1 = 0.466666666666667

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_1 then
				local var_498_2 = (arg_495_1.time_ - var_498_0) / var_498_1
				local var_498_3 = Color.New(0.9811321, 0.06016379, 0.06016379)

				var_498_3.a = Mathf.Lerp(1, 0, var_498_2)
				arg_495_1.mask_.color = var_498_3
			end

			if arg_495_1.time_ >= var_498_0 + var_498_1 and arg_495_1.time_ < var_498_0 + var_498_1 + arg_498_0 then
				local var_498_4 = Color.New(0.9811321, 0.06016379, 0.06016379)
				local var_498_5 = 0

				arg_495_1.mask_.enabled = false
				var_498_4.a = var_498_5
				arg_495_1.mask_.color = var_498_4
			end

			if arg_495_1.frameCnt_ <= 1 then
				arg_495_1.dialog_:SetActive(false)
			end

			local var_498_6 = 0.566666666666667
			local var_498_7 = 1.375

			if var_498_6 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0

				arg_495_1.dialog_:SetActive(true)

				arg_495_1.dialogCg_.alpha = 0

				local var_498_8 = LeanTween.value(arg_495_1.dialog_, 0, 1, 0.3)

				var_498_8:setOnUpdate(LuaHelper.FloatAction(function(arg_499_0)
					arg_495_1.dialogCg_.alpha = arg_499_0
				end))
				var_498_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_495_1.dialog_)
					var_498_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_495_1.duration_ = arg_495_1.duration_ + 0.3

				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_9 = arg_495_1:GetWordFromCfg(411331117)
				local var_498_10 = arg_495_1:FormatText(var_498_9.content)

				arg_495_1.text_.text = var_498_10

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_11 = 55
				local var_498_12 = utf8.len(var_498_10)
				local var_498_13 = var_498_11 <= 0 and var_498_7 or var_498_7 * (var_498_12 / var_498_11)

				if var_498_13 > 0 and var_498_7 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13
					var_498_6 = var_498_6 + 0.3

					if var_498_13 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_6
					end
				end

				arg_495_1.text_.text = var_498_10
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_14 = var_498_6 + 0.3
			local var_498_15 = math.max(var_498_7, arg_495_1.talkMaxDuration)

			if var_498_14 <= arg_495_1.time_ and arg_495_1.time_ < var_498_14 + var_498_15 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_14) / var_498_15

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_14 + var_498_15 and arg_495_1.time_ < var_498_14 + var_498_15 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play411331118 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 411331118
		arg_501_1.duration_ = 5.83

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play411331119(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				local var_504_1 = manager.ui.mainCamera.transform.localPosition
				local var_504_2 = Vector3.New(0, 0, 10) + Vector3.New(var_504_1.x, var_504_1.y, 0)
				local var_504_3 = arg_501_1.bgs_.STblack

				var_504_3.transform.localPosition = var_504_2
				var_504_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_504_4 = var_504_3:GetComponent("SpriteRenderer")

				if var_504_4 and var_504_4.sprite then
					local var_504_5 = (var_504_3.transform.localPosition - var_504_1).z
					local var_504_6 = manager.ui.mainCameraCom_
					local var_504_7 = 2 * var_504_5 * Mathf.Tan(var_504_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_504_8 = var_504_7 * var_504_6.aspect
					local var_504_9 = var_504_4.sprite.bounds.size.x
					local var_504_10 = var_504_4.sprite.bounds.size.y
					local var_504_11 = var_504_8 / var_504_9
					local var_504_12 = var_504_7 / var_504_10
					local var_504_13 = var_504_12 < var_504_11 and var_504_11 or var_504_12

					var_504_3.transform.localScale = Vector3.New(var_504_13, var_504_13, 0)
				end

				for iter_504_0, iter_504_1 in pairs(arg_501_1.bgs_) do
					if iter_504_0 ~= "STblack" then
						iter_504_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_504_14 = 0

			if var_504_14 < arg_501_1.time_ and arg_501_1.time_ <= var_504_14 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_15 = 0.933333333333333

			if var_504_14 <= arg_501_1.time_ and arg_501_1.time_ < var_504_14 + var_504_15 then
				local var_504_16 = (arg_501_1.time_ - var_504_14) / var_504_15
				local var_504_17 = Color.New(1, 1, 1)

				var_504_17.a = Mathf.Lerp(1, 0, var_504_16)
				arg_501_1.mask_.color = var_504_17
			end

			if arg_501_1.time_ >= var_504_14 + var_504_15 and arg_501_1.time_ < var_504_14 + var_504_15 + arg_504_0 then
				local var_504_18 = Color.New(1, 1, 1)
				local var_504_19 = 0

				arg_501_1.mask_.enabled = false
				var_504_18.a = var_504_19
				arg_501_1.mask_.color = var_504_18
			end

			local var_504_20 = manager.ui.mainCamera.transform
			local var_504_21 = 0

			if var_504_21 < arg_501_1.time_ and arg_501_1.time_ <= var_504_21 + arg_504_0 then
				arg_501_1.var_.shakeOldPos = var_504_20.localPosition
			end

			local var_504_22 = 0.633333333333333

			if var_504_21 <= arg_501_1.time_ and arg_501_1.time_ < var_504_21 + var_504_22 then
				local var_504_23 = (arg_501_1.time_ - var_504_21) / 0.066
				local var_504_24, var_504_25 = math.modf(var_504_23)

				var_504_20.localPosition = Vector3.New(var_504_25 * 0.13, var_504_25 * 0.13, var_504_25 * 0.13) + arg_501_1.var_.shakeOldPos
			end

			if arg_501_1.time_ >= var_504_21 + var_504_22 and arg_501_1.time_ < var_504_21 + var_504_22 + arg_504_0 then
				var_504_20.localPosition = arg_501_1.var_.shakeOldPos
			end

			local var_504_26 = 0
			local var_504_27 = 0.4

			if var_504_26 < arg_501_1.time_ and arg_501_1.time_ <= var_504_26 + arg_504_0 then
				local var_504_28 = "play"
				local var_504_29 = "effect"

				arg_501_1:AudioAction(var_504_28, var_504_29, "se_story_128", "se_story_128_stab", "")
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_30 = 0.833333333333333
			local var_504_31 = 0.325

			if var_504_30 < arg_501_1.time_ and arg_501_1.time_ <= var_504_30 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_32 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_32:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_33 = arg_501_1:FormatText(StoryNameCfg[908].name)

				arg_501_1.leftNameTxt_.text = var_504_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_34 = arg_501_1:GetWordFromCfg(411331118)
				local var_504_35 = arg_501_1:FormatText(var_504_34.content)

				arg_501_1.text_.text = var_504_35

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_36 = 13
				local var_504_37 = utf8.len(var_504_35)
				local var_504_38 = var_504_36 <= 0 and var_504_31 or var_504_31 * (var_504_37 / var_504_36)

				if var_504_38 > 0 and var_504_31 < var_504_38 then
					arg_501_1.talkMaxDuration = var_504_38
					var_504_30 = var_504_30 + 0.3

					if var_504_38 + var_504_30 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_38 + var_504_30
					end
				end

				arg_501_1.text_.text = var_504_35
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_39 = var_504_30 + 0.3
			local var_504_40 = math.max(var_504_31, arg_501_1.talkMaxDuration)

			if var_504_39 <= arg_501_1.time_ and arg_501_1.time_ < var_504_39 + var_504_40 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_39) / var_504_40

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_39 + var_504_40 and arg_501_1.time_ < var_504_39 + var_504_40 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play411331119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 411331119
		arg_507_1.duration_ = 5.43

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play411331120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = manager.ui.mainCamera.transform
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.var_.shakeOldPos = var_510_0.localPosition
			end

			local var_510_2 = 0.633333333333333

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / 0.066
				local var_510_4, var_510_5 = math.modf(var_510_3)

				var_510_0.localPosition = Vector3.New(var_510_5 * 0.13, var_510_5 * 0.13, var_510_5 * 0.13) + arg_507_1.var_.shakeOldPos
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 then
				var_510_0.localPosition = arg_507_1.var_.shakeOldPos
			end

			local var_510_6 = 0
			local var_510_7 = 0.4

			if var_510_6 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				local var_510_8 = "play"
				local var_510_9 = "effect"

				arg_507_1:AudioAction(var_510_8, var_510_9, "se_story_1211", "se_story_1211_stab2", "")
			end

			if arg_507_1.frameCnt_ <= 1 then
				arg_507_1.dialog_:SetActive(false)
			end

			local var_510_10 = 0.433333333333333
			local var_510_11 = 0.3

			if var_510_10 < arg_507_1.time_ and arg_507_1.time_ <= var_510_10 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_12 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_12:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_13 = arg_507_1:FormatText(StoryNameCfg[907].name)

				arg_507_1.leftNameTxt_.text = var_510_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_14 = arg_507_1:GetWordFromCfg(411331119)
				local var_510_15 = arg_507_1:FormatText(var_510_14.content)

				arg_507_1.text_.text = var_510_15

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_16 = 12
				local var_510_17 = utf8.len(var_510_15)
				local var_510_18 = var_510_16 <= 0 and var_510_11 or var_510_11 * (var_510_17 / var_510_16)

				if var_510_18 > 0 and var_510_11 < var_510_18 then
					arg_507_1.talkMaxDuration = var_510_18
					var_510_10 = var_510_10 + 0.3

					if var_510_18 + var_510_10 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_18 + var_510_10
					end
				end

				arg_507_1.text_.text = var_510_15
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_19 = var_510_10 + 0.3
			local var_510_20 = math.max(var_510_11, arg_507_1.talkMaxDuration)

			if var_510_19 <= arg_507_1.time_ and arg_507_1.time_ < var_510_19 + var_510_20 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_19) / var_510_20

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_19 + var_510_20 and arg_507_1.time_ < var_510_19 + var_510_20 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play411331120 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 411331120
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play411331121(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.05

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_2 = arg_513_1:GetWordFromCfg(411331120)
				local var_516_3 = arg_513_1:FormatText(var_516_2.content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 2
				local var_516_5 = utf8.len(var_516_3)
				local var_516_6 = var_516_4 <= 0 and var_516_1 or var_516_1 * (var_516_5 / var_516_4)

				if var_516_6 > 0 and var_516_1 < var_516_6 then
					arg_513_1.talkMaxDuration = var_516_6

					if var_516_6 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_6 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_7 and arg_513_1.time_ < var_516_0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play411331121 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 411331121
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play411331122(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.275

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_2 = arg_517_1:GetWordFromCfg(411331121)
				local var_520_3 = arg_517_1:FormatText(var_520_2.content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 11
				local var_520_5 = utf8.len(var_520_3)
				local var_520_6 = var_520_4 <= 0 and var_520_1 or var_520_1 * (var_520_5 / var_520_4)

				if var_520_6 > 0 and var_520_1 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_7 and arg_517_1.time_ < var_520_0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play411331122 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 411331122
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play411331123(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.125

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_2 = arg_521_1:GetWordFromCfg(411331122)
				local var_524_3 = arg_521_1:FormatText(var_524_2.content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 5
				local var_524_5 = utf8.len(var_524_3)
				local var_524_6 = var_524_4 <= 0 and var_524_1 or var_524_1 * (var_524_5 / var_524_4)

				if var_524_6 > 0 and var_524_1 < var_524_6 then
					arg_521_1.talkMaxDuration = var_524_6

					if var_524_6 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_6 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_7 and arg_521_1.time_ < var_524_0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play411331123 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 411331123
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play411331124(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 0.2

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_2 = arg_525_1:GetWordFromCfg(411331123)
				local var_528_3 = arg_525_1:FormatText(var_528_2.content)

				arg_525_1.text_.text = var_528_3

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 8
				local var_528_5 = utf8.len(var_528_3)
				local var_528_6 = var_528_4 <= 0 and var_528_1 or var_528_1 * (var_528_5 / var_528_4)

				if var_528_6 > 0 and var_528_1 < var_528_6 then
					arg_525_1.talkMaxDuration = var_528_6

					if var_528_6 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_6 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_3
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_7 and arg_525_1.time_ < var_528_0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play411331124 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 411331124
		arg_529_1.duration_ = 9

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play411331125(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 2

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				local var_532_1 = manager.ui.mainCamera.transform.localPosition
				local var_532_2 = Vector3.New(0, 0, 10) + Vector3.New(var_532_1.x, var_532_1.y, 0)
				local var_532_3 = arg_529_1.bgs_.D10

				var_532_3.transform.localPosition = var_532_2
				var_532_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_532_4 = var_532_3:GetComponent("SpriteRenderer")

				if var_532_4 and var_532_4.sprite then
					local var_532_5 = (var_532_3.transform.localPosition - var_532_1).z
					local var_532_6 = manager.ui.mainCameraCom_
					local var_532_7 = 2 * var_532_5 * Mathf.Tan(var_532_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_532_8 = var_532_7 * var_532_6.aspect
					local var_532_9 = var_532_4.sprite.bounds.size.x
					local var_532_10 = var_532_4.sprite.bounds.size.y
					local var_532_11 = var_532_8 / var_532_9
					local var_532_12 = var_532_7 / var_532_10
					local var_532_13 = var_532_12 < var_532_11 and var_532_11 or var_532_12

					var_532_3.transform.localScale = Vector3.New(var_532_13, var_532_13, 0)
				end

				for iter_532_0, iter_532_1 in pairs(arg_529_1.bgs_) do
					if iter_532_0 ~= "D10" then
						iter_532_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_532_14 = 0

			if var_532_14 < arg_529_1.time_ and arg_529_1.time_ <= var_532_14 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_15 = 2

			if var_532_14 <= arg_529_1.time_ and arg_529_1.time_ < var_532_14 + var_532_15 then
				local var_532_16 = (arg_529_1.time_ - var_532_14) / var_532_15
				local var_532_17 = Color.New(0, 0, 0)

				var_532_17.a = Mathf.Lerp(1, 0, var_532_16)
				arg_529_1.mask_.color = var_532_17
			end

			if arg_529_1.time_ >= var_532_14 + var_532_15 and arg_529_1.time_ < var_532_14 + var_532_15 + arg_532_0 then
				local var_532_18 = Color.New(0, 0, 0)
				local var_532_19 = 0

				arg_529_1.mask_.enabled = false
				var_532_18.a = var_532_19
				arg_529_1.mask_.color = var_532_18
			end

			local var_532_20 = 2

			if var_532_20 < arg_529_1.time_ and arg_529_1.time_ <= var_532_20 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_21 = 2

			if var_532_20 <= arg_529_1.time_ and arg_529_1.time_ < var_532_20 + var_532_21 then
				local var_532_22 = (arg_529_1.time_ - var_532_20) / var_532_21
				local var_532_23 = Color.New(0, 0, 0)

				var_532_23.a = Mathf.Lerp(1, 0, var_532_22)
				arg_529_1.mask_.color = var_532_23
			end

			if arg_529_1.time_ >= var_532_20 + var_532_21 and arg_529_1.time_ < var_532_20 + var_532_21 + arg_532_0 then
				local var_532_24 = Color.New(0, 0, 0)
				local var_532_25 = 0

				arg_529_1.mask_.enabled = false
				var_532_24.a = var_532_25
				arg_529_1.mask_.color = var_532_24
			end

			if arg_529_1.frameCnt_ <= 1 then
				arg_529_1.dialog_:SetActive(false)
			end

			local var_532_26 = 4
			local var_532_27 = 0.775

			if var_532_26 < arg_529_1.time_ and arg_529_1.time_ <= var_532_26 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0

				arg_529_1.dialog_:SetActive(true)

				arg_529_1.dialogCg_.alpha = 0

				local var_532_28 = LeanTween.value(arg_529_1.dialog_, 0, 1, 0.3)

				var_532_28:setOnUpdate(LuaHelper.FloatAction(function(arg_533_0)
					arg_529_1.dialogCg_.alpha = arg_533_0
				end))
				var_532_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_529_1.dialog_)
					var_532_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_529_1.duration_ = arg_529_1.duration_ + 0.3

				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_29 = arg_529_1:GetWordFromCfg(411331124)
				local var_532_30 = arg_529_1:FormatText(var_532_29.content)

				arg_529_1.text_.text = var_532_30

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_31 = 31
				local var_532_32 = utf8.len(var_532_30)
				local var_532_33 = var_532_31 <= 0 and var_532_27 or var_532_27 * (var_532_32 / var_532_31)

				if var_532_33 > 0 and var_532_27 < var_532_33 then
					arg_529_1.talkMaxDuration = var_532_33
					var_532_26 = var_532_26 + 0.3

					if var_532_33 + var_532_26 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_33 + var_532_26
					end
				end

				arg_529_1.text_.text = var_532_30
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_34 = var_532_26 + 0.3
			local var_532_35 = math.max(var_532_27, arg_529_1.talkMaxDuration)

			if var_532_34 <= arg_529_1.time_ and arg_529_1.time_ < var_532_34 + var_532_35 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_34) / var_532_35

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_34 + var_532_35 and arg_529_1.time_ < var_532_34 + var_532_35 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play411331125 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 411331125
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play411331126(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 1.375

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_2 = arg_535_1:GetWordFromCfg(411331125)
				local var_538_3 = arg_535_1:FormatText(var_538_2.content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 55
				local var_538_5 = utf8.len(var_538_3)
				local var_538_6 = var_538_4 <= 0 and var_538_1 or var_538_1 * (var_538_5 / var_538_4)

				if var_538_6 > 0 and var_538_1 < var_538_6 then
					arg_535_1.talkMaxDuration = var_538_6

					if var_538_6 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_6 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_7 and arg_535_1.time_ < var_538_0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play411331126 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 411331126
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play411331127(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 1.3

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_2 = arg_539_1:GetWordFromCfg(411331126)
				local var_542_3 = arg_539_1:FormatText(var_542_2.content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 52
				local var_542_5 = utf8.len(var_542_3)
				local var_542_6 = var_542_4 <= 0 and var_542_1 or var_542_1 * (var_542_5 / var_542_4)

				if var_542_6 > 0 and var_542_1 < var_542_6 then
					arg_539_1.talkMaxDuration = var_542_6

					if var_542_6 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_6 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_7 and arg_539_1.time_ < var_542_0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play411331127 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 411331127
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play411331128(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["4040ui_story"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos4040ui_story = var_546_0.localPosition
			end

			local var_546_2 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2
				local var_546_4 = Vector3.New(0, -1.55, -5.5)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos4040ui_story, var_546_4, var_546_3)

				local var_546_5 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_5.x, var_546_5.y, var_546_5.z)

				local var_546_6 = var_546_0.localEulerAngles

				var_546_6.z = 0
				var_546_6.x = 0
				var_546_0.localEulerAngles = var_546_6
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_546_7 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_7.x, var_546_7.y, var_546_7.z)

				local var_546_8 = var_546_0.localEulerAngles

				var_546_8.z = 0
				var_546_8.x = 0
				var_546_0.localEulerAngles = var_546_8
			end

			local var_546_9 = arg_543_1.actors_["4040ui_story"]
			local var_546_10 = 0

			if var_546_10 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect4040ui_story == nil then
				arg_543_1.var_.characterEffect4040ui_story = var_546_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_11 = 0.200000002980232

			if var_546_10 <= arg_543_1.time_ and arg_543_1.time_ < var_546_10 + var_546_11 and not isNil(var_546_9) then
				local var_546_12 = (arg_543_1.time_ - var_546_10) / var_546_11

				if arg_543_1.var_.characterEffect4040ui_story and not isNil(var_546_9) then
					arg_543_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_10 + var_546_11 and arg_543_1.time_ < var_546_10 + var_546_11 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect4040ui_story then
				arg_543_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_546_13 = 0

			if var_546_13 < arg_543_1.time_ and arg_543_1.time_ <= var_546_13 + arg_546_0 then
				arg_543_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_546_14 = 0

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_546_15 = 0
			local var_546_16 = 0.175

			if var_546_15 < arg_543_1.time_ and arg_543_1.time_ <= var_546_15 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_17 = arg_543_1:FormatText(StoryNameCfg[905].name)

				arg_543_1.leftNameTxt_.text = var_546_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_18 = arg_543_1:GetWordFromCfg(411331127)
				local var_546_19 = arg_543_1:FormatText(var_546_18.content)

				arg_543_1.text_.text = var_546_19

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_20 = 7
				local var_546_21 = utf8.len(var_546_19)
				local var_546_22 = var_546_20 <= 0 and var_546_16 or var_546_16 * (var_546_21 / var_546_20)

				if var_546_22 > 0 and var_546_16 < var_546_22 then
					arg_543_1.talkMaxDuration = var_546_22

					if var_546_22 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_22 + var_546_15
					end
				end

				arg_543_1.text_.text = var_546_19
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_23 = math.max(var_546_16, arg_543_1.talkMaxDuration)

			if var_546_15 <= arg_543_1.time_ and arg_543_1.time_ < var_546_15 + var_546_23 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_15) / var_546_23

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_15 + var_546_23 and arg_543_1.time_ < var_546_15 + var_546_23 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play411331128 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 411331128
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play411331129(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["4040ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect4040ui_story == nil then
				arg_547_1.var_.characterEffect4040ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect4040ui_story and not isNil(var_550_0) then
					local var_550_4 = Mathf.Lerp(0, 0.5, var_550_3)

					arg_547_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_547_1.var_.characterEffect4040ui_story.fillRatio = var_550_4
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect4040ui_story then
				local var_550_5 = 0.5

				arg_547_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_547_1.var_.characterEffect4040ui_story.fillRatio = var_550_5
			end

			local var_550_6 = 0
			local var_550_7 = 1.45

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_8 = arg_547_1:GetWordFromCfg(411331128)
				local var_550_9 = arg_547_1:FormatText(var_550_8.content)

				arg_547_1.text_.text = var_550_9

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_10 = 58
				local var_550_11 = utf8.len(var_550_9)
				local var_550_12 = var_550_10 <= 0 and var_550_7 or var_550_7 * (var_550_11 / var_550_10)

				if var_550_12 > 0 and var_550_7 < var_550_12 then
					arg_547_1.talkMaxDuration = var_550_12

					if var_550_12 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_12 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_9
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_13 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_13 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_13

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_13 and arg_547_1.time_ < var_550_6 + var_550_13 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play411331129 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 411331129
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play411331130(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 0.55

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_2 = arg_551_1:FormatText(StoryNameCfg[904].name)

				arg_551_1.leftNameTxt_.text = var_554_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:GetWordFromCfg(411331129)
				local var_554_4 = arg_551_1:FormatText(var_554_3.content)

				arg_551_1.text_.text = var_554_4

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 22
				local var_554_6 = utf8.len(var_554_4)
				local var_554_7 = var_554_5 <= 0 and var_554_1 or var_554_1 * (var_554_6 / var_554_5)

				if var_554_7 > 0 and var_554_1 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_4
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_8 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_8 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_8

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_8 and arg_551_1.time_ < var_554_0 + var_554_8 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play411331130 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 411331130
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play411331131(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["4040ui_story"].transform
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.var_.moveOldPos4040ui_story = var_558_0.localPosition
			end

			local var_558_2 = 0.001

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2
				local var_558_4 = Vector3.New(0, -1.55, -5.5)

				var_558_0.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos4040ui_story, var_558_4, var_558_3)

				local var_558_5 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_5.x, var_558_5.y, var_558_5.z)

				local var_558_6 = var_558_0.localEulerAngles

				var_558_6.z = 0
				var_558_6.x = 0
				var_558_0.localEulerAngles = var_558_6
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 then
				var_558_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_558_7 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_7.x, var_558_7.y, var_558_7.z)

				local var_558_8 = var_558_0.localEulerAngles

				var_558_8.z = 0
				var_558_8.x = 0
				var_558_0.localEulerAngles = var_558_8
			end

			local var_558_9 = arg_555_1.actors_["4040ui_story"]
			local var_558_10 = 0

			if var_558_10 < arg_555_1.time_ and arg_555_1.time_ <= var_558_10 + arg_558_0 and not isNil(var_558_9) and arg_555_1.var_.characterEffect4040ui_story == nil then
				arg_555_1.var_.characterEffect4040ui_story = var_558_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_11 = 0.200000002980232

			if var_558_10 <= arg_555_1.time_ and arg_555_1.time_ < var_558_10 + var_558_11 and not isNil(var_558_9) then
				local var_558_12 = (arg_555_1.time_ - var_558_10) / var_558_11

				if arg_555_1.var_.characterEffect4040ui_story and not isNil(var_558_9) then
					arg_555_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= var_558_10 + var_558_11 and arg_555_1.time_ < var_558_10 + var_558_11 + arg_558_0 and not isNil(var_558_9) and arg_555_1.var_.characterEffect4040ui_story then
				arg_555_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_558_13 = 0

			if var_558_13 < arg_555_1.time_ and arg_555_1.time_ <= var_558_13 + arg_558_0 then
				arg_555_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_558_14 = 0

			if var_558_14 < arg_555_1.time_ and arg_555_1.time_ <= var_558_14 + arg_558_0 then
				arg_555_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_558_15 = 0
			local var_558_16 = 0.225

			if var_558_15 < arg_555_1.time_ and arg_555_1.time_ <= var_558_15 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_17 = arg_555_1:FormatText(StoryNameCfg[905].name)

				arg_555_1.leftNameTxt_.text = var_558_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_18 = arg_555_1:GetWordFromCfg(411331130)
				local var_558_19 = arg_555_1:FormatText(var_558_18.content)

				arg_555_1.text_.text = var_558_19

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_20 = 9
				local var_558_21 = utf8.len(var_558_19)
				local var_558_22 = var_558_20 <= 0 and var_558_16 or var_558_16 * (var_558_21 / var_558_20)

				if var_558_22 > 0 and var_558_16 < var_558_22 then
					arg_555_1.talkMaxDuration = var_558_22

					if var_558_22 + var_558_15 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_22 + var_558_15
					end
				end

				arg_555_1.text_.text = var_558_19
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_23 = math.max(var_558_16, arg_555_1.talkMaxDuration)

			if var_558_15 <= arg_555_1.time_ and arg_555_1.time_ < var_558_15 + var_558_23 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_15) / var_558_23

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_15 + var_558_23 and arg_555_1.time_ < var_558_15 + var_558_23 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play411331131 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 411331131
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play411331132(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["4040ui_story"]
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 and not isNil(var_562_0) and arg_559_1.var_.characterEffect4040ui_story == nil then
				arg_559_1.var_.characterEffect4040ui_story = var_562_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_2 = 0.200000002980232

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 and not isNil(var_562_0) then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2

				if arg_559_1.var_.characterEffect4040ui_story and not isNil(var_562_0) then
					local var_562_4 = Mathf.Lerp(0, 0.5, var_562_3)

					arg_559_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_559_1.var_.characterEffect4040ui_story.fillRatio = var_562_4
				end
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 and not isNil(var_562_0) and arg_559_1.var_.characterEffect4040ui_story then
				local var_562_5 = 0.5

				arg_559_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_559_1.var_.characterEffect4040ui_story.fillRatio = var_562_5
			end

			local var_562_6 = 0
			local var_562_7 = 0.875

			if var_562_6 < arg_559_1.time_ and arg_559_1.time_ <= var_562_6 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_8 = arg_559_1:GetWordFromCfg(411331131)
				local var_562_9 = arg_559_1:FormatText(var_562_8.content)

				arg_559_1.text_.text = var_562_9

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_10 = 35
				local var_562_11 = utf8.len(var_562_9)
				local var_562_12 = var_562_10 <= 0 and var_562_7 or var_562_7 * (var_562_11 / var_562_10)

				if var_562_12 > 0 and var_562_7 < var_562_12 then
					arg_559_1.talkMaxDuration = var_562_12

					if var_562_12 + var_562_6 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_12 + var_562_6
					end
				end

				arg_559_1.text_.text = var_562_9
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_13 = math.max(var_562_7, arg_559_1.talkMaxDuration)

			if var_562_6 <= arg_559_1.time_ and arg_559_1.time_ < var_562_6 + var_562_13 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_6) / var_562_13

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_6 + var_562_13 and arg_559_1.time_ < var_562_6 + var_562_13 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play411331132 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 411331132
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play411331133(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0
			local var_566_1 = 0.375

			if var_566_0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_2 = arg_563_1:FormatText(StoryNameCfg[904].name)

				arg_563_1.leftNameTxt_.text = var_566_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_3 = arg_563_1:GetWordFromCfg(411331132)
				local var_566_4 = arg_563_1:FormatText(var_566_3.content)

				arg_563_1.text_.text = var_566_4

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_5 = 15
				local var_566_6 = utf8.len(var_566_4)
				local var_566_7 = var_566_5 <= 0 and var_566_1 or var_566_1 * (var_566_6 / var_566_5)

				if var_566_7 > 0 and var_566_1 < var_566_7 then
					arg_563_1.talkMaxDuration = var_566_7

					if var_566_7 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_7 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_4
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_8 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_8 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_8

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_8 and arg_563_1.time_ < var_566_0 + var_566_8 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play411331133 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 411331133
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play411331134(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 1.15

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[904].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:GetWordFromCfg(411331133)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 46
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_8 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_8 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_8

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_8 and arg_567_1.time_ < var_570_0 + var_570_8 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play411331134 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 411331134
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play411331135(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 1.05

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_2 = arg_571_1:FormatText(StoryNameCfg[904].name)

				arg_571_1.leftNameTxt_.text = var_574_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lokiblack")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:GetWordFromCfg(411331134)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 42
				local var_574_6 = utf8.len(var_574_4)
				local var_574_7 = var_574_5 <= 0 and var_574_1 or var_574_1 * (var_574_6 / var_574_5)

				if var_574_7 > 0 and var_574_1 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_8 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_8 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_8

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_8 and arg_571_1.time_ < var_574_0 + var_574_8 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play411331135 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 411331135
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play411331136(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 1.725

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_2 = arg_575_1:GetWordFromCfg(411331135)
				local var_578_3 = arg_575_1:FormatText(var_578_2.content)

				arg_575_1.text_.text = var_578_3

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 69
				local var_578_5 = utf8.len(var_578_3)
				local var_578_6 = var_578_4 <= 0 and var_578_1 or var_578_1 * (var_578_5 / var_578_4)

				if var_578_6 > 0 and var_578_1 < var_578_6 then
					arg_575_1.talkMaxDuration = var_578_6

					if var_578_6 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_6 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_3
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_7 and arg_575_1.time_ < var_578_0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play411331136 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 411331136
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play411331137(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = "ML0107"

			if arg_579_1.bgs_[var_582_0] == nil then
				local var_582_1 = Object.Instantiate(arg_579_1.paintGo_)

				var_582_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_582_0)
				var_582_1.name = var_582_0
				var_582_1.transform.parent = arg_579_1.stage_.transform
				var_582_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_579_1.bgs_[var_582_0] = var_582_1
			end

			local var_582_2 = 0

			if var_582_2 < arg_579_1.time_ and arg_579_1.time_ <= var_582_2 + arg_582_0 then
				local var_582_3 = manager.ui.mainCamera.transform.localPosition
				local var_582_4 = Vector3.New(0, 0, 10) + Vector3.New(var_582_3.x, var_582_3.y, 0)
				local var_582_5 = arg_579_1.bgs_.ML0107

				var_582_5.transform.localPosition = var_582_4
				var_582_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_582_6 = var_582_5:GetComponent("SpriteRenderer")

				if var_582_6 and var_582_6.sprite then
					local var_582_7 = (var_582_5.transform.localPosition - var_582_3).z
					local var_582_8 = manager.ui.mainCameraCom_
					local var_582_9 = 2 * var_582_7 * Mathf.Tan(var_582_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_582_10 = var_582_9 * var_582_8.aspect
					local var_582_11 = var_582_6.sprite.bounds.size.x
					local var_582_12 = var_582_6.sprite.bounds.size.y
					local var_582_13 = var_582_10 / var_582_11
					local var_582_14 = var_582_9 / var_582_12
					local var_582_15 = var_582_14 < var_582_13 and var_582_13 or var_582_14

					var_582_5.transform.localScale = Vector3.New(var_582_15, var_582_15, 0)
				end

				for iter_582_0, iter_582_1 in pairs(arg_579_1.bgs_) do
					if iter_582_0 ~= "ML0107" then
						iter_582_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_582_16 = 0

			if var_582_16 < arg_579_1.time_ and arg_579_1.time_ <= var_582_16 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_17 = 2

			if var_582_16 <= arg_579_1.time_ and arg_579_1.time_ < var_582_16 + var_582_17 then
				local var_582_18 = (arg_579_1.time_ - var_582_16) / var_582_17
				local var_582_19 = Color.New(1, 1, 1)

				var_582_19.a = Mathf.Lerp(1, 0, var_582_18)
				arg_579_1.mask_.color = var_582_19
			end

			if arg_579_1.time_ >= var_582_16 + var_582_17 and arg_579_1.time_ < var_582_16 + var_582_17 + arg_582_0 then
				local var_582_20 = Color.New(1, 1, 1)
				local var_582_21 = 0

				arg_579_1.mask_.enabled = false
				var_582_20.a = var_582_21
				arg_579_1.mask_.color = var_582_20
			end

			local var_582_22 = arg_579_1.actors_["4040ui_story"].transform
			local var_582_23 = 0

			if var_582_23 < arg_579_1.time_ and arg_579_1.time_ <= var_582_23 + arg_582_0 then
				arg_579_1.var_.moveOldPos4040ui_story = var_582_22.localPosition
			end

			local var_582_24 = 0.001

			if var_582_23 <= arg_579_1.time_ and arg_579_1.time_ < var_582_23 + var_582_24 then
				local var_582_25 = (arg_579_1.time_ - var_582_23) / var_582_24
				local var_582_26 = Vector3.New(0, 100, 0)

				var_582_22.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPos4040ui_story, var_582_26, var_582_25)

				local var_582_27 = manager.ui.mainCamera.transform.position - var_582_22.position

				var_582_22.forward = Vector3.New(var_582_27.x, var_582_27.y, var_582_27.z)

				local var_582_28 = var_582_22.localEulerAngles

				var_582_28.z = 0
				var_582_28.x = 0
				var_582_22.localEulerAngles = var_582_28
			end

			if arg_579_1.time_ >= var_582_23 + var_582_24 and arg_579_1.time_ < var_582_23 + var_582_24 + arg_582_0 then
				var_582_22.localPosition = Vector3.New(0, 100, 0)

				local var_582_29 = manager.ui.mainCamera.transform.position - var_582_22.position

				var_582_22.forward = Vector3.New(var_582_29.x, var_582_29.y, var_582_29.z)

				local var_582_30 = var_582_22.localEulerAngles

				var_582_30.z = 0
				var_582_30.x = 0
				var_582_22.localEulerAngles = var_582_30
			end

			local var_582_31 = arg_579_1.actors_["4040ui_story"]
			local var_582_32 = 0

			if var_582_32 < arg_579_1.time_ and arg_579_1.time_ <= var_582_32 + arg_582_0 and not isNil(var_582_31) and arg_579_1.var_.characterEffect4040ui_story == nil then
				arg_579_1.var_.characterEffect4040ui_story = var_582_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_33 = 0.034000001847744

			if var_582_32 <= arg_579_1.time_ and arg_579_1.time_ < var_582_32 + var_582_33 and not isNil(var_582_31) then
				local var_582_34 = (arg_579_1.time_ - var_582_32) / var_582_33

				if arg_579_1.var_.characterEffect4040ui_story and not isNil(var_582_31) then
					local var_582_35 = Mathf.Lerp(0, 0.5, var_582_34)

					arg_579_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_579_1.var_.characterEffect4040ui_story.fillRatio = var_582_35
				end
			end

			if arg_579_1.time_ >= var_582_32 + var_582_33 and arg_579_1.time_ < var_582_32 + var_582_33 + arg_582_0 and not isNil(var_582_31) and arg_579_1.var_.characterEffect4040ui_story then
				local var_582_36 = 0.5

				arg_579_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_579_1.var_.characterEffect4040ui_story.fillRatio = var_582_36
			end

			local var_582_37 = arg_579_1.bgs_.ML0107.transform
			local var_582_38 = 0

			if var_582_38 < arg_579_1.time_ and arg_579_1.time_ <= var_582_38 + arg_582_0 then
				arg_579_1.var_.moveOldPosML0107 = var_582_37.localPosition
			end

			local var_582_39 = 0.1

			if var_582_38 <= arg_579_1.time_ and arg_579_1.time_ < var_582_38 + var_582_39 then
				local var_582_40 = (arg_579_1.time_ - var_582_38) / var_582_39
				local var_582_41 = Vector3.New(-1.08, 0.41, 2.77)

				var_582_37.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosML0107, var_582_41, var_582_40)
			end

			if arg_579_1.time_ >= var_582_38 + var_582_39 and arg_579_1.time_ < var_582_38 + var_582_39 + arg_582_0 then
				var_582_37.localPosition = Vector3.New(-1.08, 0.41, 2.77)
			end

			local var_582_42 = arg_579_1.bgs_.ML0107.transform
			local var_582_43 = 0.1

			if var_582_43 < arg_579_1.time_ and arg_579_1.time_ <= var_582_43 + arg_582_0 then
				arg_579_1.var_.moveOldPosML0107 = var_582_42.localPosition
			end

			local var_582_44 = 4.4

			if var_582_43 <= arg_579_1.time_ and arg_579_1.time_ < var_582_43 + var_582_44 then
				local var_582_45 = (arg_579_1.time_ - var_582_43) / var_582_44
				local var_582_46 = Vector3.New(0, 1, 10)

				var_582_42.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosML0107, var_582_46, var_582_45)
			end

			if arg_579_1.time_ >= var_582_43 + var_582_44 and arg_579_1.time_ < var_582_43 + var_582_44 + arg_582_0 then
				var_582_42.localPosition = Vector3.New(0, 1, 10)
			end

			local var_582_47 = 1.999999999999

			if var_582_47 < arg_579_1.time_ and arg_579_1.time_ <= var_582_47 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			local var_582_48 = 2.500000000001

			if arg_579_1.time_ >= var_582_47 + var_582_48 and arg_579_1.time_ < var_582_47 + var_582_48 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end

			local var_582_49 = 0
			local var_582_50 = 0.5

			if var_582_49 < arg_579_1.time_ and arg_579_1.time_ <= var_582_49 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0

				arg_579_1.dialog_:SetActive(true)

				arg_579_1.dialogCg_.alpha = 0

				local var_582_51 = LeanTween.value(arg_579_1.dialog_, 0, 1, 0.3)

				var_582_51:setOnUpdate(LuaHelper.FloatAction(function(arg_583_0)
					arg_579_1.dialogCg_.alpha = arg_583_0
				end))
				var_582_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_579_1.dialog_)
					var_582_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_579_1.duration_ = arg_579_1.duration_ + 0.3

				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_52 = arg_579_1:GetWordFromCfg(411331136)
				local var_582_53 = arg_579_1:FormatText(var_582_52.content)

				arg_579_1.text_.text = var_582_53

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_54 = 20
				local var_582_55 = utf8.len(var_582_53)
				local var_582_56 = var_582_54 <= 0 and var_582_50 or var_582_50 * (var_582_55 / var_582_54)

				if var_582_56 > 0 and var_582_50 < var_582_56 then
					arg_579_1.talkMaxDuration = var_582_56
					var_582_49 = var_582_49 + 0.3

					if var_582_56 + var_582_49 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_56 + var_582_49
					end
				end

				arg_579_1.text_.text = var_582_53
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_57 = var_582_49 + 0.3
			local var_582_58 = math.max(var_582_50, arg_579_1.talkMaxDuration)

			if var_582_57 <= arg_579_1.time_ and arg_579_1.time_ < var_582_57 + var_582_58 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_57) / var_582_58

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_57 + var_582_58 and arg_579_1.time_ < var_582_57 + var_582_58 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.4,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_579_1:InitPlayNodeList()
	end,
	Play411331137 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 411331137
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play411331138(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.575

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_2 = arg_585_1:GetWordFromCfg(411331137)
				local var_588_3 = arg_585_1:FormatText(var_588_2.content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 23
				local var_588_5 = utf8.len(var_588_3)
				local var_588_6 = var_588_4 <= 0 and var_588_1 or var_588_1 * (var_588_5 / var_588_4)

				if var_588_6 > 0 and var_588_1 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_7 and arg_585_1.time_ < var_588_0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play411331138 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 411331138
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play411331139(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0
			local var_592_1 = 1.375

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_2 = arg_589_1:GetWordFromCfg(411331138)
				local var_592_3 = arg_589_1:FormatText(var_592_2.content)

				arg_589_1.text_.text = var_592_3

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_4 = 55
				local var_592_5 = utf8.len(var_592_3)
				local var_592_6 = var_592_4 <= 0 and var_592_1 or var_592_1 * (var_592_5 / var_592_4)

				if var_592_6 > 0 and var_592_1 < var_592_6 then
					arg_589_1.talkMaxDuration = var_592_6

					if var_592_6 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_6 + var_592_0
					end
				end

				arg_589_1.text_.text = var_592_3
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_7 = math.max(var_592_1, arg_589_1.talkMaxDuration)

			if var_592_0 <= arg_589_1.time_ and arg_589_1.time_ < var_592_0 + var_592_7 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_0) / var_592_7

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_0 + var_592_7 and arg_589_1.time_ < var_592_0 + var_592_7 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play411331139 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 411331139
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play411331140(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 0.15

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[905].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_3 = arg_593_1:GetWordFromCfg(411331139)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 6
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_8 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_8 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_8

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_8 and arg_593_1.time_ < var_596_0 + var_596_8 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play411331140 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 411331140
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play411331141(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0
			local var_600_1 = 1.325

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_2 = arg_597_1:GetWordFromCfg(411331140)
				local var_600_3 = arg_597_1:FormatText(var_600_2.content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_4 = 53
				local var_600_5 = utf8.len(var_600_3)
				local var_600_6 = var_600_4 <= 0 and var_600_1 or var_600_1 * (var_600_5 / var_600_4)

				if var_600_6 > 0 and var_600_1 < var_600_6 then
					arg_597_1.talkMaxDuration = var_600_6

					if var_600_6 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_6 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_7 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_7 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_7

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_7 and arg_597_1.time_ < var_600_0 + var_600_7 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play411331141 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 411331141
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play411331142(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0
			local var_604_1 = 0.3

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_2 = arg_601_1:FormatText(StoryNameCfg[906].name)

				arg_601_1.leftNameTxt_.text = var_604_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_3 = arg_601_1:GetWordFromCfg(411331141)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 12
				local var_604_6 = utf8.len(var_604_4)
				local var_604_7 = var_604_5 <= 0 and var_604_1 or var_604_1 * (var_604_6 / var_604_5)

				if var_604_7 > 0 and var_604_1 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_0
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_8 = math.max(var_604_1, arg_601_1.talkMaxDuration)

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_8 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_0) / var_604_8

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_0 + var_604_8 and arg_601_1.time_ < var_604_0 + var_604_8 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play411331142 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 411331142
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play411331143(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.725

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_2 = arg_605_1:GetWordFromCfg(411331142)
				local var_608_3 = arg_605_1:FormatText(var_608_2.content)

				arg_605_1.text_.text = var_608_3

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 29
				local var_608_5 = utf8.len(var_608_3)
				local var_608_6 = var_608_4 <= 0 and var_608_1 or var_608_1 * (var_608_5 / var_608_4)

				if var_608_6 > 0 and var_608_1 < var_608_6 then
					arg_605_1.talkMaxDuration = var_608_6

					if var_608_6 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_6 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_3
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_7 and arg_605_1.time_ < var_608_0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play411331143 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 411331143
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play411331144(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 0.85

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_2 = arg_609_1:GetWordFromCfg(411331143)
				local var_612_3 = arg_609_1:FormatText(var_612_2.content)

				arg_609_1.text_.text = var_612_3

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_4 = 34
				local var_612_5 = utf8.len(var_612_3)
				local var_612_6 = var_612_4 <= 0 and var_612_1 or var_612_1 * (var_612_5 / var_612_4)

				if var_612_6 > 0 and var_612_1 < var_612_6 then
					arg_609_1.talkMaxDuration = var_612_6

					if var_612_6 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_6 + var_612_0
					end
				end

				arg_609_1.text_.text = var_612_3
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_7 = math.max(var_612_1, arg_609_1.talkMaxDuration)

			if var_612_0 <= arg_609_1.time_ and arg_609_1.time_ < var_612_0 + var_612_7 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_0) / var_612_7

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_0 + var_612_7 and arg_609_1.time_ < var_612_0 + var_612_7 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play411331144 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 411331144
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play411331145(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.425

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[673].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:GetWordFromCfg(411331144)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 17
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_8 and arg_613_1.time_ < var_616_0 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play411331145 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 411331145
		arg_617_1.duration_ = 2

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play411331146(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				local var_620_1 = manager.ui.mainCamera.transform.localPosition
				local var_620_2 = Vector3.New(0, 0, 10) + Vector3.New(var_620_1.x, var_620_1.y, 0)
				local var_620_3 = arg_617_1.bgs_.STblack

				var_620_3.transform.localPosition = var_620_2
				var_620_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_620_4 = var_620_3:GetComponent("SpriteRenderer")

				if var_620_4 and var_620_4.sprite then
					local var_620_5 = (var_620_3.transform.localPosition - var_620_1).z
					local var_620_6 = manager.ui.mainCameraCom_
					local var_620_7 = 2 * var_620_5 * Mathf.Tan(var_620_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_620_8 = var_620_7 * var_620_6.aspect
					local var_620_9 = var_620_4.sprite.bounds.size.x
					local var_620_10 = var_620_4.sprite.bounds.size.y
					local var_620_11 = var_620_8 / var_620_9
					local var_620_12 = var_620_7 / var_620_10
					local var_620_13 = var_620_12 < var_620_11 and var_620_11 or var_620_12

					var_620_3.transform.localScale = Vector3.New(var_620_13, var_620_13, 0)
				end

				for iter_620_0, iter_620_1 in pairs(arg_617_1.bgs_) do
					if iter_620_0 ~= "STblack" then
						iter_620_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_620_14 = 0

			if var_620_14 < arg_617_1.time_ and arg_617_1.time_ <= var_620_14 + arg_620_0 then
				arg_617_1.fswbg_:SetActive(true)
				arg_617_1.dialog_:SetActive(false)

				arg_617_1.fswtw_.percent = 0

				local var_620_15 = arg_617_1:GetWordFromCfg(411331145)
				local var_620_16 = arg_617_1:FormatText(var_620_15.content)

				arg_617_1.fswt_.text = var_620_16

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.fswt_)

				arg_617_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_617_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_617_1.fswtw_:SetDirty()

				arg_617_1.typewritterCharCountI18N = 0

				SetActive(arg_617_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_617_1:ShowNextGo(false)
			end

			local var_620_17 = 0.0166666666666667

			if var_620_17 < arg_617_1.time_ and arg_617_1.time_ <= var_620_17 + arg_620_0 then
				arg_617_1.var_.oldValueTypewriter = arg_617_1.fswtw_.percent

				SetActive(arg_617_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_617_1:ShowNextGo(false)
			end

			local var_620_18 = 9
			local var_620_19 = 0.6
			local var_620_20 = arg_617_1:GetWordFromCfg(411331145)
			local var_620_21 = arg_617_1:FormatText(var_620_20.content)
			local var_620_22, var_620_23 = arg_617_1:GetPercentByPara(var_620_21, 1)

			if var_620_17 < arg_617_1.time_ and arg_617_1.time_ <= var_620_17 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0

				local var_620_24 = var_620_18 <= 0 and var_620_19 or var_620_19 * ((var_620_23 - arg_617_1.typewritterCharCountI18N) / var_620_18)

				if var_620_24 > 0 and var_620_19 < var_620_24 then
					arg_617_1.talkMaxDuration = var_620_24

					if var_620_24 + var_620_17 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_24 + var_620_17
					end
				end
			end

			local var_620_25 = 0.6
			local var_620_26 = math.max(var_620_25, arg_617_1.talkMaxDuration)

			if var_620_17 <= arg_617_1.time_ and arg_617_1.time_ < var_620_17 + var_620_26 then
				local var_620_27 = (arg_617_1.time_ - var_620_17) / var_620_26

				arg_617_1.fswtw_.percent = Mathf.Lerp(arg_617_1.var_.oldValueTypewriter, var_620_22, var_620_27)
				arg_617_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_617_1.fswtw_:SetDirty()
			end

			if arg_617_1.time_ >= var_620_17 + var_620_26 and arg_617_1.time_ < var_620_17 + var_620_26 + arg_620_0 then
				arg_617_1.fswtw_.percent = var_620_22

				arg_617_1.fswtw_:SetDirty()
				arg_617_1:ShowNextGo(true)

				arg_617_1.typewritterCharCountI18N = var_620_23
			end

			local var_620_28 = 0

			if var_620_28 < arg_617_1.time_ and arg_617_1.time_ <= var_620_28 + arg_620_0 then
				local var_620_29 = arg_617_1.fswbg_.transform:Find("textbox/adapt/content") or arg_617_1.fswbg_.transform:Find("textbox/content")
				local var_620_30 = arg_617_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_620_31 = var_620_29:GetComponent("Text")
				local var_620_32 = var_620_29:GetComponent("RectTransform")

				var_620_31.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_620_32.offsetMin = Vector2.New(0, 0)
				var_620_32.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play411331146 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 411331146
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play411331147(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.fswbg_:SetActive(false)
				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_621_1:ShowNextGo(false)
			end

			local var_624_1 = 0
			local var_624_2 = 0.3

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0

				arg_621_1.dialog_:SetActive(true)

				arg_621_1.dialogCg_.alpha = 0

				local var_624_3 = LeanTween.value(arg_621_1.dialog_, 0, 1, 0.3)

				var_624_3:setOnUpdate(LuaHelper.FloatAction(function(arg_625_0)
					arg_621_1.dialogCg_.alpha = arg_625_0
				end))
				var_624_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_621_1.dialog_)
					var_624_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_621_1.duration_ = arg_621_1.duration_ + 0.3

				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_4 = arg_621_1:FormatText(StoryNameCfg[673].name)

				arg_621_1.leftNameTxt_.text = var_624_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_5 = arg_621_1:GetWordFromCfg(411331146)
				local var_624_6 = arg_621_1:FormatText(var_624_5.content)

				arg_621_1.text_.text = var_624_6

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_7 = 12
				local var_624_8 = utf8.len(var_624_6)
				local var_624_9 = var_624_7 <= 0 and var_624_2 or var_624_2 * (var_624_8 / var_624_7)

				if var_624_9 > 0 and var_624_2 < var_624_9 then
					arg_621_1.talkMaxDuration = var_624_9
					var_624_1 = var_624_1 + 0.3

					if var_624_9 + var_624_1 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_9 + var_624_1
					end
				end

				arg_621_1.text_.text = var_624_6
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_10 = var_624_1 + 0.3
			local var_624_11 = math.max(var_624_2, arg_621_1.talkMaxDuration)

			if var_624_10 <= arg_621_1.time_ and arg_621_1.time_ < var_624_10 + var_624_11 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_10) / var_624_11

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_10 + var_624_11 and arg_621_1.time_ < var_624_10 + var_624_11 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play411331147 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 411331147
		arg_627_1.duration_ = 1

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play411331148(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0

			if var_630_0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.fswbg_:SetActive(true)
				arg_627_1.dialog_:SetActive(false)

				arg_627_1.fswtw_.percent = 0

				local var_630_1 = arg_627_1:GetWordFromCfg(411331147)
				local var_630_2 = arg_627_1:FormatText(var_630_1.content)

				arg_627_1.fswt_.text = var_630_2

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.fswt_)

				arg_627_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_627_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_627_1.fswtw_:SetDirty()

				arg_627_1.typewritterCharCountI18N = 0

				SetActive(arg_627_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_627_1:ShowNextGo(false)
			end

			local var_630_3 = 0.0166666666666667

			if var_630_3 < arg_627_1.time_ and arg_627_1.time_ <= var_630_3 + arg_630_0 then
				arg_627_1.var_.oldValueTypewriter = arg_627_1.fswtw_.percent

				SetActive(arg_627_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_627_1:ShowNextGo(false)
			end

			local var_630_4 = 10
			local var_630_5 = 0.666666666666667
			local var_630_6 = arg_627_1:GetWordFromCfg(411331147)
			local var_630_7 = arg_627_1:FormatText(var_630_6.content)
			local var_630_8, var_630_9 = arg_627_1:GetPercentByPara(var_630_7, 1)

			if var_630_3 < arg_627_1.time_ and arg_627_1.time_ <= var_630_3 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0

				local var_630_10 = var_630_4 <= 0 and var_630_5 or var_630_5 * ((var_630_9 - arg_627_1.typewritterCharCountI18N) / var_630_4)

				if var_630_10 > 0 and var_630_5 < var_630_10 then
					arg_627_1.talkMaxDuration = var_630_10

					if var_630_10 + var_630_3 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_10 + var_630_3
					end
				end
			end

			local var_630_11 = 0.666666666666667
			local var_630_12 = math.max(var_630_11, arg_627_1.talkMaxDuration)

			if var_630_3 <= arg_627_1.time_ and arg_627_1.time_ < var_630_3 + var_630_12 then
				local var_630_13 = (arg_627_1.time_ - var_630_3) / var_630_12

				arg_627_1.fswtw_.percent = Mathf.Lerp(arg_627_1.var_.oldValueTypewriter, var_630_8, var_630_13)
				arg_627_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_627_1.fswtw_:SetDirty()
			end

			if arg_627_1.time_ >= var_630_3 + var_630_12 and arg_627_1.time_ < var_630_3 + var_630_12 + arg_630_0 then
				arg_627_1.fswtw_.percent = var_630_8

				arg_627_1.fswtw_:SetDirty()
				arg_627_1:ShowNextGo(true)

				arg_627_1.typewritterCharCountI18N = var_630_9
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play411331148 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 411331148
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play411331149(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.fswbg_:SetActive(false)
				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_631_1:ShowNextGo(false)
			end

			local var_634_1 = 0
			local var_634_2 = 0.3

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0

				arg_631_1.dialog_:SetActive(true)

				arg_631_1.dialogCg_.alpha = 0

				local var_634_3 = LeanTween.value(arg_631_1.dialog_, 0, 1, 0.3)

				var_634_3:setOnUpdate(LuaHelper.FloatAction(function(arg_635_0)
					arg_631_1.dialogCg_.alpha = arg_635_0
				end))
				var_634_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_631_1.dialog_)
					var_634_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_631_1.duration_ = arg_631_1.duration_ + 0.3

				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_4 = arg_631_1:FormatText(StoryNameCfg[673].name)

				arg_631_1.leftNameTxt_.text = var_634_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_5 = arg_631_1:GetWordFromCfg(411331148)
				local var_634_6 = arg_631_1:FormatText(var_634_5.content)

				arg_631_1.text_.text = var_634_6

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_7 = 12
				local var_634_8 = utf8.len(var_634_6)
				local var_634_9 = var_634_7 <= 0 and var_634_2 or var_634_2 * (var_634_8 / var_634_7)

				if var_634_9 > 0 and var_634_2 < var_634_9 then
					arg_631_1.talkMaxDuration = var_634_9
					var_634_1 = var_634_1 + 0.3

					if var_634_9 + var_634_1 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_9 + var_634_1
					end
				end

				arg_631_1.text_.text = var_634_6
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_10 = var_634_1 + 0.3
			local var_634_11 = math.max(var_634_2, arg_631_1.talkMaxDuration)

			if var_634_10 <= arg_631_1.time_ and arg_631_1.time_ < var_634_10 + var_634_11 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_10) / var_634_11

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_10 + var_634_11 and arg_631_1.time_ < var_634_10 + var_634_11 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play411331149 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 411331149
		arg_637_1.duration_ = 8.19

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play411331150(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 1.96666666666667

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				local var_640_1 = manager.ui.mainCamera.transform.localPosition
				local var_640_2 = Vector3.New(0, 0, 10) + Vector3.New(var_640_1.x, var_640_1.y, 0)
				local var_640_3 = arg_637_1.bgs_.ML0107

				var_640_3.transform.localPosition = var_640_2
				var_640_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_640_4 = var_640_3:GetComponent("SpriteRenderer")

				if var_640_4 and var_640_4.sprite then
					local var_640_5 = (var_640_3.transform.localPosition - var_640_1).z
					local var_640_6 = manager.ui.mainCameraCom_
					local var_640_7 = 2 * var_640_5 * Mathf.Tan(var_640_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_640_8 = var_640_7 * var_640_6.aspect
					local var_640_9 = var_640_4.sprite.bounds.size.x
					local var_640_10 = var_640_4.sprite.bounds.size.y
					local var_640_11 = var_640_8 / var_640_9
					local var_640_12 = var_640_7 / var_640_10
					local var_640_13 = var_640_12 < var_640_11 and var_640_11 or var_640_12

					var_640_3.transform.localScale = Vector3.New(var_640_13, var_640_13, 0)
				end

				for iter_640_0, iter_640_1 in pairs(arg_637_1.bgs_) do
					if iter_640_0 ~= "ML0107" then
						iter_640_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_640_14 = 0

			if var_640_14 < arg_637_1.time_ and arg_637_1.time_ <= var_640_14 + arg_640_0 then
				arg_637_1.mask_.enabled = true
				arg_637_1.mask_.raycastTarget = true

				arg_637_1:SetGaussion(false)
			end

			local var_640_15 = 2

			if var_640_14 <= arg_637_1.time_ and arg_637_1.time_ < var_640_14 + var_640_15 then
				local var_640_16 = (arg_637_1.time_ - var_640_14) / var_640_15
				local var_640_17 = Color.New(1, 1, 1)

				var_640_17.a = Mathf.Lerp(1, 0, var_640_16)
				arg_637_1.mask_.color = var_640_17
			end

			if arg_637_1.time_ >= var_640_14 + var_640_15 and arg_637_1.time_ < var_640_14 + var_640_15 + arg_640_0 then
				local var_640_18 = Color.New(1, 1, 1)
				local var_640_19 = 0

				arg_637_1.mask_.enabled = false
				var_640_18.a = var_640_19
				arg_637_1.mask_.color = var_640_18
			end

			local var_640_20 = 3.19166666666667
			local var_640_21 = 0.075

			if var_640_20 < arg_637_1.time_ and arg_637_1.time_ <= var_640_20 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_22 = arg_637_1:FormatText(StoryNameCfg[905].name)

				arg_637_1.leftNameTxt_.text = var_640_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_23 = arg_637_1:GetWordFromCfg(411331149)
				local var_640_24 = arg_637_1:FormatText(var_640_23.content)

				arg_637_1.text_.text = var_640_24

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_25 = 3
				local var_640_26 = utf8.len(var_640_24)
				local var_640_27 = var_640_25 <= 0 and var_640_21 or var_640_21 * (var_640_26 / var_640_25)

				if var_640_27 > 0 and var_640_21 < var_640_27 then
					arg_637_1.talkMaxDuration = var_640_27

					if var_640_27 + var_640_20 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_27 + var_640_20
					end
				end

				arg_637_1.text_.text = var_640_24
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_28 = math.max(var_640_21, arg_637_1.talkMaxDuration)

			if var_640_20 <= arg_637_1.time_ and arg_637_1.time_ < var_640_20 + var_640_28 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_20) / var_640_28

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_20 + var_640_28 and arg_637_1.time_ < var_640_20 + var_640_28 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play411331150 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 411331150
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play411331151(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0
			local var_644_1 = 0.675

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, false)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_2 = arg_641_1:GetWordFromCfg(411331150)
				local var_644_3 = arg_641_1:FormatText(var_644_2.content)

				arg_641_1.text_.text = var_644_3

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_4 = 27
				local var_644_5 = utf8.len(var_644_3)
				local var_644_6 = var_644_4 <= 0 and var_644_1 or var_644_1 * (var_644_5 / var_644_4)

				if var_644_6 > 0 and var_644_1 < var_644_6 then
					arg_641_1.talkMaxDuration = var_644_6

					if var_644_6 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_6 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_3
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_7 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_7 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_7

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_7 and arg_641_1.time_ < var_644_0 + var_644_7 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play411331151 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 411331151
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play411331152(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.4

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_2 = arg_645_1:GetWordFromCfg(411331151)
				local var_648_3 = arg_645_1:FormatText(var_648_2.content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_4 = 16
				local var_648_5 = utf8.len(var_648_3)
				local var_648_6 = var_648_4 <= 0 and var_648_1 or var_648_1 * (var_648_5 / var_648_4)

				if var_648_6 > 0 and var_648_1 < var_648_6 then
					arg_645_1.talkMaxDuration = var_648_6

					if var_648_6 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_6 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_7 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_7 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_7

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_7 and arg_645_1.time_ < var_648_0 + var_648_7 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play411331152 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 411331152
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play411331153(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.575

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_2 = arg_649_1:GetWordFromCfg(411331152)
				local var_652_3 = arg_649_1:FormatText(var_652_2.content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_4 = 23
				local var_652_5 = utf8.len(var_652_3)
				local var_652_6 = var_652_4 <= 0 and var_652_1 or var_652_1 * (var_652_5 / var_652_4)

				if var_652_6 > 0 and var_652_1 < var_652_6 then
					arg_649_1.talkMaxDuration = var_652_6

					if var_652_6 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_6 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_7 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_7 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_7

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_7 and arg_649_1.time_ < var_652_0 + var_652_7 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play411331153 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 411331153
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play411331154(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0
			local var_656_1 = 1

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_2 = arg_653_1:GetWordFromCfg(411331153)
				local var_656_3 = arg_653_1:FormatText(var_656_2.content)

				arg_653_1.text_.text = var_656_3

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_4 = 40
				local var_656_5 = utf8.len(var_656_3)
				local var_656_6 = var_656_4 <= 0 and var_656_1 or var_656_1 * (var_656_5 / var_656_4)

				if var_656_6 > 0 and var_656_1 < var_656_6 then
					arg_653_1.talkMaxDuration = var_656_6

					if var_656_6 + var_656_0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_6 + var_656_0
					end
				end

				arg_653_1.text_.text = var_656_3
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_7 = math.max(var_656_1, arg_653_1.talkMaxDuration)

			if var_656_0 <= arg_653_1.time_ and arg_653_1.time_ < var_656_0 + var_656_7 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_0) / var_656_7

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_0 + var_656_7 and arg_653_1.time_ < var_656_0 + var_656_7 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play411331154 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 411331154
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play411331155(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0
			local var_660_1 = 0.225

			if var_660_0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_2 = arg_657_1:FormatText(StoryNameCfg[905].name)

				arg_657_1.leftNameTxt_.text = var_660_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_3 = arg_657_1:GetWordFromCfg(411331154)
				local var_660_4 = arg_657_1:FormatText(var_660_3.content)

				arg_657_1.text_.text = var_660_4

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 9
				local var_660_6 = utf8.len(var_660_4)
				local var_660_7 = var_660_5 <= 0 and var_660_1 or var_660_1 * (var_660_6 / var_660_5)

				if var_660_7 > 0 and var_660_1 < var_660_7 then
					arg_657_1.talkMaxDuration = var_660_7

					if var_660_7 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_7 + var_660_0
					end
				end

				arg_657_1.text_.text = var_660_4
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_8 = math.max(var_660_1, arg_657_1.talkMaxDuration)

			if var_660_0 <= arg_657_1.time_ and arg_657_1.time_ < var_660_0 + var_660_8 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_0) / var_660_8

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_0 + var_660_8 and arg_657_1.time_ < var_660_0 + var_660_8 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play411331155 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 411331155
		arg_661_1.duration_ = 9

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play411331156(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 2

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				local var_664_1 = manager.ui.mainCamera.transform.localPosition
				local var_664_2 = Vector3.New(0, 0, 10) + Vector3.New(var_664_1.x, var_664_1.y, 0)
				local var_664_3 = arg_661_1.bgs_.I07

				var_664_3.transform.localPosition = var_664_2
				var_664_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_664_4 = var_664_3:GetComponent("SpriteRenderer")

				if var_664_4 and var_664_4.sprite then
					local var_664_5 = (var_664_3.transform.localPosition - var_664_1).z
					local var_664_6 = manager.ui.mainCameraCom_
					local var_664_7 = 2 * var_664_5 * Mathf.Tan(var_664_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_664_8 = var_664_7 * var_664_6.aspect
					local var_664_9 = var_664_4.sprite.bounds.size.x
					local var_664_10 = var_664_4.sprite.bounds.size.y
					local var_664_11 = var_664_8 / var_664_9
					local var_664_12 = var_664_7 / var_664_10
					local var_664_13 = var_664_12 < var_664_11 and var_664_11 or var_664_12

					var_664_3.transform.localScale = Vector3.New(var_664_13, var_664_13, 0)
				end

				for iter_664_0, iter_664_1 in pairs(arg_661_1.bgs_) do
					if iter_664_0 ~= "I07" then
						iter_664_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_664_14 = 0

			if var_664_14 < arg_661_1.time_ and arg_661_1.time_ <= var_664_14 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_15 = 2

			if var_664_14 <= arg_661_1.time_ and arg_661_1.time_ < var_664_14 + var_664_15 then
				local var_664_16 = (arg_661_1.time_ - var_664_14) / var_664_15
				local var_664_17 = Color.New(0, 0, 0)

				var_664_17.a = Mathf.Lerp(0, 1, var_664_16)
				arg_661_1.mask_.color = var_664_17
			end

			if arg_661_1.time_ >= var_664_14 + var_664_15 and arg_661_1.time_ < var_664_14 + var_664_15 + arg_664_0 then
				local var_664_18 = Color.New(0, 0, 0)

				var_664_18.a = 1
				arg_661_1.mask_.color = var_664_18
			end

			local var_664_19 = 2

			if var_664_19 < arg_661_1.time_ and arg_661_1.time_ <= var_664_19 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_20 = 2

			if var_664_19 <= arg_661_1.time_ and arg_661_1.time_ < var_664_19 + var_664_20 then
				local var_664_21 = (arg_661_1.time_ - var_664_19) / var_664_20
				local var_664_22 = Color.New(0, 0, 0)

				var_664_22.a = Mathf.Lerp(1, 0, var_664_21)
				arg_661_1.mask_.color = var_664_22
			end

			if arg_661_1.time_ >= var_664_19 + var_664_20 and arg_661_1.time_ < var_664_19 + var_664_20 + arg_664_0 then
				local var_664_23 = Color.New(0, 0, 0)
				local var_664_24 = 0

				arg_661_1.mask_.enabled = false
				var_664_23.a = var_664_24
				arg_661_1.mask_.color = var_664_23
			end

			if arg_661_1.frameCnt_ <= 1 then
				arg_661_1.dialog_:SetActive(false)
			end

			local var_664_25 = 4
			local var_664_26 = 1.45

			if var_664_25 < arg_661_1.time_ and arg_661_1.time_ <= var_664_25 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0

				arg_661_1.dialog_:SetActive(true)

				arg_661_1.dialogCg_.alpha = 0

				local var_664_27 = LeanTween.value(arg_661_1.dialog_, 0, 1, 0.3)

				var_664_27:setOnUpdate(LuaHelper.FloatAction(function(arg_665_0)
					arg_661_1.dialogCg_.alpha = arg_665_0
				end))
				var_664_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_661_1.dialog_)
					var_664_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_661_1.duration_ = arg_661_1.duration_ + 0.3

				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_28 = arg_661_1:GetWordFromCfg(411331155)
				local var_664_29 = arg_661_1:FormatText(var_664_28.content)

				arg_661_1.text_.text = var_664_29

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_30 = 58
				local var_664_31 = utf8.len(var_664_29)
				local var_664_32 = var_664_30 <= 0 and var_664_26 or var_664_26 * (var_664_31 / var_664_30)

				if var_664_32 > 0 and var_664_26 < var_664_32 then
					arg_661_1.talkMaxDuration = var_664_32
					var_664_25 = var_664_25 + 0.3

					if var_664_32 + var_664_25 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_32 + var_664_25
					end
				end

				arg_661_1.text_.text = var_664_29
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_33 = var_664_25 + 0.3
			local var_664_34 = math.max(var_664_26, arg_661_1.talkMaxDuration)

			if var_664_33 <= arg_661_1.time_ and arg_661_1.time_ < var_664_33 + var_664_34 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_33) / var_664_34

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_33 + var_664_34 and arg_661_1.time_ < var_664_33 + var_664_34 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play411331156 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 411331156
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play411331157(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = arg_667_1.actors_["4040ui_story"].transform
			local var_670_1 = 0

			if var_670_1 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 then
				arg_667_1.var_.moveOldPos4040ui_story = var_670_0.localPosition
			end

			local var_670_2 = 0.001

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_2 then
				local var_670_3 = (arg_667_1.time_ - var_670_1) / var_670_2
				local var_670_4 = Vector3.New(0, -1.55, -5.5)

				var_670_0.localPosition = Vector3.Lerp(arg_667_1.var_.moveOldPos4040ui_story, var_670_4, var_670_3)

				local var_670_5 = manager.ui.mainCamera.transform.position - var_670_0.position

				var_670_0.forward = Vector3.New(var_670_5.x, var_670_5.y, var_670_5.z)

				local var_670_6 = var_670_0.localEulerAngles

				var_670_6.z = 0
				var_670_6.x = 0
				var_670_0.localEulerAngles = var_670_6
			end

			if arg_667_1.time_ >= var_670_1 + var_670_2 and arg_667_1.time_ < var_670_1 + var_670_2 + arg_670_0 then
				var_670_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_670_7 = manager.ui.mainCamera.transform.position - var_670_0.position

				var_670_0.forward = Vector3.New(var_670_7.x, var_670_7.y, var_670_7.z)

				local var_670_8 = var_670_0.localEulerAngles

				var_670_8.z = 0
				var_670_8.x = 0
				var_670_0.localEulerAngles = var_670_8
			end

			local var_670_9 = arg_667_1.actors_["4040ui_story"]
			local var_670_10 = 0

			if var_670_10 < arg_667_1.time_ and arg_667_1.time_ <= var_670_10 + arg_670_0 and not isNil(var_670_9) and arg_667_1.var_.characterEffect4040ui_story == nil then
				arg_667_1.var_.characterEffect4040ui_story = var_670_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_11 = 0.200000002980232

			if var_670_10 <= arg_667_1.time_ and arg_667_1.time_ < var_670_10 + var_670_11 and not isNil(var_670_9) then
				local var_670_12 = (arg_667_1.time_ - var_670_10) / var_670_11

				if arg_667_1.var_.characterEffect4040ui_story and not isNil(var_670_9) then
					arg_667_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= var_670_10 + var_670_11 and arg_667_1.time_ < var_670_10 + var_670_11 + arg_670_0 and not isNil(var_670_9) and arg_667_1.var_.characterEffect4040ui_story then
				arg_667_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_670_13 = 0

			if var_670_13 < arg_667_1.time_ and arg_667_1.time_ <= var_670_13 + arg_670_0 then
				arg_667_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_670_14 = 0

			if var_670_14 < arg_667_1.time_ and arg_667_1.time_ <= var_670_14 + arg_670_0 then
				arg_667_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_670_15 = 0
			local var_670_16 = 0.225

			if var_670_15 < arg_667_1.time_ and arg_667_1.time_ <= var_670_15 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_17 = arg_667_1:FormatText(StoryNameCfg[905].name)

				arg_667_1.leftNameTxt_.text = var_670_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_18 = arg_667_1:GetWordFromCfg(411331156)
				local var_670_19 = arg_667_1:FormatText(var_670_18.content)

				arg_667_1.text_.text = var_670_19

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_20 = 9
				local var_670_21 = utf8.len(var_670_19)
				local var_670_22 = var_670_20 <= 0 and var_670_16 or var_670_16 * (var_670_21 / var_670_20)

				if var_670_22 > 0 and var_670_16 < var_670_22 then
					arg_667_1.talkMaxDuration = var_670_22

					if var_670_22 + var_670_15 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_22 + var_670_15
					end
				end

				arg_667_1.text_.text = var_670_19
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_23 = math.max(var_670_16, arg_667_1.talkMaxDuration)

			if var_670_15 <= arg_667_1.time_ and arg_667_1.time_ < var_670_15 + var_670_23 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_15) / var_670_23

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_15 + var_670_23 and arg_667_1.time_ < var_670_15 + var_670_23 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_667_1:InitPlayNodeList()
	end,
	Play411331157 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 411331157
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play411331158(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["4040ui_story"]
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.characterEffect4040ui_story == nil then
				arg_671_1.var_.characterEffect4040ui_story = var_674_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_2 = 0.200000002980232

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 and not isNil(var_674_0) then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2

				if arg_671_1.var_.characterEffect4040ui_story and not isNil(var_674_0) then
					local var_674_4 = Mathf.Lerp(0, 0.5, var_674_3)

					arg_671_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_671_1.var_.characterEffect4040ui_story.fillRatio = var_674_4
				end
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.characterEffect4040ui_story then
				local var_674_5 = 0.5

				arg_671_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_671_1.var_.characterEffect4040ui_story.fillRatio = var_674_5
			end

			local var_674_6 = 0
			local var_674_7 = 1.275

			if var_674_6 < arg_671_1.time_ and arg_671_1.time_ <= var_674_6 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_8 = arg_671_1:GetWordFromCfg(411331157)
				local var_674_9 = arg_671_1:FormatText(var_674_8.content)

				arg_671_1.text_.text = var_674_9

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_10 = 51
				local var_674_11 = utf8.len(var_674_9)
				local var_674_12 = var_674_10 <= 0 and var_674_7 or var_674_7 * (var_674_11 / var_674_10)

				if var_674_12 > 0 and var_674_7 < var_674_12 then
					arg_671_1.talkMaxDuration = var_674_12

					if var_674_12 + var_674_6 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_12 + var_674_6
					end
				end

				arg_671_1.text_.text = var_674_9
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_13 = math.max(var_674_7, arg_671_1.talkMaxDuration)

			if var_674_6 <= arg_671_1.time_ and arg_671_1.time_ < var_674_6 + var_674_13 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_6) / var_674_13

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_6 + var_674_13 and arg_671_1.time_ < var_674_6 + var_674_13 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play411331158 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 411331158
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play411331159(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["10014ui_story"].transform
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.var_.moveOldPos10014ui_story = var_678_0.localPosition
			end

			local var_678_2 = 0.001

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_2 then
				local var_678_3 = (arg_675_1.time_ - var_678_1) / var_678_2
				local var_678_4 = Vector3.New(0.7, -1.06, -6.2)

				var_678_0.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos10014ui_story, var_678_4, var_678_3)

				local var_678_5 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_5.x, var_678_5.y, var_678_5.z)

				local var_678_6 = var_678_0.localEulerAngles

				var_678_6.z = 0
				var_678_6.x = 0
				var_678_0.localEulerAngles = var_678_6
			end

			if arg_675_1.time_ >= var_678_1 + var_678_2 and arg_675_1.time_ < var_678_1 + var_678_2 + arg_678_0 then
				var_678_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_678_7 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_7.x, var_678_7.y, var_678_7.z)

				local var_678_8 = var_678_0.localEulerAngles

				var_678_8.z = 0
				var_678_8.x = 0
				var_678_0.localEulerAngles = var_678_8
			end

			local var_678_9 = arg_675_1.actors_["10014ui_story"]
			local var_678_10 = 0

			if var_678_10 < arg_675_1.time_ and arg_675_1.time_ <= var_678_10 + arg_678_0 and not isNil(var_678_9) and arg_675_1.var_.characterEffect10014ui_story == nil then
				arg_675_1.var_.characterEffect10014ui_story = var_678_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_11 = 0.200000002980232

			if var_678_10 <= arg_675_1.time_ and arg_675_1.time_ < var_678_10 + var_678_11 and not isNil(var_678_9) then
				local var_678_12 = (arg_675_1.time_ - var_678_10) / var_678_11

				if arg_675_1.var_.characterEffect10014ui_story and not isNil(var_678_9) then
					arg_675_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= var_678_10 + var_678_11 and arg_675_1.time_ < var_678_10 + var_678_11 + arg_678_0 and not isNil(var_678_9) and arg_675_1.var_.characterEffect10014ui_story then
				arg_675_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_678_13 = 0

			if var_678_13 < arg_675_1.time_ and arg_675_1.time_ <= var_678_13 + arg_678_0 then
				arg_675_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_678_14 = 0

			if var_678_14 < arg_675_1.time_ and arg_675_1.time_ <= var_678_14 + arg_678_0 then
				arg_675_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_678_15 = arg_675_1.actors_["4040ui_story"].transform
			local var_678_16 = 0

			if var_678_16 < arg_675_1.time_ and arg_675_1.time_ <= var_678_16 + arg_678_0 then
				arg_675_1.var_.moveOldPos4040ui_story = var_678_15.localPosition
			end

			local var_678_17 = 0.001

			if var_678_16 <= arg_675_1.time_ and arg_675_1.time_ < var_678_16 + var_678_17 then
				local var_678_18 = (arg_675_1.time_ - var_678_16) / var_678_17
				local var_678_19 = Vector3.New(-0.7, -1.55, -5.5)

				var_678_15.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos4040ui_story, var_678_19, var_678_18)

				local var_678_20 = manager.ui.mainCamera.transform.position - var_678_15.position

				var_678_15.forward = Vector3.New(var_678_20.x, var_678_20.y, var_678_20.z)

				local var_678_21 = var_678_15.localEulerAngles

				var_678_21.z = 0
				var_678_21.x = 0
				var_678_15.localEulerAngles = var_678_21
			end

			if arg_675_1.time_ >= var_678_16 + var_678_17 and arg_675_1.time_ < var_678_16 + var_678_17 + arg_678_0 then
				var_678_15.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_678_22 = manager.ui.mainCamera.transform.position - var_678_15.position

				var_678_15.forward = Vector3.New(var_678_22.x, var_678_22.y, var_678_22.z)

				local var_678_23 = var_678_15.localEulerAngles

				var_678_23.z = 0
				var_678_23.x = 0
				var_678_15.localEulerAngles = var_678_23
			end

			local var_678_24 = arg_675_1.actors_["4040ui_story"]
			local var_678_25 = 0

			if var_678_25 < arg_675_1.time_ and arg_675_1.time_ <= var_678_25 + arg_678_0 and not isNil(var_678_24) and arg_675_1.var_.characterEffect4040ui_story == nil then
				arg_675_1.var_.characterEffect4040ui_story = var_678_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_26 = 0.200000002980232

			if var_678_25 <= arg_675_1.time_ and arg_675_1.time_ < var_678_25 + var_678_26 and not isNil(var_678_24) then
				local var_678_27 = (arg_675_1.time_ - var_678_25) / var_678_26

				if arg_675_1.var_.characterEffect4040ui_story and not isNil(var_678_24) then
					local var_678_28 = Mathf.Lerp(0, 0.5, var_678_27)

					arg_675_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_675_1.var_.characterEffect4040ui_story.fillRatio = var_678_28
				end
			end

			if arg_675_1.time_ >= var_678_25 + var_678_26 and arg_675_1.time_ < var_678_25 + var_678_26 + arg_678_0 and not isNil(var_678_24) and arg_675_1.var_.characterEffect4040ui_story then
				local var_678_29 = 0.5

				arg_675_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_675_1.var_.characterEffect4040ui_story.fillRatio = var_678_29
			end

			local var_678_30 = 0
			local var_678_31 = 0.275

			if var_678_30 < arg_675_1.time_ and arg_675_1.time_ <= var_678_30 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_32 = arg_675_1:FormatText(StoryNameCfg[264].name)

				arg_675_1.leftNameTxt_.text = var_678_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_33 = arg_675_1:GetWordFromCfg(411331158)
				local var_678_34 = arg_675_1:FormatText(var_678_33.content)

				arg_675_1.text_.text = var_678_34

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_35 = 11
				local var_678_36 = utf8.len(var_678_34)
				local var_678_37 = var_678_35 <= 0 and var_678_31 or var_678_31 * (var_678_36 / var_678_35)

				if var_678_37 > 0 and var_678_31 < var_678_37 then
					arg_675_1.talkMaxDuration = var_678_37

					if var_678_37 + var_678_30 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_37 + var_678_30
					end
				end

				arg_675_1.text_.text = var_678_34
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_38 = math.max(var_678_31, arg_675_1.talkMaxDuration)

			if var_678_30 <= arg_675_1.time_ and arg_675_1.time_ < var_678_30 + var_678_38 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_30) / var_678_38

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_30 + var_678_38 and arg_675_1.time_ < var_678_30 + var_678_38 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play411331159 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 411331159
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play411331160(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["4040ui_story"].transform
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				arg_679_1.var_.moveOldPos4040ui_story = var_682_0.localPosition
			end

			local var_682_2 = 0.001

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2
				local var_682_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_682_0.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos4040ui_story, var_682_4, var_682_3)

				local var_682_5 = manager.ui.mainCamera.transform.position - var_682_0.position

				var_682_0.forward = Vector3.New(var_682_5.x, var_682_5.y, var_682_5.z)

				local var_682_6 = var_682_0.localEulerAngles

				var_682_6.z = 0
				var_682_6.x = 0
				var_682_0.localEulerAngles = var_682_6
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 then
				var_682_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_682_7 = manager.ui.mainCamera.transform.position - var_682_0.position

				var_682_0.forward = Vector3.New(var_682_7.x, var_682_7.y, var_682_7.z)

				local var_682_8 = var_682_0.localEulerAngles

				var_682_8.z = 0
				var_682_8.x = 0
				var_682_0.localEulerAngles = var_682_8
			end

			local var_682_9 = arg_679_1.actors_["4040ui_story"]
			local var_682_10 = 0

			if var_682_10 < arg_679_1.time_ and arg_679_1.time_ <= var_682_10 + arg_682_0 and not isNil(var_682_9) and arg_679_1.var_.characterEffect4040ui_story == nil then
				arg_679_1.var_.characterEffect4040ui_story = var_682_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_11 = 0.200000002980232

			if var_682_10 <= arg_679_1.time_ and arg_679_1.time_ < var_682_10 + var_682_11 and not isNil(var_682_9) then
				local var_682_12 = (arg_679_1.time_ - var_682_10) / var_682_11

				if arg_679_1.var_.characterEffect4040ui_story and not isNil(var_682_9) then
					arg_679_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= var_682_10 + var_682_11 and arg_679_1.time_ < var_682_10 + var_682_11 + arg_682_0 and not isNil(var_682_9) and arg_679_1.var_.characterEffect4040ui_story then
				arg_679_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_682_13 = 0

			if var_682_13 < arg_679_1.time_ and arg_679_1.time_ <= var_682_13 + arg_682_0 then
				arg_679_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_682_14 = 0

			if var_682_14 < arg_679_1.time_ and arg_679_1.time_ <= var_682_14 + arg_682_0 then
				arg_679_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_682_15 = arg_679_1.actors_["10014ui_story"]
			local var_682_16 = 0

			if var_682_16 < arg_679_1.time_ and arg_679_1.time_ <= var_682_16 + arg_682_0 and not isNil(var_682_15) and arg_679_1.var_.characterEffect10014ui_story == nil then
				arg_679_1.var_.characterEffect10014ui_story = var_682_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_17 = 0.200000002980232

			if var_682_16 <= arg_679_1.time_ and arg_679_1.time_ < var_682_16 + var_682_17 and not isNil(var_682_15) then
				local var_682_18 = (arg_679_1.time_ - var_682_16) / var_682_17

				if arg_679_1.var_.characterEffect10014ui_story and not isNil(var_682_15) then
					local var_682_19 = Mathf.Lerp(0, 0.5, var_682_18)

					arg_679_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_679_1.var_.characterEffect10014ui_story.fillRatio = var_682_19
				end
			end

			if arg_679_1.time_ >= var_682_16 + var_682_17 and arg_679_1.time_ < var_682_16 + var_682_17 + arg_682_0 and not isNil(var_682_15) and arg_679_1.var_.characterEffect10014ui_story then
				local var_682_20 = 0.5

				arg_679_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_679_1.var_.characterEffect10014ui_story.fillRatio = var_682_20
			end

			local var_682_21 = 0
			local var_682_22 = 0.15

			if var_682_21 < arg_679_1.time_ and arg_679_1.time_ <= var_682_21 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_23 = arg_679_1:FormatText(StoryNameCfg[905].name)

				arg_679_1.leftNameTxt_.text = var_682_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_24 = arg_679_1:GetWordFromCfg(411331159)
				local var_682_25 = arg_679_1:FormatText(var_682_24.content)

				arg_679_1.text_.text = var_682_25

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_26 = 6
				local var_682_27 = utf8.len(var_682_25)
				local var_682_28 = var_682_26 <= 0 and var_682_22 or var_682_22 * (var_682_27 / var_682_26)

				if var_682_28 > 0 and var_682_22 < var_682_28 then
					arg_679_1.talkMaxDuration = var_682_28

					if var_682_28 + var_682_21 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_28 + var_682_21
					end
				end

				arg_679_1.text_.text = var_682_25
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_29 = math.max(var_682_22, arg_679_1.talkMaxDuration)

			if var_682_21 <= arg_679_1.time_ and arg_679_1.time_ < var_682_21 + var_682_29 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_21) / var_682_29

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_21 + var_682_29 and arg_679_1.time_ < var_682_21 + var_682_29 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_679_1:InitPlayNodeList()
	end,
	Play411331160 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 411331160
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play411331161(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["4040ui_story"]
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect4040ui_story == nil then
				arg_683_1.var_.characterEffect4040ui_story = var_686_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_2 = 0.200000002980232

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 and not isNil(var_686_0) then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2

				if arg_683_1.var_.characterEffect4040ui_story and not isNil(var_686_0) then
					local var_686_4 = Mathf.Lerp(0, 0.5, var_686_3)

					arg_683_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_683_1.var_.characterEffect4040ui_story.fillRatio = var_686_4
				end
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect4040ui_story then
				local var_686_5 = 0.5

				arg_683_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_683_1.var_.characterEffect4040ui_story.fillRatio = var_686_5
			end

			local var_686_6 = 0
			local var_686_7 = 1.3

			if var_686_6 < arg_683_1.time_ and arg_683_1.time_ <= var_686_6 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_8 = arg_683_1:GetWordFromCfg(411331160)
				local var_686_9 = arg_683_1:FormatText(var_686_8.content)

				arg_683_1.text_.text = var_686_9

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_10 = 52
				local var_686_11 = utf8.len(var_686_9)
				local var_686_12 = var_686_10 <= 0 and var_686_7 or var_686_7 * (var_686_11 / var_686_10)

				if var_686_12 > 0 and var_686_7 < var_686_12 then
					arg_683_1.talkMaxDuration = var_686_12

					if var_686_12 + var_686_6 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_12 + var_686_6
					end
				end

				arg_683_1.text_.text = var_686_9
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_13 = math.max(var_686_7, arg_683_1.talkMaxDuration)

			if var_686_6 <= arg_683_1.time_ and arg_683_1.time_ < var_686_6 + var_686_13 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_6) / var_686_13

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_6 + var_686_13 and arg_683_1.time_ < var_686_6 + var_686_13 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play411331161 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 411331161
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play411331162(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["10014ui_story"].transform
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 then
				arg_687_1.var_.moveOldPos10014ui_story = var_690_0.localPosition
			end

			local var_690_2 = 0.001

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2
				local var_690_4 = Vector3.New(0.7, -1.06, -6.2)

				var_690_0.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos10014ui_story, var_690_4, var_690_3)

				local var_690_5 = manager.ui.mainCamera.transform.position - var_690_0.position

				var_690_0.forward = Vector3.New(var_690_5.x, var_690_5.y, var_690_5.z)

				local var_690_6 = var_690_0.localEulerAngles

				var_690_6.z = 0
				var_690_6.x = 0
				var_690_0.localEulerAngles = var_690_6
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 then
				var_690_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_690_7 = manager.ui.mainCamera.transform.position - var_690_0.position

				var_690_0.forward = Vector3.New(var_690_7.x, var_690_7.y, var_690_7.z)

				local var_690_8 = var_690_0.localEulerAngles

				var_690_8.z = 0
				var_690_8.x = 0
				var_690_0.localEulerAngles = var_690_8
			end

			local var_690_9 = arg_687_1.actors_["10014ui_story"]
			local var_690_10 = 0

			if var_690_10 < arg_687_1.time_ and arg_687_1.time_ <= var_690_10 + arg_690_0 and not isNil(var_690_9) and arg_687_1.var_.characterEffect10014ui_story == nil then
				arg_687_1.var_.characterEffect10014ui_story = var_690_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_11 = 0.200000002980232

			if var_690_10 <= arg_687_1.time_ and arg_687_1.time_ < var_690_10 + var_690_11 and not isNil(var_690_9) then
				local var_690_12 = (arg_687_1.time_ - var_690_10) / var_690_11

				if arg_687_1.var_.characterEffect10014ui_story and not isNil(var_690_9) then
					arg_687_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= var_690_10 + var_690_11 and arg_687_1.time_ < var_690_10 + var_690_11 + arg_690_0 and not isNil(var_690_9) and arg_687_1.var_.characterEffect10014ui_story then
				arg_687_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_690_13 = 0

			if var_690_13 < arg_687_1.time_ and arg_687_1.time_ <= var_690_13 + arg_690_0 then
				arg_687_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_690_14 = 0

			if var_690_14 < arg_687_1.time_ and arg_687_1.time_ <= var_690_14 + arg_690_0 then
				arg_687_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_690_15 = 0
			local var_690_16 = 0.3

			if var_690_15 < arg_687_1.time_ and arg_687_1.time_ <= var_690_15 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_17 = arg_687_1:FormatText(StoryNameCfg[264].name)

				arg_687_1.leftNameTxt_.text = var_690_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_18 = arg_687_1:GetWordFromCfg(411331161)
				local var_690_19 = arg_687_1:FormatText(var_690_18.content)

				arg_687_1.text_.text = var_690_19

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_20 = 12
				local var_690_21 = utf8.len(var_690_19)
				local var_690_22 = var_690_20 <= 0 and var_690_16 or var_690_16 * (var_690_21 / var_690_20)

				if var_690_22 > 0 and var_690_16 < var_690_22 then
					arg_687_1.talkMaxDuration = var_690_22

					if var_690_22 + var_690_15 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_22 + var_690_15
					end
				end

				arg_687_1.text_.text = var_690_19
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_23 = math.max(var_690_16, arg_687_1.talkMaxDuration)

			if var_690_15 <= arg_687_1.time_ and arg_687_1.time_ < var_690_15 + var_690_23 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_15) / var_690_23

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_15 + var_690_23 and arg_687_1.time_ < var_690_15 + var_690_23 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_687_1:InitPlayNodeList()
	end,
	Play411331162 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 411331162
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play411331163(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["10014ui_story"]
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect10014ui_story == nil then
				arg_691_1.var_.characterEffect10014ui_story = var_694_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 and not isNil(var_694_0) then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2

				if arg_691_1.var_.characterEffect10014ui_story and not isNil(var_694_0) then
					local var_694_4 = Mathf.Lerp(0, 0.5, var_694_3)

					arg_691_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_691_1.var_.characterEffect10014ui_story.fillRatio = var_694_4
				end
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect10014ui_story then
				local var_694_5 = 0.5

				arg_691_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_691_1.var_.characterEffect10014ui_story.fillRatio = var_694_5
			end

			local var_694_6 = 0
			local var_694_7 = 1.075

			if var_694_6 < arg_691_1.time_ and arg_691_1.time_ <= var_694_6 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_8 = arg_691_1:GetWordFromCfg(411331162)
				local var_694_9 = arg_691_1:FormatText(var_694_8.content)

				arg_691_1.text_.text = var_694_9

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_10 = 43
				local var_694_11 = utf8.len(var_694_9)
				local var_694_12 = var_694_10 <= 0 and var_694_7 or var_694_7 * (var_694_11 / var_694_10)

				if var_694_12 > 0 and var_694_7 < var_694_12 then
					arg_691_1.talkMaxDuration = var_694_12

					if var_694_12 + var_694_6 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_12 + var_694_6
					end
				end

				arg_691_1.text_.text = var_694_9
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_13 = math.max(var_694_7, arg_691_1.talkMaxDuration)

			if var_694_6 <= arg_691_1.time_ and arg_691_1.time_ < var_694_6 + var_694_13 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_6) / var_694_13

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_6 + var_694_13 and arg_691_1.time_ < var_694_6 + var_694_13 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play411331163 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 411331163
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play411331164(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0
			local var_698_1 = 1.175

			if var_698_0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, false)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_2 = arg_695_1:GetWordFromCfg(411331163)
				local var_698_3 = arg_695_1:FormatText(var_698_2.content)

				arg_695_1.text_.text = var_698_3

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_4 = 47
				local var_698_5 = utf8.len(var_698_3)
				local var_698_6 = var_698_4 <= 0 and var_698_1 or var_698_1 * (var_698_5 / var_698_4)

				if var_698_6 > 0 and var_698_1 < var_698_6 then
					arg_695_1.talkMaxDuration = var_698_6

					if var_698_6 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_6 + var_698_0
					end
				end

				arg_695_1.text_.text = var_698_3
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_7 = math.max(var_698_1, arg_695_1.talkMaxDuration)

			if var_698_0 <= arg_695_1.time_ and arg_695_1.time_ < var_698_0 + var_698_7 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_0) / var_698_7

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_0 + var_698_7 and arg_695_1.time_ < var_698_0 + var_698_7 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play411331164 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 411331164
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play411331165(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["10014ui_story"].transform
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.var_.moveOldPos10014ui_story = var_702_0.localPosition
			end

			local var_702_2 = 0.001

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2
				local var_702_4 = Vector3.New(0.7, -1.06, -6.2)

				var_702_0.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10014ui_story, var_702_4, var_702_3)

				local var_702_5 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_5.x, var_702_5.y, var_702_5.z)

				local var_702_6 = var_702_0.localEulerAngles

				var_702_6.z = 0
				var_702_6.x = 0
				var_702_0.localEulerAngles = var_702_6
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 then
				var_702_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_702_7 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_7.x, var_702_7.y, var_702_7.z)

				local var_702_8 = var_702_0.localEulerAngles

				var_702_8.z = 0
				var_702_8.x = 0
				var_702_0.localEulerAngles = var_702_8
			end

			local var_702_9 = arg_699_1.actors_["10014ui_story"]
			local var_702_10 = 0

			if var_702_10 < arg_699_1.time_ and arg_699_1.time_ <= var_702_10 + arg_702_0 and not isNil(var_702_9) and arg_699_1.var_.characterEffect10014ui_story == nil then
				arg_699_1.var_.characterEffect10014ui_story = var_702_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_11 = 0.200000002980232

			if var_702_10 <= arg_699_1.time_ and arg_699_1.time_ < var_702_10 + var_702_11 and not isNil(var_702_9) then
				local var_702_12 = (arg_699_1.time_ - var_702_10) / var_702_11

				if arg_699_1.var_.characterEffect10014ui_story and not isNil(var_702_9) then
					arg_699_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= var_702_10 + var_702_11 and arg_699_1.time_ < var_702_10 + var_702_11 + arg_702_0 and not isNil(var_702_9) and arg_699_1.var_.characterEffect10014ui_story then
				arg_699_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_702_13 = 0

			if var_702_13 < arg_699_1.time_ and arg_699_1.time_ <= var_702_13 + arg_702_0 then
				arg_699_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_702_14 = 0

			if var_702_14 < arg_699_1.time_ and arg_699_1.time_ <= var_702_14 + arg_702_0 then
				arg_699_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_702_15 = 0
			local var_702_16 = 0.65

			if var_702_15 < arg_699_1.time_ and arg_699_1.time_ <= var_702_15 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_17 = arg_699_1:FormatText(StoryNameCfg[264].name)

				arg_699_1.leftNameTxt_.text = var_702_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_18 = arg_699_1:GetWordFromCfg(411331164)
				local var_702_19 = arg_699_1:FormatText(var_702_18.content)

				arg_699_1.text_.text = var_702_19

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_20 = 26
				local var_702_21 = utf8.len(var_702_19)
				local var_702_22 = var_702_20 <= 0 and var_702_16 or var_702_16 * (var_702_21 / var_702_20)

				if var_702_22 > 0 and var_702_16 < var_702_22 then
					arg_699_1.talkMaxDuration = var_702_22

					if var_702_22 + var_702_15 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_22 + var_702_15
					end
				end

				arg_699_1.text_.text = var_702_19
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_23 = math.max(var_702_16, arg_699_1.talkMaxDuration)

			if var_702_15 <= arg_699_1.time_ and arg_699_1.time_ < var_702_15 + var_702_23 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_15) / var_702_23

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_15 + var_702_23 and arg_699_1.time_ < var_702_15 + var_702_23 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play411331165 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 411331165
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play411331166(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["4040ui_story"].transform
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.var_.moveOldPos4040ui_story = var_706_0.localPosition
			end

			local var_706_2 = 0.001

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2
				local var_706_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_706_0.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos4040ui_story, var_706_4, var_706_3)

				local var_706_5 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_5.x, var_706_5.y, var_706_5.z)

				local var_706_6 = var_706_0.localEulerAngles

				var_706_6.z = 0
				var_706_6.x = 0
				var_706_0.localEulerAngles = var_706_6
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 then
				var_706_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_706_7 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_7.x, var_706_7.y, var_706_7.z)

				local var_706_8 = var_706_0.localEulerAngles

				var_706_8.z = 0
				var_706_8.x = 0
				var_706_0.localEulerAngles = var_706_8
			end

			local var_706_9 = arg_703_1.actors_["4040ui_story"]
			local var_706_10 = 0

			if var_706_10 < arg_703_1.time_ and arg_703_1.time_ <= var_706_10 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect4040ui_story == nil then
				arg_703_1.var_.characterEffect4040ui_story = var_706_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_11 = 0.200000002980232

			if var_706_10 <= arg_703_1.time_ and arg_703_1.time_ < var_706_10 + var_706_11 and not isNil(var_706_9) then
				local var_706_12 = (arg_703_1.time_ - var_706_10) / var_706_11

				if arg_703_1.var_.characterEffect4040ui_story and not isNil(var_706_9) then
					arg_703_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= var_706_10 + var_706_11 and arg_703_1.time_ < var_706_10 + var_706_11 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect4040ui_story then
				arg_703_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_706_13 = 0

			if var_706_13 < arg_703_1.time_ and arg_703_1.time_ <= var_706_13 + arg_706_0 then
				arg_703_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_706_14 = 0

			if var_706_14 < arg_703_1.time_ and arg_703_1.time_ <= var_706_14 + arg_706_0 then
				arg_703_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_706_15 = arg_703_1.actors_["10014ui_story"]
			local var_706_16 = 0

			if var_706_16 < arg_703_1.time_ and arg_703_1.time_ <= var_706_16 + arg_706_0 and not isNil(var_706_15) and arg_703_1.var_.characterEffect10014ui_story == nil then
				arg_703_1.var_.characterEffect10014ui_story = var_706_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_17 = 0.200000002980232

			if var_706_16 <= arg_703_1.time_ and arg_703_1.time_ < var_706_16 + var_706_17 and not isNil(var_706_15) then
				local var_706_18 = (arg_703_1.time_ - var_706_16) / var_706_17

				if arg_703_1.var_.characterEffect10014ui_story and not isNil(var_706_15) then
					local var_706_19 = Mathf.Lerp(0, 0.5, var_706_18)

					arg_703_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_703_1.var_.characterEffect10014ui_story.fillRatio = var_706_19
				end
			end

			if arg_703_1.time_ >= var_706_16 + var_706_17 and arg_703_1.time_ < var_706_16 + var_706_17 + arg_706_0 and not isNil(var_706_15) and arg_703_1.var_.characterEffect10014ui_story then
				local var_706_20 = 0.5

				arg_703_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_703_1.var_.characterEffect10014ui_story.fillRatio = var_706_20
			end

			local var_706_21 = 0
			local var_706_22 = 0.225

			if var_706_21 < arg_703_1.time_ and arg_703_1.time_ <= var_706_21 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_23 = arg_703_1:FormatText(StoryNameCfg[905].name)

				arg_703_1.leftNameTxt_.text = var_706_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_24 = arg_703_1:GetWordFromCfg(411331165)
				local var_706_25 = arg_703_1:FormatText(var_706_24.content)

				arg_703_1.text_.text = var_706_25

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_26 = 9
				local var_706_27 = utf8.len(var_706_25)
				local var_706_28 = var_706_26 <= 0 and var_706_22 or var_706_22 * (var_706_27 / var_706_26)

				if var_706_28 > 0 and var_706_22 < var_706_28 then
					arg_703_1.talkMaxDuration = var_706_28

					if var_706_28 + var_706_21 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_28 + var_706_21
					end
				end

				arg_703_1.text_.text = var_706_25
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_29 = math.max(var_706_22, arg_703_1.talkMaxDuration)

			if var_706_21 <= arg_703_1.time_ and arg_703_1.time_ < var_706_21 + var_706_29 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_21) / var_706_29

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_21 + var_706_29 and arg_703_1.time_ < var_706_21 + var_706_29 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play411331166 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 411331166
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play411331167(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["4040ui_story"]
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 and not isNil(var_710_0) and arg_707_1.var_.characterEffect4040ui_story == nil then
				arg_707_1.var_.characterEffect4040ui_story = var_710_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_2 = 0.200000002980232

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 and not isNil(var_710_0) then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2

				if arg_707_1.var_.characterEffect4040ui_story and not isNil(var_710_0) then
					local var_710_4 = Mathf.Lerp(0, 0.5, var_710_3)

					arg_707_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_707_1.var_.characterEffect4040ui_story.fillRatio = var_710_4
				end
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 and not isNil(var_710_0) and arg_707_1.var_.characterEffect4040ui_story then
				local var_710_5 = 0.5

				arg_707_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_707_1.var_.characterEffect4040ui_story.fillRatio = var_710_5
			end

			local var_710_6 = 0
			local var_710_7 = 1.5

			if var_710_6 < arg_707_1.time_ and arg_707_1.time_ <= var_710_6 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_8 = arg_707_1:GetWordFromCfg(411331166)
				local var_710_9 = arg_707_1:FormatText(var_710_8.content)

				arg_707_1.text_.text = var_710_9

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_10 = 60
				local var_710_11 = utf8.len(var_710_9)
				local var_710_12 = var_710_10 <= 0 and var_710_7 or var_710_7 * (var_710_11 / var_710_10)

				if var_710_12 > 0 and var_710_7 < var_710_12 then
					arg_707_1.talkMaxDuration = var_710_12

					if var_710_12 + var_710_6 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_12 + var_710_6
					end
				end

				arg_707_1.text_.text = var_710_9
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_13 = math.max(var_710_7, arg_707_1.talkMaxDuration)

			if var_710_6 <= arg_707_1.time_ and arg_707_1.time_ < var_710_6 + var_710_13 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_6) / var_710_13

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_6 + var_710_13 and arg_707_1.time_ < var_710_6 + var_710_13 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play411331167 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 411331167
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play411331168(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["4040ui_story"].transform
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.var_.moveOldPos4040ui_story = var_714_0.localPosition
			end

			local var_714_2 = 0.001

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2
				local var_714_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_714_0.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos4040ui_story, var_714_4, var_714_3)

				local var_714_5 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_5.x, var_714_5.y, var_714_5.z)

				local var_714_6 = var_714_0.localEulerAngles

				var_714_6.z = 0
				var_714_6.x = 0
				var_714_0.localEulerAngles = var_714_6
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 then
				var_714_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_714_7 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_7.x, var_714_7.y, var_714_7.z)

				local var_714_8 = var_714_0.localEulerAngles

				var_714_8.z = 0
				var_714_8.x = 0
				var_714_0.localEulerAngles = var_714_8
			end

			local var_714_9 = arg_711_1.actors_["4040ui_story"]
			local var_714_10 = 0

			if var_714_10 < arg_711_1.time_ and arg_711_1.time_ <= var_714_10 + arg_714_0 and not isNil(var_714_9) and arg_711_1.var_.characterEffect4040ui_story == nil then
				arg_711_1.var_.characterEffect4040ui_story = var_714_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_11 = 0.200000002980232

			if var_714_10 <= arg_711_1.time_ and arg_711_1.time_ < var_714_10 + var_714_11 and not isNil(var_714_9) then
				local var_714_12 = (arg_711_1.time_ - var_714_10) / var_714_11

				if arg_711_1.var_.characterEffect4040ui_story and not isNil(var_714_9) then
					arg_711_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= var_714_10 + var_714_11 and arg_711_1.time_ < var_714_10 + var_714_11 + arg_714_0 and not isNil(var_714_9) and arg_711_1.var_.characterEffect4040ui_story then
				arg_711_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_714_13 = 0

			if var_714_13 < arg_711_1.time_ and arg_711_1.time_ <= var_714_13 + arg_714_0 then
				arg_711_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_714_14 = 0
			local var_714_15 = 0.75

			if var_714_14 < arg_711_1.time_ and arg_711_1.time_ <= var_714_14 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_16 = arg_711_1:FormatText(StoryNameCfg[668].name)

				arg_711_1.leftNameTxt_.text = var_714_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_17 = arg_711_1:GetWordFromCfg(411331167)
				local var_714_18 = arg_711_1:FormatText(var_714_17.content)

				arg_711_1.text_.text = var_714_18

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_19 = 30
				local var_714_20 = utf8.len(var_714_18)
				local var_714_21 = var_714_19 <= 0 and var_714_15 or var_714_15 * (var_714_20 / var_714_19)

				if var_714_21 > 0 and var_714_15 < var_714_21 then
					arg_711_1.talkMaxDuration = var_714_21

					if var_714_21 + var_714_14 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_21 + var_714_14
					end
				end

				arg_711_1.text_.text = var_714_18
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_22 = math.max(var_714_15, arg_711_1.talkMaxDuration)

			if var_714_14 <= arg_711_1.time_ and arg_711_1.time_ < var_714_14 + var_714_22 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_14) / var_714_22

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_14 + var_714_22 and arg_711_1.time_ < var_714_14 + var_714_22 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	Play411331168 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 411331168
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play411331169(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = arg_715_1.actors_["10014ui_story"].transform
			local var_718_1 = 0

			if var_718_1 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 then
				arg_715_1.var_.moveOldPos10014ui_story = var_718_0.localPosition
			end

			local var_718_2 = 0.001

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_2 then
				local var_718_3 = (arg_715_1.time_ - var_718_1) / var_718_2
				local var_718_4 = Vector3.New(0.7, -1.06, -6.2)

				var_718_0.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos10014ui_story, var_718_4, var_718_3)

				local var_718_5 = manager.ui.mainCamera.transform.position - var_718_0.position

				var_718_0.forward = Vector3.New(var_718_5.x, var_718_5.y, var_718_5.z)

				local var_718_6 = var_718_0.localEulerAngles

				var_718_6.z = 0
				var_718_6.x = 0
				var_718_0.localEulerAngles = var_718_6
			end

			if arg_715_1.time_ >= var_718_1 + var_718_2 and arg_715_1.time_ < var_718_1 + var_718_2 + arg_718_0 then
				var_718_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_718_7 = manager.ui.mainCamera.transform.position - var_718_0.position

				var_718_0.forward = Vector3.New(var_718_7.x, var_718_7.y, var_718_7.z)

				local var_718_8 = var_718_0.localEulerAngles

				var_718_8.z = 0
				var_718_8.x = 0
				var_718_0.localEulerAngles = var_718_8
			end

			local var_718_9 = arg_715_1.actors_["10014ui_story"]
			local var_718_10 = 0

			if var_718_10 < arg_715_1.time_ and arg_715_1.time_ <= var_718_10 + arg_718_0 and not isNil(var_718_9) and arg_715_1.var_.characterEffect10014ui_story == nil then
				arg_715_1.var_.characterEffect10014ui_story = var_718_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_11 = 0.200000002980232

			if var_718_10 <= arg_715_1.time_ and arg_715_1.time_ < var_718_10 + var_718_11 and not isNil(var_718_9) then
				local var_718_12 = (arg_715_1.time_ - var_718_10) / var_718_11

				if arg_715_1.var_.characterEffect10014ui_story and not isNil(var_718_9) then
					arg_715_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= var_718_10 + var_718_11 and arg_715_1.time_ < var_718_10 + var_718_11 + arg_718_0 and not isNil(var_718_9) and arg_715_1.var_.characterEffect10014ui_story then
				arg_715_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_718_13 = 0

			if var_718_13 < arg_715_1.time_ and arg_715_1.time_ <= var_718_13 + arg_718_0 then
				arg_715_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_718_14 = 0

			if var_718_14 < arg_715_1.time_ and arg_715_1.time_ <= var_718_14 + arg_718_0 then
				arg_715_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_718_15 = arg_715_1.actors_["4040ui_story"]
			local var_718_16 = 0

			if var_718_16 < arg_715_1.time_ and arg_715_1.time_ <= var_718_16 + arg_718_0 and not isNil(var_718_15) and arg_715_1.var_.characterEffect4040ui_story == nil then
				arg_715_1.var_.characterEffect4040ui_story = var_718_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_17 = 0.200000002980232

			if var_718_16 <= arg_715_1.time_ and arg_715_1.time_ < var_718_16 + var_718_17 and not isNil(var_718_15) then
				local var_718_18 = (arg_715_1.time_ - var_718_16) / var_718_17

				if arg_715_1.var_.characterEffect4040ui_story and not isNil(var_718_15) then
					local var_718_19 = Mathf.Lerp(0, 0.5, var_718_18)

					arg_715_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_715_1.var_.characterEffect4040ui_story.fillRatio = var_718_19
				end
			end

			if arg_715_1.time_ >= var_718_16 + var_718_17 and arg_715_1.time_ < var_718_16 + var_718_17 + arg_718_0 and not isNil(var_718_15) and arg_715_1.var_.characterEffect4040ui_story then
				local var_718_20 = 0.5

				arg_715_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_715_1.var_.characterEffect4040ui_story.fillRatio = var_718_20
			end

			local var_718_21 = 0
			local var_718_22 = 0.175

			if var_718_21 < arg_715_1.time_ and arg_715_1.time_ <= var_718_21 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_23 = arg_715_1:FormatText(StoryNameCfg[264].name)

				arg_715_1.leftNameTxt_.text = var_718_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_24 = arg_715_1:GetWordFromCfg(411331168)
				local var_718_25 = arg_715_1:FormatText(var_718_24.content)

				arg_715_1.text_.text = var_718_25

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_26 = 7
				local var_718_27 = utf8.len(var_718_25)
				local var_718_28 = var_718_26 <= 0 and var_718_22 or var_718_22 * (var_718_27 / var_718_26)

				if var_718_28 > 0 and var_718_22 < var_718_28 then
					arg_715_1.talkMaxDuration = var_718_28

					if var_718_28 + var_718_21 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_28 + var_718_21
					end
				end

				arg_715_1.text_.text = var_718_25
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_29 = math.max(var_718_22, arg_715_1.talkMaxDuration)

			if var_718_21 <= arg_715_1.time_ and arg_715_1.time_ < var_718_21 + var_718_29 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_21) / var_718_29

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_21 + var_718_29 and arg_715_1.time_ < var_718_21 + var_718_29 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	Play411331169 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 411331169
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play411331170(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = arg_719_1.actors_["4040ui_story"].transform
			local var_722_1 = 0

			if var_722_1 < arg_719_1.time_ and arg_719_1.time_ <= var_722_1 + arg_722_0 then
				arg_719_1.var_.moveOldPos4040ui_story = var_722_0.localPosition
			end

			local var_722_2 = 0.001

			if var_722_1 <= arg_719_1.time_ and arg_719_1.time_ < var_722_1 + var_722_2 then
				local var_722_3 = (arg_719_1.time_ - var_722_1) / var_722_2
				local var_722_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_722_0.localPosition = Vector3.Lerp(arg_719_1.var_.moveOldPos4040ui_story, var_722_4, var_722_3)

				local var_722_5 = manager.ui.mainCamera.transform.position - var_722_0.position

				var_722_0.forward = Vector3.New(var_722_5.x, var_722_5.y, var_722_5.z)

				local var_722_6 = var_722_0.localEulerAngles

				var_722_6.z = 0
				var_722_6.x = 0
				var_722_0.localEulerAngles = var_722_6
			end

			if arg_719_1.time_ >= var_722_1 + var_722_2 and arg_719_1.time_ < var_722_1 + var_722_2 + arg_722_0 then
				var_722_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_722_7 = manager.ui.mainCamera.transform.position - var_722_0.position

				var_722_0.forward = Vector3.New(var_722_7.x, var_722_7.y, var_722_7.z)

				local var_722_8 = var_722_0.localEulerAngles

				var_722_8.z = 0
				var_722_8.x = 0
				var_722_0.localEulerAngles = var_722_8
			end

			local var_722_9 = arg_719_1.actors_["4040ui_story"]
			local var_722_10 = 0

			if var_722_10 < arg_719_1.time_ and arg_719_1.time_ <= var_722_10 + arg_722_0 and not isNil(var_722_9) and arg_719_1.var_.characterEffect4040ui_story == nil then
				arg_719_1.var_.characterEffect4040ui_story = var_722_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_11 = 0.200000002980232

			if var_722_10 <= arg_719_1.time_ and arg_719_1.time_ < var_722_10 + var_722_11 and not isNil(var_722_9) then
				local var_722_12 = (arg_719_1.time_ - var_722_10) / var_722_11

				if arg_719_1.var_.characterEffect4040ui_story and not isNil(var_722_9) then
					arg_719_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= var_722_10 + var_722_11 and arg_719_1.time_ < var_722_10 + var_722_11 + arg_722_0 and not isNil(var_722_9) and arg_719_1.var_.characterEffect4040ui_story then
				arg_719_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_722_13 = 0

			if var_722_13 < arg_719_1.time_ and arg_719_1.time_ <= var_722_13 + arg_722_0 then
				arg_719_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_722_14 = 0

			if var_722_14 < arg_719_1.time_ and arg_719_1.time_ <= var_722_14 + arg_722_0 then
				arg_719_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_722_15 = arg_719_1.actors_["10014ui_story"]
			local var_722_16 = 0

			if var_722_16 < arg_719_1.time_ and arg_719_1.time_ <= var_722_16 + arg_722_0 and not isNil(var_722_15) and arg_719_1.var_.characterEffect10014ui_story == nil then
				arg_719_1.var_.characterEffect10014ui_story = var_722_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_17 = 0.200000002980232

			if var_722_16 <= arg_719_1.time_ and arg_719_1.time_ < var_722_16 + var_722_17 and not isNil(var_722_15) then
				local var_722_18 = (arg_719_1.time_ - var_722_16) / var_722_17

				if arg_719_1.var_.characterEffect10014ui_story and not isNil(var_722_15) then
					local var_722_19 = Mathf.Lerp(0, 0.5, var_722_18)

					arg_719_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_719_1.var_.characterEffect10014ui_story.fillRatio = var_722_19
				end
			end

			if arg_719_1.time_ >= var_722_16 + var_722_17 and arg_719_1.time_ < var_722_16 + var_722_17 + arg_722_0 and not isNil(var_722_15) and arg_719_1.var_.characterEffect10014ui_story then
				local var_722_20 = 0.5

				arg_719_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_719_1.var_.characterEffect10014ui_story.fillRatio = var_722_20
			end

			local var_722_21 = 0
			local var_722_22 = 0.125

			if var_722_21 < arg_719_1.time_ and arg_719_1.time_ <= var_722_21 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_23 = arg_719_1:FormatText(StoryNameCfg[668].name)

				arg_719_1.leftNameTxt_.text = var_722_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_24 = arg_719_1:GetWordFromCfg(411331169)
				local var_722_25 = arg_719_1:FormatText(var_722_24.content)

				arg_719_1.text_.text = var_722_25

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_26 = 5
				local var_722_27 = utf8.len(var_722_25)
				local var_722_28 = var_722_26 <= 0 and var_722_22 or var_722_22 * (var_722_27 / var_722_26)

				if var_722_28 > 0 and var_722_22 < var_722_28 then
					arg_719_1.talkMaxDuration = var_722_28

					if var_722_28 + var_722_21 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_28 + var_722_21
					end
				end

				arg_719_1.text_.text = var_722_25
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_29 = math.max(var_722_22, arg_719_1.talkMaxDuration)

			if var_722_21 <= arg_719_1.time_ and arg_719_1.time_ < var_722_21 + var_722_29 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_21) / var_722_29

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_21 + var_722_29 and arg_719_1.time_ < var_722_21 + var_722_29 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_719_1:InitPlayNodeList()
	end,
	Play411331170 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 411331170
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play411331171(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = arg_723_1.actors_["4040ui_story"]
			local var_726_1 = 0

			if var_726_1 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 and not isNil(var_726_0) and arg_723_1.var_.characterEffect4040ui_story == nil then
				arg_723_1.var_.characterEffect4040ui_story = var_726_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_2 = 0.200000002980232

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_2 and not isNil(var_726_0) then
				local var_726_3 = (arg_723_1.time_ - var_726_1) / var_726_2

				if arg_723_1.var_.characterEffect4040ui_story and not isNil(var_726_0) then
					local var_726_4 = Mathf.Lerp(0, 0.5, var_726_3)

					arg_723_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_723_1.var_.characterEffect4040ui_story.fillRatio = var_726_4
				end
			end

			if arg_723_1.time_ >= var_726_1 + var_726_2 and arg_723_1.time_ < var_726_1 + var_726_2 + arg_726_0 and not isNil(var_726_0) and arg_723_1.var_.characterEffect4040ui_story then
				local var_726_5 = 0.5

				arg_723_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_723_1.var_.characterEffect4040ui_story.fillRatio = var_726_5
			end

			local var_726_6 = 0
			local var_726_7 = 1.175

			if var_726_6 < arg_723_1.time_ and arg_723_1.time_ <= var_726_6 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_8 = arg_723_1:GetWordFromCfg(411331170)
				local var_726_9 = arg_723_1:FormatText(var_726_8.content)

				arg_723_1.text_.text = var_726_9

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_10 = 47
				local var_726_11 = utf8.len(var_726_9)
				local var_726_12 = var_726_10 <= 0 and var_726_7 or var_726_7 * (var_726_11 / var_726_10)

				if var_726_12 > 0 and var_726_7 < var_726_12 then
					arg_723_1.talkMaxDuration = var_726_12

					if var_726_12 + var_726_6 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_12 + var_726_6
					end
				end

				arg_723_1.text_.text = var_726_9
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_13 = math.max(var_726_7, arg_723_1.talkMaxDuration)

			if var_726_6 <= arg_723_1.time_ and arg_723_1.time_ < var_726_6 + var_726_13 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_6) / var_726_13

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_6 + var_726_13 and arg_723_1.time_ < var_726_6 + var_726_13 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play411331171 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 411331171
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play411331172(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = arg_727_1.actors_["10014ui_story"].transform
			local var_730_1 = 0

			if var_730_1 < arg_727_1.time_ and arg_727_1.time_ <= var_730_1 + arg_730_0 then
				arg_727_1.var_.moveOldPos10014ui_story = var_730_0.localPosition
			end

			local var_730_2 = 0.001

			if var_730_1 <= arg_727_1.time_ and arg_727_1.time_ < var_730_1 + var_730_2 then
				local var_730_3 = (arg_727_1.time_ - var_730_1) / var_730_2
				local var_730_4 = Vector3.New(0.7, -1.06, -6.2)

				var_730_0.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos10014ui_story, var_730_4, var_730_3)

				local var_730_5 = manager.ui.mainCamera.transform.position - var_730_0.position

				var_730_0.forward = Vector3.New(var_730_5.x, var_730_5.y, var_730_5.z)

				local var_730_6 = var_730_0.localEulerAngles

				var_730_6.z = 0
				var_730_6.x = 0
				var_730_0.localEulerAngles = var_730_6
			end

			if arg_727_1.time_ >= var_730_1 + var_730_2 and arg_727_1.time_ < var_730_1 + var_730_2 + arg_730_0 then
				var_730_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_730_7 = manager.ui.mainCamera.transform.position - var_730_0.position

				var_730_0.forward = Vector3.New(var_730_7.x, var_730_7.y, var_730_7.z)

				local var_730_8 = var_730_0.localEulerAngles

				var_730_8.z = 0
				var_730_8.x = 0
				var_730_0.localEulerAngles = var_730_8
			end

			local var_730_9 = arg_727_1.actors_["10014ui_story"]
			local var_730_10 = 0

			if var_730_10 < arg_727_1.time_ and arg_727_1.time_ <= var_730_10 + arg_730_0 and not isNil(var_730_9) and arg_727_1.var_.characterEffect10014ui_story == nil then
				arg_727_1.var_.characterEffect10014ui_story = var_730_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_11 = 0.200000002980232

			if var_730_10 <= arg_727_1.time_ and arg_727_1.time_ < var_730_10 + var_730_11 and not isNil(var_730_9) then
				local var_730_12 = (arg_727_1.time_ - var_730_10) / var_730_11

				if arg_727_1.var_.characterEffect10014ui_story and not isNil(var_730_9) then
					arg_727_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= var_730_10 + var_730_11 and arg_727_1.time_ < var_730_10 + var_730_11 + arg_730_0 and not isNil(var_730_9) and arg_727_1.var_.characterEffect10014ui_story then
				arg_727_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_730_13 = 0

			if var_730_13 < arg_727_1.time_ and arg_727_1.time_ <= var_730_13 + arg_730_0 then
				arg_727_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_730_14 = 0

			if var_730_14 < arg_727_1.time_ and arg_727_1.time_ <= var_730_14 + arg_730_0 then
				arg_727_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_730_15 = 0
			local var_730_16 = 0.6

			if var_730_15 < arg_727_1.time_ and arg_727_1.time_ <= var_730_15 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				local var_730_17 = arg_727_1:FormatText(StoryNameCfg[264].name)

				arg_727_1.leftNameTxt_.text = var_730_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_18 = arg_727_1:GetWordFromCfg(411331171)
				local var_730_19 = arg_727_1:FormatText(var_730_18.content)

				arg_727_1.text_.text = var_730_19

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_20 = 24
				local var_730_21 = utf8.len(var_730_19)
				local var_730_22 = var_730_20 <= 0 and var_730_16 or var_730_16 * (var_730_21 / var_730_20)

				if var_730_22 > 0 and var_730_16 < var_730_22 then
					arg_727_1.talkMaxDuration = var_730_22

					if var_730_22 + var_730_15 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_22 + var_730_15
					end
				end

				arg_727_1.text_.text = var_730_19
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_23 = math.max(var_730_16, arg_727_1.talkMaxDuration)

			if var_730_15 <= arg_727_1.time_ and arg_727_1.time_ < var_730_15 + var_730_23 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_15) / var_730_23

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_15 + var_730_23 and arg_727_1.time_ < var_730_15 + var_730_23 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play411331172 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 411331172
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play411331173(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = arg_731_1.actors_["4040ui_story"].transform
			local var_734_1 = 0

			if var_734_1 < arg_731_1.time_ and arg_731_1.time_ <= var_734_1 + arg_734_0 then
				arg_731_1.var_.moveOldPos4040ui_story = var_734_0.localPosition
			end

			local var_734_2 = 0.001

			if var_734_1 <= arg_731_1.time_ and arg_731_1.time_ < var_734_1 + var_734_2 then
				local var_734_3 = (arg_731_1.time_ - var_734_1) / var_734_2
				local var_734_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_734_0.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos4040ui_story, var_734_4, var_734_3)

				local var_734_5 = manager.ui.mainCamera.transform.position - var_734_0.position

				var_734_0.forward = Vector3.New(var_734_5.x, var_734_5.y, var_734_5.z)

				local var_734_6 = var_734_0.localEulerAngles

				var_734_6.z = 0
				var_734_6.x = 0
				var_734_0.localEulerAngles = var_734_6
			end

			if arg_731_1.time_ >= var_734_1 + var_734_2 and arg_731_1.time_ < var_734_1 + var_734_2 + arg_734_0 then
				var_734_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_734_7 = manager.ui.mainCamera.transform.position - var_734_0.position

				var_734_0.forward = Vector3.New(var_734_7.x, var_734_7.y, var_734_7.z)

				local var_734_8 = var_734_0.localEulerAngles

				var_734_8.z = 0
				var_734_8.x = 0
				var_734_0.localEulerAngles = var_734_8
			end

			local var_734_9 = arg_731_1.actors_["4040ui_story"]
			local var_734_10 = 0

			if var_734_10 < arg_731_1.time_ and arg_731_1.time_ <= var_734_10 + arg_734_0 and not isNil(var_734_9) and arg_731_1.var_.characterEffect4040ui_story == nil then
				arg_731_1.var_.characterEffect4040ui_story = var_734_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_11 = 0.200000002980232

			if var_734_10 <= arg_731_1.time_ and arg_731_1.time_ < var_734_10 + var_734_11 and not isNil(var_734_9) then
				local var_734_12 = (arg_731_1.time_ - var_734_10) / var_734_11

				if arg_731_1.var_.characterEffect4040ui_story and not isNil(var_734_9) then
					arg_731_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= var_734_10 + var_734_11 and arg_731_1.time_ < var_734_10 + var_734_11 + arg_734_0 and not isNil(var_734_9) and arg_731_1.var_.characterEffect4040ui_story then
				arg_731_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_734_13 = 0

			if var_734_13 < arg_731_1.time_ and arg_731_1.time_ <= var_734_13 + arg_734_0 then
				arg_731_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_734_14 = 0

			if var_734_14 < arg_731_1.time_ and arg_731_1.time_ <= var_734_14 + arg_734_0 then
				arg_731_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_734_15 = arg_731_1.actors_["10014ui_story"]
			local var_734_16 = 0

			if var_734_16 < arg_731_1.time_ and arg_731_1.time_ <= var_734_16 + arg_734_0 and not isNil(var_734_15) and arg_731_1.var_.characterEffect10014ui_story == nil then
				arg_731_1.var_.characterEffect10014ui_story = var_734_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_17 = 0.200000002980232

			if var_734_16 <= arg_731_1.time_ and arg_731_1.time_ < var_734_16 + var_734_17 and not isNil(var_734_15) then
				local var_734_18 = (arg_731_1.time_ - var_734_16) / var_734_17

				if arg_731_1.var_.characterEffect10014ui_story and not isNil(var_734_15) then
					local var_734_19 = Mathf.Lerp(0, 0.5, var_734_18)

					arg_731_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_731_1.var_.characterEffect10014ui_story.fillRatio = var_734_19
				end
			end

			if arg_731_1.time_ >= var_734_16 + var_734_17 and arg_731_1.time_ < var_734_16 + var_734_17 + arg_734_0 and not isNil(var_734_15) and arg_731_1.var_.characterEffect10014ui_story then
				local var_734_20 = 0.5

				arg_731_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_731_1.var_.characterEffect10014ui_story.fillRatio = var_734_20
			end

			local var_734_21 = 0
			local var_734_22 = 0.275

			if var_734_21 < arg_731_1.time_ and arg_731_1.time_ <= var_734_21 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_23 = arg_731_1:FormatText(StoryNameCfg[668].name)

				arg_731_1.leftNameTxt_.text = var_734_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_24 = arg_731_1:GetWordFromCfg(411331172)
				local var_734_25 = arg_731_1:FormatText(var_734_24.content)

				arg_731_1.text_.text = var_734_25

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_26 = 11
				local var_734_27 = utf8.len(var_734_25)
				local var_734_28 = var_734_26 <= 0 and var_734_22 or var_734_22 * (var_734_27 / var_734_26)

				if var_734_28 > 0 and var_734_22 < var_734_28 then
					arg_731_1.talkMaxDuration = var_734_28

					if var_734_28 + var_734_21 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_28 + var_734_21
					end
				end

				arg_731_1.text_.text = var_734_25
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_29 = math.max(var_734_22, arg_731_1.talkMaxDuration)

			if var_734_21 <= arg_731_1.time_ and arg_731_1.time_ < var_734_21 + var_734_29 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_21) / var_734_29

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_21 + var_734_29 and arg_731_1.time_ < var_734_21 + var_734_29 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play411331173 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 411331173
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play411331174(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = arg_735_1.actors_["4040ui_story"]
			local var_738_1 = 0

			if var_738_1 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 and not isNil(var_738_0) and arg_735_1.var_.characterEffect4040ui_story == nil then
				arg_735_1.var_.characterEffect4040ui_story = var_738_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_2 = 0.200000002980232

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_2 and not isNil(var_738_0) then
				local var_738_3 = (arg_735_1.time_ - var_738_1) / var_738_2

				if arg_735_1.var_.characterEffect4040ui_story and not isNil(var_738_0) then
					local var_738_4 = Mathf.Lerp(0, 0.5, var_738_3)

					arg_735_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_735_1.var_.characterEffect4040ui_story.fillRatio = var_738_4
				end
			end

			if arg_735_1.time_ >= var_738_1 + var_738_2 and arg_735_1.time_ < var_738_1 + var_738_2 + arg_738_0 and not isNil(var_738_0) and arg_735_1.var_.characterEffect4040ui_story then
				local var_738_5 = 0.5

				arg_735_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_735_1.var_.characterEffect4040ui_story.fillRatio = var_738_5
			end

			local var_738_6 = 0
			local var_738_7 = 0.6

			if var_738_6 < arg_735_1.time_ and arg_735_1.time_ <= var_738_6 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, false)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_8 = arg_735_1:GetWordFromCfg(411331173)
				local var_738_9 = arg_735_1:FormatText(var_738_8.content)

				arg_735_1.text_.text = var_738_9

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_10 = 24
				local var_738_11 = utf8.len(var_738_9)
				local var_738_12 = var_738_10 <= 0 and var_738_7 or var_738_7 * (var_738_11 / var_738_10)

				if var_738_12 > 0 and var_738_7 < var_738_12 then
					arg_735_1.talkMaxDuration = var_738_12

					if var_738_12 + var_738_6 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_12 + var_738_6
					end
				end

				arg_735_1.text_.text = var_738_9
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_13 = math.max(var_738_7, arg_735_1.talkMaxDuration)

			if var_738_6 <= arg_735_1.time_ and arg_735_1.time_ < var_738_6 + var_738_13 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_6) / var_738_13

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_6 + var_738_13 and arg_735_1.time_ < var_738_6 + var_738_13 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play411331174 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 411331174
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play411331175(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = arg_739_1.actors_["4040ui_story"].transform
			local var_742_1 = 0

			if var_742_1 < arg_739_1.time_ and arg_739_1.time_ <= var_742_1 + arg_742_0 then
				arg_739_1.var_.moveOldPos4040ui_story = var_742_0.localPosition
			end

			local var_742_2 = 0.001

			if var_742_1 <= arg_739_1.time_ and arg_739_1.time_ < var_742_1 + var_742_2 then
				local var_742_3 = (arg_739_1.time_ - var_742_1) / var_742_2
				local var_742_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_742_0.localPosition = Vector3.Lerp(arg_739_1.var_.moveOldPos4040ui_story, var_742_4, var_742_3)

				local var_742_5 = manager.ui.mainCamera.transform.position - var_742_0.position

				var_742_0.forward = Vector3.New(var_742_5.x, var_742_5.y, var_742_5.z)

				local var_742_6 = var_742_0.localEulerAngles

				var_742_6.z = 0
				var_742_6.x = 0
				var_742_0.localEulerAngles = var_742_6
			end

			if arg_739_1.time_ >= var_742_1 + var_742_2 and arg_739_1.time_ < var_742_1 + var_742_2 + arg_742_0 then
				var_742_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_742_7 = manager.ui.mainCamera.transform.position - var_742_0.position

				var_742_0.forward = Vector3.New(var_742_7.x, var_742_7.y, var_742_7.z)

				local var_742_8 = var_742_0.localEulerAngles

				var_742_8.z = 0
				var_742_8.x = 0
				var_742_0.localEulerAngles = var_742_8
			end

			local var_742_9 = arg_739_1.actors_["4040ui_story"]
			local var_742_10 = 0

			if var_742_10 < arg_739_1.time_ and arg_739_1.time_ <= var_742_10 + arg_742_0 and not isNil(var_742_9) and arg_739_1.var_.characterEffect4040ui_story == nil then
				arg_739_1.var_.characterEffect4040ui_story = var_742_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_11 = 0.200000002980232

			if var_742_10 <= arg_739_1.time_ and arg_739_1.time_ < var_742_10 + var_742_11 and not isNil(var_742_9) then
				local var_742_12 = (arg_739_1.time_ - var_742_10) / var_742_11

				if arg_739_1.var_.characterEffect4040ui_story and not isNil(var_742_9) then
					arg_739_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_739_1.time_ >= var_742_10 + var_742_11 and arg_739_1.time_ < var_742_10 + var_742_11 + arg_742_0 and not isNil(var_742_9) and arg_739_1.var_.characterEffect4040ui_story then
				arg_739_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_742_13 = 0

			if var_742_13 < arg_739_1.time_ and arg_739_1.time_ <= var_742_13 + arg_742_0 then
				arg_739_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_742_14 = 0
			local var_742_15 = 0.5

			if var_742_14 < arg_739_1.time_ and arg_739_1.time_ <= var_742_14 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				local var_742_16 = arg_739_1:FormatText(StoryNameCfg[668].name)

				arg_739_1.leftNameTxt_.text = var_742_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_17 = arg_739_1:GetWordFromCfg(411331174)
				local var_742_18 = arg_739_1:FormatText(var_742_17.content)

				arg_739_1.text_.text = var_742_18

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_19 = 20
				local var_742_20 = utf8.len(var_742_18)
				local var_742_21 = var_742_19 <= 0 and var_742_15 or var_742_15 * (var_742_20 / var_742_19)

				if var_742_21 > 0 and var_742_15 < var_742_21 then
					arg_739_1.talkMaxDuration = var_742_21

					if var_742_21 + var_742_14 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_21 + var_742_14
					end
				end

				arg_739_1.text_.text = var_742_18
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_22 = math.max(var_742_15, arg_739_1.talkMaxDuration)

			if var_742_14 <= arg_739_1.time_ and arg_739_1.time_ < var_742_14 + var_742_22 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_14) / var_742_22

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_14 + var_742_22 and arg_739_1.time_ < var_742_14 + var_742_22 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_739_1:InitPlayNodeList()
	end,
	Play411331175 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 411331175
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play411331176(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = arg_743_1.actors_["4040ui_story"].transform
			local var_746_1 = 0

			if var_746_1 < arg_743_1.time_ and arg_743_1.time_ <= var_746_1 + arg_746_0 then
				arg_743_1.var_.moveOldPos4040ui_story = var_746_0.localPosition
			end

			local var_746_2 = 0.001

			if var_746_1 <= arg_743_1.time_ and arg_743_1.time_ < var_746_1 + var_746_2 then
				local var_746_3 = (arg_743_1.time_ - var_746_1) / var_746_2
				local var_746_4 = Vector3.New(0, 100, 0)

				var_746_0.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos4040ui_story, var_746_4, var_746_3)

				local var_746_5 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_5.x, var_746_5.y, var_746_5.z)

				local var_746_6 = var_746_0.localEulerAngles

				var_746_6.z = 0
				var_746_6.x = 0
				var_746_0.localEulerAngles = var_746_6
			end

			if arg_743_1.time_ >= var_746_1 + var_746_2 and arg_743_1.time_ < var_746_1 + var_746_2 + arg_746_0 then
				var_746_0.localPosition = Vector3.New(0, 100, 0)

				local var_746_7 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_7.x, var_746_7.y, var_746_7.z)

				local var_746_8 = var_746_0.localEulerAngles

				var_746_8.z = 0
				var_746_8.x = 0
				var_746_0.localEulerAngles = var_746_8
			end

			local var_746_9 = arg_743_1.actors_["4040ui_story"]
			local var_746_10 = 0

			if var_746_10 < arg_743_1.time_ and arg_743_1.time_ <= var_746_10 + arg_746_0 and not isNil(var_746_9) and arg_743_1.var_.characterEffect4040ui_story == nil then
				arg_743_1.var_.characterEffect4040ui_story = var_746_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_11 = 0.200000002980232

			if var_746_10 <= arg_743_1.time_ and arg_743_1.time_ < var_746_10 + var_746_11 and not isNil(var_746_9) then
				local var_746_12 = (arg_743_1.time_ - var_746_10) / var_746_11

				if arg_743_1.var_.characterEffect4040ui_story and not isNil(var_746_9) then
					local var_746_13 = Mathf.Lerp(0, 0.5, var_746_12)

					arg_743_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_743_1.var_.characterEffect4040ui_story.fillRatio = var_746_13
				end
			end

			if arg_743_1.time_ >= var_746_10 + var_746_11 and arg_743_1.time_ < var_746_10 + var_746_11 + arg_746_0 and not isNil(var_746_9) and arg_743_1.var_.characterEffect4040ui_story then
				local var_746_14 = 0.5

				arg_743_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_743_1.var_.characterEffect4040ui_story.fillRatio = var_746_14
			end

			local var_746_15 = arg_743_1.actors_["10014ui_story"].transform
			local var_746_16 = 0

			if var_746_16 < arg_743_1.time_ and arg_743_1.time_ <= var_746_16 + arg_746_0 then
				arg_743_1.var_.moveOldPos10014ui_story = var_746_15.localPosition
			end

			local var_746_17 = 0.001

			if var_746_16 <= arg_743_1.time_ and arg_743_1.time_ < var_746_16 + var_746_17 then
				local var_746_18 = (arg_743_1.time_ - var_746_16) / var_746_17
				local var_746_19 = Vector3.New(0, 100, 0)

				var_746_15.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos10014ui_story, var_746_19, var_746_18)

				local var_746_20 = manager.ui.mainCamera.transform.position - var_746_15.position

				var_746_15.forward = Vector3.New(var_746_20.x, var_746_20.y, var_746_20.z)

				local var_746_21 = var_746_15.localEulerAngles

				var_746_21.z = 0
				var_746_21.x = 0
				var_746_15.localEulerAngles = var_746_21
			end

			if arg_743_1.time_ >= var_746_16 + var_746_17 and arg_743_1.time_ < var_746_16 + var_746_17 + arg_746_0 then
				var_746_15.localPosition = Vector3.New(0, 100, 0)

				local var_746_22 = manager.ui.mainCamera.transform.position - var_746_15.position

				var_746_15.forward = Vector3.New(var_746_22.x, var_746_22.y, var_746_22.z)

				local var_746_23 = var_746_15.localEulerAngles

				var_746_23.z = 0
				var_746_23.x = 0
				var_746_15.localEulerAngles = var_746_23
			end

			local var_746_24 = arg_743_1.actors_["10014ui_story"]
			local var_746_25 = 0

			if var_746_25 < arg_743_1.time_ and arg_743_1.time_ <= var_746_25 + arg_746_0 and not isNil(var_746_24) and arg_743_1.var_.characterEffect10014ui_story == nil then
				arg_743_1.var_.characterEffect10014ui_story = var_746_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_26 = 0.200000002980232

			if var_746_25 <= arg_743_1.time_ and arg_743_1.time_ < var_746_25 + var_746_26 and not isNil(var_746_24) then
				local var_746_27 = (arg_743_1.time_ - var_746_25) / var_746_26

				if arg_743_1.var_.characterEffect10014ui_story and not isNil(var_746_24) then
					local var_746_28 = Mathf.Lerp(0, 0.5, var_746_27)

					arg_743_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_743_1.var_.characterEffect10014ui_story.fillRatio = var_746_28
				end
			end

			if arg_743_1.time_ >= var_746_25 + var_746_26 and arg_743_1.time_ < var_746_25 + var_746_26 + arg_746_0 and not isNil(var_746_24) and arg_743_1.var_.characterEffect10014ui_story then
				local var_746_29 = 0.5

				arg_743_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_743_1.var_.characterEffect10014ui_story.fillRatio = var_746_29
			end

			local var_746_30 = 0
			local var_746_31 = 1.325

			if var_746_30 < arg_743_1.time_ and arg_743_1.time_ <= var_746_30 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, false)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_32 = arg_743_1:GetWordFromCfg(411331175)
				local var_746_33 = arg_743_1:FormatText(var_746_32.content)

				arg_743_1.text_.text = var_746_33

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_34 = 53
				local var_746_35 = utf8.len(var_746_33)
				local var_746_36 = var_746_34 <= 0 and var_746_31 or var_746_31 * (var_746_35 / var_746_34)

				if var_746_36 > 0 and var_746_31 < var_746_36 then
					arg_743_1.talkMaxDuration = var_746_36

					if var_746_36 + var_746_30 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_36 + var_746_30
					end
				end

				arg_743_1.text_.text = var_746_33
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_37 = math.max(var_746_31, arg_743_1.talkMaxDuration)

			if var_746_30 <= arg_743_1.time_ and arg_743_1.time_ < var_746_30 + var_746_37 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_30) / var_746_37

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_30 + var_746_37 and arg_743_1.time_ < var_746_30 + var_746_37 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_743_1:InitPlayNodeList()
	end,
	Play411331176 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 411331176
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play411331177(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = arg_747_1.actors_["10014ui_story"].transform
			local var_750_1 = 0

			if var_750_1 < arg_747_1.time_ and arg_747_1.time_ <= var_750_1 + arg_750_0 then
				arg_747_1.var_.moveOldPos10014ui_story = var_750_0.localPosition
			end

			local var_750_2 = 0.001

			if var_750_1 <= arg_747_1.time_ and arg_747_1.time_ < var_750_1 + var_750_2 then
				local var_750_3 = (arg_747_1.time_ - var_750_1) / var_750_2
				local var_750_4 = Vector3.New(0, -1.06, -6.2)

				var_750_0.localPosition = Vector3.Lerp(arg_747_1.var_.moveOldPos10014ui_story, var_750_4, var_750_3)

				local var_750_5 = manager.ui.mainCamera.transform.position - var_750_0.position

				var_750_0.forward = Vector3.New(var_750_5.x, var_750_5.y, var_750_5.z)

				local var_750_6 = var_750_0.localEulerAngles

				var_750_6.z = 0
				var_750_6.x = 0
				var_750_0.localEulerAngles = var_750_6
			end

			if arg_747_1.time_ >= var_750_1 + var_750_2 and arg_747_1.time_ < var_750_1 + var_750_2 + arg_750_0 then
				var_750_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_750_7 = manager.ui.mainCamera.transform.position - var_750_0.position

				var_750_0.forward = Vector3.New(var_750_7.x, var_750_7.y, var_750_7.z)

				local var_750_8 = var_750_0.localEulerAngles

				var_750_8.z = 0
				var_750_8.x = 0
				var_750_0.localEulerAngles = var_750_8
			end

			local var_750_9 = arg_747_1.actors_["10014ui_story"]
			local var_750_10 = 0

			if var_750_10 < arg_747_1.time_ and arg_747_1.time_ <= var_750_10 + arg_750_0 and not isNil(var_750_9) and arg_747_1.var_.characterEffect10014ui_story == nil then
				arg_747_1.var_.characterEffect10014ui_story = var_750_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_11 = 0.200000002980232

			if var_750_10 <= arg_747_1.time_ and arg_747_1.time_ < var_750_10 + var_750_11 and not isNil(var_750_9) then
				local var_750_12 = (arg_747_1.time_ - var_750_10) / var_750_11

				if arg_747_1.var_.characterEffect10014ui_story and not isNil(var_750_9) then
					arg_747_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_747_1.time_ >= var_750_10 + var_750_11 and arg_747_1.time_ < var_750_10 + var_750_11 + arg_750_0 and not isNil(var_750_9) and arg_747_1.var_.characterEffect10014ui_story then
				arg_747_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_750_13 = 0

			if var_750_13 < arg_747_1.time_ and arg_747_1.time_ <= var_750_13 + arg_750_0 then
				arg_747_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_750_14 = 0

			if var_750_14 < arg_747_1.time_ and arg_747_1.time_ <= var_750_14 + arg_750_0 then
				arg_747_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_750_15 = 0
			local var_750_16 = 0.075

			if var_750_15 < arg_747_1.time_ and arg_747_1.time_ <= var_750_15 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_17 = arg_747_1:FormatText(StoryNameCfg[264].name)

				arg_747_1.leftNameTxt_.text = var_750_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_18 = arg_747_1:GetWordFromCfg(411331176)
				local var_750_19 = arg_747_1:FormatText(var_750_18.content)

				arg_747_1.text_.text = var_750_19

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_20 = 3
				local var_750_21 = utf8.len(var_750_19)
				local var_750_22 = var_750_20 <= 0 and var_750_16 or var_750_16 * (var_750_21 / var_750_20)

				if var_750_22 > 0 and var_750_16 < var_750_22 then
					arg_747_1.talkMaxDuration = var_750_22

					if var_750_22 + var_750_15 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_22 + var_750_15
					end
				end

				arg_747_1.text_.text = var_750_19
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_23 = math.max(var_750_16, arg_747_1.talkMaxDuration)

			if var_750_15 <= arg_747_1.time_ and arg_747_1.time_ < var_750_15 + var_750_23 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_15) / var_750_23

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_15 + var_750_23 and arg_747_1.time_ < var_750_15 + var_750_23 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_747_1:InitPlayNodeList()
	end,
	Play411331177 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 411331177
		arg_751_1.duration_ = 5

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play411331178(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = 0

			if var_754_0 < arg_751_1.time_ and arg_751_1.time_ <= var_754_0 + arg_754_0 then
				arg_751_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_754_1 = 0
			local var_754_2 = 0.4

			if var_754_1 < arg_751_1.time_ and arg_751_1.time_ <= var_754_1 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				local var_754_3 = arg_751_1:FormatText(StoryNameCfg[264].name)

				arg_751_1.leftNameTxt_.text = var_754_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_4 = arg_751_1:GetWordFromCfg(411331177)
				local var_754_5 = arg_751_1:FormatText(var_754_4.content)

				arg_751_1.text_.text = var_754_5

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_6 = 16
				local var_754_7 = utf8.len(var_754_5)
				local var_754_8 = var_754_6 <= 0 and var_754_2 or var_754_2 * (var_754_7 / var_754_6)

				if var_754_8 > 0 and var_754_2 < var_754_8 then
					arg_751_1.talkMaxDuration = var_754_8

					if var_754_8 + var_754_1 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_8 + var_754_1
					end
				end

				arg_751_1.text_.text = var_754_5
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)
				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_9 = math.max(var_754_2, arg_751_1.talkMaxDuration)

			if var_754_1 <= arg_751_1.time_ and arg_751_1.time_ < var_754_1 + var_754_9 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_1) / var_754_9

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_1 + var_754_9 and arg_751_1.time_ < var_754_1 + var_754_9 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play411331178 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 411331178
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play411331179(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = arg_755_1.actors_["10014ui_story"].transform
			local var_758_1 = 0

			if var_758_1 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 then
				arg_755_1.var_.moveOldPos10014ui_story = var_758_0.localPosition
			end

			local var_758_2 = 0.001

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_2 then
				local var_758_3 = (arg_755_1.time_ - var_758_1) / var_758_2
				local var_758_4 = Vector3.New(0, 100, 0)

				var_758_0.localPosition = Vector3.Lerp(arg_755_1.var_.moveOldPos10014ui_story, var_758_4, var_758_3)

				local var_758_5 = manager.ui.mainCamera.transform.position - var_758_0.position

				var_758_0.forward = Vector3.New(var_758_5.x, var_758_5.y, var_758_5.z)

				local var_758_6 = var_758_0.localEulerAngles

				var_758_6.z = 0
				var_758_6.x = 0
				var_758_0.localEulerAngles = var_758_6
			end

			if arg_755_1.time_ >= var_758_1 + var_758_2 and arg_755_1.time_ < var_758_1 + var_758_2 + arg_758_0 then
				var_758_0.localPosition = Vector3.New(0, 100, 0)

				local var_758_7 = manager.ui.mainCamera.transform.position - var_758_0.position

				var_758_0.forward = Vector3.New(var_758_7.x, var_758_7.y, var_758_7.z)

				local var_758_8 = var_758_0.localEulerAngles

				var_758_8.z = 0
				var_758_8.x = 0
				var_758_0.localEulerAngles = var_758_8
			end

			local var_758_9 = arg_755_1.actors_["10014ui_story"]
			local var_758_10 = 0

			if var_758_10 < arg_755_1.time_ and arg_755_1.time_ <= var_758_10 + arg_758_0 and not isNil(var_758_9) and arg_755_1.var_.characterEffect10014ui_story == nil then
				arg_755_1.var_.characterEffect10014ui_story = var_758_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_11 = 0.200000002980232

			if var_758_10 <= arg_755_1.time_ and arg_755_1.time_ < var_758_10 + var_758_11 and not isNil(var_758_9) then
				local var_758_12 = (arg_755_1.time_ - var_758_10) / var_758_11

				if arg_755_1.var_.characterEffect10014ui_story and not isNil(var_758_9) then
					local var_758_13 = Mathf.Lerp(0, 0.5, var_758_12)

					arg_755_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_755_1.var_.characterEffect10014ui_story.fillRatio = var_758_13
				end
			end

			if arg_755_1.time_ >= var_758_10 + var_758_11 and arg_755_1.time_ < var_758_10 + var_758_11 + arg_758_0 and not isNil(var_758_9) and arg_755_1.var_.characterEffect10014ui_story then
				local var_758_14 = 0.5

				arg_755_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_755_1.var_.characterEffect10014ui_story.fillRatio = var_758_14
			end

			local var_758_15 = 0
			local var_758_16 = 1.3

			if var_758_15 < arg_755_1.time_ and arg_755_1.time_ <= var_758_15 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, false)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_17 = arg_755_1:GetWordFromCfg(411331178)
				local var_758_18 = arg_755_1:FormatText(var_758_17.content)

				arg_755_1.text_.text = var_758_18

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_19 = 52
				local var_758_20 = utf8.len(var_758_18)
				local var_758_21 = var_758_19 <= 0 and var_758_16 or var_758_16 * (var_758_20 / var_758_19)

				if var_758_21 > 0 and var_758_16 < var_758_21 then
					arg_755_1.talkMaxDuration = var_758_21

					if var_758_21 + var_758_15 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_21 + var_758_15
					end
				end

				arg_755_1.text_.text = var_758_18
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_22 = math.max(var_758_16, arg_755_1.talkMaxDuration)

			if var_758_15 <= arg_755_1.time_ and arg_755_1.time_ < var_758_15 + var_758_22 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_15) / var_758_22

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_15 + var_758_22 and arg_755_1.time_ < var_758_15 + var_758_22 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_755_1:InitPlayNodeList()
	end,
	Play411331179 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 411331179
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play411331180(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = manager.ui.mainCamera.transform
			local var_762_1 = 0

			if var_762_1 < arg_759_1.time_ and arg_759_1.time_ <= var_762_1 + arg_762_0 then
				local var_762_2 = arg_759_1.var_.effectshiwang2
				local var_762_3
				local var_762_4 = var_762_0

				if not var_762_2 then
					var_762_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_762_4)
					var_762_2.name = "shiwang2"
					arg_759_1.var_.effectshiwang2 = var_762_2
				else
					var_762_2.transform:SetParent(var_762_4)
				end

				var_762_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_762_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_762_5 = 0
			local var_762_6 = 0.425

			if var_762_5 < arg_759_1.time_ and arg_759_1.time_ <= var_762_5 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, false)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_7 = arg_759_1:GetWordFromCfg(411331179)
				local var_762_8 = arg_759_1:FormatText(var_762_7.content)

				arg_759_1.text_.text = var_762_8

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_9 = 17
				local var_762_10 = utf8.len(var_762_8)
				local var_762_11 = var_762_9 <= 0 and var_762_6 or var_762_6 * (var_762_10 / var_762_9)

				if var_762_11 > 0 and var_762_6 < var_762_11 then
					arg_759_1.talkMaxDuration = var_762_11

					if var_762_11 + var_762_5 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_11 + var_762_5
					end
				end

				arg_759_1.text_.text = var_762_8
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_12 = math.max(var_762_6, arg_759_1.talkMaxDuration)

			if var_762_5 <= arg_759_1.time_ and arg_759_1.time_ < var_762_5 + var_762_12 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_5) / var_762_12

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_5 + var_762_12 and arg_759_1.time_ < var_762_5 + var_762_12 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {}

		arg_759_1:InitPlayNodeList()
	end,
	Play411331180 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 411331180
		arg_763_1.duration_ = 5

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play411331181(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0
			local var_766_1 = 0.9

			if var_766_0 < arg_763_1.time_ and arg_763_1.time_ <= var_766_0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, false)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_2 = arg_763_1:GetWordFromCfg(411331180)
				local var_766_3 = arg_763_1:FormatText(var_766_2.content)

				arg_763_1.text_.text = var_766_3

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_4 = 36
				local var_766_5 = utf8.len(var_766_3)
				local var_766_6 = var_766_4 <= 0 and var_766_1 or var_766_1 * (var_766_5 / var_766_4)

				if var_766_6 > 0 and var_766_1 < var_766_6 then
					arg_763_1.talkMaxDuration = var_766_6

					if var_766_6 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_6 + var_766_0
					end
				end

				arg_763_1.text_.text = var_766_3
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)
				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_7 = math.max(var_766_1, arg_763_1.talkMaxDuration)

			if var_766_0 <= arg_763_1.time_ and arg_763_1.time_ < var_766_0 + var_766_7 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_0) / var_766_7

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_0 + var_766_7 and arg_763_1.time_ < var_766_0 + var_766_7 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play411331181 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 411331181
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
			arg_767_1.auto_ = false
		end

		function arg_767_1.playNext_(arg_769_0)
			arg_767_1.onStoryFinished_()
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = arg_767_1.actors_["4040ui_story"].transform
			local var_770_1 = 0

			if var_770_1 < arg_767_1.time_ and arg_767_1.time_ <= var_770_1 + arg_770_0 then
				arg_767_1.var_.moveOldPos4040ui_story = var_770_0.localPosition
			end

			local var_770_2 = 0.001

			if var_770_1 <= arg_767_1.time_ and arg_767_1.time_ < var_770_1 + var_770_2 then
				local var_770_3 = (arg_767_1.time_ - var_770_1) / var_770_2
				local var_770_4 = Vector3.New(0, -1.55, -5.5)

				var_770_0.localPosition = Vector3.Lerp(arg_767_1.var_.moveOldPos4040ui_story, var_770_4, var_770_3)

				local var_770_5 = manager.ui.mainCamera.transform.position - var_770_0.position

				var_770_0.forward = Vector3.New(var_770_5.x, var_770_5.y, var_770_5.z)

				local var_770_6 = var_770_0.localEulerAngles

				var_770_6.z = 0
				var_770_6.x = 0
				var_770_0.localEulerAngles = var_770_6
			end

			if arg_767_1.time_ >= var_770_1 + var_770_2 and arg_767_1.time_ < var_770_1 + var_770_2 + arg_770_0 then
				var_770_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_770_7 = manager.ui.mainCamera.transform.position - var_770_0.position

				var_770_0.forward = Vector3.New(var_770_7.x, var_770_7.y, var_770_7.z)

				local var_770_8 = var_770_0.localEulerAngles

				var_770_8.z = 0
				var_770_8.x = 0
				var_770_0.localEulerAngles = var_770_8
			end

			local var_770_9 = arg_767_1.actors_["4040ui_story"]
			local var_770_10 = 0

			if var_770_10 < arg_767_1.time_ and arg_767_1.time_ <= var_770_10 + arg_770_0 and not isNil(var_770_9) and arg_767_1.var_.characterEffect4040ui_story == nil then
				arg_767_1.var_.characterEffect4040ui_story = var_770_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_11 = 0.200000002980232

			if var_770_10 <= arg_767_1.time_ and arg_767_1.time_ < var_770_10 + var_770_11 and not isNil(var_770_9) then
				local var_770_12 = (arg_767_1.time_ - var_770_10) / var_770_11

				if arg_767_1.var_.characterEffect4040ui_story and not isNil(var_770_9) then
					arg_767_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_767_1.time_ >= var_770_10 + var_770_11 and arg_767_1.time_ < var_770_10 + var_770_11 + arg_770_0 and not isNil(var_770_9) and arg_767_1.var_.characterEffect4040ui_story then
				arg_767_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_770_13 = 0

			if var_770_13 < arg_767_1.time_ and arg_767_1.time_ <= var_770_13 + arg_770_0 then
				arg_767_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_770_14 = 0

			if var_770_14 < arg_767_1.time_ and arg_767_1.time_ <= var_770_14 + arg_770_0 then
				arg_767_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_770_15 = manager.ui.mainCamera.transform
			local var_770_16 = 0

			if var_770_16 < arg_767_1.time_ and arg_767_1.time_ <= var_770_16 + arg_770_0 then
				local var_770_17 = arg_767_1.var_.effectshiwang2

				if var_770_17 then
					Object.Destroy(var_770_17)

					arg_767_1.var_.effectshiwang2 = nil
				end
			end

			local var_770_18 = 0
			local var_770_19 = 0.35

			if var_770_18 < arg_767_1.time_ and arg_767_1.time_ <= var_770_18 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				local var_770_20 = arg_767_1:FormatText(StoryNameCfg[668].name)

				arg_767_1.leftNameTxt_.text = var_770_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_21 = arg_767_1:GetWordFromCfg(411331181)
				local var_770_22 = arg_767_1:FormatText(var_770_21.content)

				arg_767_1.text_.text = var_770_22

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_23 = 14
				local var_770_24 = utf8.len(var_770_22)
				local var_770_25 = var_770_23 <= 0 and var_770_19 or var_770_19 * (var_770_24 / var_770_23)

				if var_770_25 > 0 and var_770_19 < var_770_25 then
					arg_767_1.talkMaxDuration = var_770_25

					if var_770_25 + var_770_18 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_25 + var_770_18
					end
				end

				arg_767_1.text_.text = var_770_22
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_26 = math.max(var_770_19, arg_767_1.talkMaxDuration)

			if var_770_18 <= arg_767_1.time_ and arg_767_1.time_ < var_770_18 + var_770_26 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_18) / var_770_26

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_18 + var_770_26 and arg_767_1.time_ < var_770_18 + var_770_26 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_767_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/D10",
		"TextureConfig/Background/ML0107"
	},
	voices = {}
}
