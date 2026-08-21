return {
	Play107101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play107101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C06b"

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
				local var_4_5 = arg_1_1.bgs_.C06b

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
					if iter_4_0 ~= "C06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = "3007_tpose"

			if arg_1_1.actors_[var_4_16] == nil then
				local var_4_17 = Asset.Load("Char/" .. "3007_tpose")

				if not isNil(var_4_17) then
					local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_1_1.stage_.transform)

					var_4_18.name = var_4_16
					var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_16] = var_4_18

					local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

					var_4_19.enabled = true

					local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

					if var_4_20 then
						var_4_20:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_19.transform, false)

					arg_1_1.var_[var_4_16 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_16 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_16 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_21 = arg_1_1.actors_["3007_tpose"].transform
			local var_4_22 = 1.8

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.var_.moveOldPos3007_tpose = var_4_21.localPosition

				local var_4_23 = GameObjectTools.GetOrAddComponent(var_4_21.gameObject, typeof(DynamicBoneHelper))

				if var_4_23 then
					var_4_23:EnableDynamicBone(false)
				end
			end

			local var_4_24 = 0.001

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Vector3.New(0, -2.25, -1.9)

				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3007_tpose, var_4_26, var_4_25)

				local var_4_27 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_27.x, var_4_27.y, var_4_27.z)

				local var_4_28 = var_4_21.localEulerAngles

				var_4_28.z = 0
				var_4_28.x = 0
				var_4_21.localEulerAngles = var_4_28
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_4_29 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_29.x, var_4_29.y, var_4_29.z)

				local var_4_30 = var_4_21.localEulerAngles

				var_4_30.z = 0
				var_4_30.x = 0
				var_4_21.localEulerAngles = var_4_30

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_21.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(true)
				end
			end

			local var_4_32 = 0

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_4_33 = arg_1_1.bgs_.C06b
			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = var_4_33:GetComponent("SpriteRenderer")

				if var_4_35 then
					arg_1_1.var_.alphaOldValueC06b = var_4_35.color.a
					arg_1_1.var_.alphaMatValueC06b = var_4_35
				end

				arg_1_1.var_.alphaOldValueC06b = 0
			end

			local var_4_36 = 1.5

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_34) / var_4_36
				local var_4_38 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC06b, 1, var_4_37)

				if arg_1_1.var_.alphaMatValueC06b then
					local var_4_39 = arg_1_1.var_.alphaMatValueC06b.color

					var_4_39.a = var_4_38
					arg_1_1.var_.alphaMatValueC06b.color = var_4_39
				end
			end

			if arg_1_1.time_ >= var_4_34 + var_4_36 and arg_1_1.time_ < var_4_34 + var_4_36 + arg_4_0 and arg_1_1.var_.alphaMatValueC06b then
				local var_4_40 = arg_1_1.var_.alphaMatValueC06b
				local var_4_41 = var_4_40.color

				var_4_41.a = 1
				var_4_40.color = var_4_41
			end

			local var_4_42 = 0
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 2
			local var_4_49 = 1.1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_50 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_50:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_51 = arg_1_1:GetWordFromCfg(107101001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 44
				local var_4_54 = utf8.len(var_4_52)
				local var_4_55 = var_4_53 <= 0 and var_4_49 or var_4_49 * (var_4_54 / var_4_53)

				if var_4_55 > 0 and var_4_49 < var_4_55 then
					arg_1_1.talkMaxDuration = var_4_55
					var_4_48 = var_4_48 + 0.3

					if var_4_55 + var_4_48 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_48
					end
				end

				arg_1_1.text_.text = var_4_52
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_56 = var_4_48 + 0.3
			local var_4_57 = math.max(var_4_49, arg_1_1.talkMaxDuration)

			if var_4_56 <= arg_1_1.time_ and arg_1_1.time_ < var_4_56 + var_4_57 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_56) / var_4_57

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_56 + var_4_57 and arg_1_1.time_ < var_4_56 + var_4_57 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play107101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107101002
		arg_8_1.duration_ = 5.3

		local var_8_0 = {
			ja = 3.4,
			ko = 4.3,
			zh = 4.866,
			en = 5.3
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play107101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.35

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[99].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(107101002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 14
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101002", "story_v_out_107101.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_107101", "107101002", "story_v_out_107101.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_107101", "107101002", "story_v_out_107101.awb")

						arg_8_1:RecordAudio("107101002", var_11_9)
						arg_8_1:RecordAudio("107101002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107101", "107101002", "story_v_out_107101.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107101", "107101002", "story_v_out_107101.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play107101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107101003
		arg_12_1.duration_ = 5.83

		local var_12_0 = {
			ja = 5.666,
			ko = 3.7,
			zh = 5.833,
			en = 5.3
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
				arg_12_0:Play107101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["3007_tpose"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3007_tpose == nil then
				arg_12_1.var_.characterEffect3007_tpose = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect3007_tpose and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3007_tpose then
				arg_12_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_15_4 = 0
			local var_15_5 = 0.25

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_6 = arg_12_1:FormatText(StoryNameCfg[98].name)

				arg_12_1.leftNameTxt_.text = var_15_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_7 = arg_12_1:GetWordFromCfg(107101003)
				local var_15_8 = arg_12_1:FormatText(var_15_7.content)

				arg_12_1.text_.text = var_15_8

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 10
				local var_15_10 = utf8.len(var_15_8)
				local var_15_11 = var_15_9 <= 0 and var_15_5 or var_15_5 * (var_15_10 / var_15_9)

				if var_15_11 > 0 and var_15_5 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_8
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101003", "story_v_out_107101.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_107101", "107101003", "story_v_out_107101.awb") / 1000

					if var_15_12 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_4
					end

					if var_15_7.prefab_name ~= "" and arg_12_1.actors_[var_15_7.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_7.prefab_name].transform, "story_v_out_107101", "107101003", "story_v_out_107101.awb")

						arg_12_1:RecordAudio("107101003", var_15_13)
						arg_12_1:RecordAudio("107101003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_107101", "107101003", "story_v_out_107101.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_107101", "107101003", "story_v_out_107101.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_5, arg_12_1.talkMaxDuration)

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_4) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_4 + var_15_14 and arg_12_1.time_ < var_15_4 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play107101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 107101004
		arg_16_1.duration_ = 20.77

		local var_16_0 = {
			ja = 20.766,
			ko = 14.833,
			zh = 14.333,
			en = 17.833
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play107101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3007_tpose"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3007_tpose == nil then
				arg_16_1.var_.characterEffect3007_tpose = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect3007_tpose and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_16_1.var_.characterEffect3007_tpose.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3007_tpose then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_16_1.var_.characterEffect3007_tpose.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 1.625

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[99].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(107101004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 65
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101004", "story_v_out_107101.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_107101", "107101004", "story_v_out_107101.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_107101", "107101004", "story_v_out_107101.awb")

						arg_16_1:RecordAudio("107101004", var_19_15)
						arg_16_1:RecordAudio("107101004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_107101", "107101004", "story_v_out_107101.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_107101", "107101004", "story_v_out_107101.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play107101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 107101005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play107101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 1.075

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(107101005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 43
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play107101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 107101006
		arg_24_1.duration_ = 3

		local var_24_0 = {
			ja = 2.9,
			ko = 1.7,
			zh = 2.933,
			en = 3
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
				arg_24_0:Play107101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["3007_tpose"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3007_tpose == nil then
				arg_24_1.var_.characterEffect3007_tpose = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect3007_tpose and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3007_tpose then
				arg_24_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_27_4 = 0
			local var_27_5 = 0.1

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_6 = arg_24_1:FormatText(StoryNameCfg[98].name)

				arg_24_1.leftNameTxt_.text = var_27_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(107101006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 4
				local var_27_10 = utf8.len(var_27_8)
				local var_27_11 = var_27_9 <= 0 and var_27_5 or var_27_5 * (var_27_10 / var_27_9)

				if var_27_11 > 0 and var_27_5 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101006", "story_v_out_107101.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_107101", "107101006", "story_v_out_107101.awb") / 1000

					if var_27_12 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_4
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_out_107101", "107101006", "story_v_out_107101.awb")

						arg_24_1:RecordAudio("107101006", var_27_13)
						arg_24_1:RecordAudio("107101006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_107101", "107101006", "story_v_out_107101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_107101", "107101006", "story_v_out_107101.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_14 and arg_24_1.time_ < var_27_4 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play107101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 107101007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play107101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3007_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3007_tpose == nil then
				arg_28_1.var_.characterEffect3007_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect3007_tpose and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_28_1.var_.characterEffect3007_tpose.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3007_tpose then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_28_1.var_.characterEffect3007_tpose.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.666666666666667

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				local var_31_8 = "play"
				local var_31_9 = "effect"

				arg_28_1:AudioAction(var_31_8, var_31_9, "se_story_7", "se_story_7_fire", "")
			end

			local var_31_10 = 0
			local var_31_11 = 1

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(107101007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_14 = 40
				local var_31_15 = utf8.len(var_31_13)
				local var_31_16 = var_31_14 <= 0 and var_31_11 or var_31_11 * (var_31_15 / var_31_14)

				if var_31_16 > 0 and var_31_11 < var_31_16 then
					arg_28_1.talkMaxDuration = var_31_16

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_17 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_17 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_17

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_17 and arg_28_1.time_ < var_31_10 + var_31_17 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play107101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 107101008
		arg_32_1.duration_ = 5.57

		local var_32_0 = {
			ja = 5.566,
			ko = 1.5,
			zh = 5.233,
			en = 5.366
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
				arg_32_0:Play107101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3007_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3007_tpose == nil then
				arg_32_1.var_.characterEffect3007_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3007_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3007_tpose then
				arg_32_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_35_4 = 0
			local var_35_5 = 0.15

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_6 = arg_32_1:FormatText(StoryNameCfg[98].name)

				arg_32_1.leftNameTxt_.text = var_35_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_7 = arg_32_1:GetWordFromCfg(107101008)
				local var_35_8 = arg_32_1:FormatText(var_35_7.content)

				arg_32_1.text_.text = var_35_8

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 6
				local var_35_10 = utf8.len(var_35_8)
				local var_35_11 = var_35_9 <= 0 and var_35_5 or var_35_5 * (var_35_10 / var_35_9)

				if var_35_11 > 0 and var_35_5 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_8
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101008", "story_v_out_107101.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_107101", "107101008", "story_v_out_107101.awb") / 1000

					if var_35_12 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_4
					end

					if var_35_7.prefab_name ~= "" and arg_32_1.actors_[var_35_7.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_7.prefab_name].transform, "story_v_out_107101", "107101008", "story_v_out_107101.awb")

						arg_32_1:RecordAudio("107101008", var_35_13)
						arg_32_1:RecordAudio("107101008", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_107101", "107101008", "story_v_out_107101.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_107101", "107101008", "story_v_out_107101.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_14 and arg_32_1.time_ < var_35_4 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play107101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 107101009
		arg_36_1.duration_ = 1.67

		local var_36_0 = {
			ja = 1.233,
			ko = 1.666,
			zh = 1.4,
			en = 1.4
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
				arg_36_0:Play107101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["3007_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3007_tpose == nil then
				arg_36_1.var_.characterEffect3007_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect3007_tpose and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_36_1.var_.characterEffect3007_tpose.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3007_tpose then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_36_1.var_.characterEffect3007_tpose.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.15

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[99].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(107101009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 6
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101009", "story_v_out_107101.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_107101", "107101009", "story_v_out_107101.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_107101", "107101009", "story_v_out_107101.awb")

						arg_36_1:RecordAudio("107101009", var_39_15)
						arg_36_1:RecordAudio("107101009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_107101", "107101009", "story_v_out_107101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_107101", "107101009", "story_v_out_107101.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play107101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 107101010
		arg_40_1.duration_ = 12.5

		local var_40_0 = {
			ja = 7.433,
			ko = 3.2,
			zh = 7.3,
			en = 12.5
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
				arg_40_0:Play107101011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["3007_tpose"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect3007_tpose == nil then
				arg_40_1.var_.characterEffect3007_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect3007_tpose and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect3007_tpose then
				arg_40_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 0.275

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_6 = arg_40_1:FormatText(StoryNameCfg[98].name)

				arg_40_1.leftNameTxt_.text = var_43_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(107101010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 11
				local var_43_10 = utf8.len(var_43_8)
				local var_43_11 = var_43_9 <= 0 and var_43_5 or var_43_5 * (var_43_10 / var_43_9)

				if var_43_11 > 0 and var_43_5 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101010", "story_v_out_107101.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_107101", "107101010", "story_v_out_107101.awb") / 1000

					if var_43_12 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_4
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_107101", "107101010", "story_v_out_107101.awb")

						arg_40_1:RecordAudio("107101010", var_43_13)
						arg_40_1:RecordAudio("107101010", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_107101", "107101010", "story_v_out_107101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_107101", "107101010", "story_v_out_107101.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_14 and arg_40_1.time_ < var_43_4 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play107101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 107101011
		arg_44_1.duration_ = 4.03

		local var_44_0 = {
			ja = 3.2,
			ko = 4.033,
			zh = 2.7,
			en = 2.966
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
				arg_44_0:Play107101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3007_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3007_tpose == nil then
				arg_44_1.var_.characterEffect3007_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect3007_tpose and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_44_1.var_.characterEffect3007_tpose.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3007_tpose then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_44_1.var_.characterEffect3007_tpose.fillRatio = var_47_5
			end

			local var_47_6 = arg_44_1.actors_["3007_tpose"].transform
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				arg_44_1.var_.moveOldPos3007_tpose = var_47_6.localPosition

				local var_47_8 = GameObjectTools.GetOrAddComponent(var_47_6.gameObject, typeof(DynamicBoneHelper))

				if var_47_8 then
					var_47_8:EnableDynamicBone(false)
				end
			end

			local var_47_9 = 0.001

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_9 then
				local var_47_10 = (arg_44_1.time_ - var_47_7) / var_47_9
				local var_47_11 = Vector3.New(0, 100, 0)

				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3007_tpose, var_47_11, var_47_10)

				local var_47_12 = manager.ui.mainCamera.transform.position - var_47_6.position

				var_47_6.forward = Vector3.New(var_47_12.x, var_47_12.y, var_47_12.z)

				local var_47_13 = var_47_6.localEulerAngles

				var_47_13.z = 0
				var_47_13.x = 0
				var_47_6.localEulerAngles = var_47_13
			end

			if arg_44_1.time_ >= var_47_7 + var_47_9 and arg_44_1.time_ < var_47_7 + var_47_9 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(0, 100, 0)

				local var_47_14 = manager.ui.mainCamera.transform.position - var_47_6.position

				var_47_6.forward = Vector3.New(var_47_14.x, var_47_14.y, var_47_14.z)

				local var_47_15 = var_47_6.localEulerAngles

				var_47_15.z = 0
				var_47_15.x = 0
				var_47_6.localEulerAngles = var_47_15

				local var_47_16 = GameObjectTools.GetOrAddComponent(var_47_6.gameObject, typeof(DynamicBoneHelper))

				if var_47_16 then
					var_47_16:EnableDynamicBone(true)
				end
			end

			local var_47_17 = 0
			local var_47_18 = 0.35

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_19 = arg_44_1:FormatText(StoryNameCfg[99].name)

				arg_44_1.leftNameTxt_.text = var_47_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_20 = arg_44_1:GetWordFromCfg(107101011)
				local var_47_21 = arg_44_1:FormatText(var_47_20.content)

				arg_44_1.text_.text = var_47_21

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_22 = 14
				local var_47_23 = utf8.len(var_47_21)
				local var_47_24 = var_47_22 <= 0 and var_47_18 or var_47_18 * (var_47_23 / var_47_22)

				if var_47_24 > 0 and var_47_18 < var_47_24 then
					arg_44_1.talkMaxDuration = var_47_24

					if var_47_24 + var_47_17 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_17
					end
				end

				arg_44_1.text_.text = var_47_21
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101011", "story_v_out_107101.awb") ~= 0 then
					local var_47_25 = manager.audio:GetVoiceLength("story_v_out_107101", "107101011", "story_v_out_107101.awb") / 1000

					if var_47_25 + var_47_17 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_25 + var_47_17
					end

					if var_47_20.prefab_name ~= "" and arg_44_1.actors_[var_47_20.prefab_name] ~= nil then
						local var_47_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_20.prefab_name].transform, "story_v_out_107101", "107101011", "story_v_out_107101.awb")

						arg_44_1:RecordAudio("107101011", var_47_26)
						arg_44_1:RecordAudio("107101011", var_47_26)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_107101", "107101011", "story_v_out_107101.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_107101", "107101011", "story_v_out_107101.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_27 = math.max(var_47_18, arg_44_1.talkMaxDuration)

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_27 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_17) / var_47_27

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_17 + var_47_27 and arg_44_1.time_ < var_47_17 + var_47_27 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play107101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 107101012
		arg_48_1.duration_ = 7.23

		local var_48_0 = {
			ja = 6.566,
			ko = 6.866,
			zh = 7.233,
			en = 6.4
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
				arg_48_0:Play107101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "1084ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["1084ui_story"]
			local var_51_6 = 2

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_7 = 0.1

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 and not isNil(var_51_5) then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_5) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_9 = arg_48_1.bgs_.C06b.transform
			local var_51_10 = 1.5

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.var_.moveOldPosC06b = var_51_9.localPosition
			end

			local var_51_11 = 0.001

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11
				local var_51_13 = Vector3.New(0, -100, 10)

				var_51_9.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPosC06b, var_51_13, var_51_12)
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 then
				var_51_9.localPosition = Vector3.New(0, -100, 10)
			end

			local var_51_14 = "C03a"

			if arg_48_1.bgs_[var_51_14] == nil then
				local var_51_15 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_14)
				var_51_15.name = var_51_14
				var_51_15.transform.parent = arg_48_1.stage_.transform
				var_51_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_14] = var_51_15
			end

			local var_51_16 = 1.5

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				local var_51_17 = manager.ui.mainCamera.transform.localPosition
				local var_51_18 = Vector3.New(0, 0, 10) + Vector3.New(var_51_17.x, var_51_17.y, 0)
				local var_51_19 = arg_48_1.bgs_.C03a

				var_51_19.transform.localPosition = var_51_18
				var_51_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_20 = var_51_19:GetComponent("SpriteRenderer")

				if var_51_20 and var_51_20.sprite then
					local var_51_21 = (var_51_19.transform.localPosition - var_51_17).z
					local var_51_22 = manager.ui.mainCameraCom_
					local var_51_23 = 2 * var_51_21 * Mathf.Tan(var_51_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_24 = var_51_23 * var_51_22.aspect
					local var_51_25 = var_51_20.sprite.bounds.size.x
					local var_51_26 = var_51_20.sprite.bounds.size.y
					local var_51_27 = var_51_24 / var_51_25
					local var_51_28 = var_51_23 / var_51_26
					local var_51_29 = var_51_28 < var_51_27 and var_51_27 or var_51_28

					var_51_19.transform.localScale = Vector3.New(var_51_29, var_51_29, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "C03a" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_30 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_31 = 2

			if var_51_31 < arg_48_1.time_ and arg_48_1.time_ <= var_51_31 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_30.localPosition
			end

			local var_51_32 = 0.001

			if var_51_31 <= arg_48_1.time_ and arg_48_1.time_ < var_51_31 + var_51_32 then
				local var_51_33 = (arg_48_1.time_ - var_51_31) / var_51_32
				local var_51_34 = Vector3.New(-0.7, -0.97, -6)

				var_51_30.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_34, var_51_33)

				local var_51_35 = manager.ui.mainCamera.transform.position - var_51_30.position

				var_51_30.forward = Vector3.New(var_51_35.x, var_51_35.y, var_51_35.z)

				local var_51_36 = var_51_30.localEulerAngles

				var_51_36.z = 0
				var_51_36.x = 0
				var_51_30.localEulerAngles = var_51_36
			end

			if arg_48_1.time_ >= var_51_31 + var_51_32 and arg_48_1.time_ < var_51_31 + var_51_32 + arg_51_0 then
				var_51_30.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_51_37 = manager.ui.mainCamera.transform.position - var_51_30.position

				var_51_30.forward = Vector3.New(var_51_37.x, var_51_37.y, var_51_37.z)

				local var_51_38 = var_51_30.localEulerAngles

				var_51_38.z = 0
				var_51_38.x = 0
				var_51_30.localEulerAngles = var_51_38
			end

			local var_51_39 = 2

			if var_51_39 < arg_48_1.time_ and arg_48_1.time_ <= var_51_39 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_51_40 = arg_48_1.bgs_.C06b
			local var_51_41 = 0

			if var_51_41 < arg_48_1.time_ and arg_48_1.time_ <= var_51_41 + arg_51_0 then
				local var_51_42 = var_51_40:GetComponent("SpriteRenderer")

				if var_51_42 then
					arg_48_1.var_.alphaOldValueC06b = var_51_42.color.a
					arg_48_1.var_.alphaMatValueC06b = var_51_42
				end

				arg_48_1.var_.alphaOldValueC06b = 1
			end

			local var_51_43 = 1.5

			if var_51_41 <= arg_48_1.time_ and arg_48_1.time_ < var_51_41 + var_51_43 then
				local var_51_44 = (arg_48_1.time_ - var_51_41) / var_51_43
				local var_51_45 = Mathf.Lerp(arg_48_1.var_.alphaOldValueC06b, 0, var_51_44)

				if arg_48_1.var_.alphaMatValueC06b then
					local var_51_46 = arg_48_1.var_.alphaMatValueC06b.color

					var_51_46.a = var_51_45
					arg_48_1.var_.alphaMatValueC06b.color = var_51_46
				end
			end

			if arg_48_1.time_ >= var_51_41 + var_51_43 and arg_48_1.time_ < var_51_41 + var_51_43 + arg_51_0 and arg_48_1.var_.alphaMatValueC06b then
				local var_51_47 = arg_48_1.var_.alphaMatValueC06b
				local var_51_48 = var_51_47.color

				var_51_48.a = 0
				var_51_47.color = var_51_48
			end

			local var_51_49 = arg_48_1.bgs_.C03a
			local var_51_50 = 1.5

			if var_51_50 < arg_48_1.time_ and arg_48_1.time_ <= var_51_50 + arg_51_0 then
				local var_51_51 = var_51_49:GetComponent("SpriteRenderer")

				if var_51_51 then
					arg_48_1.var_.alphaOldValueC03a = var_51_51.color.a
					arg_48_1.var_.alphaMatValueC03a = var_51_51
				end

				arg_48_1.var_.alphaOldValueC03a = 0
			end

			local var_51_52 = 1.5

			if var_51_50 <= arg_48_1.time_ and arg_48_1.time_ < var_51_50 + var_51_52 then
				local var_51_53 = (arg_48_1.time_ - var_51_50) / var_51_52
				local var_51_54 = Mathf.Lerp(arg_48_1.var_.alphaOldValueC03a, 1, var_51_53)

				if arg_48_1.var_.alphaMatValueC03a then
					local var_51_55 = arg_48_1.var_.alphaMatValueC03a.color

					var_51_55.a = var_51_54
					arg_48_1.var_.alphaMatValueC03a.color = var_51_55
				end
			end

			if arg_48_1.time_ >= var_51_50 + var_51_52 and arg_48_1.time_ < var_51_50 + var_51_52 + arg_51_0 and arg_48_1.var_.alphaMatValueC03a then
				local var_51_56 = arg_48_1.var_.alphaMatValueC03a
				local var_51_57 = var_51_56.color

				var_51_57.a = 1
				var_51_56.color = var_51_57
			end

			local var_51_58 = 0

			if var_51_58 < arg_48_1.time_ and arg_48_1.time_ <= var_51_58 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			local var_51_59 = 2

			if arg_48_1.time_ >= var_51_58 + var_51_59 and arg_48_1.time_ < var_51_58 + var_51_59 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_60 = 0

			if var_51_60 < arg_48_1.time_ and arg_48_1.time_ <= var_51_60 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_61 = 2
			local var_51_62 = 0.4

			if var_51_61 < arg_48_1.time_ and arg_48_1.time_ <= var_51_61 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_63 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_64 = arg_48_1:GetWordFromCfg(107101012)
				local var_51_65 = arg_48_1:FormatText(var_51_64.content)

				arg_48_1.text_.text = var_51_65

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_66 = 16
				local var_51_67 = utf8.len(var_51_65)
				local var_51_68 = var_51_66 <= 0 and var_51_62 or var_51_62 * (var_51_67 / var_51_66)

				if var_51_68 > 0 and var_51_62 < var_51_68 then
					arg_48_1.talkMaxDuration = var_51_68

					if var_51_68 + var_51_61 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_68 + var_51_61
					end
				end

				arg_48_1.text_.text = var_51_65
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101012", "story_v_out_107101.awb") ~= 0 then
					local var_51_69 = manager.audio:GetVoiceLength("story_v_out_107101", "107101012", "story_v_out_107101.awb") / 1000

					if var_51_69 + var_51_61 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_69 + var_51_61
					end

					if var_51_64.prefab_name ~= "" and arg_48_1.actors_[var_51_64.prefab_name] ~= nil then
						local var_51_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_64.prefab_name].transform, "story_v_out_107101", "107101012", "story_v_out_107101.awb")

						arg_48_1:RecordAudio("107101012", var_51_70)
						arg_48_1:RecordAudio("107101012", var_51_70)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_107101", "107101012", "story_v_out_107101.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_107101", "107101012", "story_v_out_107101.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_71 = math.max(var_51_62, arg_48_1.talkMaxDuration)

			if var_51_61 <= arg_48_1.time_ and arg_48_1.time_ < var_51_61 + var_51_71 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_61) / var_51_71

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_61 + var_51_71 and arg_48_1.time_ < var_51_61 + var_51_71 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "C06b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play107101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107101013
		arg_52_1.duration_ = 5.73

		local var_52_0 = {
			ja = 3.233,
			ko = 3.3,
			zh = 4.766,
			en = 5.733
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
				arg_52_0:Play107101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1038ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["1038ui_story"]
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1038ui_story == nil then
				arg_52_1.var_.characterEffect1038ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.1

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 and not isNil(var_55_5) then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7

				if arg_52_1.var_.characterEffect1038ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1038ui_story then
				arg_52_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_55_9 = arg_52_1.actors_["1084ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.1

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_14
			end

			local var_55_15 = arg_52_1.actors_["1038ui_story"].transform
			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.var_.moveOldPos1038ui_story = var_55_15.localPosition
			end

			local var_55_17 = 0.001

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17
				local var_55_19 = Vector3.New(0.7, -1.11, -5.9)

				var_55_15.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1038ui_story, var_55_19, var_55_18)

				local var_55_20 = manager.ui.mainCamera.transform.position - var_55_15.position

				var_55_15.forward = Vector3.New(var_55_20.x, var_55_20.y, var_55_20.z)

				local var_55_21 = var_55_15.localEulerAngles

				var_55_21.z = 0
				var_55_21.x = 0
				var_55_15.localEulerAngles = var_55_21
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				var_55_15.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_55_22 = manager.ui.mainCamera.transform.position - var_55_15.position

				var_55_15.forward = Vector3.New(var_55_22.x, var_55_22.y, var_55_22.z)

				local var_55_23 = var_55_15.localEulerAngles

				var_55_23.z = 0
				var_55_23.x = 0
				var_55_15.localEulerAngles = var_55_23
			end

			local var_55_24 = 0

			if var_55_24 < arg_52_1.time_ and arg_52_1.time_ <= var_55_24 + arg_55_0 then
				arg_52_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action4_1")
			end

			local var_55_25 = 0

			if var_55_25 < arg_52_1.time_ and arg_52_1.time_ <= var_55_25 + arg_55_0 then
				arg_52_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_55_26 = 0
			local var_55_27 = 0.425

			if var_55_26 < arg_52_1.time_ and arg_52_1.time_ <= var_55_26 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_28 = arg_52_1:FormatText(StoryNameCfg[94].name)

				arg_52_1.leftNameTxt_.text = var_55_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_29 = arg_52_1:GetWordFromCfg(107101013)
				local var_55_30 = arg_52_1:FormatText(var_55_29.content)

				arg_52_1.text_.text = var_55_30

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_31 = 17
				local var_55_32 = utf8.len(var_55_30)
				local var_55_33 = var_55_31 <= 0 and var_55_27 or var_55_27 * (var_55_32 / var_55_31)

				if var_55_33 > 0 and var_55_27 < var_55_33 then
					arg_52_1.talkMaxDuration = var_55_33

					if var_55_33 + var_55_26 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_33 + var_55_26
					end
				end

				arg_52_1.text_.text = var_55_30
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101013", "story_v_out_107101.awb") ~= 0 then
					local var_55_34 = manager.audio:GetVoiceLength("story_v_out_107101", "107101013", "story_v_out_107101.awb") / 1000

					if var_55_34 + var_55_26 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_34 + var_55_26
					end

					if var_55_29.prefab_name ~= "" and arg_52_1.actors_[var_55_29.prefab_name] ~= nil then
						local var_55_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_29.prefab_name].transform, "story_v_out_107101", "107101013", "story_v_out_107101.awb")

						arg_52_1:RecordAudio("107101013", var_55_35)
						arg_52_1:RecordAudio("107101013", var_55_35)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_107101", "107101013", "story_v_out_107101.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_107101", "107101013", "story_v_out_107101.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_36 = math.max(var_55_27, arg_52_1.talkMaxDuration)

			if var_55_26 <= arg_52_1.time_ and arg_52_1.time_ < var_55_26 + var_55_36 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_26) / var_55_36

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_26 + var_55_36 and arg_52_1.time_ < var_55_26 + var_55_36 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play107101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107101014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play107101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1038ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1038ui_story == nil then
				arg_56_1.var_.characterEffect1038ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1038ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1038ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1038ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1038ui_story.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["1038ui_story"].transform
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.var_.moveOldPos1038ui_story = var_59_6.localPosition
			end

			local var_59_8 = 0.001

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_7) / var_59_8
				local var_59_10 = Vector3.New(0, 100, 0)

				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1038ui_story, var_59_10, var_59_9)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_6.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_6.localEulerAngles = var_59_12
			end

			if arg_56_1.time_ >= var_59_7 + var_59_8 and arg_56_1.time_ < var_59_7 + var_59_8 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)

				local var_59_13 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_13.x, var_59_13.y, var_59_13.z)

				local var_59_14 = var_59_6.localEulerAngles

				var_59_14.z = 0
				var_59_14.x = 0
				var_59_6.localEulerAngles = var_59_14
			end

			local var_59_15 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_15.localPosition
			end

			local var_59_17 = 0.001

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 then
				local var_59_18 = (arg_56_1.time_ - var_59_16) / var_59_17
				local var_59_19 = Vector3.New(0, 100, 0)

				var_59_15.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_19, var_59_18)

				local var_59_20 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_20.x, var_59_20.y, var_59_20.z)

				local var_59_21 = var_59_15.localEulerAngles

				var_59_21.z = 0
				var_59_21.x = 0
				var_59_15.localEulerAngles = var_59_21
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
				var_59_15.localPosition = Vector3.New(0, 100, 0)

				local var_59_22 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_22.x, var_59_22.y, var_59_22.z)

				local var_59_23 = var_59_15.localEulerAngles

				var_59_23.z = 0
				var_59_23.x = 0
				var_59_15.localEulerAngles = var_59_23
			end

			local var_59_24 = 0
			local var_59_25 = 0.4

			if var_59_24 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_26 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_27 = arg_56_1:GetWordFromCfg(107101014)
				local var_59_28 = arg_56_1:FormatText(var_59_27.content)

				arg_56_1.text_.text = var_59_28

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_29 = 16
				local var_59_30 = utf8.len(var_59_28)
				local var_59_31 = var_59_29 <= 0 and var_59_25 or var_59_25 * (var_59_30 / var_59_29)

				if var_59_31 > 0 and var_59_25 < var_59_31 then
					arg_56_1.talkMaxDuration = var_59_31

					if var_59_31 + var_59_24 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_31 + var_59_24
					end
				end

				arg_56_1.text_.text = var_59_28
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_32 = math.max(var_59_25, arg_56_1.talkMaxDuration)

			if var_59_24 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_32 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_24) / var_59_32

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_24 + var_59_32 and arg_56_1.time_ < var_59_24 + var_59_32 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play107101015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 107101015
		arg_60_1.duration_ = 8

		local var_60_0 = {
			ja = 8,
			ko = 5.166,
			zh = 4.5,
			en = 6.366
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
				arg_60_0:Play107101016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.575

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[10].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(107101015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 23
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101015", "story_v_out_107101.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_107101", "107101015", "story_v_out_107101.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_107101", "107101015", "story_v_out_107101.awb")

						arg_60_1:RecordAudio("107101015", var_63_9)
						arg_60_1:RecordAudio("107101015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_107101", "107101015", "story_v_out_107101.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_107101", "107101015", "story_v_out_107101.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play107101016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 107101016
		arg_64_1.duration_ = 6.7

		local var_64_0 = {
			ja = 6.7,
			ko = 5.5,
			zh = 5.133,
			en = 5.733
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
				arg_64_0:Play107101017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.6

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[10].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(107101016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 24
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101016", "story_v_out_107101.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_107101", "107101016", "story_v_out_107101.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_107101", "107101016", "story_v_out_107101.awb")

						arg_64_1:RecordAudio("107101016", var_67_9)
						arg_64_1:RecordAudio("107101016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_107101", "107101016", "story_v_out_107101.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_107101", "107101016", "story_v_out_107101.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play107101017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 107101017
		arg_68_1.duration_ = 3.2

		local var_68_0 = {
			ja = 2.266,
			ko = 3.2,
			zh = 2.733,
			en = 2.533
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
				arg_68_0:Play107101018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_4.localPosition
			end

			local var_71_6 = 0.001

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6
				local var_71_8 = Vector3.New(0, -0.97, -6)

				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_8, var_71_7)

				local var_71_9 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_9.x, var_71_9.y, var_71_9.z)

				local var_71_10 = var_71_4.localEulerAngles

				var_71_10.z = 0
				var_71_10.x = 0
				var_71_4.localEulerAngles = var_71_10
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_4.position

				var_71_4.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_4.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_4.localEulerAngles = var_71_12
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_71_15 = 0
			local var_71_16 = 0.25

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(107101017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 10
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101017", "story_v_out_107101.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_107101", "107101017", "story_v_out_107101.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_107101", "107101017", "story_v_out_107101.awb")

						arg_68_1:RecordAudio("107101017", var_71_24)
						arg_68_1:RecordAudio("107101017", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_107101", "107101017", "story_v_out_107101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_107101", "107101017", "story_v_out_107101.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play107101018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 107101018
		arg_72_1.duration_ = 19.7

		local var_72_0 = {
			ja = 17.9,
			ko = 11.866,
			zh = 11.466,
			en = 19.7
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
				arg_72_0:Play107101019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_5
			end

			local var_75_6 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_6.localPosition
			end

			local var_75_8 = 0.001

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / var_75_8
				local var_75_10 = Vector3.New(0, 100, 0)

				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_10, var_75_9)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_6.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_6.localEulerAngles = var_75_12
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, 100, 0)

				local var_75_13 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_13.x, var_75_13.y, var_75_13.z)

				local var_75_14 = var_75_6.localEulerAngles

				var_75_14.z = 0
				var_75_14.x = 0
				var_75_6.localEulerAngles = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 1.35

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[10].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_18 = arg_72_1:GetWordFromCfg(107101018)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 54
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101018", "story_v_out_107101.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_107101", "107101018", "story_v_out_107101.awb") / 1000

					if var_75_23 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_107101", "107101018", "story_v_out_107101.awb")

						arg_72_1:RecordAudio("107101018", var_75_24)
						arg_72_1:RecordAudio("107101018", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_107101", "107101018", "story_v_out_107101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_107101", "107101018", "story_v_out_107101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_25 and arg_72_1.time_ < var_75_15 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play107101019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 107101019
		arg_76_1.duration_ = 13.5

		local var_76_0 = {
			ja = 10.266,
			ko = 7.7,
			zh = 8.7,
			en = 13.5
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
				arg_76_0:Play107101020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.925

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[10].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(107101019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 37
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101019", "story_v_out_107101.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_107101", "107101019", "story_v_out_107101.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_107101", "107101019", "story_v_out_107101.awb")

						arg_76_1:RecordAudio("107101019", var_79_9)
						arg_76_1:RecordAudio("107101019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_107101", "107101019", "story_v_out_107101.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_107101", "107101019", "story_v_out_107101.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play107101020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 107101020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play107101021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.45

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(107101020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 18
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play107101021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 107101021
		arg_84_1.duration_ = 4.5

		local var_84_0 = {
			ja = 3.733,
			ko = 3.166,
			zh = 3.266,
			en = 4.5
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
				arg_84_0:Play107101022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["3007_tpose"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect3007_tpose == nil then
				arg_84_1.var_.characterEffect3007_tpose = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect3007_tpose and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect3007_tpose then
				arg_84_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_87_4 = manager.ui.mainCamera.transform
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.var_.shakeOldPos = var_87_4.localPosition
			end

			local var_87_6 = 0.6

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / 0.066
				local var_87_8, var_87_9 = math.modf(var_87_7)

				var_87_4.localPosition = Vector3.New(var_87_9 * 0.13, var_87_9 * 0.13, var_87_9 * 0.13) + arg_84_1.var_.shakeOldPos
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 then
				var_87_4.localPosition = arg_84_1.var_.shakeOldPos
			end

			local var_87_10 = 0
			local var_87_11 = 0.1

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_12 = arg_84_1:FormatText(StoryNameCfg[98].name)

				arg_84_1.leftNameTxt_.text = var_87_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3007")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_13 = arg_84_1:GetWordFromCfg(107101021)
				local var_87_14 = arg_84_1:FormatText(var_87_13.content)

				arg_84_1.text_.text = var_87_14

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 4
				local var_87_16 = utf8.len(var_87_14)
				local var_87_17 = var_87_15 <= 0 and var_87_11 or var_87_11 * (var_87_16 / var_87_15)

				if var_87_17 > 0 and var_87_11 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_14
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101021", "story_v_out_107101.awb") ~= 0 then
					local var_87_18 = manager.audio:GetVoiceLength("story_v_out_107101", "107101021", "story_v_out_107101.awb") / 1000

					if var_87_18 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_10
					end

					if var_87_13.prefab_name ~= "" and arg_84_1.actors_[var_87_13.prefab_name] ~= nil then
						local var_87_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_13.prefab_name].transform, "story_v_out_107101", "107101021", "story_v_out_107101.awb")

						arg_84_1:RecordAudio("107101021", var_87_19)
						arg_84_1:RecordAudio("107101021", var_87_19)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_107101", "107101021", "story_v_out_107101.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_107101", "107101021", "story_v_out_107101.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_20 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_20

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_20 and arg_84_1.time_ < var_87_10 + var_87_20 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play107101022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 107101022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play107101023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["3007_tpose"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect3007_tpose == nil then
				arg_88_1.var_.characterEffect3007_tpose = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect3007_tpose and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_88_1.var_.characterEffect3007_tpose.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect3007_tpose then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_88_1.var_.characterEffect3007_tpose.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.05

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(107101022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 2
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play107101023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 107101023
		arg_92_1.duration_ = 2.77

		local var_92_0 = {
			ja = 2.066,
			ko = 2.766,
			zh = 2.233,
			en = 2.2
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
				arg_92_0:Play107101024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1084ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["3007_tpose"].transform
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.var_.moveOldPos3007_tpose = var_95_4.localPosition

				local var_95_6 = GameObjectTools.GetOrAddComponent(var_95_4.gameObject, typeof(DynamicBoneHelper))

				if var_95_6 then
					var_95_6:EnableDynamicBone(false)
				end
			end

			local var_95_7 = 0.001

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_7 then
				local var_95_8 = (arg_92_1.time_ - var_95_5) / var_95_7
				local var_95_9 = Vector3.New(0, 100, 0)

				var_95_4.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3007_tpose, var_95_9, var_95_8)

				local var_95_10 = manager.ui.mainCamera.transform.position - var_95_4.position

				var_95_4.forward = Vector3.New(var_95_10.x, var_95_10.y, var_95_10.z)

				local var_95_11 = var_95_4.localEulerAngles

				var_95_11.z = 0
				var_95_11.x = 0
				var_95_4.localEulerAngles = var_95_11
			end

			if arg_92_1.time_ >= var_95_5 + var_95_7 and arg_92_1.time_ < var_95_5 + var_95_7 + arg_95_0 then
				var_95_4.localPosition = Vector3.New(0, 100, 0)

				local var_95_12 = manager.ui.mainCamera.transform.position - var_95_4.position

				var_95_4.forward = Vector3.New(var_95_12.x, var_95_12.y, var_95_12.z)

				local var_95_13 = var_95_4.localEulerAngles

				var_95_13.z = 0
				var_95_13.x = 0
				var_95_4.localEulerAngles = var_95_13

				local var_95_14 = GameObjectTools.GetOrAddComponent(var_95_4.gameObject, typeof(DynamicBoneHelper))

				if var_95_14 then
					var_95_14:EnableDynamicBone(true)
				end
			end

			local var_95_15 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_15.localPosition

				local var_95_17 = "1084ui_story"

				arg_92_1:ShowWeapon(arg_92_1.var_[var_95_17 .. "Animator"].transform, true)
			end

			local var_95_18 = 0.001

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_18 then
				local var_95_19 = (arg_92_1.time_ - var_95_16) / var_95_18
				local var_95_20 = Vector3.New(0, -0.97, -6)

				var_95_15.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_20, var_95_19)

				local var_95_21 = manager.ui.mainCamera.transform.position - var_95_15.position

				var_95_15.forward = Vector3.New(var_95_21.x, var_95_21.y, var_95_21.z)

				local var_95_22 = var_95_15.localEulerAngles

				var_95_22.z = 0
				var_95_22.x = 0
				var_95_15.localEulerAngles = var_95_22
			end

			if arg_92_1.time_ >= var_95_16 + var_95_18 and arg_92_1.time_ < var_95_16 + var_95_18 + arg_95_0 then
				var_95_15.localPosition = Vector3.New(0, -0.97, -6)

				local var_95_23 = manager.ui.mainCamera.transform.position - var_95_15.position

				var_95_15.forward = Vector3.New(var_95_23.x, var_95_23.y, var_95_23.z)

				local var_95_24 = var_95_15.localEulerAngles

				var_95_24.z = 0
				var_95_24.x = 0
				var_95_15.localEulerAngles = var_95_24
			end

			local var_95_25 = 0

			if var_95_25 < arg_92_1.time_ and arg_92_1.time_ <= var_95_25 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_95_26 = 0

			if var_95_26 < arg_92_1.time_ and arg_92_1.time_ <= var_95_26 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_95_27 = 0
			local var_95_28 = 0.275

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_29 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_30 = arg_92_1:GetWordFromCfg(107101023)
				local var_95_31 = arg_92_1:FormatText(var_95_30.content)

				arg_92_1.text_.text = var_95_31

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_32 = 11
				local var_95_33 = utf8.len(var_95_31)
				local var_95_34 = var_95_32 <= 0 and var_95_28 or var_95_28 * (var_95_33 / var_95_32)

				if var_95_34 > 0 and var_95_28 < var_95_34 then
					arg_92_1.talkMaxDuration = var_95_34

					if var_95_34 + var_95_27 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_34 + var_95_27
					end
				end

				arg_92_1.text_.text = var_95_31
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101023", "story_v_out_107101.awb") ~= 0 then
					local var_95_35 = manager.audio:GetVoiceLength("story_v_out_107101", "107101023", "story_v_out_107101.awb") / 1000

					if var_95_35 + var_95_27 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_35 + var_95_27
					end

					if var_95_30.prefab_name ~= "" and arg_92_1.actors_[var_95_30.prefab_name] ~= nil then
						local var_95_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_30.prefab_name].transform, "story_v_out_107101", "107101023", "story_v_out_107101.awb")

						arg_92_1:RecordAudio("107101023", var_95_36)
						arg_92_1:RecordAudio("107101023", var_95_36)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_107101", "107101023", "story_v_out_107101.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_107101", "107101023", "story_v_out_107101.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_37 = math.max(var_95_28, arg_92_1.talkMaxDuration)

			if var_95_27 <= arg_92_1.time_ and arg_92_1.time_ < var_95_27 + var_95_37 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_27) / var_95_37

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_27 + var_95_37 and arg_92_1.time_ < var_95_27 + var_95_37 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play107101024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 107101024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play107101025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1084ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_5
			end

			local var_99_6 = arg_96_1.actors_["1084ui_story"].transform
			local var_99_7 = 0

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = var_99_6.localPosition
			end

			local var_99_8 = 0.001

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_8 then
				local var_99_9 = (arg_96_1.time_ - var_99_7) / var_99_8
				local var_99_10 = Vector3.New(0, 100, 0)

				var_99_6.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, var_99_10, var_99_9)

				local var_99_11 = manager.ui.mainCamera.transform.position - var_99_6.position

				var_99_6.forward = Vector3.New(var_99_11.x, var_99_11.y, var_99_11.z)

				local var_99_12 = var_99_6.localEulerAngles

				var_99_12.z = 0
				var_99_12.x = 0
				var_99_6.localEulerAngles = var_99_12
			end

			if arg_96_1.time_ >= var_99_7 + var_99_8 and arg_96_1.time_ < var_99_7 + var_99_8 + arg_99_0 then
				var_99_6.localPosition = Vector3.New(0, 100, 0)

				local var_99_13 = manager.ui.mainCamera.transform.position - var_99_6.position

				var_99_6.forward = Vector3.New(var_99_13.x, var_99_13.y, var_99_13.z)

				local var_99_14 = var_99_6.localEulerAngles

				var_99_14.z = 0
				var_99_14.x = 0
				var_99_6.localEulerAngles = var_99_14
			end

			local var_99_15 = 0

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_99_16 = 0
			local var_99_17 = 0.55

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(107101024)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 22
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_17 or var_99_17 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_17 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_23 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_23 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_23

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_23 and arg_96_1.time_ < var_99_16 + var_99_23 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play107101025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 107101025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play107101026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.366666668156783
			local var_103_1 = 0.733333331843217

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				local var_103_2 = "play"
				local var_103_3 = "effect"

				arg_100_1:AudioAction(var_103_2, var_103_3, "se_story_7", "se_story_7_blast", "")
			end

			local var_103_4 = 0
			local var_103_5 = 1.1

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(107101025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_8 = 44
				local var_103_9 = utf8.len(var_103_7)
				local var_103_10 = var_103_8 <= 0 and var_103_5 or var_103_5 * (var_103_9 / var_103_8)

				if var_103_10 > 0 and var_103_5 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_11 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_11 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_11

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_11 and arg_100_1.time_ < var_103_4 + var_103_11 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play107101026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 107101026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play107101027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["3007_tpose"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos3007_tpose = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, -2.25, -1.9)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos3007_tpose, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = 0

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_107_12 = 0
			local var_107_13 = 0.775

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(107101026)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 31
				local var_107_17 = utf8.len(var_107_15)
				local var_107_18 = var_107_16 <= 0 and var_107_13 or var_107_13 * (var_107_17 / var_107_16)

				if var_107_18 > 0 and var_107_13 < var_107_18 then
					arg_104_1.talkMaxDuration = var_107_18

					if var_107_18 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_12
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_19 = math.max(var_107_13, arg_104_1.talkMaxDuration)

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_19 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_12) / var_107_19

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_12 + var_107_19 and arg_104_1.time_ < var_107_12 + var_107_19 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play107101027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 107101027
		arg_108_1.duration_ = 2.87

		local var_108_0 = {
			ja = 2.866,
			ko = 2.366,
			zh = 2.766,
			en = 2.833
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
				arg_108_0:Play107101028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.275

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(107101027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 11
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101027", "story_v_out_107101.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_107101", "107101027", "story_v_out_107101.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_107101", "107101027", "story_v_out_107101.awb")

						arg_108_1:RecordAudio("107101027", var_111_9)
						arg_108_1:RecordAudio("107101027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_107101", "107101027", "story_v_out_107101.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_107101", "107101027", "story_v_out_107101.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play107101028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 107101028
		arg_112_1.duration_ = 15.9

		local var_112_0 = {
			ja = 15.9,
			ko = 14.3,
			zh = 14.233,
			en = 14.933
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
				arg_112_0:Play107101029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["3007_tpose"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3007_tpose == nil then
				arg_112_1.var_.characterEffect3007_tpose = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect3007_tpose and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3007_tpose then
				arg_112_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_115_4 = 0
			local var_115_5 = 0.7

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_6 = arg_112_1:FormatText(StoryNameCfg[98].name)

				arg_112_1.leftNameTxt_.text = var_115_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(107101028)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101028", "story_v_out_107101.awb") ~= 0 then
					local var_115_12 = manager.audio:GetVoiceLength("story_v_out_107101", "107101028", "story_v_out_107101.awb") / 1000

					if var_115_12 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_4
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_107101", "107101028", "story_v_out_107101.awb")

						arg_112_1:RecordAudio("107101028", var_115_13)
						arg_112_1:RecordAudio("107101028", var_115_13)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_107101", "107101028", "story_v_out_107101.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_107101", "107101028", "story_v_out_107101.awb")
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
	Play107101029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 107101029
		arg_116_1.duration_ = 3.67

		local var_116_0 = {
			ja = 3.666,
			ko = 2.3,
			zh = 1.6,
			en = 1.633
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play107101030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["3007_tpose"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect3007_tpose == nil then
				arg_116_1.var_.characterEffect3007_tpose = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect3007_tpose and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_116_1.var_.characterEffect3007_tpose.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect3007_tpose then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_116_1.var_.characterEffect3007_tpose.fillRatio = var_119_5
			end

			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_119_7 = 0
			local var_119_8 = 0.225

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_9 = arg_116_1:FormatText(StoryNameCfg[94].name)

				arg_116_1.leftNameTxt_.text = var_119_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_10 = arg_116_1:GetWordFromCfg(107101029)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_12 = 9
				local var_119_13 = utf8.len(var_119_11)
				local var_119_14 = var_119_12 <= 0 and var_119_8 or var_119_8 * (var_119_13 / var_119_12)

				if var_119_14 > 0 and var_119_8 < var_119_14 then
					arg_116_1.talkMaxDuration = var_119_14

					if var_119_14 + var_119_7 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_7
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101029", "story_v_out_107101.awb") ~= 0 then
					local var_119_15 = manager.audio:GetVoiceLength("story_v_out_107101", "107101029", "story_v_out_107101.awb") / 1000

					if var_119_15 + var_119_7 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_7
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_out_107101", "107101029", "story_v_out_107101.awb")

						arg_116_1:RecordAudio("107101029", var_119_16)
						arg_116_1:RecordAudio("107101029", var_119_16)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_107101", "107101029", "story_v_out_107101.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_107101", "107101029", "story_v_out_107101.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_17 = math.max(var_119_8, arg_116_1.talkMaxDuration)

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_17 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_7) / var_119_17

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_7 + var_119_17 and arg_116_1.time_ < var_119_7 + var_119_17 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play107101030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 107101030
		arg_120_1.duration_ = 14.1

		local var_120_0 = {
			ja = 14.1,
			ko = 10.7,
			zh = 12.466,
			en = 10.333
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play107101031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.175

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[10].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(107101030)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 47
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101030", "story_v_out_107101.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_107101", "107101030", "story_v_out_107101.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_107101", "107101030", "story_v_out_107101.awb")

						arg_120_1:RecordAudio("107101030", var_123_9)
						arg_120_1:RecordAudio("107101030", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_107101", "107101030", "story_v_out_107101.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_107101", "107101030", "story_v_out_107101.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play107101031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 107101031
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			ja = 4.566,
			ko = 3.1,
			zh = 5.1,
			en = 4.7
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
			arg_124_1.auto_ = false
		end

		function arg_124_1.playNext_(arg_126_0)
			arg_124_1.onStoryFinished_()
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["3007_tpose"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect3007_tpose == nil then
				arg_124_1.var_.characterEffect3007_tpose = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect3007_tpose and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect3007_tpose then
				arg_124_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_127_4 = manager.ui.mainCamera.transform
			local var_127_5 = 0.1

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.var_.shakeOldPos = var_127_4.localPosition
			end

			local var_127_6 = 0.6

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / 0.099
				local var_127_8, var_127_9 = math.modf(var_127_7)

				var_127_4.localPosition = Vector3.New(var_127_9 * 0.13, var_127_9 * 0.13, var_127_9 * 0.13) + arg_124_1.var_.shakeOldPos
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 then
				var_127_4.localPosition = arg_124_1.var_.shakeOldPos
			end

			local var_127_10 = 0
			local var_127_11 = 0.1

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_12 = arg_124_1:FormatText(StoryNameCfg[98].name)

				arg_124_1.leftNameTxt_.text = var_127_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_13 = arg_124_1:GetWordFromCfg(107101031)
				local var_127_14 = arg_124_1:FormatText(var_127_13.content)

				arg_124_1.text_.text = var_127_14

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_15 = 4
				local var_127_16 = utf8.len(var_127_14)
				local var_127_17 = var_127_15 <= 0 and var_127_11 or var_127_11 * (var_127_16 / var_127_15)

				if var_127_17 > 0 and var_127_11 < var_127_17 then
					arg_124_1.talkMaxDuration = var_127_17

					if var_127_17 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_17 + var_127_10
					end
				end

				arg_124_1.text_.text = var_127_14
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107101", "107101031", "story_v_out_107101.awb") ~= 0 then
					local var_127_18 = manager.audio:GetVoiceLength("story_v_out_107101", "107101031", "story_v_out_107101.awb") / 1000

					if var_127_18 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_18 + var_127_10
					end

					if var_127_13.prefab_name ~= "" and arg_124_1.actors_[var_127_13.prefab_name] ~= nil then
						local var_127_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_13.prefab_name].transform, "story_v_out_107101", "107101031", "story_v_out_107101.awb")

						arg_124_1:RecordAudio("107101031", var_127_19)
						arg_124_1:RecordAudio("107101031", var_127_19)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_107101", "107101031", "story_v_out_107101.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_107101", "107101031", "story_v_out_107101.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_20 = math.max(var_127_11, arg_124_1.talkMaxDuration)

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_20 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_10) / var_127_20

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_10 + var_127_20 and arg_124_1.time_ < var_127_10 + var_127_20 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C06b",
		"TextureConfig/Background/C03a"
	},
	voices = {
		"story_v_out_107101.awb"
	}
}
