return {
	Play319591001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319591001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319591002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I12h"

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
				local var_4_5 = arg_1_1.bgs_.I12h

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
					if iter_4_0 ~= "I12h" then
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
			local var_4_23 = 0.0666666666666667

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 0.875

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(319591001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 35
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319591002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319591002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319591003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.8

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(319591002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 32
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319591003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319591003
		arg_12_1.duration_ = 4.77

		local var_12_0 = {
			zh = 3.999999999999,
			ja = 4.766
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319591004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "A08f"

			if arg_12_1.bgs_[var_15_0] == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			local var_15_2 = 2

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_3 = manager.ui.mainCamera.transform.localPosition
				local var_15_4 = Vector3.New(0, 0, 10) + Vector3.New(var_15_3.x, var_15_3.y, 0)
				local var_15_5 = arg_12_1.bgs_.A08f

				var_15_5.transform.localPosition = var_15_4
				var_15_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_6 = var_15_5:GetComponent("SpriteRenderer")

				if var_15_6 and var_15_6.sprite then
					local var_15_7 = (var_15_5.transform.localPosition - var_15_3).z
					local var_15_8 = manager.ui.mainCameraCom_
					local var_15_9 = 2 * var_15_7 * Mathf.Tan(var_15_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_10 = var_15_9 * var_15_8.aspect
					local var_15_11 = var_15_6.sprite.bounds.size.x
					local var_15_12 = var_15_6.sprite.bounds.size.y
					local var_15_13 = var_15_10 / var_15_11
					local var_15_14 = var_15_9 / var_15_12
					local var_15_15 = var_15_14 < var_15_13 and var_15_13 or var_15_14

					var_15_5.transform.localScale = Vector3.New(var_15_15, var_15_15, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "A08f" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_17 = 2

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_17 then
				local var_15_18 = (arg_12_1.time_ - var_15_16) / var_15_17
				local var_15_19 = Color.New(0, 0, 0)

				var_15_19.a = Mathf.Lerp(0, 1, var_15_18)
				arg_12_1.mask_.color = var_15_19
			end

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				local var_15_20 = Color.New(0, 0, 0)

				var_15_20.a = 1
				arg_12_1.mask_.color = var_15_20
			end

			local var_15_21 = 2

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_22 = 2

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_22 then
				local var_15_23 = (arg_12_1.time_ - var_15_21) / var_15_22
				local var_15_24 = Color.New(0, 0, 0)

				var_15_24.a = Mathf.Lerp(1, 0, var_15_23)
				arg_12_1.mask_.color = var_15_24
			end

			if arg_12_1.time_ >= var_15_21 + var_15_22 and arg_12_1.time_ < var_15_21 + var_15_22 + arg_15_0 then
				local var_15_25 = Color.New(0, 0, 0)
				local var_15_26 = 0

				arg_12_1.mask_.enabled = false
				var_15_25.a = var_15_26
				arg_12_1.mask_.color = var_15_25
			end

			local var_15_27 = "4040ui_story"

			if arg_12_1.actors_[var_15_27] == nil then
				local var_15_28 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_15_28) then
					local var_15_29 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_12_1.stage_.transform)

					var_15_29.name = var_15_27
					var_15_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_27] = var_15_29

					local var_15_30 = var_15_29:GetComponentInChildren(typeof(CharacterEffect))

					var_15_30.enabled = true

					local var_15_31 = GameObjectTools.GetOrAddComponent(var_15_29, typeof(DynamicBoneHelper))

					if var_15_31 then
						var_15_31:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_30.transform, false)

					arg_12_1.var_[var_15_27 .. "Animator"] = var_15_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_27 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_27 .. "LipSync"] = var_15_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_32 = arg_12_1.actors_["4040ui_story"].transform
			local var_15_33 = 2

			if var_15_33 < arg_12_1.time_ and arg_12_1.time_ <= var_15_33 + arg_15_0 then
				arg_12_1.var_.moveOldPos4040ui_story = var_15_32.localPosition
			end

			local var_15_34 = 0.001

			if var_15_33 <= arg_12_1.time_ and arg_12_1.time_ < var_15_33 + var_15_34 then
				local var_15_35 = (arg_12_1.time_ - var_15_33) / var_15_34
				local var_15_36 = Vector3.New(0, -1.55, -5.5)

				var_15_32.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos4040ui_story, var_15_36, var_15_35)

				local var_15_37 = manager.ui.mainCamera.transform.position - var_15_32.position

				var_15_32.forward = Vector3.New(var_15_37.x, var_15_37.y, var_15_37.z)

				local var_15_38 = var_15_32.localEulerAngles

				var_15_38.z = 0
				var_15_38.x = 0
				var_15_32.localEulerAngles = var_15_38
			end

			if arg_12_1.time_ >= var_15_33 + var_15_34 and arg_12_1.time_ < var_15_33 + var_15_34 + arg_15_0 then
				var_15_32.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_15_39 = manager.ui.mainCamera.transform.position - var_15_32.position

				var_15_32.forward = Vector3.New(var_15_39.x, var_15_39.y, var_15_39.z)

				local var_15_40 = var_15_32.localEulerAngles

				var_15_40.z = 0
				var_15_40.x = 0
				var_15_32.localEulerAngles = var_15_40
			end

			local var_15_41 = arg_12_1.actors_["4040ui_story"]
			local var_15_42 = 2

			if var_15_42 < arg_12_1.time_ and arg_12_1.time_ <= var_15_42 + arg_15_0 and not isNil(var_15_41) and arg_12_1.var_.characterEffect4040ui_story == nil then
				arg_12_1.var_.characterEffect4040ui_story = var_15_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_43 = 0.200000002980232

			if var_15_42 <= arg_12_1.time_ and arg_12_1.time_ < var_15_42 + var_15_43 and not isNil(var_15_41) then
				local var_15_44 = (arg_12_1.time_ - var_15_42) / var_15_43

				if arg_12_1.var_.characterEffect4040ui_story and not isNil(var_15_41) then
					arg_12_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_42 + var_15_43 and arg_12_1.time_ < var_15_42 + var_15_43 + arg_15_0 and not isNil(var_15_41) and arg_12_1.var_.characterEffect4040ui_story then
				arg_12_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_15_45 = 2

			if var_15_45 < arg_12_1.time_ and arg_12_1.time_ <= var_15_45 + arg_15_0 then
				arg_12_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_15_46 = 2

			if var_15_46 < arg_12_1.time_ and arg_12_1.time_ <= var_15_46 + arg_15_0 then
				arg_12_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_15_47 = 0
			local var_15_48 = 0.0666666666666667

			if var_15_47 < arg_12_1.time_ and arg_12_1.time_ <= var_15_47 + arg_15_0 then
				local var_15_49 = "play"
				local var_15_50 = "music"

				arg_12_1:AudioAction(var_15_49, var_15_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_15_51 = ""
				local var_15_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_15_52 ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_52 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_52

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_52
						arg_12_1.bgmTxt2_.text = var_15_52
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_15_53 = 0.1
			local var_15_54 = 1

			if var_15_53 < arg_12_1.time_ and arg_12_1.time_ <= var_15_53 + arg_15_0 then
				local var_15_55 = "play"
				local var_15_56 = "music"

				arg_12_1:AudioAction(var_15_55, var_15_56, "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_15_57 = ""
				local var_15_58 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

				if var_15_58 ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_58 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_58

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_58
						arg_12_1.bgmTxt2_.text = var_15_58
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_59 = 2
			local var_15_60 = 0.175

			if var_15_59 < arg_12_1.time_ and arg_12_1.time_ <= var_15_59 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_61 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_61:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_12_1.dialogCg_.alpha = arg_18_0
				end))
				var_15_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_62 = arg_12_1:FormatText(StoryNameCfg[668].name)

				arg_12_1.leftNameTxt_.text = var_15_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_63 = arg_12_1:GetWordFromCfg(319591003)
				local var_15_64 = arg_12_1:FormatText(var_15_63.content)

				arg_12_1.text_.text = var_15_64

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_65 = 7
				local var_15_66 = utf8.len(var_15_64)
				local var_15_67 = var_15_65 <= 0 and var_15_60 or var_15_60 * (var_15_66 / var_15_65)

				if var_15_67 > 0 and var_15_60 < var_15_67 then
					arg_12_1.talkMaxDuration = var_15_67
					var_15_59 = var_15_59 + 0.3

					if var_15_67 + var_15_59 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_67 + var_15_59
					end
				end

				arg_12_1.text_.text = var_15_64
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591003", "story_v_out_319591.awb") ~= 0 then
					local var_15_68 = manager.audio:GetVoiceLength("story_v_out_319591", "319591003", "story_v_out_319591.awb") / 1000

					if var_15_68 + var_15_59 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_68 + var_15_59
					end

					if var_15_63.prefab_name ~= "" and arg_12_1.actors_[var_15_63.prefab_name] ~= nil then
						local var_15_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_63.prefab_name].transform, "story_v_out_319591", "319591003", "story_v_out_319591.awb")

						arg_12_1:RecordAudio("319591003", var_15_69)
						arg_12_1:RecordAudio("319591003", var_15_69)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_319591", "319591003", "story_v_out_319591.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_319591", "319591003", "story_v_out_319591.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_70 = var_15_59 + 0.3
			local var_15_71 = math.max(var_15_60, arg_12_1.talkMaxDuration)

			if var_15_70 <= arg_12_1.time_ and arg_12_1.time_ < var_15_70 + var_15_71 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_70) / var_15_71

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_70 + var_15_71 and arg_12_1.time_ < var_15_70 + var_15_71 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play319591004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319591004
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319591005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["4040ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect4040ui_story == nil then
				arg_20_1.var_.characterEffect4040ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect4040ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_20_1.var_.characterEffect4040ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect4040ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_20_1.var_.characterEffect4040ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 1.25

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(319591004)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 49
				local var_23_11 = utf8.len(var_23_9)
				local var_23_12 = var_23_10 <= 0 and var_23_7 or var_23_7 * (var_23_11 / var_23_10)

				if var_23_12 > 0 and var_23_7 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_13 and arg_20_1.time_ < var_23_6 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319591005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319591005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319591006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.9

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(319591005)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 36
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319591006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319591006
		arg_28_1.duration_ = 2.6

		local var_28_0 = {
			zh = 2,
			ja = 2.6
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
				arg_28_0:Play319591007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["4040ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4040ui_story == nil then
				arg_28_1.var_.characterEffect4040ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect4040ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4040ui_story then
				arg_28_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_31_4 = 0
			local var_31_5 = 0.175

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_6 = arg_28_1:FormatText(StoryNameCfg[668].name)

				arg_28_1.leftNameTxt_.text = var_31_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:GetWordFromCfg(319591006)
				local var_31_8 = arg_28_1:FormatText(var_31_7.content)

				arg_28_1.text_.text = var_31_8

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 7
				local var_31_10 = utf8.len(var_31_8)
				local var_31_11 = var_31_9 <= 0 and var_31_5 or var_31_5 * (var_31_10 / var_31_9)

				if var_31_11 > 0 and var_31_5 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_8
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591006", "story_v_out_319591.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591006", "story_v_out_319591.awb") / 1000

					if var_31_12 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_4
					end

					if var_31_7.prefab_name ~= "" and arg_28_1.actors_[var_31_7.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_7.prefab_name].transform, "story_v_out_319591", "319591006", "story_v_out_319591.awb")

						arg_28_1:RecordAudio("319591006", var_31_13)
						arg_28_1:RecordAudio("319591006", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_319591", "319591006", "story_v_out_319591.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_319591", "319591006", "story_v_out_319591.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_14 and arg_28_1.time_ < var_31_4 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319591007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319591007
		arg_32_1.duration_ = 5.5

		local var_32_0 = {
			zh = 2.7,
			ja = 5.5
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
				arg_32_0:Play319591008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "10079ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["10079ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos10079ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0.7, -0.95, -6.05)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10079ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["10079ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect10079ui_story == nil then
				arg_32_1.var_.characterEffect10079ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect10079ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect10079ui_story then
				arg_32_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_35_20 = arg_32_1.actors_["4040ui_story"].transform
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.var_.moveOldPos4040ui_story = var_35_20.localPosition
			end

			local var_35_22 = 0.001

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22
				local var_35_24 = Vector3.New(-0.7, -1.55, -5.5)

				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4040ui_story, var_35_24, var_35_23)

				local var_35_25 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_25.x, var_35_25.y, var_35_25.z)

				local var_35_26 = var_35_20.localEulerAngles

				var_35_26.z = 0
				var_35_26.x = 0
				var_35_20.localEulerAngles = var_35_26
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_35_27 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_27.x, var_35_27.y, var_35_27.z)

				local var_35_28 = var_35_20.localEulerAngles

				var_35_28.z = 0
				var_35_28.x = 0
				var_35_20.localEulerAngles = var_35_28
			end

			local var_35_29 = arg_32_1.actors_["4040ui_story"]
			local var_35_30 = 0

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect4040ui_story == nil then
				arg_32_1.var_.characterEffect4040ui_story = var_35_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_31 = 0.200000002980232

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_31 and not isNil(var_35_29) then
				local var_35_32 = (arg_32_1.time_ - var_35_30) / var_35_31

				if arg_32_1.var_.characterEffect4040ui_story and not isNil(var_35_29) then
					local var_35_33 = Mathf.Lerp(0, 0.5, var_35_32)

					arg_32_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_32_1.var_.characterEffect4040ui_story.fillRatio = var_35_33
				end
			end

			if arg_32_1.time_ >= var_35_30 + var_35_31 and arg_32_1.time_ < var_35_30 + var_35_31 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect4040ui_story then
				local var_35_34 = 0.5

				arg_32_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_32_1.var_.characterEffect4040ui_story.fillRatio = var_35_34
			end

			local var_35_35 = 0
			local var_35_36 = 0.225

			if var_35_35 < arg_32_1.time_ and arg_32_1.time_ <= var_35_35 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_37 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_38 = arg_32_1:GetWordFromCfg(319591007)
				local var_35_39 = arg_32_1:FormatText(var_35_38.content)

				arg_32_1.text_.text = var_35_39

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_40 = 9
				local var_35_41 = utf8.len(var_35_39)
				local var_35_42 = var_35_40 <= 0 and var_35_36 or var_35_36 * (var_35_41 / var_35_40)

				if var_35_42 > 0 and var_35_36 < var_35_42 then
					arg_32_1.talkMaxDuration = var_35_42

					if var_35_42 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_42 + var_35_35
					end
				end

				arg_32_1.text_.text = var_35_39
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591007", "story_v_out_319591.awb") ~= 0 then
					local var_35_43 = manager.audio:GetVoiceLength("story_v_out_319591", "319591007", "story_v_out_319591.awb") / 1000

					if var_35_43 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_43 + var_35_35
					end

					if var_35_38.prefab_name ~= "" and arg_32_1.actors_[var_35_38.prefab_name] ~= nil then
						local var_35_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_38.prefab_name].transform, "story_v_out_319591", "319591007", "story_v_out_319591.awb")

						arg_32_1:RecordAudio("319591007", var_35_44)
						arg_32_1:RecordAudio("319591007", var_35_44)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319591", "319591007", "story_v_out_319591.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319591", "319591007", "story_v_out_319591.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_45 = math.max(var_35_36, arg_32_1.talkMaxDuration)

			if var_35_35 <= arg_32_1.time_ and arg_32_1.time_ < var_35_35 + var_35_45 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_35) / var_35_45

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_35 + var_35_45 and arg_32_1.time_ < var_35_35 + var_35_45 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_32_1:InitPlayNodeList()
	end,
	Play319591008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319591008
		arg_36_1.duration_ = 8.9

		local var_36_0 = {
			zh = 5.633,
			ja = 8.9
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
				arg_36_0:Play319591009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10079ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10079ui_story == nil then
				arg_36_1.var_.characterEffect10079ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10079ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10079ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10079ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10079ui_story.fillRatio = var_39_5
			end

			local var_39_6 = arg_36_1.actors_["4040ui_story"]
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 and not isNil(var_39_6) and arg_36_1.var_.characterEffect4040ui_story == nil then
				arg_36_1.var_.characterEffect4040ui_story = var_39_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.200000002980232

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_8 and not isNil(var_39_6) then
				local var_39_9 = (arg_36_1.time_ - var_39_7) / var_39_8

				if arg_36_1.var_.characterEffect4040ui_story and not isNil(var_39_6) then
					arg_36_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_7 + var_39_8 and arg_36_1.time_ < var_39_7 + var_39_8 + arg_39_0 and not isNil(var_39_6) and arg_36_1.var_.characterEffect4040ui_story then
				arg_36_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_39_10 = 0
			local var_39_11 = 0.525

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[668].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(319591008)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 21
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591008", "story_v_out_319591.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591008", "story_v_out_319591.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_319591", "319591008", "story_v_out_319591.awb")

						arg_36_1:RecordAudio("319591008", var_39_19)
						arg_36_1:RecordAudio("319591008", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319591", "319591008", "story_v_out_319591.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319591", "319591008", "story_v_out_319591.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play319591009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319591009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319591010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4040ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4040ui_story == nil then
				arg_40_1.var_.characterEffect4040ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect4040ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_40_1.var_.characterEffect4040ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4040ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_40_1.var_.characterEffect4040ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.625

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_8 = arg_40_1:GetWordFromCfg(319591009)
				local var_43_9 = arg_40_1:FormatText(var_43_8.content)

				arg_40_1.text_.text = var_43_9

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 25
				local var_43_11 = utf8.len(var_43_9)
				local var_43_12 = var_43_10 <= 0 and var_43_7 or var_43_7 * (var_43_11 / var_43_10)

				if var_43_12 > 0 and var_43_7 < var_43_12 then
					arg_40_1.talkMaxDuration = var_43_12

					if var_43_12 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_9
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_13 and arg_40_1.time_ < var_43_6 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play319591010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319591010
		arg_44_1.duration_ = 13.3

		local var_44_0 = {
			zh = 6.333,
			ja = 13.3
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
				arg_44_0:Play319591011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10079ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10079ui_story == nil then
				arg_44_1.var_.characterEffect10079ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10079ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10079ui_story then
				arg_44_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_47_5 = 0
			local var_47_6 = 0.775

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_7 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(319591010)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 31
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_6 or var_47_6 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_6 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591010", "story_v_out_319591.awb") ~= 0 then
					local var_47_13 = manager.audio:GetVoiceLength("story_v_out_319591", "319591010", "story_v_out_319591.awb") / 1000

					if var_47_13 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_5
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_319591", "319591010", "story_v_out_319591.awb")

						arg_44_1:RecordAudio("319591010", var_47_14)
						arg_44_1:RecordAudio("319591010", var_47_14)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319591", "319591010", "story_v_out_319591.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319591", "319591010", "story_v_out_319591.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_15 and arg_44_1.time_ < var_47_5 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319591011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319591011
		arg_48_1.duration_ = 13.27

		local var_48_0 = {
			zh = 4.066,
			ja = 13.266
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
				arg_48_0:Play319591012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["4040ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos4040ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4040ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["4040ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect4040ui_story == nil then
				arg_48_1.var_.characterEffect4040ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect4040ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect4040ui_story then
				arg_48_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_51_15 = arg_48_1.actors_["10079ui_story"]
			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 and not isNil(var_51_15) and arg_48_1.var_.characterEffect10079ui_story == nil then
				arg_48_1.var_.characterEffect10079ui_story = var_51_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_17 = 0.200000002980232

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_17 and not isNil(var_51_15) then
				local var_51_18 = (arg_48_1.time_ - var_51_16) / var_51_17

				if arg_48_1.var_.characterEffect10079ui_story and not isNil(var_51_15) then
					local var_51_19 = Mathf.Lerp(0, 0.5, var_51_18)

					arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10079ui_story.fillRatio = var_51_19
				end
			end

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 and not isNil(var_51_15) and arg_48_1.var_.characterEffect10079ui_story then
				local var_51_20 = 0.5

				arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10079ui_story.fillRatio = var_51_20
			end

			local var_51_21 = 0
			local var_51_22 = 0.525

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_23 = arg_48_1:FormatText(StoryNameCfg[668].name)

				arg_48_1.leftNameTxt_.text = var_51_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_24 = arg_48_1:GetWordFromCfg(319591011)
				local var_51_25 = arg_48_1:FormatText(var_51_24.content)

				arg_48_1.text_.text = var_51_25

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_26 = 21
				local var_51_27 = utf8.len(var_51_25)
				local var_51_28 = var_51_26 <= 0 and var_51_22 or var_51_22 * (var_51_27 / var_51_26)

				if var_51_28 > 0 and var_51_22 < var_51_28 then
					arg_48_1.talkMaxDuration = var_51_28

					if var_51_28 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_21
					end
				end

				arg_48_1.text_.text = var_51_25
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591011", "story_v_out_319591.awb") ~= 0 then
					local var_51_29 = manager.audio:GetVoiceLength("story_v_out_319591", "319591011", "story_v_out_319591.awb") / 1000

					if var_51_29 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_29 + var_51_21
					end

					if var_51_24.prefab_name ~= "" and arg_48_1.actors_[var_51_24.prefab_name] ~= nil then
						local var_51_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_24.prefab_name].transform, "story_v_out_319591", "319591011", "story_v_out_319591.awb")

						arg_48_1:RecordAudio("319591011", var_51_30)
						arg_48_1:RecordAudio("319591011", var_51_30)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319591", "319591011", "story_v_out_319591.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319591", "319591011", "story_v_out_319591.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_31 = math.max(var_51_22, arg_48_1.talkMaxDuration)

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_31 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_21) / var_51_31

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_21 + var_51_31 and arg_48_1.time_ < var_51_21 + var_51_31 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play319591012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319591012
		arg_52_1.duration_ = 4.57

		local var_52_0 = {
			zh = 2.166,
			ja = 4.566
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
				arg_52_0:Play319591013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_55_2 = 0
			local var_55_3 = 0.2

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_4 = arg_52_1:FormatText(StoryNameCfg[668].name)

				arg_52_1.leftNameTxt_.text = var_55_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_5 = arg_52_1:GetWordFromCfg(319591012)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 8
				local var_55_8 = utf8.len(var_55_6)
				local var_55_9 = var_55_7 <= 0 and var_55_3 or var_55_3 * (var_55_8 / var_55_7)

				if var_55_9 > 0 and var_55_3 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591012", "story_v_out_319591.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591012", "story_v_out_319591.awb") / 1000

					if var_55_10 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_2
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_319591", "319591012", "story_v_out_319591.awb")

						arg_52_1:RecordAudio("319591012", var_55_11)
						arg_52_1:RecordAudio("319591012", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319591", "319591012", "story_v_out_319591.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319591", "319591012", "story_v_out_319591.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_12 and arg_52_1.time_ < var_55_2 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319591013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319591013
		arg_56_1.duration_ = 6.23

		local var_56_0 = {
			zh = 3.3,
			ja = 6.233
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
				arg_56_0:Play319591014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10079ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10079ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0.7, -0.95, -6.05)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10079ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["10079ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect10079ui_story == nil then
				arg_56_1.var_.characterEffect10079ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect10079ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect10079ui_story then
				arg_56_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_15 = arg_56_1.actors_["4040ui_story"]
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 and not isNil(var_59_15) and arg_56_1.var_.characterEffect4040ui_story == nil then
				arg_56_1.var_.characterEffect4040ui_story = var_59_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_17 = 0.200000002980232

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 and not isNil(var_59_15) then
				local var_59_18 = (arg_56_1.time_ - var_59_16) / var_59_17

				if arg_56_1.var_.characterEffect4040ui_story and not isNil(var_59_15) then
					local var_59_19 = Mathf.Lerp(0, 0.5, var_59_18)

					arg_56_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_56_1.var_.characterEffect4040ui_story.fillRatio = var_59_19
				end
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 and not isNil(var_59_15) and arg_56_1.var_.characterEffect4040ui_story then
				local var_59_20 = 0.5

				arg_56_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_56_1.var_.characterEffect4040ui_story.fillRatio = var_59_20
			end

			local var_59_21 = 0
			local var_59_22 = 0.375

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_23 = arg_56_1:FormatText(StoryNameCfg[6].name)

				arg_56_1.leftNameTxt_.text = var_59_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:GetWordFromCfg(319591013)
				local var_59_25 = arg_56_1:FormatText(var_59_24.content)

				arg_56_1.text_.text = var_59_25

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 15
				local var_59_27 = utf8.len(var_59_25)
				local var_59_28 = var_59_26 <= 0 and var_59_22 or var_59_22 * (var_59_27 / var_59_26)

				if var_59_28 > 0 and var_59_22 < var_59_28 then
					arg_56_1.talkMaxDuration = var_59_28

					if var_59_28 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_28 + var_59_21
					end
				end

				arg_56_1.text_.text = var_59_25
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591013", "story_v_out_319591.awb") ~= 0 then
					local var_59_29 = manager.audio:GetVoiceLength("story_v_out_319591", "319591013", "story_v_out_319591.awb") / 1000

					if var_59_29 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_21
					end

					if var_59_24.prefab_name ~= "" and arg_56_1.actors_[var_59_24.prefab_name] ~= nil then
						local var_59_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_24.prefab_name].transform, "story_v_out_319591", "319591013", "story_v_out_319591.awb")

						arg_56_1:RecordAudio("319591013", var_59_30)
						arg_56_1:RecordAudio("319591013", var_59_30)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319591", "319591013", "story_v_out_319591.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319591", "319591013", "story_v_out_319591.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_31 = math.max(var_59_22, arg_56_1.talkMaxDuration)

			if var_59_21 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_31 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_21) / var_59_31

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_21 + var_59_31 and arg_56_1.time_ < var_59_21 + var_59_31 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play319591014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319591014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play319591015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10079ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10079ui_story == nil then
				arg_60_1.var_.characterEffect10079ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10079ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10079ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10079ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10079ui_story.fillRatio = var_63_5
			end

			local var_63_6 = arg_60_1.actors_["4040ui_story"].transform
			local var_63_7 = 0

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.var_.moveOldPos4040ui_story = var_63_6.localPosition
			end

			local var_63_8 = 0.001

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_8 then
				local var_63_9 = (arg_60_1.time_ - var_63_7) / var_63_8
				local var_63_10 = Vector3.New(0, 100, 0)

				var_63_6.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos4040ui_story, var_63_10, var_63_9)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_6.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_6.localEulerAngles = var_63_12
			end

			if arg_60_1.time_ >= var_63_7 + var_63_8 and arg_60_1.time_ < var_63_7 + var_63_8 + arg_63_0 then
				var_63_6.localPosition = Vector3.New(0, 100, 0)

				local var_63_13 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_13.x, var_63_13.y, var_63_13.z)

				local var_63_14 = var_63_6.localEulerAngles

				var_63_14.z = 0
				var_63_14.x = 0
				var_63_6.localEulerAngles = var_63_14
			end

			local var_63_15 = arg_60_1.actors_["10079ui_story"].transform
			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.var_.moveOldPos10079ui_story = var_63_15.localPosition
			end

			local var_63_17 = 0.001

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17
				local var_63_19 = Vector3.New(0, 100, 0)

				var_63_15.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10079ui_story, var_63_19, var_63_18)

				local var_63_20 = manager.ui.mainCamera.transform.position - var_63_15.position

				var_63_15.forward = Vector3.New(var_63_20.x, var_63_20.y, var_63_20.z)

				local var_63_21 = var_63_15.localEulerAngles

				var_63_21.z = 0
				var_63_21.x = 0
				var_63_15.localEulerAngles = var_63_21
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				var_63_15.localPosition = Vector3.New(0, 100, 0)

				local var_63_22 = manager.ui.mainCamera.transform.position - var_63_15.position

				var_63_15.forward = Vector3.New(var_63_22.x, var_63_22.y, var_63_22.z)

				local var_63_23 = var_63_15.localEulerAngles

				var_63_23.z = 0
				var_63_23.x = 0
				var_63_15.localEulerAngles = var_63_23
			end

			local var_63_24 = 0
			local var_63_25 = 1.325

			if var_63_24 < arg_60_1.time_ and arg_60_1.time_ <= var_63_24 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_26 = arg_60_1:GetWordFromCfg(319591014)
				local var_63_27 = arg_60_1:FormatText(var_63_26.content)

				arg_60_1.text_.text = var_63_27

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_28 = 53
				local var_63_29 = utf8.len(var_63_27)
				local var_63_30 = var_63_28 <= 0 and var_63_25 or var_63_25 * (var_63_29 / var_63_28)

				if var_63_30 > 0 and var_63_25 < var_63_30 then
					arg_60_1.talkMaxDuration = var_63_30

					if var_63_30 + var_63_24 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_30 + var_63_24
					end
				end

				arg_60_1.text_.text = var_63_27
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_31 = math.max(var_63_25, arg_60_1.talkMaxDuration)

			if var_63_24 <= arg_60_1.time_ and arg_60_1.time_ < var_63_24 + var_63_31 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_24) / var_63_31

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_24 + var_63_31 and arg_60_1.time_ < var_63_24 + var_63_31 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play319591015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319591015
		arg_64_1.duration_ = 8.57

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319591016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "STwhite"

			if arg_64_1.bgs_[var_67_0] == nil then
				local var_67_1 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_67_0)
				var_67_1.name = var_67_0
				var_67_1.transform.parent = arg_64_1.stage_.transform
				var_67_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_[var_67_0] = var_67_1
			end

			local var_67_2 = 2

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				local var_67_3 = manager.ui.mainCamera.transform.localPosition
				local var_67_4 = Vector3.New(0, 0, 10) + Vector3.New(var_67_3.x, var_67_3.y, 0)
				local var_67_5 = arg_64_1.bgs_.STwhite

				var_67_5.transform.localPosition = var_67_4
				var_67_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_6 = var_67_5:GetComponent("SpriteRenderer")

				if var_67_6 and var_67_6.sprite then
					local var_67_7 = (var_67_5.transform.localPosition - var_67_3).z
					local var_67_8 = manager.ui.mainCameraCom_
					local var_67_9 = 2 * var_67_7 * Mathf.Tan(var_67_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_67_10 = var_67_9 * var_67_8.aspect
					local var_67_11 = var_67_6.sprite.bounds.size.x
					local var_67_12 = var_67_6.sprite.bounds.size.y
					local var_67_13 = var_67_10 / var_67_11
					local var_67_14 = var_67_9 / var_67_12
					local var_67_15 = var_67_14 < var_67_13 and var_67_13 or var_67_14

					var_67_5.transform.localScale = Vector3.New(var_67_15, var_67_15, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "STwhite" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_17 = 2

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_17 then
				local var_67_18 = (arg_64_1.time_ - var_67_16) / var_67_17
				local var_67_19 = Color.New(0, 0, 0)

				var_67_19.a = Mathf.Lerp(0, 1, var_67_18)
				arg_64_1.mask_.color = var_67_19
			end

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				local var_67_20 = Color.New(0, 0, 0)

				var_67_20.a = 1
				arg_64_1.mask_.color = var_67_20
			end

			local var_67_21 = 2

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_22 = 2

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 then
				local var_67_23 = (arg_64_1.time_ - var_67_21) / var_67_22
				local var_67_24 = Color.New(0, 0, 0)

				var_67_24.a = Mathf.Lerp(1, 0, var_67_23)
				arg_64_1.mask_.color = var_67_24
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 then
				local var_67_25 = Color.New(0, 0, 0)
				local var_67_26 = 0

				arg_64_1.mask_.enabled = false
				var_67_25.a = var_67_26
				arg_64_1.mask_.color = var_67_25
			end

			local var_67_27 = arg_64_1.actors_["10079ui_story"].transform
			local var_67_28 = 2

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1.var_.moveOldPos10079ui_story = var_67_27.localPosition
			end

			local var_67_29 = 0.001

			if var_67_28 <= arg_64_1.time_ and arg_64_1.time_ < var_67_28 + var_67_29 then
				local var_67_30 = (arg_64_1.time_ - var_67_28) / var_67_29
				local var_67_31 = Vector3.New(0, 100, 0)

				var_67_27.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10079ui_story, var_67_31, var_67_30)

				local var_67_32 = manager.ui.mainCamera.transform.position - var_67_27.position

				var_67_27.forward = Vector3.New(var_67_32.x, var_67_32.y, var_67_32.z)

				local var_67_33 = var_67_27.localEulerAngles

				var_67_33.z = 0
				var_67_33.x = 0
				var_67_27.localEulerAngles = var_67_33
			end

			if arg_64_1.time_ >= var_67_28 + var_67_29 and arg_64_1.time_ < var_67_28 + var_67_29 + arg_67_0 then
				var_67_27.localPosition = Vector3.New(0, 100, 0)

				local var_67_34 = manager.ui.mainCamera.transform.position - var_67_27.position

				var_67_27.forward = Vector3.New(var_67_34.x, var_67_34.y, var_67_34.z)

				local var_67_35 = var_67_27.localEulerAngles

				var_67_35.z = 0
				var_67_35.x = 0
				var_67_27.localEulerAngles = var_67_35
			end

			local var_67_36 = arg_64_1.actors_["10079ui_story"]
			local var_67_37 = 2

			if var_67_37 < arg_64_1.time_ and arg_64_1.time_ <= var_67_37 + arg_67_0 and not isNil(var_67_36) and arg_64_1.var_.characterEffect10079ui_story == nil then
				arg_64_1.var_.characterEffect10079ui_story = var_67_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_38 = 0.200000002980232

			if var_67_37 <= arg_64_1.time_ and arg_64_1.time_ < var_67_37 + var_67_38 and not isNil(var_67_36) then
				local var_67_39 = (arg_64_1.time_ - var_67_37) / var_67_38

				if arg_64_1.var_.characterEffect10079ui_story and not isNil(var_67_36) then
					local var_67_40 = Mathf.Lerp(0, 0.5, var_67_39)

					arg_64_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10079ui_story.fillRatio = var_67_40
				end
			end

			if arg_64_1.time_ >= var_67_37 + var_67_38 and arg_64_1.time_ < var_67_37 + var_67_38 + arg_67_0 and not isNil(var_67_36) and arg_64_1.var_.characterEffect10079ui_story then
				local var_67_41 = 0.5

				arg_64_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10079ui_story.fillRatio = var_67_41
			end

			local var_67_42 = arg_64_1.actors_["4040ui_story"].transform
			local var_67_43 = 2

			if var_67_43 < arg_64_1.time_ and arg_64_1.time_ <= var_67_43 + arg_67_0 then
				arg_64_1.var_.moveOldPos4040ui_story = var_67_42.localPosition
			end

			local var_67_44 = 0.001

			if var_67_43 <= arg_64_1.time_ and arg_64_1.time_ < var_67_43 + var_67_44 then
				local var_67_45 = (arg_64_1.time_ - var_67_43) / var_67_44
				local var_67_46 = Vector3.New(0, 100, 0)

				var_67_42.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4040ui_story, var_67_46, var_67_45)

				local var_67_47 = manager.ui.mainCamera.transform.position - var_67_42.position

				var_67_42.forward = Vector3.New(var_67_47.x, var_67_47.y, var_67_47.z)

				local var_67_48 = var_67_42.localEulerAngles

				var_67_48.z = 0
				var_67_48.x = 0
				var_67_42.localEulerAngles = var_67_48
			end

			if arg_64_1.time_ >= var_67_43 + var_67_44 and arg_64_1.time_ < var_67_43 + var_67_44 + arg_67_0 then
				var_67_42.localPosition = Vector3.New(0, 100, 0)

				local var_67_49 = manager.ui.mainCamera.transform.position - var_67_42.position

				var_67_42.forward = Vector3.New(var_67_49.x, var_67_49.y, var_67_49.z)

				local var_67_50 = var_67_42.localEulerAngles

				var_67_50.z = 0
				var_67_50.x = 0
				var_67_42.localEulerAngles = var_67_50
			end

			local var_67_51 = arg_64_1.actors_["4040ui_story"]
			local var_67_52 = 2

			if var_67_52 < arg_64_1.time_ and arg_64_1.time_ <= var_67_52 + arg_67_0 and not isNil(var_67_51) and arg_64_1.var_.characterEffect4040ui_story == nil then
				arg_64_1.var_.characterEffect4040ui_story = var_67_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_53 = 0.200000002980232

			if var_67_52 <= arg_64_1.time_ and arg_64_1.time_ < var_67_52 + var_67_53 and not isNil(var_67_51) then
				local var_67_54 = (arg_64_1.time_ - var_67_52) / var_67_53

				if arg_64_1.var_.characterEffect4040ui_story and not isNil(var_67_51) then
					local var_67_55 = Mathf.Lerp(0, 0.5, var_67_54)

					arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4040ui_story.fillRatio = var_67_55
				end
			end

			if arg_64_1.time_ >= var_67_52 + var_67_53 and arg_64_1.time_ < var_67_52 + var_67_53 + arg_67_0 and not isNil(var_67_51) and arg_64_1.var_.characterEffect4040ui_story then
				local var_67_56 = 0.5

				arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4040ui_story.fillRatio = var_67_56
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_57 = 3.56666666666667
			local var_67_58 = 0.875

			if var_67_57 < arg_64_1.time_ and arg_64_1.time_ <= var_67_57 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_59 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_59:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_60 = arg_64_1:GetWordFromCfg(319591015)
				local var_67_61 = arg_64_1:FormatText(var_67_60.content)

				arg_64_1.text_.text = var_67_61

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_62 = 35
				local var_67_63 = utf8.len(var_67_61)
				local var_67_64 = var_67_62 <= 0 and var_67_58 or var_67_58 * (var_67_63 / var_67_62)

				if var_67_64 > 0 and var_67_58 < var_67_64 then
					arg_64_1.talkMaxDuration = var_67_64
					var_67_57 = var_67_57 + 0.3

					if var_67_64 + var_67_57 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_64 + var_67_57
					end
				end

				arg_64_1.text_.text = var_67_61
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_65 = var_67_57 + 0.3
			local var_67_66 = math.max(var_67_58, arg_64_1.talkMaxDuration)

			if var_67_65 <= arg_64_1.time_ and arg_64_1.time_ < var_67_65 + var_67_66 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_65) / var_67_66

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_65 + var_67_66 and arg_64_1.time_ < var_67_65 + var_67_66 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play319591016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 319591016
		arg_70_1.duration_ = 7.13

		local var_70_0 = {
			zh = 6.7,
			ja = 7.133
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play319591017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "I10f"

			if arg_70_1.bgs_[var_73_0] == nil then
				local var_73_1 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_0)
				var_73_1.name = var_73_0
				var_73_1.transform.parent = arg_70_1.stage_.transform
				var_73_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_0] = var_73_1
			end

			local var_73_2 = 2

			if var_73_2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				local var_73_3 = manager.ui.mainCamera.transform.localPosition
				local var_73_4 = Vector3.New(0, 0, 10) + Vector3.New(var_73_3.x, var_73_3.y, 0)
				local var_73_5 = arg_70_1.bgs_.I10f

				var_73_5.transform.localPosition = var_73_4
				var_73_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_6 = var_73_5:GetComponent("SpriteRenderer")

				if var_73_6 and var_73_6.sprite then
					local var_73_7 = (var_73_5.transform.localPosition - var_73_3).z
					local var_73_8 = manager.ui.mainCameraCom_
					local var_73_9 = 2 * var_73_7 * Mathf.Tan(var_73_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_73_10 = var_73_9 * var_73_8.aspect
					local var_73_11 = var_73_6.sprite.bounds.size.x
					local var_73_12 = var_73_6.sprite.bounds.size.y
					local var_73_13 = var_73_10 / var_73_11
					local var_73_14 = var_73_9 / var_73_12
					local var_73_15 = var_73_14 < var_73_13 and var_73_13 or var_73_14

					var_73_5.transform.localScale = Vector3.New(var_73_15, var_73_15, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "I10f" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_16 = 0

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_17 = 2

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_17 then
				local var_73_18 = (arg_70_1.time_ - var_73_16) / var_73_17
				local var_73_19 = Color.New(0, 0, 0)

				var_73_19.a = Mathf.Lerp(0, 1, var_73_18)
				arg_70_1.mask_.color = var_73_19
			end

			if arg_70_1.time_ >= var_73_16 + var_73_17 and arg_70_1.time_ < var_73_16 + var_73_17 + arg_73_0 then
				local var_73_20 = Color.New(0, 0, 0)

				var_73_20.a = 1
				arg_70_1.mask_.color = var_73_20
			end

			local var_73_21 = 2

			if var_73_21 < arg_70_1.time_ and arg_70_1.time_ <= var_73_21 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_22 = 2

			if var_73_21 <= arg_70_1.time_ and arg_70_1.time_ < var_73_21 + var_73_22 then
				local var_73_23 = (arg_70_1.time_ - var_73_21) / var_73_22
				local var_73_24 = Color.New(0, 0, 0)

				var_73_24.a = Mathf.Lerp(1, 0, var_73_23)
				arg_70_1.mask_.color = var_73_24
			end

			if arg_70_1.time_ >= var_73_21 + var_73_22 and arg_70_1.time_ < var_73_21 + var_73_22 + arg_73_0 then
				local var_73_25 = Color.New(0, 0, 0)
				local var_73_26 = 0

				arg_70_1.mask_.enabled = false
				var_73_25.a = var_73_26
				arg_70_1.mask_.color = var_73_25
			end

			local var_73_27 = "1095ui_story"

			if arg_70_1.actors_[var_73_27] == nil then
				local var_73_28 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_73_28) then
					local var_73_29 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_70_1.stage_.transform)

					var_73_29.name = var_73_27
					var_73_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_70_1.actors_[var_73_27] = var_73_29

					local var_73_30 = var_73_29:GetComponentInChildren(typeof(CharacterEffect))

					var_73_30.enabled = true

					local var_73_31 = GameObjectTools.GetOrAddComponent(var_73_29, typeof(DynamicBoneHelper))

					if var_73_31 then
						var_73_31:EnableDynamicBone(false)
					end

					arg_70_1:ShowWeapon(var_73_30.transform, false)

					arg_70_1.var_[var_73_27 .. "Animator"] = var_73_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_70_1.var_[var_73_27 .. "Animator"].applyRootMotion = true
					arg_70_1.var_[var_73_27 .. "LipSync"] = var_73_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_73_32 = arg_70_1.actors_["1095ui_story"].transform
			local var_73_33 = 3.86666666666667

			if var_73_33 < arg_70_1.time_ and arg_70_1.time_ <= var_73_33 + arg_73_0 then
				arg_70_1.var_.moveOldPos1095ui_story = var_73_32.localPosition
			end

			local var_73_34 = 0.001

			if var_73_33 <= arg_70_1.time_ and arg_70_1.time_ < var_73_33 + var_73_34 then
				local var_73_35 = (arg_70_1.time_ - var_73_33) / var_73_34
				local var_73_36 = Vector3.New(0, -0.98, -6.1)

				var_73_32.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1095ui_story, var_73_36, var_73_35)

				local var_73_37 = manager.ui.mainCamera.transform.position - var_73_32.position

				var_73_32.forward = Vector3.New(var_73_37.x, var_73_37.y, var_73_37.z)

				local var_73_38 = var_73_32.localEulerAngles

				var_73_38.z = 0
				var_73_38.x = 0
				var_73_32.localEulerAngles = var_73_38
			end

			if arg_70_1.time_ >= var_73_33 + var_73_34 and arg_70_1.time_ < var_73_33 + var_73_34 + arg_73_0 then
				var_73_32.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_73_39 = manager.ui.mainCamera.transform.position - var_73_32.position

				var_73_32.forward = Vector3.New(var_73_39.x, var_73_39.y, var_73_39.z)

				local var_73_40 = var_73_32.localEulerAngles

				var_73_40.z = 0
				var_73_40.x = 0
				var_73_32.localEulerAngles = var_73_40
			end

			local var_73_41 = arg_70_1.actors_["1095ui_story"]
			local var_73_42 = 3.86666666666667

			if var_73_42 < arg_70_1.time_ and arg_70_1.time_ <= var_73_42 + arg_73_0 and not isNil(var_73_41) and arg_70_1.var_.characterEffect1095ui_story == nil then
				arg_70_1.var_.characterEffect1095ui_story = var_73_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_43 = 0.200000002980232

			if var_73_42 <= arg_70_1.time_ and arg_70_1.time_ < var_73_42 + var_73_43 and not isNil(var_73_41) then
				local var_73_44 = (arg_70_1.time_ - var_73_42) / var_73_43

				if arg_70_1.var_.characterEffect1095ui_story and not isNil(var_73_41) then
					arg_70_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_42 + var_73_43 and arg_70_1.time_ < var_73_42 + var_73_43 + arg_73_0 and not isNil(var_73_41) and arg_70_1.var_.characterEffect1095ui_story then
				arg_70_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_73_45 = 3.86666666666667

			if var_73_45 < arg_70_1.time_ and arg_70_1.time_ <= var_73_45 + arg_73_0 then
				arg_70_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_73_46 = 3.86666666666667

			if var_73_46 < arg_70_1.time_ and arg_70_1.time_ <= var_73_46 + arg_73_0 then
				arg_70_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_47 = 4
			local var_73_48 = 0.25

			if var_73_47 < arg_70_1.time_ and arg_70_1.time_ <= var_73_47 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_49 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_49:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_50 = arg_70_1:FormatText(StoryNameCfg[471].name)

				arg_70_1.leftNameTxt_.text = var_73_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_51 = arg_70_1:GetWordFromCfg(319591016)
				local var_73_52 = arg_70_1:FormatText(var_73_51.content)

				arg_70_1.text_.text = var_73_52

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_53 = 10
				local var_73_54 = utf8.len(var_73_52)
				local var_73_55 = var_73_53 <= 0 and var_73_48 or var_73_48 * (var_73_54 / var_73_53)

				if var_73_55 > 0 and var_73_48 < var_73_55 then
					arg_70_1.talkMaxDuration = var_73_55
					var_73_47 = var_73_47 + 0.3

					if var_73_55 + var_73_47 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_55 + var_73_47
					end
				end

				arg_70_1.text_.text = var_73_52
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591016", "story_v_out_319591.awb") ~= 0 then
					local var_73_56 = manager.audio:GetVoiceLength("story_v_out_319591", "319591016", "story_v_out_319591.awb") / 1000

					if var_73_56 + var_73_47 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_56 + var_73_47
					end

					if var_73_51.prefab_name ~= "" and arg_70_1.actors_[var_73_51.prefab_name] ~= nil then
						local var_73_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_51.prefab_name].transform, "story_v_out_319591", "319591016", "story_v_out_319591.awb")

						arg_70_1:RecordAudio("319591016", var_73_57)
						arg_70_1:RecordAudio("319591016", var_73_57)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_319591", "319591016", "story_v_out_319591.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_319591", "319591016", "story_v_out_319591.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_58 = var_73_47 + 0.3
			local var_73_59 = math.max(var_73_48, arg_70_1.talkMaxDuration)

			if var_73_58 <= arg_70_1.time_ and arg_70_1.time_ < var_73_58 + var_73_59 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_58) / var_73_59

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_58 + var_73_59 and arg_70_1.time_ < var_73_58 + var_73_59 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play319591017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319591017
		arg_76_1.duration_ = 3.2

		local var_76_0 = {
			zh = 1.999999999999,
			ja = 3.2
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
				arg_76_0:Play319591018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10079ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos10079ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0.7, -0.95, -6.05)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10079ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["10079ui_story"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect10079ui_story == nil then
				arg_76_1.var_.characterEffect10079ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.200000002980232

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect10079ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect10079ui_story then
				arg_76_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_79_15 = arg_76_1.actors_["1095ui_story"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos1095ui_story = var_79_15.localPosition
			end

			local var_79_17 = 0.001

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17
				local var_79_19 = Vector3.New(-0.7, -0.98, -6.1)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1095ui_story, var_79_19, var_79_18)

				local var_79_20 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_20.x, var_79_20.y, var_79_20.z)

				local var_79_21 = var_79_15.localEulerAngles

				var_79_21.z = 0
				var_79_21.x = 0
				var_79_15.localEulerAngles = var_79_21
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_79_22 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_22.x, var_79_22.y, var_79_22.z)

				local var_79_23 = var_79_15.localEulerAngles

				var_79_23.z = 0
				var_79_23.x = 0
				var_79_15.localEulerAngles = var_79_23
			end

			local var_79_24 = arg_76_1.actors_["1095ui_story"]
			local var_79_25 = 0

			if var_79_25 < arg_76_1.time_ and arg_76_1.time_ <= var_79_25 + arg_79_0 and not isNil(var_79_24) and arg_76_1.var_.characterEffect1095ui_story == nil then
				arg_76_1.var_.characterEffect1095ui_story = var_79_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_26 = 0.200000002980232

			if var_79_25 <= arg_76_1.time_ and arg_76_1.time_ < var_79_25 + var_79_26 and not isNil(var_79_24) then
				local var_79_27 = (arg_76_1.time_ - var_79_25) / var_79_26

				if arg_76_1.var_.characterEffect1095ui_story and not isNil(var_79_24) then
					local var_79_28 = Mathf.Lerp(0, 0.5, var_79_27)

					arg_76_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1095ui_story.fillRatio = var_79_28
				end
			end

			if arg_76_1.time_ >= var_79_25 + var_79_26 and arg_76_1.time_ < var_79_25 + var_79_26 + arg_79_0 and not isNil(var_79_24) and arg_76_1.var_.characterEffect1095ui_story then
				local var_79_29 = 0.5

				arg_76_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1095ui_story.fillRatio = var_79_29
			end

			local var_79_30 = 0
			local var_79_31 = 0.125

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_32 = arg_76_1:FormatText(StoryNameCfg[6].name)

				arg_76_1.leftNameTxt_.text = var_79_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_33 = arg_76_1:GetWordFromCfg(319591017)
				local var_79_34 = arg_76_1:FormatText(var_79_33.content)

				arg_76_1.text_.text = var_79_34

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_35 = 5
				local var_79_36 = utf8.len(var_79_34)
				local var_79_37 = var_79_35 <= 0 and var_79_31 or var_79_31 * (var_79_36 / var_79_35)

				if var_79_37 > 0 and var_79_31 < var_79_37 then
					arg_76_1.talkMaxDuration = var_79_37

					if var_79_37 + var_79_30 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_37 + var_79_30
					end
				end

				arg_76_1.text_.text = var_79_34
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591017", "story_v_out_319591.awb") ~= 0 then
					local var_79_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591017", "story_v_out_319591.awb") / 1000

					if var_79_38 + var_79_30 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_38 + var_79_30
					end

					if var_79_33.prefab_name ~= "" and arg_76_1.actors_[var_79_33.prefab_name] ~= nil then
						local var_79_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_33.prefab_name].transform, "story_v_out_319591", "319591017", "story_v_out_319591.awb")

						arg_76_1:RecordAudio("319591017", var_79_39)
						arg_76_1:RecordAudio("319591017", var_79_39)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319591", "319591017", "story_v_out_319591.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319591", "319591017", "story_v_out_319591.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_40 = math.max(var_79_31, arg_76_1.talkMaxDuration)

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_40 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_30) / var_79_40

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_30 + var_79_40 and arg_76_1.time_ < var_79_30 + var_79_40 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play319591018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319591018
		arg_80_1.duration_ = 6.4

		local var_80_0 = {
			zh = 6.4,
			ja = 4.5
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
				arg_80_0:Play319591019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["4040ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos4040ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, -1.55, -5.5)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4040ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["4040ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect4040ui_story == nil then
				arg_80_1.var_.characterEffect4040ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect4040ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect4040ui_story then
				arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_83_13 = 0

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_83_15 = arg_80_1.actors_["10079ui_story"].transform
			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.var_.moveOldPos10079ui_story = var_83_15.localPosition
			end

			local var_83_17 = 0.001

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_16) / var_83_17
				local var_83_19 = Vector3.New(0, 100, 0)

				var_83_15.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10079ui_story, var_83_19, var_83_18)

				local var_83_20 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_20.x, var_83_20.y, var_83_20.z)

				local var_83_21 = var_83_15.localEulerAngles

				var_83_21.z = 0
				var_83_21.x = 0
				var_83_15.localEulerAngles = var_83_21
			end

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				var_83_15.localPosition = Vector3.New(0, 100, 0)

				local var_83_22 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_22.x, var_83_22.y, var_83_22.z)

				local var_83_23 = var_83_15.localEulerAngles

				var_83_23.z = 0
				var_83_23.x = 0
				var_83_15.localEulerAngles = var_83_23
			end

			local var_83_24 = arg_80_1.actors_["10079ui_story"]
			local var_83_25 = 0

			if var_83_25 < arg_80_1.time_ and arg_80_1.time_ <= var_83_25 + arg_83_0 and not isNil(var_83_24) and arg_80_1.var_.characterEffect10079ui_story == nil then
				arg_80_1.var_.characterEffect10079ui_story = var_83_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_26 = 0.200000002980232

			if var_83_25 <= arg_80_1.time_ and arg_80_1.time_ < var_83_25 + var_83_26 and not isNil(var_83_24) then
				local var_83_27 = (arg_80_1.time_ - var_83_25) / var_83_26

				if arg_80_1.var_.characterEffect10079ui_story and not isNil(var_83_24) then
					local var_83_28 = Mathf.Lerp(0, 0.5, var_83_27)

					arg_80_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10079ui_story.fillRatio = var_83_28
				end
			end

			if arg_80_1.time_ >= var_83_25 + var_83_26 and arg_80_1.time_ < var_83_25 + var_83_26 + arg_83_0 and not isNil(var_83_24) and arg_80_1.var_.characterEffect10079ui_story then
				local var_83_29 = 0.5

				arg_80_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10079ui_story.fillRatio = var_83_29
			end

			local var_83_30 = arg_80_1.actors_["1095ui_story"].transform
			local var_83_31 = 0

			if var_83_31 < arg_80_1.time_ and arg_80_1.time_ <= var_83_31 + arg_83_0 then
				arg_80_1.var_.moveOldPos1095ui_story = var_83_30.localPosition
			end

			local var_83_32 = 0.001

			if var_83_31 <= arg_80_1.time_ and arg_80_1.time_ < var_83_31 + var_83_32 then
				local var_83_33 = (arg_80_1.time_ - var_83_31) / var_83_32
				local var_83_34 = Vector3.New(0, 100, 0)

				var_83_30.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1095ui_story, var_83_34, var_83_33)

				local var_83_35 = manager.ui.mainCamera.transform.position - var_83_30.position

				var_83_30.forward = Vector3.New(var_83_35.x, var_83_35.y, var_83_35.z)

				local var_83_36 = var_83_30.localEulerAngles

				var_83_36.z = 0
				var_83_36.x = 0
				var_83_30.localEulerAngles = var_83_36
			end

			if arg_80_1.time_ >= var_83_31 + var_83_32 and arg_80_1.time_ < var_83_31 + var_83_32 + arg_83_0 then
				var_83_30.localPosition = Vector3.New(0, 100, 0)

				local var_83_37 = manager.ui.mainCamera.transform.position - var_83_30.position

				var_83_30.forward = Vector3.New(var_83_37.x, var_83_37.y, var_83_37.z)

				local var_83_38 = var_83_30.localEulerAngles

				var_83_38.z = 0
				var_83_38.x = 0
				var_83_30.localEulerAngles = var_83_38
			end

			local var_83_39 = arg_80_1.actors_["1095ui_story"]
			local var_83_40 = 0

			if var_83_40 < arg_80_1.time_ and arg_80_1.time_ <= var_83_40 + arg_83_0 and not isNil(var_83_39) and arg_80_1.var_.characterEffect1095ui_story == nil then
				arg_80_1.var_.characterEffect1095ui_story = var_83_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_41 = 0.200000002980232

			if var_83_40 <= arg_80_1.time_ and arg_80_1.time_ < var_83_40 + var_83_41 and not isNil(var_83_39) then
				local var_83_42 = (arg_80_1.time_ - var_83_40) / var_83_41

				if arg_80_1.var_.characterEffect1095ui_story and not isNil(var_83_39) then
					local var_83_43 = Mathf.Lerp(0, 0.5, var_83_42)

					arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1095ui_story.fillRatio = var_83_43
				end
			end

			if arg_80_1.time_ >= var_83_40 + var_83_41 and arg_80_1.time_ < var_83_40 + var_83_41 + arg_83_0 and not isNil(var_83_39) and arg_80_1.var_.characterEffect1095ui_story then
				local var_83_44 = 0.5

				arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1095ui_story.fillRatio = var_83_44
			end

			local var_83_45 = 0
			local var_83_46 = 0.625

			if var_83_45 < arg_80_1.time_ and arg_80_1.time_ <= var_83_45 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_47 = arg_80_1:FormatText(StoryNameCfg[668].name)

				arg_80_1.leftNameTxt_.text = var_83_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_48 = arg_80_1:GetWordFromCfg(319591018)
				local var_83_49 = arg_80_1:FormatText(var_83_48.content)

				arg_80_1.text_.text = var_83_49

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_50 = 25
				local var_83_51 = utf8.len(var_83_49)
				local var_83_52 = var_83_50 <= 0 and var_83_46 or var_83_46 * (var_83_51 / var_83_50)

				if var_83_52 > 0 and var_83_46 < var_83_52 then
					arg_80_1.talkMaxDuration = var_83_52

					if var_83_52 + var_83_45 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_52 + var_83_45
					end
				end

				arg_80_1.text_.text = var_83_49
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591018", "story_v_out_319591.awb") ~= 0 then
					local var_83_53 = manager.audio:GetVoiceLength("story_v_out_319591", "319591018", "story_v_out_319591.awb") / 1000

					if var_83_53 + var_83_45 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_53 + var_83_45
					end

					if var_83_48.prefab_name ~= "" and arg_80_1.actors_[var_83_48.prefab_name] ~= nil then
						local var_83_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_48.prefab_name].transform, "story_v_out_319591", "319591018", "story_v_out_319591.awb")

						arg_80_1:RecordAudio("319591018", var_83_54)
						arg_80_1:RecordAudio("319591018", var_83_54)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319591", "319591018", "story_v_out_319591.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319591", "319591018", "story_v_out_319591.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_55 = math.max(var_83_46, arg_80_1.talkMaxDuration)

			if var_83_45 <= arg_80_1.time_ and arg_80_1.time_ < var_83_45 + var_83_55 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_45) / var_83_55

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_45 + var_83_55 and arg_80_1.time_ < var_83_45 + var_83_55 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play319591019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319591019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319591020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["4040ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos4040ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos4040ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, 100, 0)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["4040ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect4040ui_story == nil then
				arg_84_1.var_.characterEffect4040ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect4040ui_story and not isNil(var_87_9) then
					local var_87_13 = Mathf.Lerp(0, 0.5, var_87_12)

					arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4040ui_story.fillRatio = var_87_13
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect4040ui_story then
				local var_87_14 = 0.5

				arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4040ui_story.fillRatio = var_87_14
			end

			local var_87_15 = 0
			local var_87_16 = 1.4

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_17 = arg_84_1:GetWordFromCfg(319591019)
				local var_87_18 = arg_84_1:FormatText(var_87_17.content)

				arg_84_1.text_.text = var_87_18

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_19 = 56
				local var_87_20 = utf8.len(var_87_18)
				local var_87_21 = var_87_19 <= 0 and var_87_16 or var_87_16 * (var_87_20 / var_87_19)

				if var_87_21 > 0 and var_87_16 < var_87_21 then
					arg_84_1.talkMaxDuration = var_87_21

					if var_87_21 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_21 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_18
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_22 and arg_84_1.time_ < var_87_15 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play319591020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319591020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319591021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.275

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(319591020)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 51
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319591021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319591021
		arg_92_1.duration_ = 5.7

		local var_92_0 = {
			zh = 5.7,
			ja = 5.6
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
				arg_92_0:Play319591022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "4037ui_story"

			if arg_92_1.actors_[var_95_0] == nil then
				local var_95_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_95_1) then
					local var_95_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_92_1.stage_.transform)

					var_95_2.name = var_95_0
					var_95_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_92_1.actors_[var_95_0] = var_95_2

					local var_95_3 = var_95_2:GetComponentInChildren(typeof(CharacterEffect))

					var_95_3.enabled = true

					local var_95_4 = GameObjectTools.GetOrAddComponent(var_95_2, typeof(DynamicBoneHelper))

					if var_95_4 then
						var_95_4:EnableDynamicBone(false)
					end

					arg_92_1:ShowWeapon(var_95_3.transform, false)

					arg_92_1.var_[var_95_0 .. "Animator"] = var_95_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_92_1.var_[var_95_0 .. "Animator"].applyRootMotion = true
					arg_92_1.var_[var_95_0 .. "LipSync"] = var_95_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_95_5 = arg_92_1.actors_["4037ui_story"].transform
			local var_95_6 = 0

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.var_.moveOldPos4037ui_story = var_95_5.localPosition
			end

			local var_95_7 = 0.001

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_7 then
				local var_95_8 = (arg_92_1.time_ - var_95_6) / var_95_7
				local var_95_9 = Vector3.New(0, -1.12, -6.2)

				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos4037ui_story, var_95_9, var_95_8)

				local var_95_10 = manager.ui.mainCamera.transform.position - var_95_5.position

				var_95_5.forward = Vector3.New(var_95_10.x, var_95_10.y, var_95_10.z)

				local var_95_11 = var_95_5.localEulerAngles

				var_95_11.z = 0
				var_95_11.x = 0
				var_95_5.localEulerAngles = var_95_11
			end

			if arg_92_1.time_ >= var_95_6 + var_95_7 and arg_92_1.time_ < var_95_6 + var_95_7 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_95_12 = manager.ui.mainCamera.transform.position - var_95_5.position

				var_95_5.forward = Vector3.New(var_95_12.x, var_95_12.y, var_95_12.z)

				local var_95_13 = var_95_5.localEulerAngles

				var_95_13.z = 0
				var_95_13.x = 0
				var_95_5.localEulerAngles = var_95_13
			end

			local var_95_14 = arg_92_1.actors_["4037ui_story"]
			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 and not isNil(var_95_14) and arg_92_1.var_.characterEffect4037ui_story == nil then
				arg_92_1.var_.characterEffect4037ui_story = var_95_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_16 = 0.200000002980232

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_16 and not isNil(var_95_14) then
				local var_95_17 = (arg_92_1.time_ - var_95_15) / var_95_16

				if arg_92_1.var_.characterEffect4037ui_story and not isNil(var_95_14) then
					arg_92_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_15 + var_95_16 and arg_92_1.time_ < var_95_15 + var_95_16 + arg_95_0 and not isNil(var_95_14) and arg_92_1.var_.characterEffect4037ui_story then
				arg_92_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_95_18 = 0

			if var_95_18 < arg_92_1.time_ and arg_92_1.time_ <= var_95_18 + arg_95_0 then
				arg_92_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_95_19 = 0

			if var_95_19 < arg_92_1.time_ and arg_92_1.time_ <= var_95_19 + arg_95_0 then
				arg_92_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_20 = 0
			local var_95_21 = 0.425

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_22 = arg_92_1:FormatText(StoryNameCfg[453].name)

				arg_92_1.leftNameTxt_.text = var_95_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_23 = arg_92_1:GetWordFromCfg(319591021)
				local var_95_24 = arg_92_1:FormatText(var_95_23.content)

				arg_92_1.text_.text = var_95_24

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_25 = 17
				local var_95_26 = utf8.len(var_95_24)
				local var_95_27 = var_95_25 <= 0 and var_95_21 or var_95_21 * (var_95_26 / var_95_25)

				if var_95_27 > 0 and var_95_21 < var_95_27 then
					arg_92_1.talkMaxDuration = var_95_27

					if var_95_27 + var_95_20 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_27 + var_95_20
					end
				end

				arg_92_1.text_.text = var_95_24
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591021", "story_v_out_319591.awb") ~= 0 then
					local var_95_28 = manager.audio:GetVoiceLength("story_v_out_319591", "319591021", "story_v_out_319591.awb") / 1000

					if var_95_28 + var_95_20 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_28 + var_95_20
					end

					if var_95_23.prefab_name ~= "" and arg_92_1.actors_[var_95_23.prefab_name] ~= nil then
						local var_95_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_23.prefab_name].transform, "story_v_out_319591", "319591021", "story_v_out_319591.awb")

						arg_92_1:RecordAudio("319591021", var_95_29)
						arg_92_1:RecordAudio("319591021", var_95_29)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319591", "319591021", "story_v_out_319591.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319591", "319591021", "story_v_out_319591.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_30 = math.max(var_95_21, arg_92_1.talkMaxDuration)

			if var_95_20 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_30 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_20) / var_95_30

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_20 + var_95_30 and arg_92_1.time_ < var_95_20 + var_95_30 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play319591022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319591022
		arg_96_1.duration_ = 8.43

		local var_96_0 = {
			zh = 1.3,
			ja = 8.433
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
				arg_96_0:Play319591023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "10037ui_story"

			if arg_96_1.actors_[var_99_0] == nil then
				local var_99_1 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_99_1) then
					local var_99_2 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_96_1.stage_.transform)

					var_99_2.name = var_99_0
					var_99_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_96_1.actors_[var_99_0] = var_99_2

					local var_99_3 = var_99_2:GetComponentInChildren(typeof(CharacterEffect))

					var_99_3.enabled = true

					local var_99_4 = GameObjectTools.GetOrAddComponent(var_99_2, typeof(DynamicBoneHelper))

					if var_99_4 then
						var_99_4:EnableDynamicBone(false)
					end

					arg_96_1:ShowWeapon(var_99_3.transform, false)

					arg_96_1.var_[var_99_0 .. "Animator"] = var_99_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_96_1.var_[var_99_0 .. "Animator"].applyRootMotion = true
					arg_96_1.var_[var_99_0 .. "LipSync"] = var_99_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_99_5 = arg_96_1.actors_["10037ui_story"].transform
			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.var_.moveOldPos10037ui_story = var_99_5.localPosition
			end

			local var_99_7 = 0.001

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_7 then
				local var_99_8 = (arg_96_1.time_ - var_99_6) / var_99_7
				local var_99_9 = Vector3.New(0.7, -1.13, -6.2)

				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10037ui_story, var_99_9, var_99_8)

				local var_99_10 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_10.x, var_99_10.y, var_99_10.z)

				local var_99_11 = var_99_5.localEulerAngles

				var_99_11.z = 0
				var_99_11.x = 0
				var_99_5.localEulerAngles = var_99_11
			end

			if arg_96_1.time_ >= var_99_6 + var_99_7 and arg_96_1.time_ < var_99_6 + var_99_7 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_99_12 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_12.x, var_99_12.y, var_99_12.z)

				local var_99_13 = var_99_5.localEulerAngles

				var_99_13.z = 0
				var_99_13.x = 0
				var_99_5.localEulerAngles = var_99_13
			end

			local var_99_14 = arg_96_1.actors_["10037ui_story"]
			local var_99_15 = 0

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 and not isNil(var_99_14) and arg_96_1.var_.characterEffect10037ui_story == nil then
				arg_96_1.var_.characterEffect10037ui_story = var_99_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_16 = 0.200000002980232

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_16 and not isNil(var_99_14) then
				local var_99_17 = (arg_96_1.time_ - var_99_15) / var_99_16

				if arg_96_1.var_.characterEffect10037ui_story and not isNil(var_99_14) then
					arg_96_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_15 + var_99_16 and arg_96_1.time_ < var_99_15 + var_99_16 + arg_99_0 and not isNil(var_99_14) and arg_96_1.var_.characterEffect10037ui_story then
				arg_96_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_99_18 = 0

			if var_99_18 < arg_96_1.time_ and arg_96_1.time_ <= var_99_18 + arg_99_0 then
				arg_96_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_99_19 = 0

			if var_99_19 < arg_96_1.time_ and arg_96_1.time_ <= var_99_19 + arg_99_0 then
				arg_96_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_20 = arg_96_1.actors_["4037ui_story"].transform
			local var_99_21 = 0

			if var_99_21 < arg_96_1.time_ and arg_96_1.time_ <= var_99_21 + arg_99_0 then
				arg_96_1.var_.moveOldPos4037ui_story = var_99_20.localPosition
			end

			local var_99_22 = 0.001

			if var_99_21 <= arg_96_1.time_ and arg_96_1.time_ < var_99_21 + var_99_22 then
				local var_99_23 = (arg_96_1.time_ - var_99_21) / var_99_22
				local var_99_24 = Vector3.New(-0.7, -1.12, -6.2)

				var_99_20.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos4037ui_story, var_99_24, var_99_23)

				local var_99_25 = manager.ui.mainCamera.transform.position - var_99_20.position

				var_99_20.forward = Vector3.New(var_99_25.x, var_99_25.y, var_99_25.z)

				local var_99_26 = var_99_20.localEulerAngles

				var_99_26.z = 0
				var_99_26.x = 0
				var_99_20.localEulerAngles = var_99_26
			end

			if arg_96_1.time_ >= var_99_21 + var_99_22 and arg_96_1.time_ < var_99_21 + var_99_22 + arg_99_0 then
				var_99_20.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_99_27 = manager.ui.mainCamera.transform.position - var_99_20.position

				var_99_20.forward = Vector3.New(var_99_27.x, var_99_27.y, var_99_27.z)

				local var_99_28 = var_99_20.localEulerAngles

				var_99_28.z = 0
				var_99_28.x = 0
				var_99_20.localEulerAngles = var_99_28
			end

			local var_99_29 = arg_96_1.actors_["4037ui_story"]
			local var_99_30 = 0

			if var_99_30 < arg_96_1.time_ and arg_96_1.time_ <= var_99_30 + arg_99_0 and not isNil(var_99_29) and arg_96_1.var_.characterEffect4037ui_story == nil then
				arg_96_1.var_.characterEffect4037ui_story = var_99_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_31 = 0.200000002980232

			if var_99_30 <= arg_96_1.time_ and arg_96_1.time_ < var_99_30 + var_99_31 and not isNil(var_99_29) then
				local var_99_32 = (arg_96_1.time_ - var_99_30) / var_99_31

				if arg_96_1.var_.characterEffect4037ui_story and not isNil(var_99_29) then
					local var_99_33 = Mathf.Lerp(0, 0.5, var_99_32)

					arg_96_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_96_1.var_.characterEffect4037ui_story.fillRatio = var_99_33
				end
			end

			if arg_96_1.time_ >= var_99_30 + var_99_31 and arg_96_1.time_ < var_99_30 + var_99_31 + arg_99_0 and not isNil(var_99_29) and arg_96_1.var_.characterEffect4037ui_story then
				local var_99_34 = 0.5

				arg_96_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_96_1.var_.characterEffect4037ui_story.fillRatio = var_99_34
			end

			local var_99_35 = 0
			local var_99_36 = 0.15

			if var_99_35 < arg_96_1.time_ and arg_96_1.time_ <= var_99_35 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_37 = arg_96_1:FormatText(StoryNameCfg[383].name)

				arg_96_1.leftNameTxt_.text = var_99_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_38 = arg_96_1:GetWordFromCfg(319591022)
				local var_99_39 = arg_96_1:FormatText(var_99_38.content)

				arg_96_1.text_.text = var_99_39

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_40 = 6
				local var_99_41 = utf8.len(var_99_39)
				local var_99_42 = var_99_40 <= 0 and var_99_36 or var_99_36 * (var_99_41 / var_99_40)

				if var_99_42 > 0 and var_99_36 < var_99_42 then
					arg_96_1.talkMaxDuration = var_99_42

					if var_99_42 + var_99_35 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_42 + var_99_35
					end
				end

				arg_96_1.text_.text = var_99_39
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591022", "story_v_out_319591.awb") ~= 0 then
					local var_99_43 = manager.audio:GetVoiceLength("story_v_out_319591", "319591022", "story_v_out_319591.awb") / 1000

					if var_99_43 + var_99_35 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_43 + var_99_35
					end

					if var_99_38.prefab_name ~= "" and arg_96_1.actors_[var_99_38.prefab_name] ~= nil then
						local var_99_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_38.prefab_name].transform, "story_v_out_319591", "319591022", "story_v_out_319591.awb")

						arg_96_1:RecordAudio("319591022", var_99_44)
						arg_96_1:RecordAudio("319591022", var_99_44)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319591", "319591022", "story_v_out_319591.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319591", "319591022", "story_v_out_319591.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_45 = math.max(var_99_36, arg_96_1.talkMaxDuration)

			if var_99_35 <= arg_96_1.time_ and arg_96_1.time_ < var_99_35 + var_99_45 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_35) / var_99_45

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_35 + var_99_45 and arg_96_1.time_ < var_99_35 + var_99_45 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play319591023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319591023
		arg_100_1.duration_ = 7.73

		local var_100_0 = {
			zh = 2.5,
			ja = 7.733
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
				arg_100_0:Play319591024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1095ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1095ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(0, -0.98, -6.1)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1095ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = arg_100_1.actors_["1095ui_story"]
			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1095ui_story == nil then
				arg_100_1.var_.characterEffect1095ui_story = var_103_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_11 = 0.200000002980232

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_11 and not isNil(var_103_9) then
				local var_103_12 = (arg_100_1.time_ - var_103_10) / var_103_11

				if arg_100_1.var_.characterEffect1095ui_story and not isNil(var_103_9) then
					arg_100_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_10 + var_103_11 and arg_100_1.time_ < var_103_10 + var_103_11 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1095ui_story then
				arg_100_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_103_13 = 0

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_103_15 = arg_100_1.actors_["10037ui_story"].transform
			local var_103_16 = 0

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.var_.moveOldPos10037ui_story = var_103_15.localPosition
			end

			local var_103_17 = 0.001

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_17 then
				local var_103_18 = (arg_100_1.time_ - var_103_16) / var_103_17
				local var_103_19 = Vector3.New(0, 100, 0)

				var_103_15.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10037ui_story, var_103_19, var_103_18)

				local var_103_20 = manager.ui.mainCamera.transform.position - var_103_15.position

				var_103_15.forward = Vector3.New(var_103_20.x, var_103_20.y, var_103_20.z)

				local var_103_21 = var_103_15.localEulerAngles

				var_103_21.z = 0
				var_103_21.x = 0
				var_103_15.localEulerAngles = var_103_21
			end

			if arg_100_1.time_ >= var_103_16 + var_103_17 and arg_100_1.time_ < var_103_16 + var_103_17 + arg_103_0 then
				var_103_15.localPosition = Vector3.New(0, 100, 0)

				local var_103_22 = manager.ui.mainCamera.transform.position - var_103_15.position

				var_103_15.forward = Vector3.New(var_103_22.x, var_103_22.y, var_103_22.z)

				local var_103_23 = var_103_15.localEulerAngles

				var_103_23.z = 0
				var_103_23.x = 0
				var_103_15.localEulerAngles = var_103_23
			end

			local var_103_24 = arg_100_1.actors_["10037ui_story"]
			local var_103_25 = 0

			if var_103_25 < arg_100_1.time_ and arg_100_1.time_ <= var_103_25 + arg_103_0 and not isNil(var_103_24) and arg_100_1.var_.characterEffect10037ui_story == nil then
				arg_100_1.var_.characterEffect10037ui_story = var_103_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_26 = 0.200000002980232

			if var_103_25 <= arg_100_1.time_ and arg_100_1.time_ < var_103_25 + var_103_26 and not isNil(var_103_24) then
				local var_103_27 = (arg_100_1.time_ - var_103_25) / var_103_26

				if arg_100_1.var_.characterEffect10037ui_story and not isNil(var_103_24) then
					local var_103_28 = Mathf.Lerp(0, 0.5, var_103_27)

					arg_100_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10037ui_story.fillRatio = var_103_28
				end
			end

			if arg_100_1.time_ >= var_103_25 + var_103_26 and arg_100_1.time_ < var_103_25 + var_103_26 + arg_103_0 and not isNil(var_103_24) and arg_100_1.var_.characterEffect10037ui_story then
				local var_103_29 = 0.5

				arg_100_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10037ui_story.fillRatio = var_103_29
			end

			local var_103_30 = arg_100_1.actors_["4037ui_story"].transform
			local var_103_31 = 0

			if var_103_31 < arg_100_1.time_ and arg_100_1.time_ <= var_103_31 + arg_103_0 then
				arg_100_1.var_.moveOldPos4037ui_story = var_103_30.localPosition
			end

			local var_103_32 = 0.001

			if var_103_31 <= arg_100_1.time_ and arg_100_1.time_ < var_103_31 + var_103_32 then
				local var_103_33 = (arg_100_1.time_ - var_103_31) / var_103_32
				local var_103_34 = Vector3.New(0, 100, 0)

				var_103_30.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4037ui_story, var_103_34, var_103_33)

				local var_103_35 = manager.ui.mainCamera.transform.position - var_103_30.position

				var_103_30.forward = Vector3.New(var_103_35.x, var_103_35.y, var_103_35.z)

				local var_103_36 = var_103_30.localEulerAngles

				var_103_36.z = 0
				var_103_36.x = 0
				var_103_30.localEulerAngles = var_103_36
			end

			if arg_100_1.time_ >= var_103_31 + var_103_32 and arg_100_1.time_ < var_103_31 + var_103_32 + arg_103_0 then
				var_103_30.localPosition = Vector3.New(0, 100, 0)

				local var_103_37 = manager.ui.mainCamera.transform.position - var_103_30.position

				var_103_30.forward = Vector3.New(var_103_37.x, var_103_37.y, var_103_37.z)

				local var_103_38 = var_103_30.localEulerAngles

				var_103_38.z = 0
				var_103_38.x = 0
				var_103_30.localEulerAngles = var_103_38
			end

			local var_103_39 = arg_100_1.actors_["4037ui_story"]
			local var_103_40 = 0

			if var_103_40 < arg_100_1.time_ and arg_100_1.time_ <= var_103_40 + arg_103_0 and not isNil(var_103_39) and arg_100_1.var_.characterEffect4037ui_story == nil then
				arg_100_1.var_.characterEffect4037ui_story = var_103_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_41 = 0.200000002980232

			if var_103_40 <= arg_100_1.time_ and arg_100_1.time_ < var_103_40 + var_103_41 and not isNil(var_103_39) then
				local var_103_42 = (arg_100_1.time_ - var_103_40) / var_103_41

				if arg_100_1.var_.characterEffect4037ui_story and not isNil(var_103_39) then
					local var_103_43 = Mathf.Lerp(0, 0.5, var_103_42)

					arg_100_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_100_1.var_.characterEffect4037ui_story.fillRatio = var_103_43
				end
			end

			if arg_100_1.time_ >= var_103_40 + var_103_41 and arg_100_1.time_ < var_103_40 + var_103_41 + arg_103_0 and not isNil(var_103_39) and arg_100_1.var_.characterEffect4037ui_story then
				local var_103_44 = 0.5

				arg_100_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_100_1.var_.characterEffect4037ui_story.fillRatio = var_103_44
			end

			local var_103_45 = 0
			local var_103_46 = 0.3

			if var_103_45 < arg_100_1.time_ and arg_100_1.time_ <= var_103_45 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_47 = arg_100_1:FormatText(StoryNameCfg[471].name)

				arg_100_1.leftNameTxt_.text = var_103_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_48 = arg_100_1:GetWordFromCfg(319591023)
				local var_103_49 = arg_100_1:FormatText(var_103_48.content)

				arg_100_1.text_.text = var_103_49

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_50 = 12
				local var_103_51 = utf8.len(var_103_49)
				local var_103_52 = var_103_50 <= 0 and var_103_46 or var_103_46 * (var_103_51 / var_103_50)

				if var_103_52 > 0 and var_103_46 < var_103_52 then
					arg_100_1.talkMaxDuration = var_103_52

					if var_103_52 + var_103_45 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_52 + var_103_45
					end
				end

				arg_100_1.text_.text = var_103_49
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591023", "story_v_out_319591.awb") ~= 0 then
					local var_103_53 = manager.audio:GetVoiceLength("story_v_out_319591", "319591023", "story_v_out_319591.awb") / 1000

					if var_103_53 + var_103_45 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_53 + var_103_45
					end

					if var_103_48.prefab_name ~= "" and arg_100_1.actors_[var_103_48.prefab_name] ~= nil then
						local var_103_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_48.prefab_name].transform, "story_v_out_319591", "319591023", "story_v_out_319591.awb")

						arg_100_1:RecordAudio("319591023", var_103_54)
						arg_100_1:RecordAudio("319591023", var_103_54)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_319591", "319591023", "story_v_out_319591.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_319591", "319591023", "story_v_out_319591.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_55 = math.max(var_103_46, arg_100_1.talkMaxDuration)

			if var_103_45 <= arg_100_1.time_ and arg_100_1.time_ < var_103_45 + var_103_55 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_45) / var_103_55

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_45 + var_103_55 and arg_100_1.time_ < var_103_45 + var_103_55 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play319591024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319591024
		arg_104_1.duration_ = 3.63

		local var_104_0 = {
			zh = 2.166,
			ja = 3.633
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
				arg_104_0:Play319591025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["4040ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos4040ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0.7, -1.55, -5.5)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos4040ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["4040ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect4040ui_story == nil then
				arg_104_1.var_.characterEffect4040ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect4040ui_story and not isNil(var_107_9) then
					arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect4040ui_story then
				arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_107_13 = 0

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 then
				arg_104_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_107_14 = 0

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_15 = arg_104_1.actors_["1095ui_story"].transform
			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.var_.moveOldPos1095ui_story = var_107_15.localPosition
			end

			local var_107_17 = 0.001

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_17 then
				local var_107_18 = (arg_104_1.time_ - var_107_16) / var_107_17
				local var_107_19 = Vector3.New(-0.7, -0.98, -6.1)

				var_107_15.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1095ui_story, var_107_19, var_107_18)

				local var_107_20 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_20.x, var_107_20.y, var_107_20.z)

				local var_107_21 = var_107_15.localEulerAngles

				var_107_21.z = 0
				var_107_21.x = 0
				var_107_15.localEulerAngles = var_107_21
			end

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 then
				var_107_15.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_107_22 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_22.x, var_107_22.y, var_107_22.z)

				local var_107_23 = var_107_15.localEulerAngles

				var_107_23.z = 0
				var_107_23.x = 0
				var_107_15.localEulerAngles = var_107_23
			end

			local var_107_24 = arg_104_1.actors_["1095ui_story"]
			local var_107_25 = 0

			if var_107_25 < arg_104_1.time_ and arg_104_1.time_ <= var_107_25 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1095ui_story == nil then
				arg_104_1.var_.characterEffect1095ui_story = var_107_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_26 = 0.200000002980232

			if var_107_25 <= arg_104_1.time_ and arg_104_1.time_ < var_107_25 + var_107_26 and not isNil(var_107_24) then
				local var_107_27 = (arg_104_1.time_ - var_107_25) / var_107_26

				if arg_104_1.var_.characterEffect1095ui_story and not isNil(var_107_24) then
					local var_107_28 = Mathf.Lerp(0, 0.5, var_107_27)

					arg_104_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1095ui_story.fillRatio = var_107_28
				end
			end

			if arg_104_1.time_ >= var_107_25 + var_107_26 and arg_104_1.time_ < var_107_25 + var_107_26 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1095ui_story then
				local var_107_29 = 0.5

				arg_104_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1095ui_story.fillRatio = var_107_29
			end

			local var_107_30 = 0
			local var_107_31 = 0.25

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_32 = arg_104_1:FormatText(StoryNameCfg[668].name)

				arg_104_1.leftNameTxt_.text = var_107_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_33 = arg_104_1:GetWordFromCfg(319591024)
				local var_107_34 = arg_104_1:FormatText(var_107_33.content)

				arg_104_1.text_.text = var_107_34

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_35 = 10
				local var_107_36 = utf8.len(var_107_34)
				local var_107_37 = var_107_35 <= 0 and var_107_31 or var_107_31 * (var_107_36 / var_107_35)

				if var_107_37 > 0 and var_107_31 < var_107_37 then
					arg_104_1.talkMaxDuration = var_107_37

					if var_107_37 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_37 + var_107_30
					end
				end

				arg_104_1.text_.text = var_107_34
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591024", "story_v_out_319591.awb") ~= 0 then
					local var_107_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591024", "story_v_out_319591.awb") / 1000

					if var_107_38 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_38 + var_107_30
					end

					if var_107_33.prefab_name ~= "" and arg_104_1.actors_[var_107_33.prefab_name] ~= nil then
						local var_107_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_33.prefab_name].transform, "story_v_out_319591", "319591024", "story_v_out_319591.awb")

						arg_104_1:RecordAudio("319591024", var_107_39)
						arg_104_1:RecordAudio("319591024", var_107_39)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319591", "319591024", "story_v_out_319591.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319591", "319591024", "story_v_out_319591.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_40 = math.max(var_107_31, arg_104_1.talkMaxDuration)

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_40 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_30) / var_107_40

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_30 + var_107_40 and arg_104_1.time_ < var_107_30 + var_107_40 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play319591025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319591025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319591026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["4040ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect4040ui_story == nil then
				arg_108_1.var_.characterEffect4040ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect4040ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4040ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect4040ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4040ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.825

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(319591025)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 33
				local var_111_11 = utf8.len(var_111_9)
				local var_111_12 = var_111_10 <= 0 and var_111_7 or var_111_7 * (var_111_11 / var_111_10)

				if var_111_12 > 0 and var_111_7 < var_111_12 then
					arg_108_1.talkMaxDuration = var_111_12

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_13 and arg_108_1.time_ < var_111_6 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play319591026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319591026
		arg_112_1.duration_ = 4.8

		local var_112_0 = {
			zh = 3,
			ja = 4.8
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319591027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["4040ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect4040ui_story == nil then
				arg_112_1.var_.characterEffect4040ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect4040ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect4040ui_story then
				arg_112_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_115_4 = 0
			local var_115_5 = 0.325

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_6 = arg_112_1:FormatText(StoryNameCfg[668].name)

				arg_112_1.leftNameTxt_.text = var_115_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(319591026)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 13
				local var_115_10 = utf8.len(var_115_8)
				local var_115_11 = var_115_9 <= 0 and var_115_5 or var_115_5 * (var_115_10 / var_115_9)

				if var_115_11 > 0 and var_115_5 < var_115_11 then
					arg_112_1.talkMaxDuration = var_115_11

					if var_115_11 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591026", "story_v_out_319591.awb") ~= 0 then
					local var_115_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591026", "story_v_out_319591.awb") / 1000

					if var_115_12 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_4
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_319591", "319591026", "story_v_out_319591.awb")

						arg_112_1:RecordAudio("319591026", var_115_13)
						arg_112_1:RecordAudio("319591026", var_115_13)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319591", "319591026", "story_v_out_319591.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319591", "319591026", "story_v_out_319591.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_14 and arg_112_1.time_ < var_115_4 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319591027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319591027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319591028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["4040ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect4040ui_story == nil then
				arg_116_1.var_.characterEffect4040ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect4040ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_116_1.var_.characterEffect4040ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect4040ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_116_1.var_.characterEffect4040ui_story.fillRatio = var_119_5
			end

			local var_119_6 = arg_116_1.actors_["4040ui_story"].transform
			local var_119_7 = 0

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.var_.moveOldPos4040ui_story = var_119_6.localPosition
			end

			local var_119_8 = 0.001

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 then
				local var_119_9 = (arg_116_1.time_ - var_119_7) / var_119_8
				local var_119_10 = Vector3.New(0, 100, 0)

				var_119_6.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos4040ui_story, var_119_10, var_119_9)

				local var_119_11 = manager.ui.mainCamera.transform.position - var_119_6.position

				var_119_6.forward = Vector3.New(var_119_11.x, var_119_11.y, var_119_11.z)

				local var_119_12 = var_119_6.localEulerAngles

				var_119_12.z = 0
				var_119_12.x = 0
				var_119_6.localEulerAngles = var_119_12
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 then
				var_119_6.localPosition = Vector3.New(0, 100, 0)

				local var_119_13 = manager.ui.mainCamera.transform.position - var_119_6.position

				var_119_6.forward = Vector3.New(var_119_13.x, var_119_13.y, var_119_13.z)

				local var_119_14 = var_119_6.localEulerAngles

				var_119_14.z = 0
				var_119_14.x = 0
				var_119_6.localEulerAngles = var_119_14
			end

			local var_119_15 = arg_116_1.actors_["1095ui_story"].transform
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.var_.moveOldPos1095ui_story = var_119_15.localPosition
			end

			local var_119_17 = 0.001

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17
				local var_119_19 = Vector3.New(0, 100, 0)

				var_119_15.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1095ui_story, var_119_19, var_119_18)

				local var_119_20 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_20.x, var_119_20.y, var_119_20.z)

				local var_119_21 = var_119_15.localEulerAngles

				var_119_21.z = 0
				var_119_21.x = 0
				var_119_15.localEulerAngles = var_119_21
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				var_119_15.localPosition = Vector3.New(0, 100, 0)

				local var_119_22 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_22.x, var_119_22.y, var_119_22.z)

				local var_119_23 = var_119_15.localEulerAngles

				var_119_23.z = 0
				var_119_23.x = 0
				var_119_15.localEulerAngles = var_119_23
			end

			local var_119_24 = 0
			local var_119_25 = 1.3

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(319591027)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_28 = 52
				local var_119_29 = utf8.len(var_119_27)
				local var_119_30 = var_119_28 <= 0 and var_119_25 or var_119_25 * (var_119_29 / var_119_28)

				if var_119_30 > 0 and var_119_25 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30

					if var_119_30 + var_119_24 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_24
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_31 = math.max(var_119_25, arg_116_1.talkMaxDuration)

			if var_119_24 <= arg_116_1.time_ and arg_116_1.time_ < var_119_24 + var_119_31 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_24) / var_119_31

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_24 + var_119_31 and arg_116_1.time_ < var_119_24 + var_119_31 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play319591028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319591028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319591029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.75

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(319591028)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 30
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319591029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319591029
		arg_124_1.duration_ = 4.53

		local var_124_0 = {
			zh = 2.533,
			ja = 4.533
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
				arg_124_0:Play319591030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.25

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[694].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(319591029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 10
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591029", "story_v_out_319591.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591029", "story_v_out_319591.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_319591", "319591029", "story_v_out_319591.awb")

						arg_124_1:RecordAudio("319591029", var_127_9)
						arg_124_1:RecordAudio("319591029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319591", "319591029", "story_v_out_319591.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319591", "319591029", "story_v_out_319591.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319591030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319591030
		arg_128_1.duration_ = 6.97

		local var_128_0 = {
			zh = 4.5,
			ja = 6.966
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
				arg_128_0:Play319591031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1095ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1095ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1095ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1095ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1095ui_story == nil then
				arg_128_1.var_.characterEffect1095ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1095ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1095ui_story then
				arg_128_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_131_15 = 0
			local var_131_16 = 0.475

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[471].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(319591030)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 19
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591030", "story_v_out_319591.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_319591", "319591030", "story_v_out_319591.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_319591", "319591030", "story_v_out_319591.awb")

						arg_128_1:RecordAudio("319591030", var_131_24)
						arg_128_1:RecordAudio("319591030", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319591", "319591030", "story_v_out_319591.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319591", "319591030", "story_v_out_319591.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play319591031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319591031
		arg_132_1.duration_ = 3.2

		local var_132_0 = {
			zh = 3.2,
			ja = 3.1
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
				arg_132_0:Play319591032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1095ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1095ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1095ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1095ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1095ui_story.fillRatio = var_135_5
			end

			local var_135_6 = arg_132_1.actors_["4040ui_story"]
			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect4040ui_story == nil then
				arg_132_1.var_.characterEffect4040ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.200000002980232

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_8 and not isNil(var_135_6) then
				local var_135_9 = (arg_132_1.time_ - var_135_7) / var_135_8

				if arg_132_1.var_.characterEffect4040ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_7 + var_135_8 and arg_132_1.time_ < var_135_7 + var_135_8 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect4040ui_story then
				arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_135_10 = arg_132_1.actors_["4040ui_story"].transform
			local var_135_11 = 0

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1.var_.moveOldPos4040ui_story = var_135_10.localPosition
			end

			local var_135_12 = 0.001

			if var_135_11 <= arg_132_1.time_ and arg_132_1.time_ < var_135_11 + var_135_12 then
				local var_135_13 = (arg_132_1.time_ - var_135_11) / var_135_12
				local var_135_14 = Vector3.New(0.7, -1.55, -5.5)

				var_135_10.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4040ui_story, var_135_14, var_135_13)

				local var_135_15 = manager.ui.mainCamera.transform.position - var_135_10.position

				var_135_10.forward = Vector3.New(var_135_15.x, var_135_15.y, var_135_15.z)

				local var_135_16 = var_135_10.localEulerAngles

				var_135_16.z = 0
				var_135_16.x = 0
				var_135_10.localEulerAngles = var_135_16
			end

			if arg_132_1.time_ >= var_135_11 + var_135_12 and arg_132_1.time_ < var_135_11 + var_135_12 + arg_135_0 then
				var_135_10.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_135_17 = manager.ui.mainCamera.transform.position - var_135_10.position

				var_135_10.forward = Vector3.New(var_135_17.x, var_135_17.y, var_135_17.z)

				local var_135_18 = var_135_10.localEulerAngles

				var_135_18.z = 0
				var_135_18.x = 0
				var_135_10.localEulerAngles = var_135_18
			end

			local var_135_19 = 0

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 then
				arg_132_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_135_20 = 0
			local var_135_21 = 0.275

			if var_135_20 < arg_132_1.time_ and arg_132_1.time_ <= var_135_20 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_22 = arg_132_1:FormatText(StoryNameCfg[668].name)

				arg_132_1.leftNameTxt_.text = var_135_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_23 = arg_132_1:GetWordFromCfg(319591031)
				local var_135_24 = arg_132_1:FormatText(var_135_23.content)

				arg_132_1.text_.text = var_135_24

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_25 = 11
				local var_135_26 = utf8.len(var_135_24)
				local var_135_27 = var_135_25 <= 0 and var_135_21 or var_135_21 * (var_135_26 / var_135_25)

				if var_135_27 > 0 and var_135_21 < var_135_27 then
					arg_132_1.talkMaxDuration = var_135_27

					if var_135_27 + var_135_20 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_27 + var_135_20
					end
				end

				arg_132_1.text_.text = var_135_24
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591031", "story_v_out_319591.awb") ~= 0 then
					local var_135_28 = manager.audio:GetVoiceLength("story_v_out_319591", "319591031", "story_v_out_319591.awb") / 1000

					if var_135_28 + var_135_20 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_28 + var_135_20
					end

					if var_135_23.prefab_name ~= "" and arg_132_1.actors_[var_135_23.prefab_name] ~= nil then
						local var_135_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_23.prefab_name].transform, "story_v_out_319591", "319591031", "story_v_out_319591.awb")

						arg_132_1:RecordAudio("319591031", var_135_29)
						arg_132_1:RecordAudio("319591031", var_135_29)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319591", "319591031", "story_v_out_319591.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319591", "319591031", "story_v_out_319591.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_30 = math.max(var_135_21, arg_132_1.talkMaxDuration)

			if var_135_20 <= arg_132_1.time_ and arg_132_1.time_ < var_135_20 + var_135_30 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_20) / var_135_30

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_20 + var_135_30 and arg_132_1.time_ < var_135_20 + var_135_30 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319591032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319591032
		arg_136_1.duration_ = 10.3

		local var_136_0 = {
			zh = 4.1,
			ja = 10.3
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
				arg_136_0:Play319591033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_139_2 = 0
			local var_139_3 = 0.4

			if var_139_2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_4 = arg_136_1:FormatText(StoryNameCfg[668].name)

				arg_136_1.leftNameTxt_.text = var_139_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_5 = arg_136_1:GetWordFromCfg(319591032)
				local var_139_6 = arg_136_1:FormatText(var_139_5.content)

				arg_136_1.text_.text = var_139_6

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 16
				local var_139_8 = utf8.len(var_139_6)
				local var_139_9 = var_139_7 <= 0 and var_139_3 or var_139_3 * (var_139_8 / var_139_7)

				if var_139_9 > 0 and var_139_3 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_6
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591032", "story_v_out_319591.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591032", "story_v_out_319591.awb") / 1000

					if var_139_10 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_2
					end

					if var_139_5.prefab_name ~= "" and arg_136_1.actors_[var_139_5.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_5.prefab_name].transform, "story_v_out_319591", "319591032", "story_v_out_319591.awb")

						arg_136_1:RecordAudio("319591032", var_139_11)
						arg_136_1:RecordAudio("319591032", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319591", "319591032", "story_v_out_319591.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319591", "319591032", "story_v_out_319591.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_12 and arg_136_1.time_ < var_139_2 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319591033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319591033
		arg_140_1.duration_ = 8.4

		local var_140_0 = {
			zh = 4.066,
			ja = 8.4
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
				arg_140_0:Play319591034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["4040ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4040ui_story == nil then
				arg_140_1.var_.characterEffect4040ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect4040ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_140_1.var_.characterEffect4040ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4040ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_140_1.var_.characterEffect4040ui_story.fillRatio = var_143_5
			end

			local var_143_6 = arg_140_1.actors_["1095ui_story"]
			local var_143_7 = 0

			if var_143_7 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1095ui_story == nil then
				arg_140_1.var_.characterEffect1095ui_story = var_143_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_8 = 0.200000002980232

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 and not isNil(var_143_6) then
				local var_143_9 = (arg_140_1.time_ - var_143_7) / var_143_8

				if arg_140_1.var_.characterEffect1095ui_story and not isNil(var_143_6) then
					arg_140_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_7 + var_143_8 and arg_140_1.time_ < var_143_7 + var_143_8 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1095ui_story then
				arg_140_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_143_10 = 0
			local var_143_11 = 0.55

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_12 = arg_140_1:FormatText(StoryNameCfg[471].name)

				arg_140_1.leftNameTxt_.text = var_143_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_13 = arg_140_1:GetWordFromCfg(319591033)
				local var_143_14 = arg_140_1:FormatText(var_143_13.content)

				arg_140_1.text_.text = var_143_14

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_15 = 22
				local var_143_16 = utf8.len(var_143_14)
				local var_143_17 = var_143_15 <= 0 and var_143_11 or var_143_11 * (var_143_16 / var_143_15)

				if var_143_17 > 0 and var_143_11 < var_143_17 then
					arg_140_1.talkMaxDuration = var_143_17

					if var_143_17 + var_143_10 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_17 + var_143_10
					end
				end

				arg_140_1.text_.text = var_143_14
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591033", "story_v_out_319591.awb") ~= 0 then
					local var_143_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591033", "story_v_out_319591.awb") / 1000

					if var_143_18 + var_143_10 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_10
					end

					if var_143_13.prefab_name ~= "" and arg_140_1.actors_[var_143_13.prefab_name] ~= nil then
						local var_143_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_13.prefab_name].transform, "story_v_out_319591", "319591033", "story_v_out_319591.awb")

						arg_140_1:RecordAudio("319591033", var_143_19)
						arg_140_1:RecordAudio("319591033", var_143_19)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319591", "319591033", "story_v_out_319591.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319591", "319591033", "story_v_out_319591.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_20 = math.max(var_143_11, arg_140_1.talkMaxDuration)

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_20 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_10) / var_143_20

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_10 + var_143_20 and arg_140_1.time_ < var_143_10 + var_143_20 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319591034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319591034
		arg_144_1.duration_ = 6.3

		local var_144_0 = {
			zh = 6.3,
			ja = 6.133
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
				arg_144_0:Play319591035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["4040ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4040ui_story == nil then
				arg_144_1.var_.characterEffect4040ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect4040ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4040ui_story then
				arg_144_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_147_4 = 0

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_6 = arg_144_1.actors_["1095ui_story"]
			local var_147_7 = 0

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_8 = 0.200000002980232

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_8 and not isNil(var_147_6) then
				local var_147_9 = (arg_144_1.time_ - var_147_7) / var_147_8

				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_6) then
					local var_147_10 = Mathf.Lerp(0, 0.5, var_147_9)

					arg_144_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1095ui_story.fillRatio = var_147_10
				end
			end

			if arg_144_1.time_ >= var_147_7 + var_147_8 and arg_144_1.time_ < var_147_7 + var_147_8 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect1095ui_story then
				local var_147_11 = 0.5

				arg_144_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1095ui_story.fillRatio = var_147_11
			end

			local var_147_12 = 0
			local var_147_13 = 0.625

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_14 = arg_144_1:FormatText(StoryNameCfg[668].name)

				arg_144_1.leftNameTxt_.text = var_147_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_15 = arg_144_1:GetWordFromCfg(319591034)
				local var_147_16 = arg_144_1:FormatText(var_147_15.content)

				arg_144_1.text_.text = var_147_16

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_17 = 25
				local var_147_18 = utf8.len(var_147_16)
				local var_147_19 = var_147_17 <= 0 and var_147_13 or var_147_13 * (var_147_18 / var_147_17)

				if var_147_19 > 0 and var_147_13 < var_147_19 then
					arg_144_1.talkMaxDuration = var_147_19

					if var_147_19 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_19 + var_147_12
					end
				end

				arg_144_1.text_.text = var_147_16
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591034", "story_v_out_319591.awb") ~= 0 then
					local var_147_20 = manager.audio:GetVoiceLength("story_v_out_319591", "319591034", "story_v_out_319591.awb") / 1000

					if var_147_20 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_20 + var_147_12
					end

					if var_147_15.prefab_name ~= "" and arg_144_1.actors_[var_147_15.prefab_name] ~= nil then
						local var_147_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_15.prefab_name].transform, "story_v_out_319591", "319591034", "story_v_out_319591.awb")

						arg_144_1:RecordAudio("319591034", var_147_21)
						arg_144_1:RecordAudio("319591034", var_147_21)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319591", "319591034", "story_v_out_319591.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319591", "319591034", "story_v_out_319591.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_22 = math.max(var_147_13, arg_144_1.talkMaxDuration)

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_22 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_12) / var_147_22

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_12 + var_147_22 and arg_144_1.time_ < var_147_12 + var_147_22 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319591035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319591035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play319591036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["4040ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect4040ui_story == nil then
				arg_148_1.var_.characterEffect4040ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect4040ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_148_1.var_.characterEffect4040ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect4040ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_148_1.var_.characterEffect4040ui_story.fillRatio = var_151_5
			end

			local var_151_6 = arg_148_1.actors_["1095ui_story"]
			local var_151_7 = 0

			if var_151_7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 and not isNil(var_151_6) and arg_148_1.var_.characterEffect1095ui_story == nil then
				arg_148_1.var_.characterEffect1095ui_story = var_151_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_8 = 0.200000002980232

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_8 and not isNil(var_151_6) then
				local var_151_9 = (arg_148_1.time_ - var_151_7) / var_151_8

				if arg_148_1.var_.characterEffect1095ui_story and not isNil(var_151_6) then
					local var_151_10 = Mathf.Lerp(0, 0.5, var_151_9)

					arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1095ui_story.fillRatio = var_151_10
				end
			end

			if arg_148_1.time_ >= var_151_7 + var_151_8 and arg_148_1.time_ < var_151_7 + var_151_8 + arg_151_0 and not isNil(var_151_6) and arg_148_1.var_.characterEffect1095ui_story then
				local var_151_11 = 0.5

				arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1095ui_story.fillRatio = var_151_11
			end

			local var_151_12 = 0
			local var_151_13 = 1

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_14 = arg_148_1:GetWordFromCfg(319591035)
				local var_151_15 = arg_148_1:FormatText(var_151_14.content)

				arg_148_1.text_.text = var_151_15

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_16 = 40
				local var_151_17 = utf8.len(var_151_15)
				local var_151_18 = var_151_16 <= 0 and var_151_13 or var_151_13 * (var_151_17 / var_151_16)

				if var_151_18 > 0 and var_151_13 < var_151_18 then
					arg_148_1.talkMaxDuration = var_151_18

					if var_151_18 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_18 + var_151_12
					end
				end

				arg_148_1.text_.text = var_151_15
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_19 = math.max(var_151_13, arg_148_1.talkMaxDuration)

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_19 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_12) / var_151_19

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_12 + var_151_19 and arg_148_1.time_ < var_151_12 + var_151_19 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play319591036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319591036
		arg_152_1.duration_ = 6

		local var_152_0 = {
			zh = 3.433,
			ja = 6
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
				arg_152_0:Play319591037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["4040ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect4040ui_story == nil then
				arg_152_1.var_.characterEffect4040ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect4040ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect4040ui_story then
				arg_152_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_155_4 = 0
			local var_155_5 = 0.325

			if var_155_4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_6 = arg_152_1:FormatText(StoryNameCfg[668].name)

				arg_152_1.leftNameTxt_.text = var_155_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_7 = arg_152_1:GetWordFromCfg(319591036)
				local var_155_8 = arg_152_1:FormatText(var_155_7.content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 13
				local var_155_10 = utf8.len(var_155_8)
				local var_155_11 = var_155_9 <= 0 and var_155_5 or var_155_5 * (var_155_10 / var_155_9)

				if var_155_11 > 0 and var_155_5 < var_155_11 then
					arg_152_1.talkMaxDuration = var_155_11

					if var_155_11 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591036", "story_v_out_319591.awb") ~= 0 then
					local var_155_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591036", "story_v_out_319591.awb") / 1000

					if var_155_12 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_4
					end

					if var_155_7.prefab_name ~= "" and arg_152_1.actors_[var_155_7.prefab_name] ~= nil then
						local var_155_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_7.prefab_name].transform, "story_v_out_319591", "319591036", "story_v_out_319591.awb")

						arg_152_1:RecordAudio("319591036", var_155_13)
						arg_152_1:RecordAudio("319591036", var_155_13)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319591", "319591036", "story_v_out_319591.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319591", "319591036", "story_v_out_319591.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_14 and arg_152_1.time_ < var_155_4 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319591037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319591037
		arg_156_1.duration_ = 2.6

		local var_156_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_156_0:Play319591038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1095ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1095ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1095ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1095ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1095ui_story == nil then
				arg_156_1.var_.characterEffect1095ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1095ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1095ui_story then
				arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_15 = arg_156_1.actors_["4040ui_story"]
			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 and not isNil(var_159_15) and arg_156_1.var_.characterEffect4040ui_story == nil then
				arg_156_1.var_.characterEffect4040ui_story = var_159_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_17 = 0.200000002980232

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_17 and not isNil(var_159_15) then
				local var_159_18 = (arg_156_1.time_ - var_159_16) / var_159_17

				if arg_156_1.var_.characterEffect4040ui_story and not isNil(var_159_15) then
					local var_159_19 = Mathf.Lerp(0, 0.5, var_159_18)

					arg_156_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_156_1.var_.characterEffect4040ui_story.fillRatio = var_159_19
				end
			end

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 and not isNil(var_159_15) and arg_156_1.var_.characterEffect4040ui_story then
				local var_159_20 = 0.5

				arg_156_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_156_1.var_.characterEffect4040ui_story.fillRatio = var_159_20
			end

			local var_159_21 = 0
			local var_159_22 = 0.05

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_23 = arg_156_1:FormatText(StoryNameCfg[471].name)

				arg_156_1.leftNameTxt_.text = var_159_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_24 = arg_156_1:GetWordFromCfg(319591037)
				local var_159_25 = arg_156_1:FormatText(var_159_24.content)

				arg_156_1.text_.text = var_159_25

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_26 = 2
				local var_159_27 = utf8.len(var_159_25)
				local var_159_28 = var_159_26 <= 0 and var_159_22 or var_159_22 * (var_159_27 / var_159_26)

				if var_159_28 > 0 and var_159_22 < var_159_28 then
					arg_156_1.talkMaxDuration = var_159_28

					if var_159_28 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_21
					end
				end

				arg_156_1.text_.text = var_159_25
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591037", "story_v_out_319591.awb") ~= 0 then
					local var_159_29 = manager.audio:GetVoiceLength("story_v_out_319591", "319591037", "story_v_out_319591.awb") / 1000

					if var_159_29 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_29 + var_159_21
					end

					if var_159_24.prefab_name ~= "" and arg_156_1.actors_[var_159_24.prefab_name] ~= nil then
						local var_159_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_24.prefab_name].transform, "story_v_out_319591", "319591037", "story_v_out_319591.awb")

						arg_156_1:RecordAudio("319591037", var_159_30)
						arg_156_1:RecordAudio("319591037", var_159_30)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319591", "319591037", "story_v_out_319591.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319591", "319591037", "story_v_out_319591.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_31 = math.max(var_159_22, arg_156_1.talkMaxDuration)

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_31 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_21) / var_159_31

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_21 + var_159_31 and arg_156_1.time_ < var_159_21 + var_159_31 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play319591038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319591038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319591039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.5

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				local var_163_1 = manager.ui.mainCamera.transform.localPosition
				local var_163_2 = Vector3.New(0, 0, 10) + Vector3.New(var_163_1.x, var_163_1.y, 0)
				local var_163_3 = arg_160_1.bgs_.STwhite

				var_163_3.transform.localPosition = var_163_2
				var_163_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_4 = var_163_3:GetComponent("SpriteRenderer")

				if var_163_4 and var_163_4.sprite then
					local var_163_5 = (var_163_3.transform.localPosition - var_163_1).z
					local var_163_6 = manager.ui.mainCameraCom_
					local var_163_7 = 2 * var_163_5 * Mathf.Tan(var_163_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_8 = var_163_7 * var_163_6.aspect
					local var_163_9 = var_163_4.sprite.bounds.size.x
					local var_163_10 = var_163_4.sprite.bounds.size.y
					local var_163_11 = var_163_8 / var_163_9
					local var_163_12 = var_163_7 / var_163_10
					local var_163_13 = var_163_12 < var_163_11 and var_163_11 or var_163_12

					var_163_3.transform.localScale = Vector3.New(var_163_13, var_163_13, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "STwhite" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_14 = arg_160_1.actors_["1095ui_story"]
			local var_163_15 = 0

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 and not isNil(var_163_14) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_16 = 0.200000002980232

			if var_163_15 <= arg_160_1.time_ and arg_160_1.time_ < var_163_15 + var_163_16 and not isNil(var_163_14) then
				local var_163_17 = (arg_160_1.time_ - var_163_15) / var_163_16

				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_14) then
					local var_163_18 = Mathf.Lerp(0, 0.5, var_163_17)

					arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1095ui_story.fillRatio = var_163_18
				end
			end

			if arg_160_1.time_ >= var_163_15 + var_163_16 and arg_160_1.time_ < var_163_15 + var_163_16 + arg_163_0 and not isNil(var_163_14) and arg_160_1.var_.characterEffect1095ui_story then
				local var_163_19 = 0.5

				arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1095ui_story.fillRatio = var_163_19
			end

			local var_163_20 = arg_160_1.actors_["1095ui_story"].transform
			local var_163_21 = 0

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1.var_.moveOldPos1095ui_story = var_163_20.localPosition
			end

			local var_163_22 = 0.001

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_22 then
				local var_163_23 = (arg_160_1.time_ - var_163_21) / var_163_22
				local var_163_24 = Vector3.New(0, 100, 0)

				var_163_20.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1095ui_story, var_163_24, var_163_23)

				local var_163_25 = manager.ui.mainCamera.transform.position - var_163_20.position

				var_163_20.forward = Vector3.New(var_163_25.x, var_163_25.y, var_163_25.z)

				local var_163_26 = var_163_20.localEulerAngles

				var_163_26.z = 0
				var_163_26.x = 0
				var_163_20.localEulerAngles = var_163_26
			end

			if arg_160_1.time_ >= var_163_21 + var_163_22 and arg_160_1.time_ < var_163_21 + var_163_22 + arg_163_0 then
				var_163_20.localPosition = Vector3.New(0, 100, 0)

				local var_163_27 = manager.ui.mainCamera.transform.position - var_163_20.position

				var_163_20.forward = Vector3.New(var_163_27.x, var_163_27.y, var_163_27.z)

				local var_163_28 = var_163_20.localEulerAngles

				var_163_28.z = 0
				var_163_28.x = 0
				var_163_20.localEulerAngles = var_163_28
			end

			local var_163_29 = arg_160_1.actors_["4040ui_story"].transform
			local var_163_30 = 0

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.var_.moveOldPos4040ui_story = var_163_29.localPosition
			end

			local var_163_31 = 0.001

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_31 then
				local var_163_32 = (arg_160_1.time_ - var_163_30) / var_163_31
				local var_163_33 = Vector3.New(0, 100, 0)

				var_163_29.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos4040ui_story, var_163_33, var_163_32)

				local var_163_34 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_34.x, var_163_34.y, var_163_34.z)

				local var_163_35 = var_163_29.localEulerAngles

				var_163_35.z = 0
				var_163_35.x = 0
				var_163_29.localEulerAngles = var_163_35
			end

			if arg_160_1.time_ >= var_163_30 + var_163_31 and arg_160_1.time_ < var_163_30 + var_163_31 + arg_163_0 then
				var_163_29.localPosition = Vector3.New(0, 100, 0)

				local var_163_36 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_36.x, var_163_36.y, var_163_36.z)

				local var_163_37 = var_163_29.localEulerAngles

				var_163_37.z = 0
				var_163_37.x = 0
				var_163_29.localEulerAngles = var_163_37
			end

			local var_163_38 = 0.5

			if var_163_38 < arg_160_1.time_ and arg_160_1.time_ <= var_163_38 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_39 = 1

			if var_163_38 <= arg_160_1.time_ and arg_160_1.time_ < var_163_38 + var_163_39 then
				local var_163_40 = (arg_160_1.time_ - var_163_38) / var_163_39
				local var_163_41 = Color.New(1, 1, 1)

				var_163_41.a = Mathf.Lerp(1, 0, var_163_40)
				arg_160_1.mask_.color = var_163_41
			end

			if arg_160_1.time_ >= var_163_38 + var_163_39 and arg_160_1.time_ < var_163_38 + var_163_39 + arg_163_0 then
				local var_163_42 = Color.New(1, 1, 1)
				local var_163_43 = 0

				arg_160_1.mask_.enabled = false
				var_163_42.a = var_163_43
				arg_160_1.mask_.color = var_163_42
			end

			local var_163_44 = arg_160_1.bgs_.I10f.transform
			local var_163_45 = 0

			if var_163_45 < arg_160_1.time_ and arg_160_1.time_ <= var_163_45 + arg_163_0 then
				arg_160_1.var_.moveOldPosI10f = var_163_44.localPosition
			end

			local var_163_46 = 0.5

			if var_163_45 <= arg_160_1.time_ and arg_160_1.time_ < var_163_45 + var_163_46 then
				local var_163_47 = (arg_160_1.time_ - var_163_45) / var_163_46
				local var_163_48 = Vector3.New(0, 1, 3)

				var_163_44.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPosI10f, var_163_48, var_163_47)
			end

			if arg_160_1.time_ >= var_163_45 + var_163_46 and arg_160_1.time_ < var_163_45 + var_163_46 + arg_163_0 then
				var_163_44.localPosition = Vector3.New(0, 1, 3)
			end

			local var_163_49 = arg_160_1.bgs_.STwhite.transform
			local var_163_50 = 0.5

			if var_163_50 < arg_160_1.time_ and arg_160_1.time_ <= var_163_50 + arg_163_0 then
				arg_160_1.var_.moveOldPosSTwhite = var_163_49.localPosition
			end

			local var_163_51 = 0.5

			if var_163_50 <= arg_160_1.time_ and arg_160_1.time_ < var_163_50 + var_163_51 then
				local var_163_52 = (arg_160_1.time_ - var_163_50) / var_163_51
				local var_163_53 = Vector3.New(0, 1, 10)

				var_163_49.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPosSTwhite, var_163_53, var_163_52)
			end

			if arg_160_1.time_ >= var_163_50 + var_163_51 and arg_160_1.time_ < var_163_50 + var_163_51 + arg_163_0 then
				var_163_49.localPosition = Vector3.New(0, 1, 10)
			end

			local var_163_54 = 0.5
			local var_163_55 = 1

			if var_163_54 < arg_160_1.time_ and arg_160_1.time_ <= var_163_54 + arg_163_0 then
				local var_163_56 = "play"
				local var_163_57 = "effect"

				arg_160_1:AudioAction(var_163_56, var_163_57, "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			local var_163_58 = 0
			local var_163_59 = 0.8

			if var_163_58 < arg_160_1.time_ and arg_160_1.time_ <= var_163_58 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_60 = arg_160_1:GetWordFromCfg(319591038)
				local var_163_61 = arg_160_1:FormatText(var_163_60.content)

				arg_160_1.text_.text = var_163_61

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_62 = 32
				local var_163_63 = utf8.len(var_163_61)
				local var_163_64 = var_163_62 <= 0 and var_163_59 or var_163_59 * (var_163_63 / var_163_62)

				if var_163_64 > 0 and var_163_59 < var_163_64 then
					arg_160_1.talkMaxDuration = var_163_64

					if var_163_64 + var_163_58 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_64 + var_163_58
					end
				end

				arg_160_1.text_.text = var_163_61
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_65 = math.max(var_163_59, arg_160_1.talkMaxDuration)

			if var_163_58 <= arg_160_1.time_ and arg_160_1.time_ < var_163_58 + var_163_65 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_58) / var_163_65

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_58 + var_163_65 and arg_160_1.time_ < var_163_58 + var_163_65 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
			},
			{
				assetPath = "",
				actorName = "I10f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play319591039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319591039
		arg_164_1.duration_ = 6

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319591040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 1

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				local var_167_2 = "play"
				local var_167_3 = "effect"

				arg_164_1:AudioAction(var_167_2, var_167_3, "se_story_123_02", "se_story_123_02_whoosh", "")
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_5 = 1

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_5 then
				local var_167_6 = (arg_164_1.time_ - var_167_4) / var_167_5
				local var_167_7 = Color.New(1, 1, 1)

				var_167_7.a = Mathf.Lerp(1, 0, var_167_6)
				arg_164_1.mask_.color = var_167_7
			end

			if arg_164_1.time_ >= var_167_4 + var_167_5 and arg_164_1.time_ < var_167_4 + var_167_5 + arg_167_0 then
				local var_167_8 = Color.New(1, 1, 1)
				local var_167_9 = 0

				arg_164_1.mask_.enabled = false
				var_167_8.a = var_167_9
				arg_164_1.mask_.color = var_167_8
			end

			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				local var_167_11 = manager.ui.mainCamera.transform.localPosition
				local var_167_12 = Vector3.New(0, 0, 10) + Vector3.New(var_167_11.x, var_167_11.y, 0)
				local var_167_13 = arg_164_1.bgs_.I10f

				var_167_13.transform.localPosition = var_167_12
				var_167_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_14 = var_167_13:GetComponent("SpriteRenderer")

				if var_167_14 and var_167_14.sprite then
					local var_167_15 = (var_167_13.transform.localPosition - var_167_11).z
					local var_167_16 = manager.ui.mainCameraCom_
					local var_167_17 = 2 * var_167_15 * Mathf.Tan(var_167_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_18 = var_167_17 * var_167_16.aspect
					local var_167_19 = var_167_14.sprite.bounds.size.x
					local var_167_20 = var_167_14.sprite.bounds.size.y
					local var_167_21 = var_167_18 / var_167_19
					local var_167_22 = var_167_17 / var_167_20
					local var_167_23 = var_167_22 < var_167_21 and var_167_21 or var_167_22

					var_167_13.transform.localScale = Vector3.New(var_167_23, var_167_23, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "I10f" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_24 = 1
			local var_167_25 = 1.3

			if var_167_24 < arg_164_1.time_ and arg_164_1.time_ <= var_167_24 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_26 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_26:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_27 = arg_164_1:GetWordFromCfg(319591039)
				local var_167_28 = arg_164_1:FormatText(var_167_27.content)

				arg_164_1.text_.text = var_167_28

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_29 = 52
				local var_167_30 = utf8.len(var_167_28)
				local var_167_31 = var_167_29 <= 0 and var_167_25 or var_167_25 * (var_167_30 / var_167_29)

				if var_167_31 > 0 and var_167_25 < var_167_31 then
					arg_164_1.talkMaxDuration = var_167_31
					var_167_24 = var_167_24 + 0.3

					if var_167_31 + var_167_24 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_31 + var_167_24
					end
				end

				arg_164_1.text_.text = var_167_28
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_32 = var_167_24 + 0.3
			local var_167_33 = math.max(var_167_25, arg_164_1.talkMaxDuration)

			if var_167_32 <= arg_164_1.time_ and arg_164_1.time_ < var_167_32 + var_167_33 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_32) / var_167_33

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_32 + var_167_33 and arg_164_1.time_ < var_167_32 + var_167_33 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play319591040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319591040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319591041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				local var_173_2 = "play"
				local var_173_3 = "effect"

				arg_170_1:AudioAction(var_173_2, var_173_3, "se_story_127", "se_story_127_hit", "")
			end

			local var_173_4 = 0
			local var_173_5 = 1.3

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(319591040)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_8 = 52
				local var_173_9 = utf8.len(var_173_7)
				local var_173_10 = var_173_8 <= 0 and var_173_5 or var_173_5 * (var_173_9 / var_173_8)

				if var_173_10 > 0 and var_173_5 < var_173_10 then
					arg_170_1.talkMaxDuration = var_173_10

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_11 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_11 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_11

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_11 and arg_170_1.time_ < var_173_4 + var_173_11 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play319591041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319591041
		arg_174_1.duration_ = 1.6

		local var_174_0 = {
			zh = 1.6,
			ja = 1.433
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
				arg_174_0:Play319591042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["4037ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos4037ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, -1.12, -6.2)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4037ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = arg_174_1.actors_["4037ui_story"]
			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect4037ui_story == nil then
				arg_174_1.var_.characterEffect4037ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.200000002980232

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_11 and not isNil(var_177_9) then
				local var_177_12 = (arg_174_1.time_ - var_177_10) / var_177_11

				if arg_174_1.var_.characterEffect4037ui_story and not isNil(var_177_9) then
					arg_174_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_10 + var_177_11 and arg_174_1.time_ < var_177_10 + var_177_11 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect4037ui_story then
				arg_174_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_177_13 = 0

			if var_177_13 < arg_174_1.time_ and arg_174_1.time_ <= var_177_13 + arg_177_0 then
				arg_174_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_177_14 = 0

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_15 = arg_174_1.actors_["4040ui_story"].transform
			local var_177_16 = 0

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 then
				arg_174_1.var_.moveOldPos4040ui_story = var_177_15.localPosition
			end

			local var_177_17 = 0.001

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_17 then
				local var_177_18 = (arg_174_1.time_ - var_177_16) / var_177_17
				local var_177_19 = Vector3.New(0, 100, 0)

				var_177_15.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4040ui_story, var_177_19, var_177_18)

				local var_177_20 = manager.ui.mainCamera.transform.position - var_177_15.position

				var_177_15.forward = Vector3.New(var_177_20.x, var_177_20.y, var_177_20.z)

				local var_177_21 = var_177_15.localEulerAngles

				var_177_21.z = 0
				var_177_21.x = 0
				var_177_15.localEulerAngles = var_177_21
			end

			if arg_174_1.time_ >= var_177_16 + var_177_17 and arg_174_1.time_ < var_177_16 + var_177_17 + arg_177_0 then
				var_177_15.localPosition = Vector3.New(0, 100, 0)

				local var_177_22 = manager.ui.mainCamera.transform.position - var_177_15.position

				var_177_15.forward = Vector3.New(var_177_22.x, var_177_22.y, var_177_22.z)

				local var_177_23 = var_177_15.localEulerAngles

				var_177_23.z = 0
				var_177_23.x = 0
				var_177_15.localEulerAngles = var_177_23
			end

			local var_177_24 = arg_174_1.actors_["4040ui_story"]
			local var_177_25 = 0

			if var_177_25 < arg_174_1.time_ and arg_174_1.time_ <= var_177_25 + arg_177_0 and not isNil(var_177_24) and arg_174_1.var_.characterEffect4040ui_story == nil then
				arg_174_1.var_.characterEffect4040ui_story = var_177_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_26 = 0.200000002980232

			if var_177_25 <= arg_174_1.time_ and arg_174_1.time_ < var_177_25 + var_177_26 and not isNil(var_177_24) then
				local var_177_27 = (arg_174_1.time_ - var_177_25) / var_177_26

				if arg_174_1.var_.characterEffect4040ui_story and not isNil(var_177_24) then
					local var_177_28 = Mathf.Lerp(0, 0.5, var_177_27)

					arg_174_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_174_1.var_.characterEffect4040ui_story.fillRatio = var_177_28
				end
			end

			if arg_174_1.time_ >= var_177_25 + var_177_26 and arg_174_1.time_ < var_177_25 + var_177_26 + arg_177_0 and not isNil(var_177_24) and arg_174_1.var_.characterEffect4040ui_story then
				local var_177_29 = 0.5

				arg_174_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_174_1.var_.characterEffect4040ui_story.fillRatio = var_177_29
			end

			local var_177_30 = arg_174_1.actors_["1095ui_story"].transform
			local var_177_31 = 0

			if var_177_31 < arg_174_1.time_ and arg_174_1.time_ <= var_177_31 + arg_177_0 then
				arg_174_1.var_.moveOldPos1095ui_story = var_177_30.localPosition
			end

			local var_177_32 = 0.001

			if var_177_31 <= arg_174_1.time_ and arg_174_1.time_ < var_177_31 + var_177_32 then
				local var_177_33 = (arg_174_1.time_ - var_177_31) / var_177_32
				local var_177_34 = Vector3.New(0, 100, 0)

				var_177_30.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1095ui_story, var_177_34, var_177_33)

				local var_177_35 = manager.ui.mainCamera.transform.position - var_177_30.position

				var_177_30.forward = Vector3.New(var_177_35.x, var_177_35.y, var_177_35.z)

				local var_177_36 = var_177_30.localEulerAngles

				var_177_36.z = 0
				var_177_36.x = 0
				var_177_30.localEulerAngles = var_177_36
			end

			if arg_174_1.time_ >= var_177_31 + var_177_32 and arg_174_1.time_ < var_177_31 + var_177_32 + arg_177_0 then
				var_177_30.localPosition = Vector3.New(0, 100, 0)

				local var_177_37 = manager.ui.mainCamera.transform.position - var_177_30.position

				var_177_30.forward = Vector3.New(var_177_37.x, var_177_37.y, var_177_37.z)

				local var_177_38 = var_177_30.localEulerAngles

				var_177_38.z = 0
				var_177_38.x = 0
				var_177_30.localEulerAngles = var_177_38
			end

			local var_177_39 = arg_174_1.actors_["1095ui_story"]
			local var_177_40 = 0

			if var_177_40 < arg_174_1.time_ and arg_174_1.time_ <= var_177_40 + arg_177_0 and not isNil(var_177_39) and arg_174_1.var_.characterEffect1095ui_story == nil then
				arg_174_1.var_.characterEffect1095ui_story = var_177_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_41 = 0.200000002980232

			if var_177_40 <= arg_174_1.time_ and arg_174_1.time_ < var_177_40 + var_177_41 and not isNil(var_177_39) then
				local var_177_42 = (arg_174_1.time_ - var_177_40) / var_177_41

				if arg_174_1.var_.characterEffect1095ui_story and not isNil(var_177_39) then
					local var_177_43 = Mathf.Lerp(0, 0.5, var_177_42)

					arg_174_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1095ui_story.fillRatio = var_177_43
				end
			end

			if arg_174_1.time_ >= var_177_40 + var_177_41 and arg_174_1.time_ < var_177_40 + var_177_41 + arg_177_0 and not isNil(var_177_39) and arg_174_1.var_.characterEffect1095ui_story then
				local var_177_44 = 0.5

				arg_174_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1095ui_story.fillRatio = var_177_44
			end

			local var_177_45 = 0
			local var_177_46 = 0.125

			if var_177_45 < arg_174_1.time_ and arg_174_1.time_ <= var_177_45 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_47 = arg_174_1:FormatText(StoryNameCfg[453].name)

				arg_174_1.leftNameTxt_.text = var_177_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_48 = arg_174_1:GetWordFromCfg(319591041)
				local var_177_49 = arg_174_1:FormatText(var_177_48.content)

				arg_174_1.text_.text = var_177_49

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_50 = 5
				local var_177_51 = utf8.len(var_177_49)
				local var_177_52 = var_177_50 <= 0 and var_177_46 or var_177_46 * (var_177_51 / var_177_50)

				if var_177_52 > 0 and var_177_46 < var_177_52 then
					arg_174_1.talkMaxDuration = var_177_52

					if var_177_52 + var_177_45 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_52 + var_177_45
					end
				end

				arg_174_1.text_.text = var_177_49
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591041", "story_v_out_319591.awb") ~= 0 then
					local var_177_53 = manager.audio:GetVoiceLength("story_v_out_319591", "319591041", "story_v_out_319591.awb") / 1000

					if var_177_53 + var_177_45 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_53 + var_177_45
					end

					if var_177_48.prefab_name ~= "" and arg_174_1.actors_[var_177_48.prefab_name] ~= nil then
						local var_177_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_48.prefab_name].transform, "story_v_out_319591", "319591041", "story_v_out_319591.awb")

						arg_174_1:RecordAudio("319591041", var_177_54)
						arg_174_1:RecordAudio("319591041", var_177_54)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_319591", "319591041", "story_v_out_319591.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_319591", "319591041", "story_v_out_319591.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_55 = math.max(var_177_46, arg_174_1.talkMaxDuration)

			if var_177_45 <= arg_174_1.time_ and arg_174_1.time_ < var_177_45 + var_177_55 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_45) / var_177_55

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_45 + var_177_55 and arg_174_1.time_ < var_177_45 + var_177_55 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play319591042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319591042
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play319591043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["4037ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect4037ui_story == nil then
				arg_178_1.var_.characterEffect4037ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect4037ui_story and not isNil(var_181_0) then
					local var_181_4 = Mathf.Lerp(0, 0.5, var_181_3)

					arg_178_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_178_1.var_.characterEffect4037ui_story.fillRatio = var_181_4
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect4037ui_story then
				local var_181_5 = 0.5

				arg_178_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_178_1.var_.characterEffect4037ui_story.fillRatio = var_181_5
			end

			local var_181_6 = 0
			local var_181_7 = 1.175

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(319591042)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_10 = 47
				local var_181_11 = utf8.len(var_181_9)
				local var_181_12 = var_181_10 <= 0 and var_181_7 or var_181_7 * (var_181_11 / var_181_10)

				if var_181_12 > 0 and var_181_7 < var_181_12 then
					arg_178_1.talkMaxDuration = var_181_12

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_13 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_13 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_13

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_13 and arg_178_1.time_ < var_181_6 + var_181_13 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play319591043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319591043
		arg_182_1.duration_ = 2

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319591044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10079ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos10079ui_story = var_185_0.localPosition

				local var_185_2 = "10079ui_story"

				arg_182_1:ShowWeapon(arg_182_1.var_[var_185_2 .. "Animator"].transform, true)
			end

			local var_185_3 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_3 then
				local var_185_4 = (arg_182_1.time_ - var_185_1) / var_185_3
				local var_185_5 = Vector3.New(0, -0.95, -6.05)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10079ui_story, var_185_5, var_185_4)

				local var_185_6 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_6.x, var_185_6.y, var_185_6.z)

				local var_185_7 = var_185_0.localEulerAngles

				var_185_7.z = 0
				var_185_7.x = 0
				var_185_0.localEulerAngles = var_185_7
			end

			if arg_182_1.time_ >= var_185_1 + var_185_3 and arg_182_1.time_ < var_185_1 + var_185_3 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_185_8 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_8.x, var_185_8.y, var_185_8.z)

				local var_185_9 = var_185_0.localEulerAngles

				var_185_9.z = 0
				var_185_9.x = 0
				var_185_0.localEulerAngles = var_185_9
			end

			local var_185_10 = arg_182_1.actors_["10079ui_story"]
			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 and not isNil(var_185_10) and arg_182_1.var_.characterEffect10079ui_story == nil then
				arg_182_1.var_.characterEffect10079ui_story = var_185_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_12 = 0.200000002980232

			if var_185_11 <= arg_182_1.time_ and arg_182_1.time_ < var_185_11 + var_185_12 and not isNil(var_185_10) then
				local var_185_13 = (arg_182_1.time_ - var_185_11) / var_185_12

				if arg_182_1.var_.characterEffect10079ui_story and not isNil(var_185_10) then
					arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_11 + var_185_12 and arg_182_1.time_ < var_185_11 + var_185_12 + arg_185_0 and not isNil(var_185_10) and arg_182_1.var_.characterEffect10079ui_story then
				arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_185_14 = 0

			if var_185_14 < arg_182_1.time_ and arg_182_1.time_ <= var_185_14 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_185_15 = 0

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_185_16 = arg_182_1.actors_["4037ui_story"].transform
			local var_185_17 = 0

			if var_185_17 < arg_182_1.time_ and arg_182_1.time_ <= var_185_17 + arg_185_0 then
				arg_182_1.var_.moveOldPos4037ui_story = var_185_16.localPosition
			end

			local var_185_18 = 0.001

			if var_185_17 <= arg_182_1.time_ and arg_182_1.time_ < var_185_17 + var_185_18 then
				local var_185_19 = (arg_182_1.time_ - var_185_17) / var_185_18
				local var_185_20 = Vector3.New(0, 100, 0)

				var_185_16.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos4037ui_story, var_185_20, var_185_19)

				local var_185_21 = manager.ui.mainCamera.transform.position - var_185_16.position

				var_185_16.forward = Vector3.New(var_185_21.x, var_185_21.y, var_185_21.z)

				local var_185_22 = var_185_16.localEulerAngles

				var_185_22.z = 0
				var_185_22.x = 0
				var_185_16.localEulerAngles = var_185_22
			end

			if arg_182_1.time_ >= var_185_17 + var_185_18 and arg_182_1.time_ < var_185_17 + var_185_18 + arg_185_0 then
				var_185_16.localPosition = Vector3.New(0, 100, 0)

				local var_185_23 = manager.ui.mainCamera.transform.position - var_185_16.position

				var_185_16.forward = Vector3.New(var_185_23.x, var_185_23.y, var_185_23.z)

				local var_185_24 = var_185_16.localEulerAngles

				var_185_24.z = 0
				var_185_24.x = 0
				var_185_16.localEulerAngles = var_185_24
			end

			local var_185_25 = arg_182_1.actors_["4037ui_story"]
			local var_185_26 = 0

			if var_185_26 < arg_182_1.time_ and arg_182_1.time_ <= var_185_26 + arg_185_0 and not isNil(var_185_25) and arg_182_1.var_.characterEffect4037ui_story == nil then
				arg_182_1.var_.characterEffect4037ui_story = var_185_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_27 = 0.200000002980232

			if var_185_26 <= arg_182_1.time_ and arg_182_1.time_ < var_185_26 + var_185_27 and not isNil(var_185_25) then
				local var_185_28 = (arg_182_1.time_ - var_185_26) / var_185_27

				if arg_182_1.var_.characterEffect4037ui_story and not isNil(var_185_25) then
					local var_185_29 = Mathf.Lerp(0, 0.5, var_185_28)

					arg_182_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_182_1.var_.characterEffect4037ui_story.fillRatio = var_185_29
				end
			end

			if arg_182_1.time_ >= var_185_26 + var_185_27 and arg_182_1.time_ < var_185_26 + var_185_27 + arg_185_0 and not isNil(var_185_25) and arg_182_1.var_.characterEffect4037ui_story then
				local var_185_30 = 0.5

				arg_182_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_182_1.var_.characterEffect4037ui_story.fillRatio = var_185_30
			end

			local var_185_31 = 0
			local var_185_32 = 0.075

			if var_185_31 < arg_182_1.time_ and arg_182_1.time_ <= var_185_31 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_33 = arg_182_1:FormatText(StoryNameCfg[6].name)

				arg_182_1.leftNameTxt_.text = var_185_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_34 = arg_182_1:GetWordFromCfg(319591043)
				local var_185_35 = arg_182_1:FormatText(var_185_34.content)

				arg_182_1.text_.text = var_185_35

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_36 = 3
				local var_185_37 = utf8.len(var_185_35)
				local var_185_38 = var_185_36 <= 0 and var_185_32 or var_185_32 * (var_185_37 / var_185_36)

				if var_185_38 > 0 and var_185_32 < var_185_38 then
					arg_182_1.talkMaxDuration = var_185_38

					if var_185_38 + var_185_31 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_38 + var_185_31
					end
				end

				arg_182_1.text_.text = var_185_35
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591043", "story_v_out_319591.awb") ~= 0 then
					local var_185_39 = manager.audio:GetVoiceLength("story_v_out_319591", "319591043", "story_v_out_319591.awb") / 1000

					if var_185_39 + var_185_31 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_39 + var_185_31
					end

					if var_185_34.prefab_name ~= "" and arg_182_1.actors_[var_185_34.prefab_name] ~= nil then
						local var_185_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_34.prefab_name].transform, "story_v_out_319591", "319591043", "story_v_out_319591.awb")

						arg_182_1:RecordAudio("319591043", var_185_40)
						arg_182_1:RecordAudio("319591043", var_185_40)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319591", "319591043", "story_v_out_319591.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319591", "319591043", "story_v_out_319591.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_41 = math.max(var_185_32, arg_182_1.talkMaxDuration)

			if var_185_31 <= arg_182_1.time_ and arg_182_1.time_ < var_185_31 + var_185_41 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_31) / var_185_41

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_31 + var_185_41 and arg_182_1.time_ < var_185_31 + var_185_41 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play319591044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319591044
		arg_186_1.duration_ = 2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play319591045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1095ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos1095ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(0.7, -0.98, -6.1)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1095ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = arg_186_1.actors_["1095ui_story"]
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect1095ui_story == nil then
				arg_186_1.var_.characterEffect1095ui_story = var_189_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_11 = 0.200000002980232

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 and not isNil(var_189_9) then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11

				if arg_186_1.var_.characterEffect1095ui_story and not isNil(var_189_9) then
					arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect1095ui_story then
				arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_189_13 = 0

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_189_14 = 0

			if var_189_14 < arg_186_1.time_ and arg_186_1.time_ <= var_189_14 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_189_15 = arg_186_1.actors_["10079ui_story"].transform
			local var_189_16 = 0

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.var_.moveOldPos10079ui_story = var_189_15.localPosition
			end

			local var_189_17 = 0.001

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_17 then
				local var_189_18 = (arg_186_1.time_ - var_189_16) / var_189_17
				local var_189_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_189_15.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10079ui_story, var_189_19, var_189_18)

				local var_189_20 = manager.ui.mainCamera.transform.position - var_189_15.position

				var_189_15.forward = Vector3.New(var_189_20.x, var_189_20.y, var_189_20.z)

				local var_189_21 = var_189_15.localEulerAngles

				var_189_21.z = 0
				var_189_21.x = 0
				var_189_15.localEulerAngles = var_189_21
			end

			if arg_186_1.time_ >= var_189_16 + var_189_17 and arg_186_1.time_ < var_189_16 + var_189_17 + arg_189_0 then
				var_189_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_189_22 = manager.ui.mainCamera.transform.position - var_189_15.position

				var_189_15.forward = Vector3.New(var_189_22.x, var_189_22.y, var_189_22.z)

				local var_189_23 = var_189_15.localEulerAngles

				var_189_23.z = 0
				var_189_23.x = 0
				var_189_15.localEulerAngles = var_189_23
			end

			local var_189_24 = arg_186_1.actors_["10079ui_story"]
			local var_189_25 = 0

			if var_189_25 < arg_186_1.time_ and arg_186_1.time_ <= var_189_25 + arg_189_0 and not isNil(var_189_24) and arg_186_1.var_.characterEffect10079ui_story == nil then
				arg_186_1.var_.characterEffect10079ui_story = var_189_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_26 = 0.200000002980232

			if var_189_25 <= arg_186_1.time_ and arg_186_1.time_ < var_189_25 + var_189_26 and not isNil(var_189_24) then
				local var_189_27 = (arg_186_1.time_ - var_189_25) / var_189_26

				if arg_186_1.var_.characterEffect10079ui_story and not isNil(var_189_24) then
					local var_189_28 = Mathf.Lerp(0, 0.5, var_189_27)

					arg_186_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10079ui_story.fillRatio = var_189_28
				end
			end

			if arg_186_1.time_ >= var_189_25 + var_189_26 and arg_186_1.time_ < var_189_25 + var_189_26 + arg_189_0 and not isNil(var_189_24) and arg_186_1.var_.characterEffect10079ui_story then
				local var_189_29 = 0.5

				arg_186_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10079ui_story.fillRatio = var_189_29
			end

			local var_189_30 = 0
			local var_189_31 = 0.125

			if var_189_30 < arg_186_1.time_ and arg_186_1.time_ <= var_189_30 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_32 = arg_186_1:FormatText(StoryNameCfg[471].name)

				arg_186_1.leftNameTxt_.text = var_189_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_33 = arg_186_1:GetWordFromCfg(319591044)
				local var_189_34 = arg_186_1:FormatText(var_189_33.content)

				arg_186_1.text_.text = var_189_34

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_35 = 5
				local var_189_36 = utf8.len(var_189_34)
				local var_189_37 = var_189_35 <= 0 and var_189_31 or var_189_31 * (var_189_36 / var_189_35)

				if var_189_37 > 0 and var_189_31 < var_189_37 then
					arg_186_1.talkMaxDuration = var_189_37

					if var_189_37 + var_189_30 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_37 + var_189_30
					end
				end

				arg_186_1.text_.text = var_189_34
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591044", "story_v_out_319591.awb") ~= 0 then
					local var_189_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591044", "story_v_out_319591.awb") / 1000

					if var_189_38 + var_189_30 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_38 + var_189_30
					end

					if var_189_33.prefab_name ~= "" and arg_186_1.actors_[var_189_33.prefab_name] ~= nil then
						local var_189_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_33.prefab_name].transform, "story_v_out_319591", "319591044", "story_v_out_319591.awb")

						arg_186_1:RecordAudio("319591044", var_189_39)
						arg_186_1:RecordAudio("319591044", var_189_39)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_319591", "319591044", "story_v_out_319591.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_319591", "319591044", "story_v_out_319591.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_40 = math.max(var_189_31, arg_186_1.talkMaxDuration)

			if var_189_30 <= arg_186_1.time_ and arg_186_1.time_ < var_189_30 + var_189_40 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_30) / var_189_40

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_30 + var_189_40 and arg_186_1.time_ < var_189_30 + var_189_40 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play319591045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 319591045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play319591046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1095ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1095ui_story == nil then
				arg_190_1.var_.characterEffect1095ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1095ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1095ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1095ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1095ui_story.fillRatio = var_193_5
			end

			local var_193_6 = arg_190_1.actors_["10079ui_story"].transform
			local var_193_7 = 0

			if var_193_7 < arg_190_1.time_ and arg_190_1.time_ <= var_193_7 + arg_193_0 then
				arg_190_1.var_.moveOldPos10079ui_story = var_193_6.localPosition
			end

			local var_193_8 = 0.001

			if var_193_7 <= arg_190_1.time_ and arg_190_1.time_ < var_193_7 + var_193_8 then
				local var_193_9 = (arg_190_1.time_ - var_193_7) / var_193_8
				local var_193_10 = Vector3.New(0, 100, 0)

				var_193_6.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10079ui_story, var_193_10, var_193_9)

				local var_193_11 = manager.ui.mainCamera.transform.position - var_193_6.position

				var_193_6.forward = Vector3.New(var_193_11.x, var_193_11.y, var_193_11.z)

				local var_193_12 = var_193_6.localEulerAngles

				var_193_12.z = 0
				var_193_12.x = 0
				var_193_6.localEulerAngles = var_193_12
			end

			if arg_190_1.time_ >= var_193_7 + var_193_8 and arg_190_1.time_ < var_193_7 + var_193_8 + arg_193_0 then
				var_193_6.localPosition = Vector3.New(0, 100, 0)

				local var_193_13 = manager.ui.mainCamera.transform.position - var_193_6.position

				var_193_6.forward = Vector3.New(var_193_13.x, var_193_13.y, var_193_13.z)

				local var_193_14 = var_193_6.localEulerAngles

				var_193_14.z = 0
				var_193_14.x = 0
				var_193_6.localEulerAngles = var_193_14
			end

			local var_193_15 = arg_190_1.actors_["1095ui_story"].transform
			local var_193_16 = 0

			if var_193_16 < arg_190_1.time_ and arg_190_1.time_ <= var_193_16 + arg_193_0 then
				arg_190_1.var_.moveOldPos1095ui_story = var_193_15.localPosition
			end

			local var_193_17 = 0.001

			if var_193_16 <= arg_190_1.time_ and arg_190_1.time_ < var_193_16 + var_193_17 then
				local var_193_18 = (arg_190_1.time_ - var_193_16) / var_193_17
				local var_193_19 = Vector3.New(0, 100, 0)

				var_193_15.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1095ui_story, var_193_19, var_193_18)

				local var_193_20 = manager.ui.mainCamera.transform.position - var_193_15.position

				var_193_15.forward = Vector3.New(var_193_20.x, var_193_20.y, var_193_20.z)

				local var_193_21 = var_193_15.localEulerAngles

				var_193_21.z = 0
				var_193_21.x = 0
				var_193_15.localEulerAngles = var_193_21
			end

			if arg_190_1.time_ >= var_193_16 + var_193_17 and arg_190_1.time_ < var_193_16 + var_193_17 + arg_193_0 then
				var_193_15.localPosition = Vector3.New(0, 100, 0)

				local var_193_22 = manager.ui.mainCamera.transform.position - var_193_15.position

				var_193_15.forward = Vector3.New(var_193_22.x, var_193_22.y, var_193_22.z)

				local var_193_23 = var_193_15.localEulerAngles

				var_193_23.z = 0
				var_193_23.x = 0
				var_193_15.localEulerAngles = var_193_23
			end

			local var_193_24 = 0
			local var_193_25 = 1.2

			if var_193_24 < arg_190_1.time_ and arg_190_1.time_ <= var_193_24 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_26 = arg_190_1:GetWordFromCfg(319591045)
				local var_193_27 = arg_190_1:FormatText(var_193_26.content)

				arg_190_1.text_.text = var_193_27

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_28 = 48
				local var_193_29 = utf8.len(var_193_27)
				local var_193_30 = var_193_28 <= 0 and var_193_25 or var_193_25 * (var_193_29 / var_193_28)

				if var_193_30 > 0 and var_193_25 < var_193_30 then
					arg_190_1.talkMaxDuration = var_193_30

					if var_193_30 + var_193_24 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_30 + var_193_24
					end
				end

				arg_190_1.text_.text = var_193_27
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_31 = math.max(var_193_25, arg_190_1.talkMaxDuration)

			if var_193_24 <= arg_190_1.time_ and arg_190_1.time_ < var_193_24 + var_193_31 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_24) / var_193_31

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_24 + var_193_31 and arg_190_1.time_ < var_193_24 + var_193_31 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play319591046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 319591046
		arg_194_1.duration_ = 5.83

		local var_194_0 = {
			zh = 4.4,
			ja = 5.833
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play319591047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["4040ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos4040ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, -1.55, -5.5)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos4040ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["4040ui_story"]
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect4040ui_story == nil then
				arg_194_1.var_.characterEffect4040ui_story = var_197_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 and not isNil(var_197_9) then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11

				if arg_194_1.var_.characterEffect4040ui_story and not isNil(var_197_9) then
					arg_194_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect4040ui_story then
				arg_194_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_197_13 = 0

			if var_197_13 < arg_194_1.time_ and arg_194_1.time_ <= var_197_13 + arg_197_0 then
				arg_194_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_197_14 = 0

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_197_15 = arg_194_1.actors_["1095ui_story"].transform
			local var_197_16 = 0

			if var_197_16 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 then
				arg_194_1.var_.moveOldPos1095ui_story = var_197_15.localPosition
			end

			local var_197_17 = 0.001

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_17 then
				local var_197_18 = (arg_194_1.time_ - var_197_16) / var_197_17
				local var_197_19 = Vector3.New(0, 100, 0)

				var_197_15.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1095ui_story, var_197_19, var_197_18)

				local var_197_20 = manager.ui.mainCamera.transform.position - var_197_15.position

				var_197_15.forward = Vector3.New(var_197_20.x, var_197_20.y, var_197_20.z)

				local var_197_21 = var_197_15.localEulerAngles

				var_197_21.z = 0
				var_197_21.x = 0
				var_197_15.localEulerAngles = var_197_21
			end

			if arg_194_1.time_ >= var_197_16 + var_197_17 and arg_194_1.time_ < var_197_16 + var_197_17 + arg_197_0 then
				var_197_15.localPosition = Vector3.New(0, 100, 0)

				local var_197_22 = manager.ui.mainCamera.transform.position - var_197_15.position

				var_197_15.forward = Vector3.New(var_197_22.x, var_197_22.y, var_197_22.z)

				local var_197_23 = var_197_15.localEulerAngles

				var_197_23.z = 0
				var_197_23.x = 0
				var_197_15.localEulerAngles = var_197_23
			end

			local var_197_24 = arg_194_1.actors_["1095ui_story"]
			local var_197_25 = 0

			if var_197_25 < arg_194_1.time_ and arg_194_1.time_ <= var_197_25 + arg_197_0 and not isNil(var_197_24) and arg_194_1.var_.characterEffect1095ui_story == nil then
				arg_194_1.var_.characterEffect1095ui_story = var_197_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_26 = 0.200000002980232

			if var_197_25 <= arg_194_1.time_ and arg_194_1.time_ < var_197_25 + var_197_26 and not isNil(var_197_24) then
				local var_197_27 = (arg_194_1.time_ - var_197_25) / var_197_26

				if arg_194_1.var_.characterEffect1095ui_story and not isNil(var_197_24) then
					local var_197_28 = Mathf.Lerp(0, 0.5, var_197_27)

					arg_194_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1095ui_story.fillRatio = var_197_28
				end
			end

			if arg_194_1.time_ >= var_197_25 + var_197_26 and arg_194_1.time_ < var_197_25 + var_197_26 + arg_197_0 and not isNil(var_197_24) and arg_194_1.var_.characterEffect1095ui_story then
				local var_197_29 = 0.5

				arg_194_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1095ui_story.fillRatio = var_197_29
			end

			local var_197_30 = arg_194_1.actors_["10079ui_story"].transform
			local var_197_31 = 0

			if var_197_31 < arg_194_1.time_ and arg_194_1.time_ <= var_197_31 + arg_197_0 then
				arg_194_1.var_.moveOldPos10079ui_story = var_197_30.localPosition
			end

			local var_197_32 = 0.001

			if var_197_31 <= arg_194_1.time_ and arg_194_1.time_ < var_197_31 + var_197_32 then
				local var_197_33 = (arg_194_1.time_ - var_197_31) / var_197_32
				local var_197_34 = Vector3.New(0, 100, 0)

				var_197_30.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10079ui_story, var_197_34, var_197_33)

				local var_197_35 = manager.ui.mainCamera.transform.position - var_197_30.position

				var_197_30.forward = Vector3.New(var_197_35.x, var_197_35.y, var_197_35.z)

				local var_197_36 = var_197_30.localEulerAngles

				var_197_36.z = 0
				var_197_36.x = 0
				var_197_30.localEulerAngles = var_197_36
			end

			if arg_194_1.time_ >= var_197_31 + var_197_32 and arg_194_1.time_ < var_197_31 + var_197_32 + arg_197_0 then
				var_197_30.localPosition = Vector3.New(0, 100, 0)

				local var_197_37 = manager.ui.mainCamera.transform.position - var_197_30.position

				var_197_30.forward = Vector3.New(var_197_37.x, var_197_37.y, var_197_37.z)

				local var_197_38 = var_197_30.localEulerAngles

				var_197_38.z = 0
				var_197_38.x = 0
				var_197_30.localEulerAngles = var_197_38
			end

			local var_197_39 = arg_194_1.actors_["10079ui_story"]
			local var_197_40 = 0

			if var_197_40 < arg_194_1.time_ and arg_194_1.time_ <= var_197_40 + arg_197_0 and not isNil(var_197_39) and arg_194_1.var_.characterEffect10079ui_story == nil then
				arg_194_1.var_.characterEffect10079ui_story = var_197_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_41 = 0.200000002980232

			if var_197_40 <= arg_194_1.time_ and arg_194_1.time_ < var_197_40 + var_197_41 and not isNil(var_197_39) then
				local var_197_42 = (arg_194_1.time_ - var_197_40) / var_197_41

				if arg_194_1.var_.characterEffect10079ui_story and not isNil(var_197_39) then
					local var_197_43 = Mathf.Lerp(0, 0.5, var_197_42)

					arg_194_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_194_1.var_.characterEffect10079ui_story.fillRatio = var_197_43
				end
			end

			if arg_194_1.time_ >= var_197_40 + var_197_41 and arg_194_1.time_ < var_197_40 + var_197_41 + arg_197_0 and not isNil(var_197_39) and arg_194_1.var_.characterEffect10079ui_story then
				local var_197_44 = 0.5

				arg_194_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_194_1.var_.characterEffect10079ui_story.fillRatio = var_197_44
			end

			local var_197_45 = 0
			local var_197_46 = 0.35

			if var_197_45 < arg_194_1.time_ and arg_194_1.time_ <= var_197_45 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_47 = arg_194_1:FormatText(StoryNameCfg[668].name)

				arg_194_1.leftNameTxt_.text = var_197_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_48 = arg_194_1:GetWordFromCfg(319591046)
				local var_197_49 = arg_194_1:FormatText(var_197_48.content)

				arg_194_1.text_.text = var_197_49

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_50 = 14
				local var_197_51 = utf8.len(var_197_49)
				local var_197_52 = var_197_50 <= 0 and var_197_46 or var_197_46 * (var_197_51 / var_197_50)

				if var_197_52 > 0 and var_197_46 < var_197_52 then
					arg_194_1.talkMaxDuration = var_197_52

					if var_197_52 + var_197_45 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_52 + var_197_45
					end
				end

				arg_194_1.text_.text = var_197_49
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591046", "story_v_out_319591.awb") ~= 0 then
					local var_197_53 = manager.audio:GetVoiceLength("story_v_out_319591", "319591046", "story_v_out_319591.awb") / 1000

					if var_197_53 + var_197_45 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_53 + var_197_45
					end

					if var_197_48.prefab_name ~= "" and arg_194_1.actors_[var_197_48.prefab_name] ~= nil then
						local var_197_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_48.prefab_name].transform, "story_v_out_319591", "319591046", "story_v_out_319591.awb")

						arg_194_1:RecordAudio("319591046", var_197_54)
						arg_194_1:RecordAudio("319591046", var_197_54)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319591", "319591046", "story_v_out_319591.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319591", "319591046", "story_v_out_319591.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_55 = math.max(var_197_46, arg_194_1.talkMaxDuration)

			if var_197_45 <= arg_194_1.time_ and arg_194_1.time_ < var_197_45 + var_197_55 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_45) / var_197_55

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_45 + var_197_55 and arg_194_1.time_ < var_197_45 + var_197_55 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play319591047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319591047
		arg_198_1.duration_ = 6

		local var_198_0 = {
			zh = 5.066,
			ja = 6
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319591048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10079ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos10079ui_story = var_201_0.localPosition

				local var_201_2 = "10079ui_story"

				arg_198_1:ShowWeapon(arg_198_1.var_[var_201_2 .. "Animator"].transform, false)
			end

			local var_201_3 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_3 then
				local var_201_4 = (arg_198_1.time_ - var_201_1) / var_201_3
				local var_201_5 = Vector3.New(0.7, -0.95, -6.05)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10079ui_story, var_201_5, var_201_4)

				local var_201_6 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_6.x, var_201_6.y, var_201_6.z)

				local var_201_7 = var_201_0.localEulerAngles

				var_201_7.z = 0
				var_201_7.x = 0
				var_201_0.localEulerAngles = var_201_7
			end

			if arg_198_1.time_ >= var_201_1 + var_201_3 and arg_198_1.time_ < var_201_1 + var_201_3 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_201_8 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_8.x, var_201_8.y, var_201_8.z)

				local var_201_9 = var_201_0.localEulerAngles

				var_201_9.z = 0
				var_201_9.x = 0
				var_201_0.localEulerAngles = var_201_9
			end

			local var_201_10 = arg_198_1.actors_["10079ui_story"]
			local var_201_11 = 0

			if var_201_11 < arg_198_1.time_ and arg_198_1.time_ <= var_201_11 + arg_201_0 and not isNil(var_201_10) and arg_198_1.var_.characterEffect10079ui_story == nil then
				arg_198_1.var_.characterEffect10079ui_story = var_201_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_12 = 0.200000002980232

			if var_201_11 <= arg_198_1.time_ and arg_198_1.time_ < var_201_11 + var_201_12 and not isNil(var_201_10) then
				local var_201_13 = (arg_198_1.time_ - var_201_11) / var_201_12

				if arg_198_1.var_.characterEffect10079ui_story and not isNil(var_201_10) then
					arg_198_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_11 + var_201_12 and arg_198_1.time_ < var_201_11 + var_201_12 + arg_201_0 and not isNil(var_201_10) and arg_198_1.var_.characterEffect10079ui_story then
				arg_198_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_201_14 = 0

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 then
				arg_198_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_201_15 = 0

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_201_16 = arg_198_1.actors_["4040ui_story"].transform
			local var_201_17 = 0

			if var_201_17 < arg_198_1.time_ and arg_198_1.time_ <= var_201_17 + arg_201_0 then
				arg_198_1.var_.moveOldPos4040ui_story = var_201_16.localPosition
			end

			local var_201_18 = 0.001

			if var_201_17 <= arg_198_1.time_ and arg_198_1.time_ < var_201_17 + var_201_18 then
				local var_201_19 = (arg_198_1.time_ - var_201_17) / var_201_18
				local var_201_20 = Vector3.New(-0.7, -1.55, -5.5)

				var_201_16.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos4040ui_story, var_201_20, var_201_19)

				local var_201_21 = manager.ui.mainCamera.transform.position - var_201_16.position

				var_201_16.forward = Vector3.New(var_201_21.x, var_201_21.y, var_201_21.z)

				local var_201_22 = var_201_16.localEulerAngles

				var_201_22.z = 0
				var_201_22.x = 0
				var_201_16.localEulerAngles = var_201_22
			end

			if arg_198_1.time_ >= var_201_17 + var_201_18 and arg_198_1.time_ < var_201_17 + var_201_18 + arg_201_0 then
				var_201_16.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_201_23 = manager.ui.mainCamera.transform.position - var_201_16.position

				var_201_16.forward = Vector3.New(var_201_23.x, var_201_23.y, var_201_23.z)

				local var_201_24 = var_201_16.localEulerAngles

				var_201_24.z = 0
				var_201_24.x = 0
				var_201_16.localEulerAngles = var_201_24
			end

			local var_201_25 = arg_198_1.actors_["4040ui_story"]
			local var_201_26 = 0

			if var_201_26 < arg_198_1.time_ and arg_198_1.time_ <= var_201_26 + arg_201_0 and not isNil(var_201_25) and arg_198_1.var_.characterEffect4040ui_story == nil then
				arg_198_1.var_.characterEffect4040ui_story = var_201_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_27 = 0.200000002980232

			if var_201_26 <= arg_198_1.time_ and arg_198_1.time_ < var_201_26 + var_201_27 and not isNil(var_201_25) then
				local var_201_28 = (arg_198_1.time_ - var_201_26) / var_201_27

				if arg_198_1.var_.characterEffect4040ui_story and not isNil(var_201_25) then
					local var_201_29 = Mathf.Lerp(0, 0.5, var_201_28)

					arg_198_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_198_1.var_.characterEffect4040ui_story.fillRatio = var_201_29
				end
			end

			if arg_198_1.time_ >= var_201_26 + var_201_27 and arg_198_1.time_ < var_201_26 + var_201_27 + arg_201_0 and not isNil(var_201_25) and arg_198_1.var_.characterEffect4040ui_story then
				local var_201_30 = 0.5

				arg_198_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_198_1.var_.characterEffect4040ui_story.fillRatio = var_201_30
			end

			local var_201_31 = 0
			local var_201_32 = 0.675

			if var_201_31 < arg_198_1.time_ and arg_198_1.time_ <= var_201_31 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_33 = arg_198_1:FormatText(StoryNameCfg[6].name)

				arg_198_1.leftNameTxt_.text = var_201_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_34 = arg_198_1:GetWordFromCfg(319591047)
				local var_201_35 = arg_198_1:FormatText(var_201_34.content)

				arg_198_1.text_.text = var_201_35

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_36 = 27
				local var_201_37 = utf8.len(var_201_35)
				local var_201_38 = var_201_36 <= 0 and var_201_32 or var_201_32 * (var_201_37 / var_201_36)

				if var_201_38 > 0 and var_201_32 < var_201_38 then
					arg_198_1.talkMaxDuration = var_201_38

					if var_201_38 + var_201_31 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_38 + var_201_31
					end
				end

				arg_198_1.text_.text = var_201_35
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591047", "story_v_out_319591.awb") ~= 0 then
					local var_201_39 = manager.audio:GetVoiceLength("story_v_out_319591", "319591047", "story_v_out_319591.awb") / 1000

					if var_201_39 + var_201_31 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_39 + var_201_31
					end

					if var_201_34.prefab_name ~= "" and arg_198_1.actors_[var_201_34.prefab_name] ~= nil then
						local var_201_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_34.prefab_name].transform, "story_v_out_319591", "319591047", "story_v_out_319591.awb")

						arg_198_1:RecordAudio("319591047", var_201_40)
						arg_198_1:RecordAudio("319591047", var_201_40)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319591", "319591047", "story_v_out_319591.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319591", "319591047", "story_v_out_319591.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_41 = math.max(var_201_32, arg_198_1.talkMaxDuration)

			if var_201_31 <= arg_198_1.time_ and arg_198_1.time_ < var_201_31 + var_201_41 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_31) / var_201_41

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_31 + var_201_41 and arg_198_1.time_ < var_201_31 + var_201_41 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_198_1:InitPlayNodeList()
	end,
	Play319591048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319591048
		arg_202_1.duration_ = 10.97

		local var_202_0 = {
			zh = 3.233,
			ja = 10.966
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319591049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10079ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect10079ui_story == nil then
				arg_202_1.var_.characterEffect10079ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect10079ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10079ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect10079ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10079ui_story.fillRatio = var_205_5
			end

			local var_205_6 = arg_202_1.actors_["4040ui_story"]
			local var_205_7 = 0

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect4040ui_story == nil then
				arg_202_1.var_.characterEffect4040ui_story = var_205_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_8 = 0.200000002980232

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_8 and not isNil(var_205_6) then
				local var_205_9 = (arg_202_1.time_ - var_205_7) / var_205_8

				if arg_202_1.var_.characterEffect4040ui_story and not isNil(var_205_6) then
					arg_202_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_7 + var_205_8 and arg_202_1.time_ < var_205_7 + var_205_8 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect4040ui_story then
				arg_202_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_205_10 = 0
			local var_205_11 = 0.35

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_12 = arg_202_1:FormatText(StoryNameCfg[668].name)

				arg_202_1.leftNameTxt_.text = var_205_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_13 = arg_202_1:GetWordFromCfg(319591048)
				local var_205_14 = arg_202_1:FormatText(var_205_13.content)

				arg_202_1.text_.text = var_205_14

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_15 = 14
				local var_205_16 = utf8.len(var_205_14)
				local var_205_17 = var_205_15 <= 0 and var_205_11 or var_205_11 * (var_205_16 / var_205_15)

				if var_205_17 > 0 and var_205_11 < var_205_17 then
					arg_202_1.talkMaxDuration = var_205_17

					if var_205_17 + var_205_10 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_17 + var_205_10
					end
				end

				arg_202_1.text_.text = var_205_14
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591048", "story_v_out_319591.awb") ~= 0 then
					local var_205_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591048", "story_v_out_319591.awb") / 1000

					if var_205_18 + var_205_10 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_18 + var_205_10
					end

					if var_205_13.prefab_name ~= "" and arg_202_1.actors_[var_205_13.prefab_name] ~= nil then
						local var_205_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_13.prefab_name].transform, "story_v_out_319591", "319591048", "story_v_out_319591.awb")

						arg_202_1:RecordAudio("319591048", var_205_19)
						arg_202_1:RecordAudio("319591048", var_205_19)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_319591", "319591048", "story_v_out_319591.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_319591", "319591048", "story_v_out_319591.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_20 = math.max(var_205_11, arg_202_1.talkMaxDuration)

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_20 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_10) / var_205_20

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_10 + var_205_20 and arg_202_1.time_ < var_205_10 + var_205_20 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319591049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319591049
		arg_206_1.duration_ = 4.63

		local var_206_0 = {
			zh = 3.433,
			ja = 4.633
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319591050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10079ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos10079ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0.7, -0.95, -6.05)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10079ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["10079ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect10079ui_story == nil then
				arg_206_1.var_.characterEffect10079ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect10079ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect10079ui_story then
				arg_206_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_209_15 = arg_206_1.actors_["4040ui_story"]
			local var_209_16 = 0

			if var_209_16 < arg_206_1.time_ and arg_206_1.time_ <= var_209_16 + arg_209_0 and not isNil(var_209_15) and arg_206_1.var_.characterEffect4040ui_story == nil then
				arg_206_1.var_.characterEffect4040ui_story = var_209_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_17 = 0.200000002980232

			if var_209_16 <= arg_206_1.time_ and arg_206_1.time_ < var_209_16 + var_209_17 and not isNil(var_209_15) then
				local var_209_18 = (arg_206_1.time_ - var_209_16) / var_209_17

				if arg_206_1.var_.characterEffect4040ui_story and not isNil(var_209_15) then
					local var_209_19 = Mathf.Lerp(0, 0.5, var_209_18)

					arg_206_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_206_1.var_.characterEffect4040ui_story.fillRatio = var_209_19
				end
			end

			if arg_206_1.time_ >= var_209_16 + var_209_17 and arg_206_1.time_ < var_209_16 + var_209_17 + arg_209_0 and not isNil(var_209_15) and arg_206_1.var_.characterEffect4040ui_story then
				local var_209_20 = 0.5

				arg_206_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_206_1.var_.characterEffect4040ui_story.fillRatio = var_209_20
			end

			local var_209_21 = 0
			local var_209_22 = 0.425

			if var_209_21 < arg_206_1.time_ and arg_206_1.time_ <= var_209_21 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_23 = arg_206_1:FormatText(StoryNameCfg[6].name)

				arg_206_1.leftNameTxt_.text = var_209_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_24 = arg_206_1:GetWordFromCfg(319591049)
				local var_209_25 = arg_206_1:FormatText(var_209_24.content)

				arg_206_1.text_.text = var_209_25

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_26 = 17
				local var_209_27 = utf8.len(var_209_25)
				local var_209_28 = var_209_26 <= 0 and var_209_22 or var_209_22 * (var_209_27 / var_209_26)

				if var_209_28 > 0 and var_209_22 < var_209_28 then
					arg_206_1.talkMaxDuration = var_209_28

					if var_209_28 + var_209_21 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_28 + var_209_21
					end
				end

				arg_206_1.text_.text = var_209_25
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591049", "story_v_out_319591.awb") ~= 0 then
					local var_209_29 = manager.audio:GetVoiceLength("story_v_out_319591", "319591049", "story_v_out_319591.awb") / 1000

					if var_209_29 + var_209_21 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_29 + var_209_21
					end

					if var_209_24.prefab_name ~= "" and arg_206_1.actors_[var_209_24.prefab_name] ~= nil then
						local var_209_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_24.prefab_name].transform, "story_v_out_319591", "319591049", "story_v_out_319591.awb")

						arg_206_1:RecordAudio("319591049", var_209_30)
						arg_206_1:RecordAudio("319591049", var_209_30)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319591", "319591049", "story_v_out_319591.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319591", "319591049", "story_v_out_319591.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_31 = math.max(var_209_22, arg_206_1.talkMaxDuration)

			if var_209_21 <= arg_206_1.time_ and arg_206_1.time_ < var_209_21 + var_209_31 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_21) / var_209_31

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_21 + var_209_31 and arg_206_1.time_ < var_209_21 + var_209_31 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play319591050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319591050
		arg_210_1.duration_ = 9.93

		local var_210_0 = {
			zh = 7.3,
			ja = 9.933
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play319591051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10079ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10079ui_story == nil then
				arg_210_1.var_.characterEffect10079ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect10079ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10079ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10079ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10079ui_story.fillRatio = var_213_5
			end

			local var_213_6 = arg_210_1.actors_["4040ui_story"]
			local var_213_7 = 0

			if var_213_7 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect4040ui_story == nil then
				arg_210_1.var_.characterEffect4040ui_story = var_213_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_8 = 0.200000002980232

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 and not isNil(var_213_6) then
				local var_213_9 = (arg_210_1.time_ - var_213_7) / var_213_8

				if arg_210_1.var_.characterEffect4040ui_story and not isNil(var_213_6) then
					arg_210_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect4040ui_story then
				arg_210_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_213_11 = 0
			local var_213_12 = 0.45

			if var_213_11 < arg_210_1.time_ and arg_210_1.time_ <= var_213_11 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_13 = arg_210_1:FormatText(StoryNameCfg[668].name)

				arg_210_1.leftNameTxt_.text = var_213_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_14 = arg_210_1:GetWordFromCfg(319591050)
				local var_213_15 = arg_210_1:FormatText(var_213_14.content)

				arg_210_1.text_.text = var_213_15

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_16 = 18
				local var_213_17 = utf8.len(var_213_15)
				local var_213_18 = var_213_16 <= 0 and var_213_12 or var_213_12 * (var_213_17 / var_213_16)

				if var_213_18 > 0 and var_213_12 < var_213_18 then
					arg_210_1.talkMaxDuration = var_213_18

					if var_213_18 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_18 + var_213_11
					end
				end

				arg_210_1.text_.text = var_213_15
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591050", "story_v_out_319591.awb") ~= 0 then
					local var_213_19 = manager.audio:GetVoiceLength("story_v_out_319591", "319591050", "story_v_out_319591.awb") / 1000

					if var_213_19 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_19 + var_213_11
					end

					if var_213_14.prefab_name ~= "" and arg_210_1.actors_[var_213_14.prefab_name] ~= nil then
						local var_213_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_14.prefab_name].transform, "story_v_out_319591", "319591050", "story_v_out_319591.awb")

						arg_210_1:RecordAudio("319591050", var_213_20)
						arg_210_1:RecordAudio("319591050", var_213_20)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319591", "319591050", "story_v_out_319591.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319591", "319591050", "story_v_out_319591.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_21 = math.max(var_213_12, arg_210_1.talkMaxDuration)

			if var_213_11 <= arg_210_1.time_ and arg_210_1.time_ < var_213_11 + var_213_21 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_11) / var_213_21

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_11 + var_213_21 and arg_210_1.time_ < var_213_11 + var_213_21 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play319591051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319591051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play319591052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["4040ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect4040ui_story == nil then
				arg_214_1.var_.characterEffect4040ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect4040ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_214_1.var_.characterEffect4040ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect4040ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_214_1.var_.characterEffect4040ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 0.975

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_8 = arg_214_1:GetWordFromCfg(319591051)
				local var_217_9 = arg_214_1:FormatText(var_217_8.content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 39
				local var_217_11 = utf8.len(var_217_9)
				local var_217_12 = var_217_10 <= 0 and var_217_7 or var_217_7 * (var_217_11 / var_217_10)

				if var_217_12 > 0 and var_217_7 < var_217_12 then
					arg_214_1.talkMaxDuration = var_217_12

					if var_217_12 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_13 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_13 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_13

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_13 and arg_214_1.time_ < var_217_6 + var_217_13 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play319591052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319591052
		arg_218_1.duration_ = 5.47

		local var_218_0 = {
			zh = 5.466,
			ja = 4.9
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319591053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1095ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1095ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, -0.98, -6.1)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1095ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = arg_218_1.actors_["1095ui_story"]
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1095ui_story == nil then
				arg_218_1.var_.characterEffect1095ui_story = var_221_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_11 = 0.200000002980232

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_11 and not isNil(var_221_9) then
				local var_221_12 = (arg_218_1.time_ - var_221_10) / var_221_11

				if arg_218_1.var_.characterEffect1095ui_story and not isNil(var_221_9) then
					arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_10 + var_221_11 and arg_218_1.time_ < var_221_10 + var_221_11 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1095ui_story then
				arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_221_13 = 0

			if var_221_13 < arg_218_1.time_ and arg_218_1.time_ <= var_221_13 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_221_14 = 0

			if var_221_14 < arg_218_1.time_ and arg_218_1.time_ <= var_221_14 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_221_15 = arg_218_1.actors_["10079ui_story"].transform
			local var_221_16 = 0

			if var_221_16 < arg_218_1.time_ and arg_218_1.time_ <= var_221_16 + arg_221_0 then
				arg_218_1.var_.moveOldPos10079ui_story = var_221_15.localPosition
			end

			local var_221_17 = 0.001

			if var_221_16 <= arg_218_1.time_ and arg_218_1.time_ < var_221_16 + var_221_17 then
				local var_221_18 = (arg_218_1.time_ - var_221_16) / var_221_17
				local var_221_19 = Vector3.New(0, 100, 0)

				var_221_15.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10079ui_story, var_221_19, var_221_18)

				local var_221_20 = manager.ui.mainCamera.transform.position - var_221_15.position

				var_221_15.forward = Vector3.New(var_221_20.x, var_221_20.y, var_221_20.z)

				local var_221_21 = var_221_15.localEulerAngles

				var_221_21.z = 0
				var_221_21.x = 0
				var_221_15.localEulerAngles = var_221_21
			end

			if arg_218_1.time_ >= var_221_16 + var_221_17 and arg_218_1.time_ < var_221_16 + var_221_17 + arg_221_0 then
				var_221_15.localPosition = Vector3.New(0, 100, 0)

				local var_221_22 = manager.ui.mainCamera.transform.position - var_221_15.position

				var_221_15.forward = Vector3.New(var_221_22.x, var_221_22.y, var_221_22.z)

				local var_221_23 = var_221_15.localEulerAngles

				var_221_23.z = 0
				var_221_23.x = 0
				var_221_15.localEulerAngles = var_221_23
			end

			local var_221_24 = arg_218_1.actors_["10079ui_story"]
			local var_221_25 = 0

			if var_221_25 < arg_218_1.time_ and arg_218_1.time_ <= var_221_25 + arg_221_0 and not isNil(var_221_24) and arg_218_1.var_.characterEffect10079ui_story == nil then
				arg_218_1.var_.characterEffect10079ui_story = var_221_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_26 = 0.200000002980232

			if var_221_25 <= arg_218_1.time_ and arg_218_1.time_ < var_221_25 + var_221_26 and not isNil(var_221_24) then
				local var_221_27 = (arg_218_1.time_ - var_221_25) / var_221_26

				if arg_218_1.var_.characterEffect10079ui_story and not isNil(var_221_24) then
					local var_221_28 = Mathf.Lerp(0, 0.5, var_221_27)

					arg_218_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10079ui_story.fillRatio = var_221_28
				end
			end

			if arg_218_1.time_ >= var_221_25 + var_221_26 and arg_218_1.time_ < var_221_25 + var_221_26 + arg_221_0 and not isNil(var_221_24) and arg_218_1.var_.characterEffect10079ui_story then
				local var_221_29 = 0.5

				arg_218_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10079ui_story.fillRatio = var_221_29
			end

			local var_221_30 = arg_218_1.actors_["4040ui_story"].transform
			local var_221_31 = 0

			if var_221_31 < arg_218_1.time_ and arg_218_1.time_ <= var_221_31 + arg_221_0 then
				arg_218_1.var_.moveOldPos4040ui_story = var_221_30.localPosition
			end

			local var_221_32 = 0.001

			if var_221_31 <= arg_218_1.time_ and arg_218_1.time_ < var_221_31 + var_221_32 then
				local var_221_33 = (arg_218_1.time_ - var_221_31) / var_221_32
				local var_221_34 = Vector3.New(0, 100, 0)

				var_221_30.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos4040ui_story, var_221_34, var_221_33)

				local var_221_35 = manager.ui.mainCamera.transform.position - var_221_30.position

				var_221_30.forward = Vector3.New(var_221_35.x, var_221_35.y, var_221_35.z)

				local var_221_36 = var_221_30.localEulerAngles

				var_221_36.z = 0
				var_221_36.x = 0
				var_221_30.localEulerAngles = var_221_36
			end

			if arg_218_1.time_ >= var_221_31 + var_221_32 and arg_218_1.time_ < var_221_31 + var_221_32 + arg_221_0 then
				var_221_30.localPosition = Vector3.New(0, 100, 0)

				local var_221_37 = manager.ui.mainCamera.transform.position - var_221_30.position

				var_221_30.forward = Vector3.New(var_221_37.x, var_221_37.y, var_221_37.z)

				local var_221_38 = var_221_30.localEulerAngles

				var_221_38.z = 0
				var_221_38.x = 0
				var_221_30.localEulerAngles = var_221_38
			end

			local var_221_39 = arg_218_1.actors_["4040ui_story"]
			local var_221_40 = 0

			if var_221_40 < arg_218_1.time_ and arg_218_1.time_ <= var_221_40 + arg_221_0 and not isNil(var_221_39) and arg_218_1.var_.characterEffect4040ui_story == nil then
				arg_218_1.var_.characterEffect4040ui_story = var_221_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_41 = 0.200000002980232

			if var_221_40 <= arg_218_1.time_ and arg_218_1.time_ < var_221_40 + var_221_41 and not isNil(var_221_39) then
				local var_221_42 = (arg_218_1.time_ - var_221_40) / var_221_41

				if arg_218_1.var_.characterEffect4040ui_story and not isNil(var_221_39) then
					local var_221_43 = Mathf.Lerp(0, 0.5, var_221_42)

					arg_218_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_218_1.var_.characterEffect4040ui_story.fillRatio = var_221_43
				end
			end

			if arg_218_1.time_ >= var_221_40 + var_221_41 and arg_218_1.time_ < var_221_40 + var_221_41 + arg_221_0 and not isNil(var_221_39) and arg_218_1.var_.characterEffect4040ui_story then
				local var_221_44 = 0.5

				arg_218_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_218_1.var_.characterEffect4040ui_story.fillRatio = var_221_44
			end

			local var_221_45 = 0
			local var_221_46 = 0.6

			if var_221_45 < arg_218_1.time_ and arg_218_1.time_ <= var_221_45 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_47 = arg_218_1:FormatText(StoryNameCfg[471].name)

				arg_218_1.leftNameTxt_.text = var_221_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_48 = arg_218_1:GetWordFromCfg(319591052)
				local var_221_49 = arg_218_1:FormatText(var_221_48.content)

				arg_218_1.text_.text = var_221_49

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_50 = 24
				local var_221_51 = utf8.len(var_221_49)
				local var_221_52 = var_221_50 <= 0 and var_221_46 or var_221_46 * (var_221_51 / var_221_50)

				if var_221_52 > 0 and var_221_46 < var_221_52 then
					arg_218_1.talkMaxDuration = var_221_52

					if var_221_52 + var_221_45 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_52 + var_221_45
					end
				end

				arg_218_1.text_.text = var_221_49
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591052", "story_v_out_319591.awb") ~= 0 then
					local var_221_53 = manager.audio:GetVoiceLength("story_v_out_319591", "319591052", "story_v_out_319591.awb") / 1000

					if var_221_53 + var_221_45 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_53 + var_221_45
					end

					if var_221_48.prefab_name ~= "" and arg_218_1.actors_[var_221_48.prefab_name] ~= nil then
						local var_221_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_48.prefab_name].transform, "story_v_out_319591", "319591052", "story_v_out_319591.awb")

						arg_218_1:RecordAudio("319591052", var_221_54)
						arg_218_1:RecordAudio("319591052", var_221_54)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319591", "319591052", "story_v_out_319591.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319591", "319591052", "story_v_out_319591.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_55 = math.max(var_221_46, arg_218_1.talkMaxDuration)

			if var_221_45 <= arg_218_1.time_ and arg_218_1.time_ < var_221_45 + var_221_55 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_45) / var_221_55

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_45 + var_221_55 and arg_218_1.time_ < var_221_45 + var_221_55 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_218_1:InitPlayNodeList()
	end,
	Play319591053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319591053
		arg_222_1.duration_ = 13.17

		local var_222_0 = {
			zh = 10.3,
			ja = 13.166
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319591054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["4037ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos4037ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(0, -1.12, -6.2)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos4037ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = arg_222_1.actors_["4037ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect4037ui_story == nil then
				arg_222_1.var_.characterEffect4037ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect4037ui_story and not isNil(var_225_9) then
					arg_222_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect4037ui_story then
				arg_222_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_225_13 = 0

			if var_225_13 < arg_222_1.time_ and arg_222_1.time_ <= var_225_13 + arg_225_0 then
				arg_222_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_225_14 = 0

			if var_225_14 < arg_222_1.time_ and arg_222_1.time_ <= var_225_14 + arg_225_0 then
				arg_222_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_15 = arg_222_1.actors_["1095ui_story"].transform
			local var_225_16 = 0

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.var_.moveOldPos1095ui_story = var_225_15.localPosition
			end

			local var_225_17 = 0.001

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_17 then
				local var_225_18 = (arg_222_1.time_ - var_225_16) / var_225_17
				local var_225_19 = Vector3.New(0, 100, 0)

				var_225_15.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1095ui_story, var_225_19, var_225_18)

				local var_225_20 = manager.ui.mainCamera.transform.position - var_225_15.position

				var_225_15.forward = Vector3.New(var_225_20.x, var_225_20.y, var_225_20.z)

				local var_225_21 = var_225_15.localEulerAngles

				var_225_21.z = 0
				var_225_21.x = 0
				var_225_15.localEulerAngles = var_225_21
			end

			if arg_222_1.time_ >= var_225_16 + var_225_17 and arg_222_1.time_ < var_225_16 + var_225_17 + arg_225_0 then
				var_225_15.localPosition = Vector3.New(0, 100, 0)

				local var_225_22 = manager.ui.mainCamera.transform.position - var_225_15.position

				var_225_15.forward = Vector3.New(var_225_22.x, var_225_22.y, var_225_22.z)

				local var_225_23 = var_225_15.localEulerAngles

				var_225_23.z = 0
				var_225_23.x = 0
				var_225_15.localEulerAngles = var_225_23
			end

			local var_225_24 = arg_222_1.actors_["1095ui_story"]
			local var_225_25 = 0

			if var_225_25 < arg_222_1.time_ and arg_222_1.time_ <= var_225_25 + arg_225_0 and not isNil(var_225_24) and arg_222_1.var_.characterEffect1095ui_story == nil then
				arg_222_1.var_.characterEffect1095ui_story = var_225_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_26 = 0.200000002980232

			if var_225_25 <= arg_222_1.time_ and arg_222_1.time_ < var_225_25 + var_225_26 and not isNil(var_225_24) then
				local var_225_27 = (arg_222_1.time_ - var_225_25) / var_225_26

				if arg_222_1.var_.characterEffect1095ui_story and not isNil(var_225_24) then
					local var_225_28 = Mathf.Lerp(0, 0.5, var_225_27)

					arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1095ui_story.fillRatio = var_225_28
				end
			end

			if arg_222_1.time_ >= var_225_25 + var_225_26 and arg_222_1.time_ < var_225_25 + var_225_26 + arg_225_0 and not isNil(var_225_24) and arg_222_1.var_.characterEffect1095ui_story then
				local var_225_29 = 0.5

				arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1095ui_story.fillRatio = var_225_29
			end

			local var_225_30 = 0
			local var_225_31 = 0.95

			if var_225_30 < arg_222_1.time_ and arg_222_1.time_ <= var_225_30 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_32 = arg_222_1:FormatText(StoryNameCfg[453].name)

				arg_222_1.leftNameTxt_.text = var_225_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_33 = arg_222_1:GetWordFromCfg(319591053)
				local var_225_34 = arg_222_1:FormatText(var_225_33.content)

				arg_222_1.text_.text = var_225_34

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_35 = 38
				local var_225_36 = utf8.len(var_225_34)
				local var_225_37 = var_225_35 <= 0 and var_225_31 or var_225_31 * (var_225_36 / var_225_35)

				if var_225_37 > 0 and var_225_31 < var_225_37 then
					arg_222_1.talkMaxDuration = var_225_37

					if var_225_37 + var_225_30 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_37 + var_225_30
					end
				end

				arg_222_1.text_.text = var_225_34
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591053", "story_v_out_319591.awb") ~= 0 then
					local var_225_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591053", "story_v_out_319591.awb") / 1000

					if var_225_38 + var_225_30 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_38 + var_225_30
					end

					if var_225_33.prefab_name ~= "" and arg_222_1.actors_[var_225_33.prefab_name] ~= nil then
						local var_225_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_33.prefab_name].transform, "story_v_out_319591", "319591053", "story_v_out_319591.awb")

						arg_222_1:RecordAudio("319591053", var_225_39)
						arg_222_1:RecordAudio("319591053", var_225_39)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319591", "319591053", "story_v_out_319591.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319591", "319591053", "story_v_out_319591.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_40 = math.max(var_225_31, arg_222_1.talkMaxDuration)

			if var_225_30 <= arg_222_1.time_ and arg_222_1.time_ < var_225_30 + var_225_40 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_30) / var_225_40

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_30 + var_225_40 and arg_222_1.time_ < var_225_30 + var_225_40 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play319591054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319591054
		arg_226_1.duration_ = 4.07

		local var_226_0 = {
			zh = 1.8,
			ja = 4.066
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play319591055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["4037ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect4037ui_story == nil then
				arg_226_1.var_.characterEffect4037ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect4037ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_226_1.var_.characterEffect4037ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect4037ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_226_1.var_.characterEffect4037ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.15

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[694].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_9 = arg_226_1:GetWordFromCfg(319591054)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 6
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591054", "story_v_out_319591.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591054", "story_v_out_319591.awb") / 1000

					if var_229_14 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_6
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_319591", "319591054", "story_v_out_319591.awb")

						arg_226_1:RecordAudio("319591054", var_229_15)
						arg_226_1:RecordAudio("319591054", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319591", "319591054", "story_v_out_319591.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319591", "319591054", "story_v_out_319591.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_16 and arg_226_1.time_ < var_229_6 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play319591055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319591055
		arg_230_1.duration_ = 4.8

		local var_230_0 = {
			zh = 2.633,
			ja = 4.8
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play319591056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1095ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1095ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, -0.98, -6.1)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1095ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["1095ui_story"]
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect1095ui_story == nil then
				arg_230_1.var_.characterEffect1095ui_story = var_233_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_11 = 0.200000002980232

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 and not isNil(var_233_9) then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11

				if arg_230_1.var_.characterEffect1095ui_story and not isNil(var_233_9) then
					arg_230_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect1095ui_story then
				arg_230_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_233_13 = 0

			if var_233_13 < arg_230_1.time_ and arg_230_1.time_ <= var_233_13 + arg_233_0 then
				arg_230_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_233_14 = 0

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_233_15 = arg_230_1.actors_["4037ui_story"].transform
			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.var_.moveOldPos4037ui_story = var_233_15.localPosition
			end

			local var_233_17 = 0.001

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_17 then
				local var_233_18 = (arg_230_1.time_ - var_233_16) / var_233_17
				local var_233_19 = Vector3.New(0, 100, 0)

				var_233_15.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos4037ui_story, var_233_19, var_233_18)

				local var_233_20 = manager.ui.mainCamera.transform.position - var_233_15.position

				var_233_15.forward = Vector3.New(var_233_20.x, var_233_20.y, var_233_20.z)

				local var_233_21 = var_233_15.localEulerAngles

				var_233_21.z = 0
				var_233_21.x = 0
				var_233_15.localEulerAngles = var_233_21
			end

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				var_233_15.localPosition = Vector3.New(0, 100, 0)

				local var_233_22 = manager.ui.mainCamera.transform.position - var_233_15.position

				var_233_15.forward = Vector3.New(var_233_22.x, var_233_22.y, var_233_22.z)

				local var_233_23 = var_233_15.localEulerAngles

				var_233_23.z = 0
				var_233_23.x = 0
				var_233_15.localEulerAngles = var_233_23
			end

			local var_233_24 = arg_230_1.actors_["4037ui_story"]
			local var_233_25 = 0

			if var_233_25 < arg_230_1.time_ and arg_230_1.time_ <= var_233_25 + arg_233_0 and not isNil(var_233_24) and arg_230_1.var_.characterEffect4037ui_story == nil then
				arg_230_1.var_.characterEffect4037ui_story = var_233_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_26 = 0.200000002980232

			if var_233_25 <= arg_230_1.time_ and arg_230_1.time_ < var_233_25 + var_233_26 and not isNil(var_233_24) then
				local var_233_27 = (arg_230_1.time_ - var_233_25) / var_233_26

				if arg_230_1.var_.characterEffect4037ui_story and not isNil(var_233_24) then
					local var_233_28 = Mathf.Lerp(0, 0.5, var_233_27)

					arg_230_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_230_1.var_.characterEffect4037ui_story.fillRatio = var_233_28
				end
			end

			if arg_230_1.time_ >= var_233_25 + var_233_26 and arg_230_1.time_ < var_233_25 + var_233_26 + arg_233_0 and not isNil(var_233_24) and arg_230_1.var_.characterEffect4037ui_story then
				local var_233_29 = 0.5

				arg_230_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_230_1.var_.characterEffect4037ui_story.fillRatio = var_233_29
			end

			local var_233_30 = 0
			local var_233_31 = 0.375

			if var_233_30 < arg_230_1.time_ and arg_230_1.time_ <= var_233_30 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_32 = arg_230_1:FormatText(StoryNameCfg[471].name)

				arg_230_1.leftNameTxt_.text = var_233_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_33 = arg_230_1:GetWordFromCfg(319591055)
				local var_233_34 = arg_230_1:FormatText(var_233_33.content)

				arg_230_1.text_.text = var_233_34

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_35 = 15
				local var_233_36 = utf8.len(var_233_34)
				local var_233_37 = var_233_35 <= 0 and var_233_31 or var_233_31 * (var_233_36 / var_233_35)

				if var_233_37 > 0 and var_233_31 < var_233_37 then
					arg_230_1.talkMaxDuration = var_233_37

					if var_233_37 + var_233_30 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_37 + var_233_30
					end
				end

				arg_230_1.text_.text = var_233_34
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591055", "story_v_out_319591.awb") ~= 0 then
					local var_233_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591055", "story_v_out_319591.awb") / 1000

					if var_233_38 + var_233_30 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_38 + var_233_30
					end

					if var_233_33.prefab_name ~= "" and arg_230_1.actors_[var_233_33.prefab_name] ~= nil then
						local var_233_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_33.prefab_name].transform, "story_v_out_319591", "319591055", "story_v_out_319591.awb")

						arg_230_1:RecordAudio("319591055", var_233_39)
						arg_230_1:RecordAudio("319591055", var_233_39)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319591", "319591055", "story_v_out_319591.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319591", "319591055", "story_v_out_319591.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_40 = math.max(var_233_31, arg_230_1.talkMaxDuration)

			if var_233_30 <= arg_230_1.time_ and arg_230_1.time_ < var_233_30 + var_233_40 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_30) / var_233_40

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_30 + var_233_40 and arg_230_1.time_ < var_233_30 + var_233_40 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play319591056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319591056
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319591057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1095ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1095ui_story == nil then
				arg_234_1.var_.characterEffect1095ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1095ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1095ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1095ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1095ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 1.55

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(319591056)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_10 = 63
				local var_237_11 = utf8.len(var_237_9)
				local var_237_12 = var_237_10 <= 0 and var_237_7 or var_237_7 * (var_237_11 / var_237_10)

				if var_237_12 > 0 and var_237_7 < var_237_12 then
					arg_234_1.talkMaxDuration = var_237_12

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_13 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_13 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_13

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_13 and arg_234_1.time_ < var_237_6 + var_237_13 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play319591057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319591057
		arg_238_1.duration_ = 10.73

		local var_238_0 = {
			zh = 5.8,
			ja = 10.733
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play319591058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["4037ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos4037ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, -1.12, -6.2)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos4037ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["4037ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect4037ui_story == nil then
				arg_238_1.var_.characterEffect4037ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect4037ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect4037ui_story then
				arg_238_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_241_13 = 0

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_241_14 = 0

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_15 = arg_238_1.actors_["1095ui_story"].transform
			local var_241_16 = 0

			if var_241_16 < arg_238_1.time_ and arg_238_1.time_ <= var_241_16 + arg_241_0 then
				arg_238_1.var_.moveOldPos1095ui_story = var_241_15.localPosition
			end

			local var_241_17 = 0.001

			if var_241_16 <= arg_238_1.time_ and arg_238_1.time_ < var_241_16 + var_241_17 then
				local var_241_18 = (arg_238_1.time_ - var_241_16) / var_241_17
				local var_241_19 = Vector3.New(0, 100, 0)

				var_241_15.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1095ui_story, var_241_19, var_241_18)

				local var_241_20 = manager.ui.mainCamera.transform.position - var_241_15.position

				var_241_15.forward = Vector3.New(var_241_20.x, var_241_20.y, var_241_20.z)

				local var_241_21 = var_241_15.localEulerAngles

				var_241_21.z = 0
				var_241_21.x = 0
				var_241_15.localEulerAngles = var_241_21
			end

			if arg_238_1.time_ >= var_241_16 + var_241_17 and arg_238_1.time_ < var_241_16 + var_241_17 + arg_241_0 then
				var_241_15.localPosition = Vector3.New(0, 100, 0)

				local var_241_22 = manager.ui.mainCamera.transform.position - var_241_15.position

				var_241_15.forward = Vector3.New(var_241_22.x, var_241_22.y, var_241_22.z)

				local var_241_23 = var_241_15.localEulerAngles

				var_241_23.z = 0
				var_241_23.x = 0
				var_241_15.localEulerAngles = var_241_23
			end

			local var_241_24 = arg_238_1.actors_["1095ui_story"]
			local var_241_25 = 0

			if var_241_25 < arg_238_1.time_ and arg_238_1.time_ <= var_241_25 + arg_241_0 and not isNil(var_241_24) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = var_241_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_26 = 0.200000002980232

			if var_241_25 <= arg_238_1.time_ and arg_238_1.time_ < var_241_25 + var_241_26 and not isNil(var_241_24) then
				local var_241_27 = (arg_238_1.time_ - var_241_25) / var_241_26

				if arg_238_1.var_.characterEffect1095ui_story and not isNil(var_241_24) then
					local var_241_28 = Mathf.Lerp(0, 0.5, var_241_27)

					arg_238_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1095ui_story.fillRatio = var_241_28
				end
			end

			if arg_238_1.time_ >= var_241_25 + var_241_26 and arg_238_1.time_ < var_241_25 + var_241_26 + arg_241_0 and not isNil(var_241_24) and arg_238_1.var_.characterEffect1095ui_story then
				local var_241_29 = 0.5

				arg_238_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1095ui_story.fillRatio = var_241_29
			end

			local var_241_30 = 0
			local var_241_31 = 0.65

			if var_241_30 < arg_238_1.time_ and arg_238_1.time_ <= var_241_30 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_32 = arg_238_1:FormatText(StoryNameCfg[453].name)

				arg_238_1.leftNameTxt_.text = var_241_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_33 = arg_238_1:GetWordFromCfg(319591057)
				local var_241_34 = arg_238_1:FormatText(var_241_33.content)

				arg_238_1.text_.text = var_241_34

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_35 = 26
				local var_241_36 = utf8.len(var_241_34)
				local var_241_37 = var_241_35 <= 0 and var_241_31 or var_241_31 * (var_241_36 / var_241_35)

				if var_241_37 > 0 and var_241_31 < var_241_37 then
					arg_238_1.talkMaxDuration = var_241_37

					if var_241_37 + var_241_30 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_37 + var_241_30
					end
				end

				arg_238_1.text_.text = var_241_34
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591057", "story_v_out_319591.awb") ~= 0 then
					local var_241_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591057", "story_v_out_319591.awb") / 1000

					if var_241_38 + var_241_30 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_38 + var_241_30
					end

					if var_241_33.prefab_name ~= "" and arg_238_1.actors_[var_241_33.prefab_name] ~= nil then
						local var_241_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_33.prefab_name].transform, "story_v_out_319591", "319591057", "story_v_out_319591.awb")

						arg_238_1:RecordAudio("319591057", var_241_39)
						arg_238_1:RecordAudio("319591057", var_241_39)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319591", "319591057", "story_v_out_319591.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319591", "319591057", "story_v_out_319591.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_40 = math.max(var_241_31, arg_238_1.talkMaxDuration)

			if var_241_30 <= arg_238_1.time_ and arg_238_1.time_ < var_241_30 + var_241_40 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_30) / var_241_40

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_30 + var_241_40 and arg_238_1.time_ < var_241_30 + var_241_40 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play319591058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319591058
		arg_242_1.duration_ = 7.4

		local var_242_0 = {
			zh = 2.7,
			ja = 7.4
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319591059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1095ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos1095ui_story = var_245_0.localPosition
			end

			local var_245_2 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(0, -0.98, -6.1)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1095ui_story, var_245_4, var_245_3)

				local var_245_5 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_5.x, var_245_5.y, var_245_5.z)

				local var_245_6 = var_245_0.localEulerAngles

				var_245_6.z = 0
				var_245_6.x = 0
				var_245_0.localEulerAngles = var_245_6
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_245_7 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_7.x, var_245_7.y, var_245_7.z)

				local var_245_8 = var_245_0.localEulerAngles

				var_245_8.z = 0
				var_245_8.x = 0
				var_245_0.localEulerAngles = var_245_8
			end

			local var_245_9 = arg_242_1.actors_["1095ui_story"]
			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1095ui_story == nil then
				arg_242_1.var_.characterEffect1095ui_story = var_245_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.200000002980232

			if var_245_10 <= arg_242_1.time_ and arg_242_1.time_ < var_245_10 + var_245_11 and not isNil(var_245_9) then
				local var_245_12 = (arg_242_1.time_ - var_245_10) / var_245_11

				if arg_242_1.var_.characterEffect1095ui_story and not isNil(var_245_9) then
					arg_242_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_10 + var_245_11 and arg_242_1.time_ < var_245_10 + var_245_11 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1095ui_story then
				arg_242_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_245_13 = 0

			if var_245_13 < arg_242_1.time_ and arg_242_1.time_ <= var_245_13 + arg_245_0 then
				arg_242_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_245_14 = 0

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_245_15 = arg_242_1.actors_["4037ui_story"].transform
			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.var_.moveOldPos4037ui_story = var_245_15.localPosition
			end

			local var_245_17 = 0.001

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_17 then
				local var_245_18 = (arg_242_1.time_ - var_245_16) / var_245_17
				local var_245_19 = Vector3.New(0, 100, 0)

				var_245_15.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos4037ui_story, var_245_19, var_245_18)

				local var_245_20 = manager.ui.mainCamera.transform.position - var_245_15.position

				var_245_15.forward = Vector3.New(var_245_20.x, var_245_20.y, var_245_20.z)

				local var_245_21 = var_245_15.localEulerAngles

				var_245_21.z = 0
				var_245_21.x = 0
				var_245_15.localEulerAngles = var_245_21
			end

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				var_245_15.localPosition = Vector3.New(0, 100, 0)

				local var_245_22 = manager.ui.mainCamera.transform.position - var_245_15.position

				var_245_15.forward = Vector3.New(var_245_22.x, var_245_22.y, var_245_22.z)

				local var_245_23 = var_245_15.localEulerAngles

				var_245_23.z = 0
				var_245_23.x = 0
				var_245_15.localEulerAngles = var_245_23
			end

			local var_245_24 = arg_242_1.actors_["4037ui_story"]
			local var_245_25 = 0

			if var_245_25 < arg_242_1.time_ and arg_242_1.time_ <= var_245_25 + arg_245_0 and not isNil(var_245_24) and arg_242_1.var_.characterEffect4037ui_story == nil then
				arg_242_1.var_.characterEffect4037ui_story = var_245_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_26 = 0.200000002980232

			if var_245_25 <= arg_242_1.time_ and arg_242_1.time_ < var_245_25 + var_245_26 and not isNil(var_245_24) then
				local var_245_27 = (arg_242_1.time_ - var_245_25) / var_245_26

				if arg_242_1.var_.characterEffect4037ui_story and not isNil(var_245_24) then
					local var_245_28 = Mathf.Lerp(0, 0.5, var_245_27)

					arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_242_1.var_.characterEffect4037ui_story.fillRatio = var_245_28
				end
			end

			if arg_242_1.time_ >= var_245_25 + var_245_26 and arg_242_1.time_ < var_245_25 + var_245_26 + arg_245_0 and not isNil(var_245_24) and arg_242_1.var_.characterEffect4037ui_story then
				local var_245_29 = 0.5

				arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_242_1.var_.characterEffect4037ui_story.fillRatio = var_245_29
			end

			local var_245_30 = 0
			local var_245_31 = 0.425

			if var_245_30 < arg_242_1.time_ and arg_242_1.time_ <= var_245_30 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_32 = arg_242_1:FormatText(StoryNameCfg[471].name)

				arg_242_1.leftNameTxt_.text = var_245_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_33 = arg_242_1:GetWordFromCfg(319591058)
				local var_245_34 = arg_242_1:FormatText(var_245_33.content)

				arg_242_1.text_.text = var_245_34

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_35 = 17
				local var_245_36 = utf8.len(var_245_34)
				local var_245_37 = var_245_35 <= 0 and var_245_31 or var_245_31 * (var_245_36 / var_245_35)

				if var_245_37 > 0 and var_245_31 < var_245_37 then
					arg_242_1.talkMaxDuration = var_245_37

					if var_245_37 + var_245_30 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_37 + var_245_30
					end
				end

				arg_242_1.text_.text = var_245_34
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591058", "story_v_out_319591.awb") ~= 0 then
					local var_245_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591058", "story_v_out_319591.awb") / 1000

					if var_245_38 + var_245_30 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_38 + var_245_30
					end

					if var_245_33.prefab_name ~= "" and arg_242_1.actors_[var_245_33.prefab_name] ~= nil then
						local var_245_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_33.prefab_name].transform, "story_v_out_319591", "319591058", "story_v_out_319591.awb")

						arg_242_1:RecordAudio("319591058", var_245_39)
						arg_242_1:RecordAudio("319591058", var_245_39)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319591", "319591058", "story_v_out_319591.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319591", "319591058", "story_v_out_319591.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_40 = math.max(var_245_31, arg_242_1.talkMaxDuration)

			if var_245_30 <= arg_242_1.time_ and arg_242_1.time_ < var_245_30 + var_245_40 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_30) / var_245_40

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_30 + var_245_40 and arg_242_1.time_ < var_245_30 + var_245_40 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play319591059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319591059
		arg_246_1.duration_ = 3.53

		local var_246_0 = {
			zh = 3.533,
			ja = 2.233
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play319591060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["4037ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos4037ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, -1.12, -6.2)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos4037ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["4037ui_story"]
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect4037ui_story == nil then
				arg_246_1.var_.characterEffect4037ui_story = var_249_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_11 = 0.200000002980232

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 and not isNil(var_249_9) then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11

				if arg_246_1.var_.characterEffect4037ui_story and not isNil(var_249_9) then
					arg_246_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect4037ui_story then
				arg_246_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_249_13 = 0

			if var_249_13 < arg_246_1.time_ and arg_246_1.time_ <= var_249_13 + arg_249_0 then
				arg_246_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_249_14 = 0

			if var_249_14 < arg_246_1.time_ and arg_246_1.time_ <= var_249_14 + arg_249_0 then
				arg_246_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_249_15 = arg_246_1.actors_["1095ui_story"].transform
			local var_249_16 = 0

			if var_249_16 < arg_246_1.time_ and arg_246_1.time_ <= var_249_16 + arg_249_0 then
				arg_246_1.var_.moveOldPos1095ui_story = var_249_15.localPosition
			end

			local var_249_17 = 0.001

			if var_249_16 <= arg_246_1.time_ and arg_246_1.time_ < var_249_16 + var_249_17 then
				local var_249_18 = (arg_246_1.time_ - var_249_16) / var_249_17
				local var_249_19 = Vector3.New(0, 100, 0)

				var_249_15.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1095ui_story, var_249_19, var_249_18)

				local var_249_20 = manager.ui.mainCamera.transform.position - var_249_15.position

				var_249_15.forward = Vector3.New(var_249_20.x, var_249_20.y, var_249_20.z)

				local var_249_21 = var_249_15.localEulerAngles

				var_249_21.z = 0
				var_249_21.x = 0
				var_249_15.localEulerAngles = var_249_21
			end

			if arg_246_1.time_ >= var_249_16 + var_249_17 and arg_246_1.time_ < var_249_16 + var_249_17 + arg_249_0 then
				var_249_15.localPosition = Vector3.New(0, 100, 0)

				local var_249_22 = manager.ui.mainCamera.transform.position - var_249_15.position

				var_249_15.forward = Vector3.New(var_249_22.x, var_249_22.y, var_249_22.z)

				local var_249_23 = var_249_15.localEulerAngles

				var_249_23.z = 0
				var_249_23.x = 0
				var_249_15.localEulerAngles = var_249_23
			end

			local var_249_24 = arg_246_1.actors_["1095ui_story"]
			local var_249_25 = 0

			if var_249_25 < arg_246_1.time_ and arg_246_1.time_ <= var_249_25 + arg_249_0 and not isNil(var_249_24) and arg_246_1.var_.characterEffect1095ui_story == nil then
				arg_246_1.var_.characterEffect1095ui_story = var_249_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_26 = 0.200000002980232

			if var_249_25 <= arg_246_1.time_ and arg_246_1.time_ < var_249_25 + var_249_26 and not isNil(var_249_24) then
				local var_249_27 = (arg_246_1.time_ - var_249_25) / var_249_26

				if arg_246_1.var_.characterEffect1095ui_story and not isNil(var_249_24) then
					local var_249_28 = Mathf.Lerp(0, 0.5, var_249_27)

					arg_246_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1095ui_story.fillRatio = var_249_28
				end
			end

			if arg_246_1.time_ >= var_249_25 + var_249_26 and arg_246_1.time_ < var_249_25 + var_249_26 + arg_249_0 and not isNil(var_249_24) and arg_246_1.var_.characterEffect1095ui_story then
				local var_249_29 = 0.5

				arg_246_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1095ui_story.fillRatio = var_249_29
			end

			local var_249_30 = 0
			local var_249_31 = 0.25

			if var_249_30 < arg_246_1.time_ and arg_246_1.time_ <= var_249_30 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_32 = arg_246_1:FormatText(StoryNameCfg[453].name)

				arg_246_1.leftNameTxt_.text = var_249_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_33 = arg_246_1:GetWordFromCfg(319591059)
				local var_249_34 = arg_246_1:FormatText(var_249_33.content)

				arg_246_1.text_.text = var_249_34

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_35 = 10
				local var_249_36 = utf8.len(var_249_34)
				local var_249_37 = var_249_35 <= 0 and var_249_31 or var_249_31 * (var_249_36 / var_249_35)

				if var_249_37 > 0 and var_249_31 < var_249_37 then
					arg_246_1.talkMaxDuration = var_249_37

					if var_249_37 + var_249_30 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_37 + var_249_30
					end
				end

				arg_246_1.text_.text = var_249_34
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591059", "story_v_out_319591.awb") ~= 0 then
					local var_249_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591059", "story_v_out_319591.awb") / 1000

					if var_249_38 + var_249_30 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_38 + var_249_30
					end

					if var_249_33.prefab_name ~= "" and arg_246_1.actors_[var_249_33.prefab_name] ~= nil then
						local var_249_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_33.prefab_name].transform, "story_v_out_319591", "319591059", "story_v_out_319591.awb")

						arg_246_1:RecordAudio("319591059", var_249_39)
						arg_246_1:RecordAudio("319591059", var_249_39)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_319591", "319591059", "story_v_out_319591.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_319591", "319591059", "story_v_out_319591.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_40 = math.max(var_249_31, arg_246_1.talkMaxDuration)

			if var_249_30 <= arg_246_1.time_ and arg_246_1.time_ < var_249_30 + var_249_40 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_30) / var_249_40

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_30 + var_249_40 and arg_246_1.time_ < var_249_30 + var_249_40 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play319591060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319591060
		arg_250_1.duration_ = 12.13

		local var_250_0 = {
			zh = 8.6,
			ja = 12.133
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319591061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1095ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1095ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(0, -0.98, -6.1)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1095ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = arg_250_1.actors_["1095ui_story"]
			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1095ui_story == nil then
				arg_250_1.var_.characterEffect1095ui_story = var_253_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_11 = 0.200000002980232

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_11 and not isNil(var_253_9) then
				local var_253_12 = (arg_250_1.time_ - var_253_10) / var_253_11

				if arg_250_1.var_.characterEffect1095ui_story and not isNil(var_253_9) then
					arg_250_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_10 + var_253_11 and arg_250_1.time_ < var_253_10 + var_253_11 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1095ui_story then
				arg_250_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_253_13 = 0

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_253_14 = 0

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				arg_250_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_15 = arg_250_1.actors_["4037ui_story"].transform
			local var_253_16 = 0

			if var_253_16 < arg_250_1.time_ and arg_250_1.time_ <= var_253_16 + arg_253_0 then
				arg_250_1.var_.moveOldPos4037ui_story = var_253_15.localPosition
			end

			local var_253_17 = 0.001

			if var_253_16 <= arg_250_1.time_ and arg_250_1.time_ < var_253_16 + var_253_17 then
				local var_253_18 = (arg_250_1.time_ - var_253_16) / var_253_17
				local var_253_19 = Vector3.New(0, 100, 0)

				var_253_15.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos4037ui_story, var_253_19, var_253_18)

				local var_253_20 = manager.ui.mainCamera.transform.position - var_253_15.position

				var_253_15.forward = Vector3.New(var_253_20.x, var_253_20.y, var_253_20.z)

				local var_253_21 = var_253_15.localEulerAngles

				var_253_21.z = 0
				var_253_21.x = 0
				var_253_15.localEulerAngles = var_253_21
			end

			if arg_250_1.time_ >= var_253_16 + var_253_17 and arg_250_1.time_ < var_253_16 + var_253_17 + arg_253_0 then
				var_253_15.localPosition = Vector3.New(0, 100, 0)

				local var_253_22 = manager.ui.mainCamera.transform.position - var_253_15.position

				var_253_15.forward = Vector3.New(var_253_22.x, var_253_22.y, var_253_22.z)

				local var_253_23 = var_253_15.localEulerAngles

				var_253_23.z = 0
				var_253_23.x = 0
				var_253_15.localEulerAngles = var_253_23
			end

			local var_253_24 = arg_250_1.actors_["4037ui_story"]
			local var_253_25 = 0

			if var_253_25 < arg_250_1.time_ and arg_250_1.time_ <= var_253_25 + arg_253_0 and not isNil(var_253_24) and arg_250_1.var_.characterEffect4037ui_story == nil then
				arg_250_1.var_.characterEffect4037ui_story = var_253_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_26 = 0.200000002980232

			if var_253_25 <= arg_250_1.time_ and arg_250_1.time_ < var_253_25 + var_253_26 and not isNil(var_253_24) then
				local var_253_27 = (arg_250_1.time_ - var_253_25) / var_253_26

				if arg_250_1.var_.characterEffect4037ui_story and not isNil(var_253_24) then
					local var_253_28 = Mathf.Lerp(0, 0.5, var_253_27)

					arg_250_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_250_1.var_.characterEffect4037ui_story.fillRatio = var_253_28
				end
			end

			if arg_250_1.time_ >= var_253_25 + var_253_26 and arg_250_1.time_ < var_253_25 + var_253_26 + arg_253_0 and not isNil(var_253_24) and arg_250_1.var_.characterEffect4037ui_story then
				local var_253_29 = 0.5

				arg_250_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_250_1.var_.characterEffect4037ui_story.fillRatio = var_253_29
			end

			local var_253_30 = 0
			local var_253_31 = 1.05

			if var_253_30 < arg_250_1.time_ and arg_250_1.time_ <= var_253_30 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_32 = arg_250_1:FormatText(StoryNameCfg[471].name)

				arg_250_1.leftNameTxt_.text = var_253_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_33 = arg_250_1:GetWordFromCfg(319591060)
				local var_253_34 = arg_250_1:FormatText(var_253_33.content)

				arg_250_1.text_.text = var_253_34

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_35 = 42
				local var_253_36 = utf8.len(var_253_34)
				local var_253_37 = var_253_35 <= 0 and var_253_31 or var_253_31 * (var_253_36 / var_253_35)

				if var_253_37 > 0 and var_253_31 < var_253_37 then
					arg_250_1.talkMaxDuration = var_253_37

					if var_253_37 + var_253_30 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_37 + var_253_30
					end
				end

				arg_250_1.text_.text = var_253_34
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591060", "story_v_out_319591.awb") ~= 0 then
					local var_253_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591060", "story_v_out_319591.awb") / 1000

					if var_253_38 + var_253_30 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_38 + var_253_30
					end

					if var_253_33.prefab_name ~= "" and arg_250_1.actors_[var_253_33.prefab_name] ~= nil then
						local var_253_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_33.prefab_name].transform, "story_v_out_319591", "319591060", "story_v_out_319591.awb")

						arg_250_1:RecordAudio("319591060", var_253_39)
						arg_250_1:RecordAudio("319591060", var_253_39)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_319591", "319591060", "story_v_out_319591.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_319591", "319591060", "story_v_out_319591.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_40 = math.max(var_253_31, arg_250_1.talkMaxDuration)

			if var_253_30 <= arg_250_1.time_ and arg_250_1.time_ < var_253_30 + var_253_40 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_30) / var_253_40

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_30 + var_253_40 and arg_250_1.time_ < var_253_30 + var_253_40 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play319591061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319591061
		arg_254_1.duration_ = 9.4

		local var_254_0 = {
			zh = 7.666,
			ja = 9.4
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319591062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["4037ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos4037ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, -1.12, -6.2)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos4037ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["4037ui_story"]
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect4037ui_story == nil then
				arg_254_1.var_.characterEffect4037ui_story = var_257_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_11 = 0.200000002980232

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 and not isNil(var_257_9) then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11

				if arg_254_1.var_.characterEffect4037ui_story and not isNil(var_257_9) then
					arg_254_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect4037ui_story then
				arg_254_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_257_13 = 0

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action423")
			end

			local var_257_14 = 0

			if var_257_14 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 then
				arg_254_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_257_15 = arg_254_1.actors_["1095ui_story"].transform
			local var_257_16 = 0

			if var_257_16 < arg_254_1.time_ and arg_254_1.time_ <= var_257_16 + arg_257_0 then
				arg_254_1.var_.moveOldPos1095ui_story = var_257_15.localPosition
			end

			local var_257_17 = 0.001

			if var_257_16 <= arg_254_1.time_ and arg_254_1.time_ < var_257_16 + var_257_17 then
				local var_257_18 = (arg_254_1.time_ - var_257_16) / var_257_17
				local var_257_19 = Vector3.New(0, 100, 0)

				var_257_15.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1095ui_story, var_257_19, var_257_18)

				local var_257_20 = manager.ui.mainCamera.transform.position - var_257_15.position

				var_257_15.forward = Vector3.New(var_257_20.x, var_257_20.y, var_257_20.z)

				local var_257_21 = var_257_15.localEulerAngles

				var_257_21.z = 0
				var_257_21.x = 0
				var_257_15.localEulerAngles = var_257_21
			end

			if arg_254_1.time_ >= var_257_16 + var_257_17 and arg_254_1.time_ < var_257_16 + var_257_17 + arg_257_0 then
				var_257_15.localPosition = Vector3.New(0, 100, 0)

				local var_257_22 = manager.ui.mainCamera.transform.position - var_257_15.position

				var_257_15.forward = Vector3.New(var_257_22.x, var_257_22.y, var_257_22.z)

				local var_257_23 = var_257_15.localEulerAngles

				var_257_23.z = 0
				var_257_23.x = 0
				var_257_15.localEulerAngles = var_257_23
			end

			local var_257_24 = arg_254_1.actors_["1095ui_story"]
			local var_257_25 = 0

			if var_257_25 < arg_254_1.time_ and arg_254_1.time_ <= var_257_25 + arg_257_0 and not isNil(var_257_24) and arg_254_1.var_.characterEffect1095ui_story == nil then
				arg_254_1.var_.characterEffect1095ui_story = var_257_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_26 = 0.200000002980232

			if var_257_25 <= arg_254_1.time_ and arg_254_1.time_ < var_257_25 + var_257_26 and not isNil(var_257_24) then
				local var_257_27 = (arg_254_1.time_ - var_257_25) / var_257_26

				if arg_254_1.var_.characterEffect1095ui_story and not isNil(var_257_24) then
					local var_257_28 = Mathf.Lerp(0, 0.5, var_257_27)

					arg_254_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1095ui_story.fillRatio = var_257_28
				end
			end

			if arg_254_1.time_ >= var_257_25 + var_257_26 and arg_254_1.time_ < var_257_25 + var_257_26 + arg_257_0 and not isNil(var_257_24) and arg_254_1.var_.characterEffect1095ui_story then
				local var_257_29 = 0.5

				arg_254_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1095ui_story.fillRatio = var_257_29
			end

			local var_257_30 = 0
			local var_257_31 = 0.825

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_32 = arg_254_1:FormatText(StoryNameCfg[453].name)

				arg_254_1.leftNameTxt_.text = var_257_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_33 = arg_254_1:GetWordFromCfg(319591061)
				local var_257_34 = arg_254_1:FormatText(var_257_33.content)

				arg_254_1.text_.text = var_257_34

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_35 = 33
				local var_257_36 = utf8.len(var_257_34)
				local var_257_37 = var_257_35 <= 0 and var_257_31 or var_257_31 * (var_257_36 / var_257_35)

				if var_257_37 > 0 and var_257_31 < var_257_37 then
					arg_254_1.talkMaxDuration = var_257_37

					if var_257_37 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_37 + var_257_30
					end
				end

				arg_254_1.text_.text = var_257_34
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591061", "story_v_out_319591.awb") ~= 0 then
					local var_257_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591061", "story_v_out_319591.awb") / 1000

					if var_257_38 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_38 + var_257_30
					end

					if var_257_33.prefab_name ~= "" and arg_254_1.actors_[var_257_33.prefab_name] ~= nil then
						local var_257_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_33.prefab_name].transform, "story_v_out_319591", "319591061", "story_v_out_319591.awb")

						arg_254_1:RecordAudio("319591061", var_257_39)
						arg_254_1:RecordAudio("319591061", var_257_39)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319591", "319591061", "story_v_out_319591.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319591", "319591061", "story_v_out_319591.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_40 = math.max(var_257_31, arg_254_1.talkMaxDuration)

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_40 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_30) / var_257_40

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_30 + var_257_40 and arg_254_1.time_ < var_257_30 + var_257_40 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play319591062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319591062
		arg_258_1.duration_ = 11.9

		local var_258_0 = {
			zh = 7.7,
			ja = 11.9
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319591063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.675

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[453].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:GetWordFromCfg(319591062)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 27
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591062", "story_v_out_319591.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591062", "story_v_out_319591.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_319591", "319591062", "story_v_out_319591.awb")

						arg_258_1:RecordAudio("319591062", var_261_9)
						arg_258_1:RecordAudio("319591062", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319591", "319591062", "story_v_out_319591.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319591", "319591062", "story_v_out_319591.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play319591063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319591063
		arg_262_1.duration_ = 15.2

		local var_262_0 = {
			zh = 8.733,
			ja = 15.2
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319591064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1095ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1095ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, -0.98, -6.1)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1095ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["1095ui_story"]
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1095ui_story == nil then
				arg_262_1.var_.characterEffect1095ui_story = var_265_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_11 = 0.200000002980232

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 and not isNil(var_265_9) then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11

				if arg_262_1.var_.characterEffect1095ui_story and not isNil(var_265_9) then
					arg_262_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1095ui_story then
				arg_262_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_265_13 = 0

			if var_265_13 < arg_262_1.time_ and arg_262_1.time_ <= var_265_13 + arg_265_0 then
				arg_262_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_265_14 = 0

			if var_265_14 < arg_262_1.time_ and arg_262_1.time_ <= var_265_14 + arg_265_0 then
				arg_262_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_265_15 = arg_262_1.actors_["4037ui_story"].transform
			local var_265_16 = 0

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 then
				arg_262_1.var_.moveOldPos4037ui_story = var_265_15.localPosition
			end

			local var_265_17 = 0.001

			if var_265_16 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_17 then
				local var_265_18 = (arg_262_1.time_ - var_265_16) / var_265_17
				local var_265_19 = Vector3.New(0, 100, 0)

				var_265_15.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos4037ui_story, var_265_19, var_265_18)

				local var_265_20 = manager.ui.mainCamera.transform.position - var_265_15.position

				var_265_15.forward = Vector3.New(var_265_20.x, var_265_20.y, var_265_20.z)

				local var_265_21 = var_265_15.localEulerAngles

				var_265_21.z = 0
				var_265_21.x = 0
				var_265_15.localEulerAngles = var_265_21
			end

			if arg_262_1.time_ >= var_265_16 + var_265_17 and arg_262_1.time_ < var_265_16 + var_265_17 + arg_265_0 then
				var_265_15.localPosition = Vector3.New(0, 100, 0)

				local var_265_22 = manager.ui.mainCamera.transform.position - var_265_15.position

				var_265_15.forward = Vector3.New(var_265_22.x, var_265_22.y, var_265_22.z)

				local var_265_23 = var_265_15.localEulerAngles

				var_265_23.z = 0
				var_265_23.x = 0
				var_265_15.localEulerAngles = var_265_23
			end

			local var_265_24 = arg_262_1.actors_["4037ui_story"]
			local var_265_25 = 0

			if var_265_25 < arg_262_1.time_ and arg_262_1.time_ <= var_265_25 + arg_265_0 and not isNil(var_265_24) and arg_262_1.var_.characterEffect4037ui_story == nil then
				arg_262_1.var_.characterEffect4037ui_story = var_265_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_26 = 0.200000002980232

			if var_265_25 <= arg_262_1.time_ and arg_262_1.time_ < var_265_25 + var_265_26 and not isNil(var_265_24) then
				local var_265_27 = (arg_262_1.time_ - var_265_25) / var_265_26

				if arg_262_1.var_.characterEffect4037ui_story and not isNil(var_265_24) then
					local var_265_28 = Mathf.Lerp(0, 0.5, var_265_27)

					arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_262_1.var_.characterEffect4037ui_story.fillRatio = var_265_28
				end
			end

			if arg_262_1.time_ >= var_265_25 + var_265_26 and arg_262_1.time_ < var_265_25 + var_265_26 + arg_265_0 and not isNil(var_265_24) and arg_262_1.var_.characterEffect4037ui_story then
				local var_265_29 = 0.5

				arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_262_1.var_.characterEffect4037ui_story.fillRatio = var_265_29
			end

			local var_265_30 = 0
			local var_265_31 = 0.875

			if var_265_30 < arg_262_1.time_ and arg_262_1.time_ <= var_265_30 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_32 = arg_262_1:FormatText(StoryNameCfg[471].name)

				arg_262_1.leftNameTxt_.text = var_265_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_33 = arg_262_1:GetWordFromCfg(319591063)
				local var_265_34 = arg_262_1:FormatText(var_265_33.content)

				arg_262_1.text_.text = var_265_34

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_35 = 35
				local var_265_36 = utf8.len(var_265_34)
				local var_265_37 = var_265_35 <= 0 and var_265_31 or var_265_31 * (var_265_36 / var_265_35)

				if var_265_37 > 0 and var_265_31 < var_265_37 then
					arg_262_1.talkMaxDuration = var_265_37

					if var_265_37 + var_265_30 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_37 + var_265_30
					end
				end

				arg_262_1.text_.text = var_265_34
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591063", "story_v_out_319591.awb") ~= 0 then
					local var_265_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591063", "story_v_out_319591.awb") / 1000

					if var_265_38 + var_265_30 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_38 + var_265_30
					end

					if var_265_33.prefab_name ~= "" and arg_262_1.actors_[var_265_33.prefab_name] ~= nil then
						local var_265_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_33.prefab_name].transform, "story_v_out_319591", "319591063", "story_v_out_319591.awb")

						arg_262_1:RecordAudio("319591063", var_265_39)
						arg_262_1:RecordAudio("319591063", var_265_39)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319591", "319591063", "story_v_out_319591.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319591", "319591063", "story_v_out_319591.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_40 = math.max(var_265_31, arg_262_1.talkMaxDuration)

			if var_265_30 <= arg_262_1.time_ and arg_262_1.time_ < var_265_30 + var_265_40 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_30) / var_265_40

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_30 + var_265_40 and arg_262_1.time_ < var_265_30 + var_265_40 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play319591064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319591064
		arg_266_1.duration_ = 3.07

		local var_266_0 = {
			zh = 2.333,
			ja = 3.066
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319591065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["4037ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos4037ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, -1.12, -6.2)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos4037ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["4037ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect4037ui_story == nil then
				arg_266_1.var_.characterEffect4037ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect4037ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect4037ui_story then
				arg_266_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_269_13 = 0

			if var_269_13 < arg_266_1.time_ and arg_266_1.time_ <= var_269_13 + arg_269_0 then
				arg_266_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_15 = arg_266_1.actors_["1095ui_story"].transform
			local var_269_16 = 0

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1.var_.moveOldPos1095ui_story = var_269_15.localPosition
			end

			local var_269_17 = 0.001

			if var_269_16 <= arg_266_1.time_ and arg_266_1.time_ < var_269_16 + var_269_17 then
				local var_269_18 = (arg_266_1.time_ - var_269_16) / var_269_17
				local var_269_19 = Vector3.New(0, 100, 0)

				var_269_15.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1095ui_story, var_269_19, var_269_18)

				local var_269_20 = manager.ui.mainCamera.transform.position - var_269_15.position

				var_269_15.forward = Vector3.New(var_269_20.x, var_269_20.y, var_269_20.z)

				local var_269_21 = var_269_15.localEulerAngles

				var_269_21.z = 0
				var_269_21.x = 0
				var_269_15.localEulerAngles = var_269_21
			end

			if arg_266_1.time_ >= var_269_16 + var_269_17 and arg_266_1.time_ < var_269_16 + var_269_17 + arg_269_0 then
				var_269_15.localPosition = Vector3.New(0, 100, 0)

				local var_269_22 = manager.ui.mainCamera.transform.position - var_269_15.position

				var_269_15.forward = Vector3.New(var_269_22.x, var_269_22.y, var_269_22.z)

				local var_269_23 = var_269_15.localEulerAngles

				var_269_23.z = 0
				var_269_23.x = 0
				var_269_15.localEulerAngles = var_269_23
			end

			local var_269_24 = arg_266_1.actors_["1095ui_story"]
			local var_269_25 = 0

			if var_269_25 < arg_266_1.time_ and arg_266_1.time_ <= var_269_25 + arg_269_0 and not isNil(var_269_24) and arg_266_1.var_.characterEffect1095ui_story == nil then
				arg_266_1.var_.characterEffect1095ui_story = var_269_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_26 = 0.200000002980232

			if var_269_25 <= arg_266_1.time_ and arg_266_1.time_ < var_269_25 + var_269_26 and not isNil(var_269_24) then
				local var_269_27 = (arg_266_1.time_ - var_269_25) / var_269_26

				if arg_266_1.var_.characterEffect1095ui_story and not isNil(var_269_24) then
					local var_269_28 = Mathf.Lerp(0, 0.5, var_269_27)

					arg_266_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1095ui_story.fillRatio = var_269_28
				end
			end

			if arg_266_1.time_ >= var_269_25 + var_269_26 and arg_266_1.time_ < var_269_25 + var_269_26 + arg_269_0 and not isNil(var_269_24) and arg_266_1.var_.characterEffect1095ui_story then
				local var_269_29 = 0.5

				arg_266_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1095ui_story.fillRatio = var_269_29
			end

			local var_269_30 = 0
			local var_269_31 = 0.25

			if var_269_30 < arg_266_1.time_ and arg_266_1.time_ <= var_269_30 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_32 = arg_266_1:FormatText(StoryNameCfg[453].name)

				arg_266_1.leftNameTxt_.text = var_269_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_33 = arg_266_1:GetWordFromCfg(319591064)
				local var_269_34 = arg_266_1:FormatText(var_269_33.content)

				arg_266_1.text_.text = var_269_34

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_35 = 10
				local var_269_36 = utf8.len(var_269_34)
				local var_269_37 = var_269_35 <= 0 and var_269_31 or var_269_31 * (var_269_36 / var_269_35)

				if var_269_37 > 0 and var_269_31 < var_269_37 then
					arg_266_1.talkMaxDuration = var_269_37

					if var_269_37 + var_269_30 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_37 + var_269_30
					end
				end

				arg_266_1.text_.text = var_269_34
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591064", "story_v_out_319591.awb") ~= 0 then
					local var_269_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591064", "story_v_out_319591.awb") / 1000

					if var_269_38 + var_269_30 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_38 + var_269_30
					end

					if var_269_33.prefab_name ~= "" and arg_266_1.actors_[var_269_33.prefab_name] ~= nil then
						local var_269_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_33.prefab_name].transform, "story_v_out_319591", "319591064", "story_v_out_319591.awb")

						arg_266_1:RecordAudio("319591064", var_269_39)
						arg_266_1:RecordAudio("319591064", var_269_39)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319591", "319591064", "story_v_out_319591.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319591", "319591064", "story_v_out_319591.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_40 = math.max(var_269_31, arg_266_1.talkMaxDuration)

			if var_269_30 <= arg_266_1.time_ and arg_266_1.time_ < var_269_30 + var_269_40 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_30) / var_269_40

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_30 + var_269_40 and arg_266_1.time_ < var_269_30 + var_269_40 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play319591065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319591065
		arg_270_1.duration_ = 6.3

		local var_270_0 = {
			zh = 2.866,
			ja = 6.3
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319591066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1095ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1095ui_story = var_273_0.localPosition
			end

			local var_273_2 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2
				local var_273_4 = Vector3.New(0, -0.98, -6.1)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1095ui_story, var_273_4, var_273_3)

				local var_273_5 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_5.x, var_273_5.y, var_273_5.z)

				local var_273_6 = var_273_0.localEulerAngles

				var_273_6.z = 0
				var_273_6.x = 0
				var_273_0.localEulerAngles = var_273_6
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_273_7 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_7.x, var_273_7.y, var_273_7.z)

				local var_273_8 = var_273_0.localEulerAngles

				var_273_8.z = 0
				var_273_8.x = 0
				var_273_0.localEulerAngles = var_273_8
			end

			local var_273_9 = arg_270_1.actors_["1095ui_story"]
			local var_273_10 = 0

			if var_273_10 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 and not isNil(var_273_9) and arg_270_1.var_.characterEffect1095ui_story == nil then
				arg_270_1.var_.characterEffect1095ui_story = var_273_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_11 = 0.200000002980232

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_11 and not isNil(var_273_9) then
				local var_273_12 = (arg_270_1.time_ - var_273_10) / var_273_11

				if arg_270_1.var_.characterEffect1095ui_story and not isNil(var_273_9) then
					arg_270_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_10 + var_273_11 and arg_270_1.time_ < var_273_10 + var_273_11 + arg_273_0 and not isNil(var_273_9) and arg_270_1.var_.characterEffect1095ui_story then
				arg_270_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_273_13 = arg_270_1.actors_["4037ui_story"].transform
			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1.var_.moveOldPos4037ui_story = var_273_13.localPosition
			end

			local var_273_15 = 0.001

			if var_273_14 <= arg_270_1.time_ and arg_270_1.time_ < var_273_14 + var_273_15 then
				local var_273_16 = (arg_270_1.time_ - var_273_14) / var_273_15
				local var_273_17 = Vector3.New(0, 100, 0)

				var_273_13.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos4037ui_story, var_273_17, var_273_16)

				local var_273_18 = manager.ui.mainCamera.transform.position - var_273_13.position

				var_273_13.forward = Vector3.New(var_273_18.x, var_273_18.y, var_273_18.z)

				local var_273_19 = var_273_13.localEulerAngles

				var_273_19.z = 0
				var_273_19.x = 0
				var_273_13.localEulerAngles = var_273_19
			end

			if arg_270_1.time_ >= var_273_14 + var_273_15 and arg_270_1.time_ < var_273_14 + var_273_15 + arg_273_0 then
				var_273_13.localPosition = Vector3.New(0, 100, 0)

				local var_273_20 = manager.ui.mainCamera.transform.position - var_273_13.position

				var_273_13.forward = Vector3.New(var_273_20.x, var_273_20.y, var_273_20.z)

				local var_273_21 = var_273_13.localEulerAngles

				var_273_21.z = 0
				var_273_21.x = 0
				var_273_13.localEulerAngles = var_273_21
			end

			local var_273_22 = arg_270_1.actors_["4037ui_story"]
			local var_273_23 = 0

			if var_273_23 < arg_270_1.time_ and arg_270_1.time_ <= var_273_23 + arg_273_0 and not isNil(var_273_22) and arg_270_1.var_.characterEffect4037ui_story == nil then
				arg_270_1.var_.characterEffect4037ui_story = var_273_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_24 = 0.200000002980232

			if var_273_23 <= arg_270_1.time_ and arg_270_1.time_ < var_273_23 + var_273_24 and not isNil(var_273_22) then
				local var_273_25 = (arg_270_1.time_ - var_273_23) / var_273_24

				if arg_270_1.var_.characterEffect4037ui_story and not isNil(var_273_22) then
					local var_273_26 = Mathf.Lerp(0, 0.5, var_273_25)

					arg_270_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_270_1.var_.characterEffect4037ui_story.fillRatio = var_273_26
				end
			end

			if arg_270_1.time_ >= var_273_23 + var_273_24 and arg_270_1.time_ < var_273_23 + var_273_24 + arg_273_0 and not isNil(var_273_22) and arg_270_1.var_.characterEffect4037ui_story then
				local var_273_27 = 0.5

				arg_270_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_270_1.var_.characterEffect4037ui_story.fillRatio = var_273_27
			end

			local var_273_28 = 0
			local var_273_29 = 0.275

			if var_273_28 < arg_270_1.time_ and arg_270_1.time_ <= var_273_28 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_30 = arg_270_1:FormatText(StoryNameCfg[471].name)

				arg_270_1.leftNameTxt_.text = var_273_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_31 = arg_270_1:GetWordFromCfg(319591065)
				local var_273_32 = arg_270_1:FormatText(var_273_31.content)

				arg_270_1.text_.text = var_273_32

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_33 = 11
				local var_273_34 = utf8.len(var_273_32)
				local var_273_35 = var_273_33 <= 0 and var_273_29 or var_273_29 * (var_273_34 / var_273_33)

				if var_273_35 > 0 and var_273_29 < var_273_35 then
					arg_270_1.talkMaxDuration = var_273_35

					if var_273_35 + var_273_28 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_35 + var_273_28
					end
				end

				arg_270_1.text_.text = var_273_32
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591065", "story_v_out_319591.awb") ~= 0 then
					local var_273_36 = manager.audio:GetVoiceLength("story_v_out_319591", "319591065", "story_v_out_319591.awb") / 1000

					if var_273_36 + var_273_28 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_36 + var_273_28
					end

					if var_273_31.prefab_name ~= "" and arg_270_1.actors_[var_273_31.prefab_name] ~= nil then
						local var_273_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_31.prefab_name].transform, "story_v_out_319591", "319591065", "story_v_out_319591.awb")

						arg_270_1:RecordAudio("319591065", var_273_37)
						arg_270_1:RecordAudio("319591065", var_273_37)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_319591", "319591065", "story_v_out_319591.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_319591", "319591065", "story_v_out_319591.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_38 = math.max(var_273_29, arg_270_1.talkMaxDuration)

			if var_273_28 <= arg_270_1.time_ and arg_270_1.time_ < var_273_28 + var_273_38 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_28) / var_273_38

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_28 + var_273_38 and arg_270_1.time_ < var_273_28 + var_273_38 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play319591066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319591066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319591067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["4037ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos4037ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, 100, 0)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos4037ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, 100, 0)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["1095ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1095ui_story == nil then
				arg_274_1.var_.characterEffect1095ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect1095ui_story and not isNil(var_277_9) then
					local var_277_13 = Mathf.Lerp(0, 0.5, var_277_12)

					arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1095ui_story.fillRatio = var_277_13
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1095ui_story then
				local var_277_14 = 0.5

				arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1095ui_story.fillRatio = var_277_14
			end

			local var_277_15 = 0
			local var_277_16 = 0.725

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_17 = arg_274_1:GetWordFromCfg(319591066)
				local var_277_18 = arg_274_1:FormatText(var_277_17.content)

				arg_274_1.text_.text = var_277_18

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_19 = 29
				local var_277_20 = utf8.len(var_277_18)
				local var_277_21 = var_277_19 <= 0 and var_277_16 or var_277_16 * (var_277_20 / var_277_19)

				if var_277_21 > 0 and var_277_16 < var_277_21 then
					arg_274_1.talkMaxDuration = var_277_21

					if var_277_21 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_21 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_18
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_22 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_22 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_22

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_22 and arg_274_1.time_ < var_277_15 + var_277_22 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play319591067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319591067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319591068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.15

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(319591067)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 46
				local var_281_5 = utf8.len(var_281_3)
				local var_281_6 = var_281_4 <= 0 and var_281_1 or var_281_1 * (var_281_5 / var_281_4)

				if var_281_6 > 0 and var_281_1 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_7 and arg_278_1.time_ < var_281_0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319591068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319591068
		arg_282_1.duration_ = 2.53

		local var_282_0 = {
			zh = 1.7,
			ja = 2.533
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319591069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1095ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1095ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0, -0.98, -6.1)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1095ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["1095ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1095ui_story == nil then
				arg_282_1.var_.characterEffect1095ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect1095ui_story and not isNil(var_285_9) then
					arg_282_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1095ui_story then
				arg_282_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_285_13 = 0

			if var_285_13 < arg_282_1.time_ and arg_282_1.time_ <= var_285_13 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_285_14 = 0

			if var_285_14 < arg_282_1.time_ and arg_282_1.time_ <= var_285_14 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_15 = 0
			local var_285_16 = 0.2

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_17 = arg_282_1:FormatText(StoryNameCfg[471].name)

				arg_282_1.leftNameTxt_.text = var_285_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_18 = arg_282_1:GetWordFromCfg(319591068)
				local var_285_19 = arg_282_1:FormatText(var_285_18.content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_20 = 8
				local var_285_21 = utf8.len(var_285_19)
				local var_285_22 = var_285_20 <= 0 and var_285_16 or var_285_16 * (var_285_21 / var_285_20)

				if var_285_22 > 0 and var_285_16 < var_285_22 then
					arg_282_1.talkMaxDuration = var_285_22

					if var_285_22 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_22 + var_285_15
					end
				end

				arg_282_1.text_.text = var_285_19
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591068", "story_v_out_319591.awb") ~= 0 then
					local var_285_23 = manager.audio:GetVoiceLength("story_v_out_319591", "319591068", "story_v_out_319591.awb") / 1000

					if var_285_23 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_15
					end

					if var_285_18.prefab_name ~= "" and arg_282_1.actors_[var_285_18.prefab_name] ~= nil then
						local var_285_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_18.prefab_name].transform, "story_v_out_319591", "319591068", "story_v_out_319591.awb")

						arg_282_1:RecordAudio("319591068", var_285_24)
						arg_282_1:RecordAudio("319591068", var_285_24)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319591", "319591068", "story_v_out_319591.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319591", "319591068", "story_v_out_319591.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_25 = math.max(var_285_16, arg_282_1.talkMaxDuration)

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_25 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_15) / var_285_25

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_15 + var_285_25 and arg_282_1.time_ < var_285_15 + var_285_25 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play319591069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319591069
		arg_286_1.duration_ = 4.53

		local var_286_0 = {
			zh = 3.6,
			ja = 4.533
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319591070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1095ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1095ui_story == nil then
				arg_286_1.var_.characterEffect1095ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect1095ui_story and not isNil(var_289_0) then
					local var_289_4 = Mathf.Lerp(0, 0.5, var_289_3)

					arg_286_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1095ui_story.fillRatio = var_289_4
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1095ui_story then
				local var_289_5 = 0.5

				arg_286_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1095ui_story.fillRatio = var_289_5
			end

			local var_289_6 = 0
			local var_289_7 = 0.5

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_8 = arg_286_1:FormatText(StoryNameCfg[694].name)

				arg_286_1.leftNameTxt_.text = var_289_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_9 = arg_286_1:GetWordFromCfg(319591069)
				local var_289_10 = arg_286_1:FormatText(var_289_9.content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 20
				local var_289_12 = utf8.len(var_289_10)
				local var_289_13 = var_289_11 <= 0 and var_289_7 or var_289_7 * (var_289_12 / var_289_11)

				if var_289_13 > 0 and var_289_7 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591069", "story_v_out_319591.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591069", "story_v_out_319591.awb") / 1000

					if var_289_14 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_6
					end

					if var_289_9.prefab_name ~= "" and arg_286_1.actors_[var_289_9.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_9.prefab_name].transform, "story_v_out_319591", "319591069", "story_v_out_319591.awb")

						arg_286_1:RecordAudio("319591069", var_289_15)
						arg_286_1:RecordAudio("319591069", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319591", "319591069", "story_v_out_319591.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319591", "319591069", "story_v_out_319591.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_16 and arg_286_1.time_ < var_289_6 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319591070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319591070
		arg_290_1.duration_ = 1.17

		local var_290_0 = {
			zh = 0.999999999999,
			ja = 1.166
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play319591071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1095ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1095ui_story == nil then
				arg_290_1.var_.characterEffect1095ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1095ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1095ui_story then
				arg_290_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_293_4 = 0
			local var_293_5 = 0.075

			if var_293_4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_6 = arg_290_1:FormatText(StoryNameCfg[471].name)

				arg_290_1.leftNameTxt_.text = var_293_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_7 = arg_290_1:GetWordFromCfg(319591070)
				local var_293_8 = arg_290_1:FormatText(var_293_7.content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_9 = 3
				local var_293_10 = utf8.len(var_293_8)
				local var_293_11 = var_293_9 <= 0 and var_293_5 or var_293_5 * (var_293_10 / var_293_9)

				if var_293_11 > 0 and var_293_5 < var_293_11 then
					arg_290_1.talkMaxDuration = var_293_11

					if var_293_11 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_4
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591070", "story_v_out_319591.awb") ~= 0 then
					local var_293_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591070", "story_v_out_319591.awb") / 1000

					if var_293_12 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_12 + var_293_4
					end

					if var_293_7.prefab_name ~= "" and arg_290_1.actors_[var_293_7.prefab_name] ~= nil then
						local var_293_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_7.prefab_name].transform, "story_v_out_319591", "319591070", "story_v_out_319591.awb")

						arg_290_1:RecordAudio("319591070", var_293_13)
						arg_290_1:RecordAudio("319591070", var_293_13)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319591", "319591070", "story_v_out_319591.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319591", "319591070", "story_v_out_319591.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_14 = math.max(var_293_5, arg_290_1.talkMaxDuration)

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_14 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_4) / var_293_14

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_4 + var_293_14 and arg_290_1.time_ < var_293_4 + var_293_14 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319591071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319591071
		arg_294_1.duration_ = 8.67

		local var_294_0 = {
			zh = 6.3,
			ja = 8.666
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319591072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["4037ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos4037ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0, -1.12, -6.2)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos4037ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["4037ui_story"]
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect4037ui_story == nil then
				arg_294_1.var_.characterEffect4037ui_story = var_297_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_11 = 0.200000002980232

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 and not isNil(var_297_9) then
				local var_297_12 = (arg_294_1.time_ - var_297_10) / var_297_11

				if arg_294_1.var_.characterEffect4037ui_story and not isNil(var_297_9) then
					arg_294_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect4037ui_story then
				arg_294_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_297_13 = 0

			if var_297_13 < arg_294_1.time_ and arg_294_1.time_ <= var_297_13 + arg_297_0 then
				arg_294_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_297_14 = 0

			if var_297_14 < arg_294_1.time_ and arg_294_1.time_ <= var_297_14 + arg_297_0 then
				arg_294_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_297_15 = arg_294_1.actors_["1095ui_story"].transform
			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.var_.moveOldPos1095ui_story = var_297_15.localPosition
			end

			local var_297_17 = 0.001

			if var_297_16 <= arg_294_1.time_ and arg_294_1.time_ < var_297_16 + var_297_17 then
				local var_297_18 = (arg_294_1.time_ - var_297_16) / var_297_17
				local var_297_19 = Vector3.New(0, 100, 0)

				var_297_15.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1095ui_story, var_297_19, var_297_18)

				local var_297_20 = manager.ui.mainCamera.transform.position - var_297_15.position

				var_297_15.forward = Vector3.New(var_297_20.x, var_297_20.y, var_297_20.z)

				local var_297_21 = var_297_15.localEulerAngles

				var_297_21.z = 0
				var_297_21.x = 0
				var_297_15.localEulerAngles = var_297_21
			end

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 then
				var_297_15.localPosition = Vector3.New(0, 100, 0)

				local var_297_22 = manager.ui.mainCamera.transform.position - var_297_15.position

				var_297_15.forward = Vector3.New(var_297_22.x, var_297_22.y, var_297_22.z)

				local var_297_23 = var_297_15.localEulerAngles

				var_297_23.z = 0
				var_297_23.x = 0
				var_297_15.localEulerAngles = var_297_23
			end

			local var_297_24 = arg_294_1.actors_["1095ui_story"]
			local var_297_25 = 0

			if var_297_25 < arg_294_1.time_ and arg_294_1.time_ <= var_297_25 + arg_297_0 and not isNil(var_297_24) and arg_294_1.var_.characterEffect1095ui_story == nil then
				arg_294_1.var_.characterEffect1095ui_story = var_297_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_26 = 0.200000002980232

			if var_297_25 <= arg_294_1.time_ and arg_294_1.time_ < var_297_25 + var_297_26 and not isNil(var_297_24) then
				local var_297_27 = (arg_294_1.time_ - var_297_25) / var_297_26

				if arg_294_1.var_.characterEffect1095ui_story and not isNil(var_297_24) then
					local var_297_28 = Mathf.Lerp(0, 0.5, var_297_27)

					arg_294_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1095ui_story.fillRatio = var_297_28
				end
			end

			if arg_294_1.time_ >= var_297_25 + var_297_26 and arg_294_1.time_ < var_297_25 + var_297_26 + arg_297_0 and not isNil(var_297_24) and arg_294_1.var_.characterEffect1095ui_story then
				local var_297_29 = 0.5

				arg_294_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1095ui_story.fillRatio = var_297_29
			end

			local var_297_30 = 0
			local var_297_31 = 0.525

			if var_297_30 < arg_294_1.time_ and arg_294_1.time_ <= var_297_30 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_32 = arg_294_1:FormatText(StoryNameCfg[453].name)

				arg_294_1.leftNameTxt_.text = var_297_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_33 = arg_294_1:GetWordFromCfg(319591071)
				local var_297_34 = arg_294_1:FormatText(var_297_33.content)

				arg_294_1.text_.text = var_297_34

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_35 = 21
				local var_297_36 = utf8.len(var_297_34)
				local var_297_37 = var_297_35 <= 0 and var_297_31 or var_297_31 * (var_297_36 / var_297_35)

				if var_297_37 > 0 and var_297_31 < var_297_37 then
					arg_294_1.talkMaxDuration = var_297_37

					if var_297_37 + var_297_30 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_37 + var_297_30
					end
				end

				arg_294_1.text_.text = var_297_34
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591071", "story_v_out_319591.awb") ~= 0 then
					local var_297_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591071", "story_v_out_319591.awb") / 1000

					if var_297_38 + var_297_30 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_38 + var_297_30
					end

					if var_297_33.prefab_name ~= "" and arg_294_1.actors_[var_297_33.prefab_name] ~= nil then
						local var_297_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_33.prefab_name].transform, "story_v_out_319591", "319591071", "story_v_out_319591.awb")

						arg_294_1:RecordAudio("319591071", var_297_39)
						arg_294_1:RecordAudio("319591071", var_297_39)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319591", "319591071", "story_v_out_319591.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319591", "319591071", "story_v_out_319591.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_40 = math.max(var_297_31, arg_294_1.talkMaxDuration)

			if var_297_30 <= arg_294_1.time_ and arg_294_1.time_ < var_297_30 + var_297_40 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_30) / var_297_40

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_30 + var_297_40 and arg_294_1.time_ < var_297_30 + var_297_40 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319591072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319591072
		arg_298_1.duration_ = 7.43

		local var_298_0 = {
			zh = 2.866,
			ja = 7.433
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319591073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["4040ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos4040ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, -1.55, -5.5)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos4040ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["4040ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect4040ui_story == nil then
				arg_298_1.var_.characterEffect4040ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.200000002980232

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect4040ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect4040ui_story then
				arg_298_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_301_13 = 0

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_301_14 = 0

			if var_301_14 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_301_15 = arg_298_1.actors_["4037ui_story"].transform
			local var_301_16 = 0

			if var_301_16 < arg_298_1.time_ and arg_298_1.time_ <= var_301_16 + arg_301_0 then
				arg_298_1.var_.moveOldPos4037ui_story = var_301_15.localPosition
			end

			local var_301_17 = 0.001

			if var_301_16 <= arg_298_1.time_ and arg_298_1.time_ < var_301_16 + var_301_17 then
				local var_301_18 = (arg_298_1.time_ - var_301_16) / var_301_17
				local var_301_19 = Vector3.New(0, 100, 0)

				var_301_15.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos4037ui_story, var_301_19, var_301_18)

				local var_301_20 = manager.ui.mainCamera.transform.position - var_301_15.position

				var_301_15.forward = Vector3.New(var_301_20.x, var_301_20.y, var_301_20.z)

				local var_301_21 = var_301_15.localEulerAngles

				var_301_21.z = 0
				var_301_21.x = 0
				var_301_15.localEulerAngles = var_301_21
			end

			if arg_298_1.time_ >= var_301_16 + var_301_17 and arg_298_1.time_ < var_301_16 + var_301_17 + arg_301_0 then
				var_301_15.localPosition = Vector3.New(0, 100, 0)

				local var_301_22 = manager.ui.mainCamera.transform.position - var_301_15.position

				var_301_15.forward = Vector3.New(var_301_22.x, var_301_22.y, var_301_22.z)

				local var_301_23 = var_301_15.localEulerAngles

				var_301_23.z = 0
				var_301_23.x = 0
				var_301_15.localEulerAngles = var_301_23
			end

			local var_301_24 = arg_298_1.actors_["4037ui_story"]
			local var_301_25 = 0

			if var_301_25 < arg_298_1.time_ and arg_298_1.time_ <= var_301_25 + arg_301_0 and not isNil(var_301_24) and arg_298_1.var_.characterEffect4037ui_story == nil then
				arg_298_1.var_.characterEffect4037ui_story = var_301_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_26 = 0.200000002980232

			if var_301_25 <= arg_298_1.time_ and arg_298_1.time_ < var_301_25 + var_301_26 and not isNil(var_301_24) then
				local var_301_27 = (arg_298_1.time_ - var_301_25) / var_301_26

				if arg_298_1.var_.characterEffect4037ui_story and not isNil(var_301_24) then
					local var_301_28 = Mathf.Lerp(0, 0.5, var_301_27)

					arg_298_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_298_1.var_.characterEffect4037ui_story.fillRatio = var_301_28
				end
			end

			if arg_298_1.time_ >= var_301_25 + var_301_26 and arg_298_1.time_ < var_301_25 + var_301_26 + arg_301_0 and not isNil(var_301_24) and arg_298_1.var_.characterEffect4037ui_story then
				local var_301_29 = 0.5

				arg_298_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_298_1.var_.characterEffect4037ui_story.fillRatio = var_301_29
			end

			local var_301_30 = 0
			local var_301_31 = 0.2

			if var_301_30 < arg_298_1.time_ and arg_298_1.time_ <= var_301_30 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_32 = arg_298_1:FormatText(StoryNameCfg[668].name)

				arg_298_1.leftNameTxt_.text = var_301_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_33 = arg_298_1:GetWordFromCfg(319591072)
				local var_301_34 = arg_298_1:FormatText(var_301_33.content)

				arg_298_1.text_.text = var_301_34

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_35 = 8
				local var_301_36 = utf8.len(var_301_34)
				local var_301_37 = var_301_35 <= 0 and var_301_31 or var_301_31 * (var_301_36 / var_301_35)

				if var_301_37 > 0 and var_301_31 < var_301_37 then
					arg_298_1.talkMaxDuration = var_301_37

					if var_301_37 + var_301_30 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_37 + var_301_30
					end
				end

				arg_298_1.text_.text = var_301_34
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591072", "story_v_out_319591.awb") ~= 0 then
					local var_301_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591072", "story_v_out_319591.awb") / 1000

					if var_301_38 + var_301_30 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_38 + var_301_30
					end

					if var_301_33.prefab_name ~= "" and arg_298_1.actors_[var_301_33.prefab_name] ~= nil then
						local var_301_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_33.prefab_name].transform, "story_v_out_319591", "319591072", "story_v_out_319591.awb")

						arg_298_1:RecordAudio("319591072", var_301_39)
						arg_298_1:RecordAudio("319591072", var_301_39)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_319591", "319591072", "story_v_out_319591.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_319591", "319591072", "story_v_out_319591.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_40 = math.max(var_301_31, arg_298_1.talkMaxDuration)

			if var_301_30 <= arg_298_1.time_ and arg_298_1.time_ < var_301_30 + var_301_40 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_30) / var_301_40

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_30 + var_301_40 and arg_298_1.time_ < var_301_30 + var_301_40 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play319591073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319591073
		arg_302_1.duration_ = 6.4

		local var_302_0 = {
			zh = 4.566,
			ja = 6.4
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319591074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1095ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1095ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0.7, -0.98, -6.1)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1095ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1095ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1095ui_story == nil then
				arg_302_1.var_.characterEffect1095ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1095ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1095ui_story then
				arg_302_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_305_15 = arg_302_1.actors_["4040ui_story"].transform
			local var_305_16 = 0

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.var_.moveOldPos4040ui_story = var_305_15.localPosition
			end

			local var_305_17 = 0.001

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_17 then
				local var_305_18 = (arg_302_1.time_ - var_305_16) / var_305_17
				local var_305_19 = Vector3.New(-0.7, -1.55, -5.5)

				var_305_15.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos4040ui_story, var_305_19, var_305_18)

				local var_305_20 = manager.ui.mainCamera.transform.position - var_305_15.position

				var_305_15.forward = Vector3.New(var_305_20.x, var_305_20.y, var_305_20.z)

				local var_305_21 = var_305_15.localEulerAngles

				var_305_21.z = 0
				var_305_21.x = 0
				var_305_15.localEulerAngles = var_305_21
			end

			if arg_302_1.time_ >= var_305_16 + var_305_17 and arg_302_1.time_ < var_305_16 + var_305_17 + arg_305_0 then
				var_305_15.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_305_22 = manager.ui.mainCamera.transform.position - var_305_15.position

				var_305_15.forward = Vector3.New(var_305_22.x, var_305_22.y, var_305_22.z)

				local var_305_23 = var_305_15.localEulerAngles

				var_305_23.z = 0
				var_305_23.x = 0
				var_305_15.localEulerAngles = var_305_23
			end

			local var_305_24 = arg_302_1.actors_["4040ui_story"]
			local var_305_25 = 0

			if var_305_25 < arg_302_1.time_ and arg_302_1.time_ <= var_305_25 + arg_305_0 and not isNil(var_305_24) and arg_302_1.var_.characterEffect4040ui_story == nil then
				arg_302_1.var_.characterEffect4040ui_story = var_305_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_26 = 0.200000002980232

			if var_305_25 <= arg_302_1.time_ and arg_302_1.time_ < var_305_25 + var_305_26 and not isNil(var_305_24) then
				local var_305_27 = (arg_302_1.time_ - var_305_25) / var_305_26

				if arg_302_1.var_.characterEffect4040ui_story and not isNil(var_305_24) then
					local var_305_28 = Mathf.Lerp(0, 0.5, var_305_27)

					arg_302_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_302_1.var_.characterEffect4040ui_story.fillRatio = var_305_28
				end
			end

			if arg_302_1.time_ >= var_305_25 + var_305_26 and arg_302_1.time_ < var_305_25 + var_305_26 + arg_305_0 and not isNil(var_305_24) and arg_302_1.var_.characterEffect4040ui_story then
				local var_305_29 = 0.5

				arg_302_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_302_1.var_.characterEffect4040ui_story.fillRatio = var_305_29
			end

			local var_305_30 = 0
			local var_305_31 = 0.375

			if var_305_30 < arg_302_1.time_ and arg_302_1.time_ <= var_305_30 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_32 = arg_302_1:FormatText(StoryNameCfg[471].name)

				arg_302_1.leftNameTxt_.text = var_305_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_33 = arg_302_1:GetWordFromCfg(319591073)
				local var_305_34 = arg_302_1:FormatText(var_305_33.content)

				arg_302_1.text_.text = var_305_34

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_35 = 15
				local var_305_36 = utf8.len(var_305_34)
				local var_305_37 = var_305_35 <= 0 and var_305_31 or var_305_31 * (var_305_36 / var_305_35)

				if var_305_37 > 0 and var_305_31 < var_305_37 then
					arg_302_1.talkMaxDuration = var_305_37

					if var_305_37 + var_305_30 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_37 + var_305_30
					end
				end

				arg_302_1.text_.text = var_305_34
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591073", "story_v_out_319591.awb") ~= 0 then
					local var_305_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591073", "story_v_out_319591.awb") / 1000

					if var_305_38 + var_305_30 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_38 + var_305_30
					end

					if var_305_33.prefab_name ~= "" and arg_302_1.actors_[var_305_33.prefab_name] ~= nil then
						local var_305_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_33.prefab_name].transform, "story_v_out_319591", "319591073", "story_v_out_319591.awb")

						arg_302_1:RecordAudio("319591073", var_305_39)
						arg_302_1:RecordAudio("319591073", var_305_39)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319591", "319591073", "story_v_out_319591.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319591", "319591073", "story_v_out_319591.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_40 = math.max(var_305_31, arg_302_1.talkMaxDuration)

			if var_305_30 <= arg_302_1.time_ and arg_302_1.time_ < var_305_30 + var_305_40 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_30) / var_305_40

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_30 + var_305_40 and arg_302_1.time_ < var_305_30 + var_305_40 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_302_1:InitPlayNodeList()
	end,
	Play319591074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319591074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319591075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1095ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1095ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(0, 100, 0)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1095ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, 100, 0)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1095ui_story"]
			local var_309_10 = 0

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1095ui_story == nil then
				arg_306_1.var_.characterEffect1095ui_story = var_309_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_11 = 0.200000002980232

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 and not isNil(var_309_9) then
				local var_309_12 = (arg_306_1.time_ - var_309_10) / var_309_11

				if arg_306_1.var_.characterEffect1095ui_story and not isNil(var_309_9) then
					local var_309_13 = Mathf.Lerp(0, 0.5, var_309_12)

					arg_306_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1095ui_story.fillRatio = var_309_13
				end
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1095ui_story then
				local var_309_14 = 0.5

				arg_306_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1095ui_story.fillRatio = var_309_14
			end

			local var_309_15 = arg_306_1.actors_["4040ui_story"].transform
			local var_309_16 = 0

			if var_309_16 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.var_.moveOldPos4040ui_story = var_309_15.localPosition
			end

			local var_309_17 = 0.001

			if var_309_16 <= arg_306_1.time_ and arg_306_1.time_ < var_309_16 + var_309_17 then
				local var_309_18 = (arg_306_1.time_ - var_309_16) / var_309_17
				local var_309_19 = Vector3.New(0, 100, 0)

				var_309_15.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos4040ui_story, var_309_19, var_309_18)

				local var_309_20 = manager.ui.mainCamera.transform.position - var_309_15.position

				var_309_15.forward = Vector3.New(var_309_20.x, var_309_20.y, var_309_20.z)

				local var_309_21 = var_309_15.localEulerAngles

				var_309_21.z = 0
				var_309_21.x = 0
				var_309_15.localEulerAngles = var_309_21
			end

			if arg_306_1.time_ >= var_309_16 + var_309_17 and arg_306_1.time_ < var_309_16 + var_309_17 + arg_309_0 then
				var_309_15.localPosition = Vector3.New(0, 100, 0)

				local var_309_22 = manager.ui.mainCamera.transform.position - var_309_15.position

				var_309_15.forward = Vector3.New(var_309_22.x, var_309_22.y, var_309_22.z)

				local var_309_23 = var_309_15.localEulerAngles

				var_309_23.z = 0
				var_309_23.x = 0
				var_309_15.localEulerAngles = var_309_23
			end

			local var_309_24 = arg_306_1.actors_["4040ui_story"]
			local var_309_25 = 0

			if var_309_25 < arg_306_1.time_ and arg_306_1.time_ <= var_309_25 + arg_309_0 and not isNil(var_309_24) and arg_306_1.var_.characterEffect4040ui_story == nil then
				arg_306_1.var_.characterEffect4040ui_story = var_309_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_26 = 0.200000002980232

			if var_309_25 <= arg_306_1.time_ and arg_306_1.time_ < var_309_25 + var_309_26 and not isNil(var_309_24) then
				local var_309_27 = (arg_306_1.time_ - var_309_25) / var_309_26

				if arg_306_1.var_.characterEffect4040ui_story and not isNil(var_309_24) then
					local var_309_28 = Mathf.Lerp(0, 0.5, var_309_27)

					arg_306_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_306_1.var_.characterEffect4040ui_story.fillRatio = var_309_28
				end
			end

			if arg_306_1.time_ >= var_309_25 + var_309_26 and arg_306_1.time_ < var_309_25 + var_309_26 + arg_309_0 and not isNil(var_309_24) and arg_306_1.var_.characterEffect4040ui_story then
				local var_309_29 = 0.5

				arg_306_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_306_1.var_.characterEffect4040ui_story.fillRatio = var_309_29
			end

			local var_309_30 = 0
			local var_309_31 = 1.35

			if var_309_30 < arg_306_1.time_ and arg_306_1.time_ <= var_309_30 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_32 = arg_306_1:GetWordFromCfg(319591074)
				local var_309_33 = arg_306_1:FormatText(var_309_32.content)

				arg_306_1.text_.text = var_309_33

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_34 = 54
				local var_309_35 = utf8.len(var_309_33)
				local var_309_36 = var_309_34 <= 0 and var_309_31 or var_309_31 * (var_309_35 / var_309_34)

				if var_309_36 > 0 and var_309_31 < var_309_36 then
					arg_306_1.talkMaxDuration = var_309_36

					if var_309_36 + var_309_30 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_36 + var_309_30
					end
				end

				arg_306_1.text_.text = var_309_33
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_37 = math.max(var_309_31, arg_306_1.talkMaxDuration)

			if var_309_30 <= arg_306_1.time_ and arg_306_1.time_ < var_309_30 + var_309_37 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_30) / var_309_37

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_30 + var_309_37 and arg_306_1.time_ < var_309_30 + var_309_37 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_306_1:InitPlayNodeList()
	end,
	Play319591075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 319591075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play319591076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 1.05

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(319591075)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 42
				local var_313_5 = utf8.len(var_313_3)
				local var_313_6 = var_313_4 <= 0 and var_313_1 or var_313_1 * (var_313_5 / var_313_4)

				if var_313_6 > 0 and var_313_1 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_7 and arg_310_1.time_ < var_313_0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play319591076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 319591076
		arg_314_1.duration_ = 3.23

		local var_314_0 = {
			zh = 2.5,
			ja = 3.233
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play319591077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10079ui_story"].transform
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos10079ui_story = var_317_0.localPosition

				local var_317_2 = "10079ui_story"

				arg_314_1:ShowWeapon(arg_314_1.var_[var_317_2 .. "Animator"].transform, false)
			end

			local var_317_3 = 0.001

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_3 then
				local var_317_4 = (arg_314_1.time_ - var_317_1) / var_317_3
				local var_317_5 = Vector3.New(0, -0.95, -6.05)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10079ui_story, var_317_5, var_317_4)

				local var_317_6 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_6.x, var_317_6.y, var_317_6.z)

				local var_317_7 = var_317_0.localEulerAngles

				var_317_7.z = 0
				var_317_7.x = 0
				var_317_0.localEulerAngles = var_317_7
			end

			if arg_314_1.time_ >= var_317_1 + var_317_3 and arg_314_1.time_ < var_317_1 + var_317_3 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_317_8 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_8.x, var_317_8.y, var_317_8.z)

				local var_317_9 = var_317_0.localEulerAngles

				var_317_9.z = 0
				var_317_9.x = 0
				var_317_0.localEulerAngles = var_317_9
			end

			local var_317_10 = arg_314_1.actors_["10079ui_story"]
			local var_317_11 = 0

			if var_317_11 < arg_314_1.time_ and arg_314_1.time_ <= var_317_11 + arg_317_0 and not isNil(var_317_10) and arg_314_1.var_.characterEffect10079ui_story == nil then
				arg_314_1.var_.characterEffect10079ui_story = var_317_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_12 = 0.200000002980232

			if var_317_11 <= arg_314_1.time_ and arg_314_1.time_ < var_317_11 + var_317_12 and not isNil(var_317_10) then
				local var_317_13 = (arg_314_1.time_ - var_317_11) / var_317_12

				if arg_314_1.var_.characterEffect10079ui_story and not isNil(var_317_10) then
					arg_314_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_11 + var_317_12 and arg_314_1.time_ < var_317_11 + var_317_12 + arg_317_0 and not isNil(var_317_10) and arg_314_1.var_.characterEffect10079ui_story then
				arg_314_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_317_14 = 0

			if var_317_14 < arg_314_1.time_ and arg_314_1.time_ <= var_317_14 + arg_317_0 then
				arg_314_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_317_15 = 0

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 then
				arg_314_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_317_16 = 0
			local var_317_17 = 0.3

			if var_317_16 < arg_314_1.time_ and arg_314_1.time_ <= var_317_16 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_18 = arg_314_1:FormatText(StoryNameCfg[6].name)

				arg_314_1.leftNameTxt_.text = var_317_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_19 = arg_314_1:GetWordFromCfg(319591076)
				local var_317_20 = arg_314_1:FormatText(var_317_19.content)

				arg_314_1.text_.text = var_317_20

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_21 = 12
				local var_317_22 = utf8.len(var_317_20)
				local var_317_23 = var_317_21 <= 0 and var_317_17 or var_317_17 * (var_317_22 / var_317_21)

				if var_317_23 > 0 and var_317_17 < var_317_23 then
					arg_314_1.talkMaxDuration = var_317_23

					if var_317_23 + var_317_16 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_23 + var_317_16
					end
				end

				arg_314_1.text_.text = var_317_20
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591076", "story_v_out_319591.awb") ~= 0 then
					local var_317_24 = manager.audio:GetVoiceLength("story_v_out_319591", "319591076", "story_v_out_319591.awb") / 1000

					if var_317_24 + var_317_16 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_24 + var_317_16
					end

					if var_317_19.prefab_name ~= "" and arg_314_1.actors_[var_317_19.prefab_name] ~= nil then
						local var_317_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_19.prefab_name].transform, "story_v_out_319591", "319591076", "story_v_out_319591.awb")

						arg_314_1:RecordAudio("319591076", var_317_25)
						arg_314_1:RecordAudio("319591076", var_317_25)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_319591", "319591076", "story_v_out_319591.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_319591", "319591076", "story_v_out_319591.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_26 = math.max(var_317_17, arg_314_1.talkMaxDuration)

			if var_317_16 <= arg_314_1.time_ and arg_314_1.time_ < var_317_16 + var_317_26 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_16) / var_317_26

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_16 + var_317_26 and arg_314_1.time_ < var_317_16 + var_317_26 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play319591077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319591077
		arg_318_1.duration_ = 7.83

		local var_318_0 = {
			zh = 5.433,
			ja = 7.833
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319591078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["10079ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos10079ui_story = var_321_0.localPosition
			end

			local var_321_2 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2
				local var_321_4 = Vector3.New(0, 100, 0)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos10079ui_story, var_321_4, var_321_3)

				local var_321_5 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_5.x, var_321_5.y, var_321_5.z)

				local var_321_6 = var_321_0.localEulerAngles

				var_321_6.z = 0
				var_321_6.x = 0
				var_321_0.localEulerAngles = var_321_6
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, 100, 0)

				local var_321_7 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_7.x, var_321_7.y, var_321_7.z)

				local var_321_8 = var_321_0.localEulerAngles

				var_321_8.z = 0
				var_321_8.x = 0
				var_321_0.localEulerAngles = var_321_8
			end

			local var_321_9 = arg_318_1.actors_["10079ui_story"]
			local var_321_10 = 0

			if var_321_10 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 and not isNil(var_321_9) and arg_318_1.var_.characterEffect10079ui_story == nil then
				arg_318_1.var_.characterEffect10079ui_story = var_321_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_11 = 0.200000002980232

			if var_321_10 <= arg_318_1.time_ and arg_318_1.time_ < var_321_10 + var_321_11 and not isNil(var_321_9) then
				local var_321_12 = (arg_318_1.time_ - var_321_10) / var_321_11

				if arg_318_1.var_.characterEffect10079ui_story and not isNil(var_321_9) then
					local var_321_13 = Mathf.Lerp(0, 0.5, var_321_12)

					arg_318_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10079ui_story.fillRatio = var_321_13
				end
			end

			if arg_318_1.time_ >= var_321_10 + var_321_11 and arg_318_1.time_ < var_321_10 + var_321_11 + arg_321_0 and not isNil(var_321_9) and arg_318_1.var_.characterEffect10079ui_story then
				local var_321_14 = 0.5

				arg_318_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10079ui_story.fillRatio = var_321_14
			end

			local var_321_15 = arg_318_1.actors_["4040ui_story"].transform
			local var_321_16 = 0

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.var_.moveOldPos4040ui_story = var_321_15.localPosition
			end

			local var_321_17 = 0.001

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_17 then
				local var_321_18 = (arg_318_1.time_ - var_321_16) / var_321_17
				local var_321_19 = Vector3.New(0, -1.55, -5.5)

				var_321_15.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos4040ui_story, var_321_19, var_321_18)

				local var_321_20 = manager.ui.mainCamera.transform.position - var_321_15.position

				var_321_15.forward = Vector3.New(var_321_20.x, var_321_20.y, var_321_20.z)

				local var_321_21 = var_321_15.localEulerAngles

				var_321_21.z = 0
				var_321_21.x = 0
				var_321_15.localEulerAngles = var_321_21
			end

			if arg_318_1.time_ >= var_321_16 + var_321_17 and arg_318_1.time_ < var_321_16 + var_321_17 + arg_321_0 then
				var_321_15.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_321_22 = manager.ui.mainCamera.transform.position - var_321_15.position

				var_321_15.forward = Vector3.New(var_321_22.x, var_321_22.y, var_321_22.z)

				local var_321_23 = var_321_15.localEulerAngles

				var_321_23.z = 0
				var_321_23.x = 0
				var_321_15.localEulerAngles = var_321_23
			end

			local var_321_24 = arg_318_1.actors_["4040ui_story"]
			local var_321_25 = 0

			if var_321_25 < arg_318_1.time_ and arg_318_1.time_ <= var_321_25 + arg_321_0 and not isNil(var_321_24) and arg_318_1.var_.characterEffect4040ui_story == nil then
				arg_318_1.var_.characterEffect4040ui_story = var_321_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_26 = 0.200000002980232

			if var_321_25 <= arg_318_1.time_ and arg_318_1.time_ < var_321_25 + var_321_26 and not isNil(var_321_24) then
				local var_321_27 = (arg_318_1.time_ - var_321_25) / var_321_26

				if arg_318_1.var_.characterEffect4040ui_story and not isNil(var_321_24) then
					arg_318_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_25 + var_321_26 and arg_318_1.time_ < var_321_25 + var_321_26 + arg_321_0 and not isNil(var_321_24) and arg_318_1.var_.characterEffect4040ui_story then
				arg_318_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_321_28 = 0

			if var_321_28 < arg_318_1.time_ and arg_318_1.time_ <= var_321_28 + arg_321_0 then
				arg_318_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_321_29 = 0

			if var_321_29 < arg_318_1.time_ and arg_318_1.time_ <= var_321_29 + arg_321_0 then
				arg_318_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_321_30 = 0
			local var_321_31 = 0.475

			if var_321_30 < arg_318_1.time_ and arg_318_1.time_ <= var_321_30 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_32 = arg_318_1:FormatText(StoryNameCfg[668].name)

				arg_318_1.leftNameTxt_.text = var_321_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_33 = arg_318_1:GetWordFromCfg(319591077)
				local var_321_34 = arg_318_1:FormatText(var_321_33.content)

				arg_318_1.text_.text = var_321_34

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_35 = 19
				local var_321_36 = utf8.len(var_321_34)
				local var_321_37 = var_321_35 <= 0 and var_321_31 or var_321_31 * (var_321_36 / var_321_35)

				if var_321_37 > 0 and var_321_31 < var_321_37 then
					arg_318_1.talkMaxDuration = var_321_37

					if var_321_37 + var_321_30 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_37 + var_321_30
					end
				end

				arg_318_1.text_.text = var_321_34
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591077", "story_v_out_319591.awb") ~= 0 then
					local var_321_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591077", "story_v_out_319591.awb") / 1000

					if var_321_38 + var_321_30 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_38 + var_321_30
					end

					if var_321_33.prefab_name ~= "" and arg_318_1.actors_[var_321_33.prefab_name] ~= nil then
						local var_321_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_33.prefab_name].transform, "story_v_out_319591", "319591077", "story_v_out_319591.awb")

						arg_318_1:RecordAudio("319591077", var_321_39)
						arg_318_1:RecordAudio("319591077", var_321_39)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_319591", "319591077", "story_v_out_319591.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_319591", "319591077", "story_v_out_319591.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_40 = math.max(var_321_31, arg_318_1.talkMaxDuration)

			if var_321_30 <= arg_318_1.time_ and arg_318_1.time_ < var_321_30 + var_321_40 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_30) / var_321_40

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_30 + var_321_40 and arg_318_1.time_ < var_321_30 + var_321_40 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_318_1:InitPlayNodeList()
	end,
	Play319591078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319591078
		arg_322_1.duration_ = 6.1

		local var_322_0 = {
			zh = 4.066,
			ja = 6.1
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319591079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1095ui_story"].transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.var_.moveOldPos1095ui_story = var_325_0.localPosition
			end

			local var_325_2 = 0.001

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2
				local var_325_4 = Vector3.New(0, -0.98, -6.1)

				var_325_0.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1095ui_story, var_325_4, var_325_3)

				local var_325_5 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_5.x, var_325_5.y, var_325_5.z)

				local var_325_6 = var_325_0.localEulerAngles

				var_325_6.z = 0
				var_325_6.x = 0
				var_325_0.localEulerAngles = var_325_6
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 then
				var_325_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_325_7 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_7.x, var_325_7.y, var_325_7.z)

				local var_325_8 = var_325_0.localEulerAngles

				var_325_8.z = 0
				var_325_8.x = 0
				var_325_0.localEulerAngles = var_325_8
			end

			local var_325_9 = arg_322_1.actors_["1095ui_story"]
			local var_325_10 = 0

			if var_325_10 < arg_322_1.time_ and arg_322_1.time_ <= var_325_10 + arg_325_0 and not isNil(var_325_9) and arg_322_1.var_.characterEffect1095ui_story == nil then
				arg_322_1.var_.characterEffect1095ui_story = var_325_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_11 = 0.200000002980232

			if var_325_10 <= arg_322_1.time_ and arg_322_1.time_ < var_325_10 + var_325_11 and not isNil(var_325_9) then
				local var_325_12 = (arg_322_1.time_ - var_325_10) / var_325_11

				if arg_322_1.var_.characterEffect1095ui_story and not isNil(var_325_9) then
					arg_322_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_10 + var_325_11 and arg_322_1.time_ < var_325_10 + var_325_11 + arg_325_0 and not isNil(var_325_9) and arg_322_1.var_.characterEffect1095ui_story then
				arg_322_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_325_13 = 0

			if var_325_13 < arg_322_1.time_ and arg_322_1.time_ <= var_325_13 + arg_325_0 then
				arg_322_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_325_14 = 0

			if var_325_14 < arg_322_1.time_ and arg_322_1.time_ <= var_325_14 + arg_325_0 then
				arg_322_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_325_15 = arg_322_1.actors_["4040ui_story"]
			local var_325_16 = 0

			if var_325_16 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 and not isNil(var_325_15) and arg_322_1.var_.characterEffect4040ui_story == nil then
				arg_322_1.var_.characterEffect4040ui_story = var_325_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_17 = 0.200000002980232

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_17 and not isNil(var_325_15) then
				local var_325_18 = (arg_322_1.time_ - var_325_16) / var_325_17

				if arg_322_1.var_.characterEffect4040ui_story and not isNil(var_325_15) then
					local var_325_19 = Mathf.Lerp(0, 0.5, var_325_18)

					arg_322_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_322_1.var_.characterEffect4040ui_story.fillRatio = var_325_19
				end
			end

			if arg_322_1.time_ >= var_325_16 + var_325_17 and arg_322_1.time_ < var_325_16 + var_325_17 + arg_325_0 and not isNil(var_325_15) and arg_322_1.var_.characterEffect4040ui_story then
				local var_325_20 = 0.5

				arg_322_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_322_1.var_.characterEffect4040ui_story.fillRatio = var_325_20
			end

			local var_325_21 = arg_322_1.actors_["4040ui_story"].transform
			local var_325_22 = 0

			if var_325_22 < arg_322_1.time_ and arg_322_1.time_ <= var_325_22 + arg_325_0 then
				arg_322_1.var_.moveOldPos4040ui_story = var_325_21.localPosition
			end

			local var_325_23 = 0.001

			if var_325_22 <= arg_322_1.time_ and arg_322_1.time_ < var_325_22 + var_325_23 then
				local var_325_24 = (arg_322_1.time_ - var_325_22) / var_325_23
				local var_325_25 = Vector3.New(0, 100, 0)

				var_325_21.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos4040ui_story, var_325_25, var_325_24)

				local var_325_26 = manager.ui.mainCamera.transform.position - var_325_21.position

				var_325_21.forward = Vector3.New(var_325_26.x, var_325_26.y, var_325_26.z)

				local var_325_27 = var_325_21.localEulerAngles

				var_325_27.z = 0
				var_325_27.x = 0
				var_325_21.localEulerAngles = var_325_27
			end

			if arg_322_1.time_ >= var_325_22 + var_325_23 and arg_322_1.time_ < var_325_22 + var_325_23 + arg_325_0 then
				var_325_21.localPosition = Vector3.New(0, 100, 0)

				local var_325_28 = manager.ui.mainCamera.transform.position - var_325_21.position

				var_325_21.forward = Vector3.New(var_325_28.x, var_325_28.y, var_325_28.z)

				local var_325_29 = var_325_21.localEulerAngles

				var_325_29.z = 0
				var_325_29.x = 0
				var_325_21.localEulerAngles = var_325_29
			end

			local var_325_30 = 0
			local var_325_31 = 0.4

			if var_325_30 < arg_322_1.time_ and arg_322_1.time_ <= var_325_30 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_32 = arg_322_1:FormatText(StoryNameCfg[471].name)

				arg_322_1.leftNameTxt_.text = var_325_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_33 = arg_322_1:GetWordFromCfg(319591078)
				local var_325_34 = arg_322_1:FormatText(var_325_33.content)

				arg_322_1.text_.text = var_325_34

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_35 = 16
				local var_325_36 = utf8.len(var_325_34)
				local var_325_37 = var_325_35 <= 0 and var_325_31 or var_325_31 * (var_325_36 / var_325_35)

				if var_325_37 > 0 and var_325_31 < var_325_37 then
					arg_322_1.talkMaxDuration = var_325_37

					if var_325_37 + var_325_30 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_37 + var_325_30
					end
				end

				arg_322_1.text_.text = var_325_34
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591078", "story_v_out_319591.awb") ~= 0 then
					local var_325_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591078", "story_v_out_319591.awb") / 1000

					if var_325_38 + var_325_30 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_38 + var_325_30
					end

					if var_325_33.prefab_name ~= "" and arg_322_1.actors_[var_325_33.prefab_name] ~= nil then
						local var_325_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_33.prefab_name].transform, "story_v_out_319591", "319591078", "story_v_out_319591.awb")

						arg_322_1:RecordAudio("319591078", var_325_39)
						arg_322_1:RecordAudio("319591078", var_325_39)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_319591", "319591078", "story_v_out_319591.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_319591", "319591078", "story_v_out_319591.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_40 = math.max(var_325_31, arg_322_1.talkMaxDuration)

			if var_325_30 <= arg_322_1.time_ and arg_322_1.time_ < var_325_30 + var_325_40 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_30) / var_325_40

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_30 + var_325_40 and arg_322_1.time_ < var_325_30 + var_325_40 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_322_1:InitPlayNodeList()
	end,
	Play319591079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319591079
		arg_326_1.duration_ = 5.63

		local var_326_0 = {
			zh = 5.266,
			ja = 5.633
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319591080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["4040ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos4040ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(0, -1.55, -5.5)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos4040ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = arg_326_1.actors_["4040ui_story"]
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect4040ui_story == nil then
				arg_326_1.var_.characterEffect4040ui_story = var_329_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_11 = 0.200000002980232

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 and not isNil(var_329_9) then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / var_329_11

				if arg_326_1.var_.characterEffect4040ui_story and not isNil(var_329_9) then
					arg_326_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect4040ui_story then
				arg_326_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_329_13 = 0

			if var_329_13 < arg_326_1.time_ and arg_326_1.time_ <= var_329_13 + arg_329_0 then
				arg_326_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_329_14 = 0

			if var_329_14 < arg_326_1.time_ and arg_326_1.time_ <= var_329_14 + arg_329_0 then
				arg_326_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_329_15 = arg_326_1.actors_["1095ui_story"].transform
			local var_329_16 = 0

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 then
				arg_326_1.var_.moveOldPos1095ui_story = var_329_15.localPosition
			end

			local var_329_17 = 0.001

			if var_329_16 <= arg_326_1.time_ and arg_326_1.time_ < var_329_16 + var_329_17 then
				local var_329_18 = (arg_326_1.time_ - var_329_16) / var_329_17
				local var_329_19 = Vector3.New(0, 100, 0)

				var_329_15.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1095ui_story, var_329_19, var_329_18)

				local var_329_20 = manager.ui.mainCamera.transform.position - var_329_15.position

				var_329_15.forward = Vector3.New(var_329_20.x, var_329_20.y, var_329_20.z)

				local var_329_21 = var_329_15.localEulerAngles

				var_329_21.z = 0
				var_329_21.x = 0
				var_329_15.localEulerAngles = var_329_21
			end

			if arg_326_1.time_ >= var_329_16 + var_329_17 and arg_326_1.time_ < var_329_16 + var_329_17 + arg_329_0 then
				var_329_15.localPosition = Vector3.New(0, 100, 0)

				local var_329_22 = manager.ui.mainCamera.transform.position - var_329_15.position

				var_329_15.forward = Vector3.New(var_329_22.x, var_329_22.y, var_329_22.z)

				local var_329_23 = var_329_15.localEulerAngles

				var_329_23.z = 0
				var_329_23.x = 0
				var_329_15.localEulerAngles = var_329_23
			end

			local var_329_24 = arg_326_1.actors_["1095ui_story"]
			local var_329_25 = 0

			if var_329_25 < arg_326_1.time_ and arg_326_1.time_ <= var_329_25 + arg_329_0 and not isNil(var_329_24) and arg_326_1.var_.characterEffect1095ui_story == nil then
				arg_326_1.var_.characterEffect1095ui_story = var_329_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_26 = 0.200000002980232

			if var_329_25 <= arg_326_1.time_ and arg_326_1.time_ < var_329_25 + var_329_26 and not isNil(var_329_24) then
				local var_329_27 = (arg_326_1.time_ - var_329_25) / var_329_26

				if arg_326_1.var_.characterEffect1095ui_story and not isNil(var_329_24) then
					local var_329_28 = Mathf.Lerp(0, 0.5, var_329_27)

					arg_326_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1095ui_story.fillRatio = var_329_28
				end
			end

			if arg_326_1.time_ >= var_329_25 + var_329_26 and arg_326_1.time_ < var_329_25 + var_329_26 + arg_329_0 and not isNil(var_329_24) and arg_326_1.var_.characterEffect1095ui_story then
				local var_329_29 = 0.5

				arg_326_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1095ui_story.fillRatio = var_329_29
			end

			local var_329_30 = 0
			local var_329_31 = 0.3

			if var_329_30 < arg_326_1.time_ and arg_326_1.time_ <= var_329_30 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_32 = arg_326_1:FormatText(StoryNameCfg[668].name)

				arg_326_1.leftNameTxt_.text = var_329_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_33 = arg_326_1:GetWordFromCfg(319591079)
				local var_329_34 = arg_326_1:FormatText(var_329_33.content)

				arg_326_1.text_.text = var_329_34

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_35 = 12
				local var_329_36 = utf8.len(var_329_34)
				local var_329_37 = var_329_35 <= 0 and var_329_31 or var_329_31 * (var_329_36 / var_329_35)

				if var_329_37 > 0 and var_329_31 < var_329_37 then
					arg_326_1.talkMaxDuration = var_329_37

					if var_329_37 + var_329_30 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_37 + var_329_30
					end
				end

				arg_326_1.text_.text = var_329_34
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591079", "story_v_out_319591.awb") ~= 0 then
					local var_329_38 = manager.audio:GetVoiceLength("story_v_out_319591", "319591079", "story_v_out_319591.awb") / 1000

					if var_329_38 + var_329_30 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_38 + var_329_30
					end

					if var_329_33.prefab_name ~= "" and arg_326_1.actors_[var_329_33.prefab_name] ~= nil then
						local var_329_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_33.prefab_name].transform, "story_v_out_319591", "319591079", "story_v_out_319591.awb")

						arg_326_1:RecordAudio("319591079", var_329_39)
						arg_326_1:RecordAudio("319591079", var_329_39)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_319591", "319591079", "story_v_out_319591.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_319591", "319591079", "story_v_out_319591.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_40 = math.max(var_329_31, arg_326_1.talkMaxDuration)

			if var_329_30 <= arg_326_1.time_ and arg_326_1.time_ < var_329_30 + var_329_40 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_30) / var_329_40

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_30 + var_329_40 and arg_326_1.time_ < var_329_30 + var_329_40 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play319591080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319591080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319591081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["4040ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect4040ui_story == nil then
				arg_330_1.var_.characterEffect4040ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect4040ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_330_1.var_.characterEffect4040ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect4040ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_330_1.var_.characterEffect4040ui_story.fillRatio = var_333_5
			end

			local var_333_6 = 0

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_333_7 = 0
			local var_333_8 = 0.775

			if var_333_7 < arg_330_1.time_ and arg_330_1.time_ <= var_333_7 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_9 = arg_330_1:GetWordFromCfg(319591080)
				local var_333_10 = arg_330_1:FormatText(var_333_9.content)

				arg_330_1.text_.text = var_333_10

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_11 = 31
				local var_333_12 = utf8.len(var_333_10)
				local var_333_13 = var_333_11 <= 0 and var_333_8 or var_333_8 * (var_333_12 / var_333_11)

				if var_333_13 > 0 and var_333_8 < var_333_13 then
					arg_330_1.talkMaxDuration = var_333_13

					if var_333_13 + var_333_7 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_7
					end
				end

				arg_330_1.text_.text = var_333_10
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_14 = math.max(var_333_8, arg_330_1.talkMaxDuration)

			if var_333_7 <= arg_330_1.time_ and arg_330_1.time_ < var_333_7 + var_333_14 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_7) / var_333_14

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_7 + var_333_14 and arg_330_1.time_ < var_333_7 + var_333_14 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319591081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319591081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319591082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["4040ui_story"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos4040ui_story = var_337_0.localPosition
			end

			local var_337_2 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2
				local var_337_4 = Vector3.New(0, 100, 0)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos4040ui_story, var_337_4, var_337_3)

				local var_337_5 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_5.x, var_337_5.y, var_337_5.z)

				local var_337_6 = var_337_0.localEulerAngles

				var_337_6.z = 0
				var_337_6.x = 0
				var_337_0.localEulerAngles = var_337_6
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(0, 100, 0)

				local var_337_7 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_7.x, var_337_7.y, var_337_7.z)

				local var_337_8 = var_337_0.localEulerAngles

				var_337_8.z = 0
				var_337_8.x = 0
				var_337_0.localEulerAngles = var_337_8
			end

			local var_337_9 = manager.ui.mainCamera.transform
			local var_337_10 = 0

			if var_337_10 < arg_334_1.time_ and arg_334_1.time_ <= var_337_10 + arg_337_0 then
				arg_334_1.var_.shakeOldPos = var_337_9.localPosition
			end

			local var_337_11 = 0.6

			if var_337_10 <= arg_334_1.time_ and arg_334_1.time_ < var_337_10 + var_337_11 then
				local var_337_12 = (arg_334_1.time_ - var_337_10) / 0.066
				local var_337_13, var_337_14 = math.modf(var_337_12)

				var_337_9.localPosition = Vector3.New(var_337_14 * 0.13, var_337_14 * 0.13, var_337_14 * 0.13) + arg_334_1.var_.shakeOldPos
			end

			if arg_334_1.time_ >= var_337_10 + var_337_11 and arg_334_1.time_ < var_337_10 + var_337_11 + arg_337_0 then
				var_337_9.localPosition = arg_334_1.var_.shakeOldPos
			end

			local var_337_15 = 0

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			local var_337_16 = 0.6

			if arg_334_1.time_ >= var_337_15 + var_337_16 and arg_334_1.time_ < var_337_15 + var_337_16 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_17 = 0
			local var_337_18 = 1

			if var_337_17 < arg_334_1.time_ and arg_334_1.time_ <= var_337_17 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_19 = arg_334_1:GetWordFromCfg(319591081)
				local var_337_20 = arg_334_1:FormatText(var_337_19.content)

				arg_334_1.text_.text = var_337_20

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_21 = 40
				local var_337_22 = utf8.len(var_337_20)
				local var_337_23 = var_337_21 <= 0 and var_337_18 or var_337_18 * (var_337_22 / var_337_21)

				if var_337_23 > 0 and var_337_18 < var_337_23 then
					arg_334_1.talkMaxDuration = var_337_23

					if var_337_23 + var_337_17 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_23 + var_337_17
					end
				end

				arg_334_1.text_.text = var_337_20
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_24 = math.max(var_337_18, arg_334_1.talkMaxDuration)

			if var_337_17 <= arg_334_1.time_ and arg_334_1.time_ < var_337_17 + var_337_24 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_17) / var_337_24

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_17 + var_337_24 and arg_334_1.time_ < var_337_17 + var_337_24 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play319591082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 319591082
		arg_338_1.duration_ = 2.83

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play319591083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = "STblack"

			if arg_338_1.bgs_[var_341_0] == nil then
				local var_341_1 = Object.Instantiate(arg_338_1.paintGo_)

				var_341_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_341_0)
				var_341_1.name = var_341_0
				var_341_1.transform.parent = arg_338_1.stage_.transform
				var_341_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.bgs_[var_341_0] = var_341_1
			end

			local var_341_2 = 0

			if var_341_2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				local var_341_3 = manager.ui.mainCamera.transform.localPosition
				local var_341_4 = Vector3.New(0, 0, 10) + Vector3.New(var_341_3.x, var_341_3.y, 0)
				local var_341_5 = arg_338_1.bgs_.STblack

				var_341_5.transform.localPosition = var_341_4
				var_341_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_6 = var_341_5:GetComponent("SpriteRenderer")

				if var_341_6 and var_341_6.sprite then
					local var_341_7 = (var_341_5.transform.localPosition - var_341_3).z
					local var_341_8 = manager.ui.mainCameraCom_
					local var_341_9 = 2 * var_341_7 * Mathf.Tan(var_341_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_341_10 = var_341_9 * var_341_8.aspect
					local var_341_11 = var_341_6.sprite.bounds.size.x
					local var_341_12 = var_341_6.sprite.bounds.size.y
					local var_341_13 = var_341_10 / var_341_11
					local var_341_14 = var_341_9 / var_341_12
					local var_341_15 = var_341_14 < var_341_13 and var_341_13 or var_341_14

					var_341_5.transform.localScale = Vector3.New(var_341_15, var_341_15, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "STblack" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_16 = 0

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				local var_341_17 = arg_338_1.fswbg_.transform:Find("textbox/adapt/content") or arg_338_1.fswbg_.transform:Find("textbox/content")
				local var_341_18 = arg_338_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_341_19 = var_341_17:GetComponent("Text")
				local var_341_20 = var_341_17:GetComponent("RectTransform")

				var_341_19.alignment = UnityEngine.TextAnchor.LowerCenter
				var_341_20.offsetMin = Vector2.New(0, 0)
				var_341_20.offsetMax = Vector2.New(0, 0)
			end

			local var_341_21 = 0

			if var_341_21 < arg_338_1.time_ and arg_338_1.time_ <= var_341_21 + arg_341_0 then
				arg_338_1.fswbg_:SetActive(true)
				arg_338_1.dialog_:SetActive(false)

				arg_338_1.fswtw_.percent = 0

				local var_341_22 = arg_338_1:GetWordFromCfg(319591082)
				local var_341_23 = arg_338_1:FormatText(var_341_22.content)

				arg_338_1.fswt_.text = var_341_23

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.fswt_)

				arg_338_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_338_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_338_1.fswtw_:SetDirty()

				arg_338_1.typewritterCharCountI18N = 0

				SetActive(arg_338_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_338_1:ShowNextGo(false)
			end

			local var_341_24 = 0.366666666666667

			if var_341_24 < arg_338_1.time_ and arg_338_1.time_ <= var_341_24 + arg_341_0 then
				arg_338_1.var_.oldValueTypewriter = arg_338_1.fswtw_.percent

				SetActive(arg_338_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_338_1:ShowNextGo(false)
			end

			local var_341_25 = 12
			local var_341_26 = 0.8
			local var_341_27 = arg_338_1:GetWordFromCfg(319591082)
			local var_341_28 = arg_338_1:FormatText(var_341_27.content)
			local var_341_29, var_341_30 = arg_338_1:GetPercentByPara(var_341_28, 1)

			if var_341_24 < arg_338_1.time_ and arg_338_1.time_ <= var_341_24 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				local var_341_31 = var_341_25 <= 0 and var_341_26 or var_341_26 * ((var_341_30 - arg_338_1.typewritterCharCountI18N) / var_341_25)

				if var_341_31 > 0 and var_341_26 < var_341_31 then
					arg_338_1.talkMaxDuration = var_341_31

					if var_341_31 + var_341_24 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_31 + var_341_24
					end
				end
			end

			local var_341_32 = 0.8
			local var_341_33 = math.max(var_341_32, arg_338_1.talkMaxDuration)

			if var_341_24 <= arg_338_1.time_ and arg_338_1.time_ < var_341_24 + var_341_33 then
				local var_341_34 = (arg_338_1.time_ - var_341_24) / var_341_33

				arg_338_1.fswtw_.percent = Mathf.Lerp(arg_338_1.var_.oldValueTypewriter, var_341_29, var_341_34)
				arg_338_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_338_1.fswtw_:SetDirty()
			end

			if arg_338_1.time_ >= var_341_24 + var_341_33 and arg_338_1.time_ < var_341_24 + var_341_33 + arg_341_0 then
				arg_338_1.fswtw_.percent = var_341_29

				arg_338_1.fswtw_:SetDirty()
				arg_338_1:ShowNextGo(true)

				arg_338_1.typewritterCharCountI18N = var_341_30
			end

			local var_341_35 = 0

			if var_341_35 < arg_338_1.time_ and arg_338_1.time_ <= var_341_35 + arg_341_0 then
				arg_338_1.cswbg_:SetActive(true)

				local var_341_36 = arg_338_1.cswt_:GetComponent("RectTransform")

				arg_338_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_341_36.offsetMin = Vector2.New(410, 330)
				var_341_36.offsetMax = Vector2.New(-400, -175)

				local var_341_37 = arg_338_1:GetWordFromCfg(419031)
				local var_341_38 = arg_338_1:FormatText(var_341_37.content)

				arg_338_1.cswt_.text = var_341_38

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.cswt_)

				arg_338_1.cswt_.fontSize = 180
				arg_338_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_338_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_338_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_341_39 = arg_338_1.actors_["4040ui_story"].transform
			local var_341_40 = 0

			if var_341_40 < arg_338_1.time_ and arg_338_1.time_ <= var_341_40 + arg_341_0 then
				arg_338_1.var_.moveOldPos4040ui_story = var_341_39.localPosition
			end

			local var_341_41 = 0.001

			if var_341_40 <= arg_338_1.time_ and arg_338_1.time_ < var_341_40 + var_341_41 then
				local var_341_42 = (arg_338_1.time_ - var_341_40) / var_341_41
				local var_341_43 = Vector3.New(0, 100, 0)

				var_341_39.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos4040ui_story, var_341_43, var_341_42)

				local var_341_44 = manager.ui.mainCamera.transform.position - var_341_39.position

				var_341_39.forward = Vector3.New(var_341_44.x, var_341_44.y, var_341_44.z)

				local var_341_45 = var_341_39.localEulerAngles

				var_341_45.z = 0
				var_341_45.x = 0
				var_341_39.localEulerAngles = var_341_45
			end

			if arg_338_1.time_ >= var_341_40 + var_341_41 and arg_338_1.time_ < var_341_40 + var_341_41 + arg_341_0 then
				var_341_39.localPosition = Vector3.New(0, 100, 0)

				local var_341_46 = manager.ui.mainCamera.transform.position - var_341_39.position

				var_341_39.forward = Vector3.New(var_341_46.x, var_341_46.y, var_341_46.z)

				local var_341_47 = var_341_39.localEulerAngles

				var_341_47.z = 0
				var_341_47.x = 0
				var_341_39.localEulerAngles = var_341_47
			end

			local var_341_48 = 0.366666666666667
			local var_341_49 = 2.466
			local var_341_50 = manager.audio:GetVoiceLength("story_v_out_319591", "319591082", "story_v_out_319591.awb") / 1000

			if var_341_50 > 0 and var_341_49 < var_341_50 and var_341_50 + var_341_48 > arg_338_1.duration_ then
				local var_341_51 = var_341_50

				arg_338_1.duration_ = var_341_50 + var_341_48
			end

			if var_341_48 < arg_338_1.time_ and arg_338_1.time_ <= var_341_48 + arg_341_0 then
				local var_341_52 = "play"
				local var_341_53 = "voice"

				arg_338_1:AudioAction(var_341_52, var_341_53, "story_v_out_319591", "319591082", "story_v_out_319591.awb")
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play319591083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 319591083
		arg_342_1.duration_ = 1

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.fswbg_:SetActive(true)
				arg_342_1.dialog_:SetActive(false)

				arg_342_1.fswtw_.percent = 0

				local var_345_1 = arg_342_1:GetWordFromCfg(319591083)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.fswt_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.fswt_)

				arg_342_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_342_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_342_1.fswtw_:SetDirty()

				arg_342_1.typewritterCharCountI18N = 0

				SetActive(arg_342_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_342_1:ShowNextGo(false)
			end

			local var_345_3 = 0.2

			if var_345_3 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.var_.oldValueTypewriter = arg_342_1.fswtw_.percent

				SetActive(arg_342_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_342_1:ShowNextGo(false)
			end

			local var_345_4 = 10
			local var_345_5 = 0.666666666666667
			local var_345_6 = arg_342_1:GetWordFromCfg(319591083)
			local var_345_7 = arg_342_1:FormatText(var_345_6.content)
			local var_345_8, var_345_9 = arg_342_1:GetPercentByPara(var_345_7, 1)

			if var_345_3 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				local var_345_10 = var_345_4 <= 0 and var_345_5 or var_345_5 * ((var_345_9 - arg_342_1.typewritterCharCountI18N) / var_345_4)

				if var_345_10 > 0 and var_345_5 < var_345_10 then
					arg_342_1.talkMaxDuration = var_345_10

					if var_345_10 + var_345_3 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_10 + var_345_3
					end
				end
			end

			local var_345_11 = 0.666666666666667
			local var_345_12 = math.max(var_345_11, arg_342_1.talkMaxDuration)

			if var_345_3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_3 + var_345_12 then
				local var_345_13 = (arg_342_1.time_ - var_345_3) / var_345_12

				arg_342_1.fswtw_.percent = Mathf.Lerp(arg_342_1.var_.oldValueTypewriter, var_345_8, var_345_13)
				arg_342_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_342_1.fswtw_:SetDirty()
			end

			if arg_342_1.time_ >= var_345_3 + var_345_12 and arg_342_1.time_ < var_345_3 + var_345_12 + arg_345_0 then
				arg_342_1.fswtw_.percent = var_345_8

				arg_342_1.fswtw_:SetDirty()
				arg_342_1:ShowNextGo(true)

				arg_342_1.typewritterCharCountI18N = var_345_9
			end

			local var_345_14 = 0.2
			local var_345_15 = 0.266666666666667
			local var_345_16 = manager.audio:GetVoiceLength("story_v_out_319591", "319591083", "story_v_out_319591.awb") / 1000

			if var_345_16 > 0 and var_345_15 < var_345_16 and var_345_16 + var_345_14 > arg_342_1.duration_ then
				local var_345_17 = var_345_16

				arg_342_1.duration_ = var_345_16 + var_345_14
			end

			if var_345_14 < arg_342_1.time_ and arg_342_1.time_ <= var_345_14 + arg_345_0 then
				local var_345_18 = "play"
				local var_345_19 = "voice"

				arg_342_1:AudioAction(var_345_18, var_345_19, "story_v_out_319591", "319591083", "story_v_out_319591.awb")
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I12h",
		"TextureConfig/Background/A08f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I10f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319591.awb"
	}
}
