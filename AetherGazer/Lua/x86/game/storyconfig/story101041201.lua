return {
	Play104121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104121001
		arg_1_1.duration_ = 4.53

		local var_1_0 = {
			ja = 4.53266666666667,
			ko = 4.06666666666667,
			zh = 3.29966666666667,
			en = 3.76666666666667
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
				arg_1_0:Play104121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "B04f"

			if arg_1_1.bgs_[var_4_10] == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.B04f
			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = var_4_12:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueB04f = var_4_14.color.a
					arg_1_1.var_.alphaMatValueB04f = var_4_14
				end

				arg_1_1.var_.alphaOldValueB04f = 0
			end

			local var_4_15 = 1.5

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_13) / var_4_15
				local var_4_17 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB04f, 1, var_4_16)

				if arg_1_1.var_.alphaMatValueB04f then
					local var_4_18 = arg_1_1.var_.alphaMatValueB04f.color

					var_4_18.a = var_4_17
					arg_1_1.var_.alphaMatValueB04f.color = var_4_18
				end
			end

			if arg_1_1.time_ >= var_4_13 + var_4_15 and arg_1_1.time_ < var_4_13 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueB04f then
				local var_4_19 = arg_1_1.var_.alphaMatValueB04f
				local var_4_20 = var_4_19.color

				var_4_20.a = 1
				var_4_19.color = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.B04f

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_36 = 1.66666666666667

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_37 = "1084ui_story"

			if arg_1_1.actors_[var_4_37] == nil then
				local var_4_38 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_38) then
					local var_4_39 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

					var_4_39.name = var_4_37
					var_4_39.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_37] = var_4_39

					local var_4_40 = var_4_39:GetComponentInChildren(typeof(CharacterEffect))

					var_4_40.enabled = true

					local var_4_41 = GameObjectTools.GetOrAddComponent(var_4_39, typeof(DynamicBoneHelper))

					if var_4_41 then
						var_4_41:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_40.transform, false)

					arg_1_1.var_[var_4_37 .. "Animator"] = var_4_40.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_37 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_37 .. "LipSync"] = var_4_40.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_42 = 0

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_43 = 1.66666666666667
			local var_4_44 = 0.175

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_45 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_45:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_46 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_47 = arg_1_1:GetWordFromCfg(104121001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 7
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_44 or var_4_44 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_44 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_43 = var_4_43 + 0.3

					if var_4_51 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_43
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121001", "story_v_out_104121.awb") ~= 0 then
					local var_4_52 = manager.audio:GetVoiceLength("story_v_out_104121", "104121001", "story_v_out_104121.awb") / 1000

					if var_4_52 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_52 + var_4_43
					end

					if var_4_47.prefab_name ~= "" and arg_1_1.actors_[var_4_47.prefab_name] ~= nil then
						local var_4_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_47.prefab_name].transform, "story_v_out_104121", "104121001", "story_v_out_104121.awb")

						arg_1_1:RecordAudio("104121001", var_4_53)
						arg_1_1:RecordAudio("104121001", var_4_53)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104121", "104121001", "story_v_out_104121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104121", "104121001", "story_v_out_104121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_54 = var_4_43 + 0.3
			local var_4_55 = math.max(var_4_44, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_55

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104121002
		arg_8_1.duration_ = 3.43

		local var_8_0 = {
			ja = 3.433,
			ko = 2.366,
			zh = 2.333,
			en = 1.666
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
				arg_8_0:Play104121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1019ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_11_6 = 0
			local var_11_7 = 0.2

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[13].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(104121002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 8
				local var_11_12 = utf8.len(var_11_10)
				local var_11_13 = var_11_11 <= 0 and var_11_7 or var_11_7 * (var_11_12 / var_11_11)

				if var_11_13 > 0 and var_11_7 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121002", "story_v_out_104121.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_104121", "104121002", "story_v_out_104121.awb") / 1000

					if var_11_14 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_6
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_104121", "104121002", "story_v_out_104121.awb")

						arg_8_1:RecordAudio("104121002", var_11_15)
						arg_8_1:RecordAudio("104121002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104121", "104121002", "story_v_out_104121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104121", "104121002", "story_v_out_104121.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_16 and arg_8_1.time_ < var_11_6 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104121003
		arg_12_1.duration_ = 3.37

		local var_12_0 = {
			ja = 3.366,
			ko = 2.866,
			zh = 2.5,
			en = 2.366
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
				arg_12_0:Play104121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1011ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.175

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[37].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(104121003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 7
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121003", "story_v_out_104121.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_104121", "104121003", "story_v_out_104121.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_104121", "104121003", "story_v_out_104121.awb")

						arg_12_1:RecordAudio("104121003", var_15_15)
						arg_12_1:RecordAudio("104121003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104121", "104121003", "story_v_out_104121.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104121", "104121003", "story_v_out_104121.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104121004
		arg_16_1.duration_ = 5.5

		local var_16_0 = {
			ja = 4.233,
			ko = 3.3,
			zh = 3.666,
			en = 5.5
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
				arg_16_0:Play104121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1036ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1036ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1036ui_story == nil then
				arg_16_1.var_.characterEffect1036ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1036ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1036ui_story then
				arg_16_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1036ui_story"].transform
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPos1036ui_story = var_19_9.localPosition
			end

			local var_19_11 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11
				local var_19_13 = Vector3.New(0, -1.09, -5.78)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1036ui_story, var_19_13, var_19_12)

				local var_19_14 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_14.x, var_19_14.y, var_19_14.z)

				local var_19_15 = var_19_9.localEulerAngles

				var_19_15.z = 0
				var_19_15.x = 0
				var_19_9.localEulerAngles = var_19_15
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_9.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_9.localEulerAngles = var_19_17
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_20 = 0
			local var_19_21 = 0.325

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[5].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(104121004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 13
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121004", "story_v_out_104121.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_104121", "104121004", "story_v_out_104121.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_104121", "104121004", "story_v_out_104121.awb")

						arg_16_1:RecordAudio("104121004", var_19_29)
						arg_16_1:RecordAudio("104121004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104121", "104121004", "story_v_out_104121.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104121", "104121004", "story_v_out_104121.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104121005
		arg_20_1.duration_ = 5.33

		local var_20_0 = {
			ja = 3.9,
			ko = 5.333,
			zh = 4.4,
			en = 4.833
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play104121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_23_1 = 0
			local var_23_2 = 0.375

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[5].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(104121005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 15
				local var_23_7 = utf8.len(var_23_5)
				local var_23_8 = var_23_6 <= 0 and var_23_2 or var_23_2 * (var_23_7 / var_23_6)

				if var_23_8 > 0 and var_23_2 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8

					if var_23_8 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121005", "story_v_out_104121.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_104121", "104121005", "story_v_out_104121.awb") / 1000

					if var_23_9 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_1
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_104121", "104121005", "story_v_out_104121.awb")

						arg_20_1:RecordAudio("104121005", var_23_10)
						arg_20_1:RecordAudio("104121005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104121", "104121005", "story_v_out_104121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104121", "104121005", "story_v_out_104121.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_11 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_11

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_11 and arg_20_1.time_ < var_23_1 + var_23_11 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play104121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104121006
		arg_24_1.duration_ = 8.63

		local var_24_0 = {
			ja = 6.266,
			ko = 8.633,
			zh = 5.4,
			en = 6.4
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
				arg_24_0:Play104121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "10001_tpose"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["10001_tpose"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect10001_tpose == nil then
				arg_24_1.var_.characterEffect10001_tpose = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect10001_tpose and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect10001_tpose then
				arg_24_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1036ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1036ui_story == nil then
				arg_24_1.var_.characterEffect1036ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1036ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1036ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1036ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1036ui_story.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["1036ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos1036ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0, 100, 0)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1036ui_story, var_27_19, var_27_18)

				local var_27_20 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_20.x, var_27_20.y, var_27_20.z)

				local var_27_21 = var_27_15.localEulerAngles

				var_27_21.z = 0
				var_27_21.x = 0
				var_27_15.localEulerAngles = var_27_21
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0, 100, 0)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_15.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_15.localEulerAngles = var_27_23
			end

			local var_27_24 = arg_24_1.actors_["10001_tpose"].transform
			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.var_.moveOldPos10001_tpose = var_27_24.localPosition

				local var_27_26 = GameObjectTools.GetOrAddComponent(var_27_24.gameObject, typeof(DynamicBoneHelper))

				if var_27_26 then
					var_27_26:EnableDynamicBone(false)
				end
			end

			local var_27_27 = 0.001

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_27 then
				local var_27_28 = (arg_24_1.time_ - var_27_25) / var_27_27
				local var_27_29 = Vector3.New(0, -1.23, -5.8)

				var_27_24.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10001_tpose, var_27_29, var_27_28)

				local var_27_30 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_30.x, var_27_30.y, var_27_30.z)

				local var_27_31 = var_27_24.localEulerAngles

				var_27_31.z = 0
				var_27_31.x = 0
				var_27_24.localEulerAngles = var_27_31
			end

			if arg_24_1.time_ >= var_27_25 + var_27_27 and arg_24_1.time_ < var_27_25 + var_27_27 + arg_27_0 then
				var_27_24.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_27_32 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_32.x, var_27_32.y, var_27_32.z)

				local var_27_33 = var_27_24.localEulerAngles

				var_27_33.z = 0
				var_27_33.x = 0
				var_27_24.localEulerAngles = var_27_33

				local var_27_34 = GameObjectTools.GetOrAddComponent(var_27_24.gameObject, typeof(DynamicBoneHelper))

				if var_27_34 then
					var_27_34:EnableDynamicBone(true)
				end
			end

			local var_27_35 = 0

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_27_36 = 0

			if var_27_36 < arg_24_1.time_ and arg_24_1.time_ <= var_27_36 + arg_27_0 then
				arg_24_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_27_37 = 0
			local var_27_38 = 0.425

			if var_27_37 < arg_24_1.time_ and arg_24_1.time_ <= var_27_37 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_39 = arg_24_1:FormatText(StoryNameCfg[31].name)

				arg_24_1.leftNameTxt_.text = var_27_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_40 = arg_24_1:GetWordFromCfg(104121006)
				local var_27_41 = arg_24_1:FormatText(var_27_40.content)

				arg_24_1.text_.text = var_27_41

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_42 = 16
				local var_27_43 = utf8.len(var_27_41)
				local var_27_44 = var_27_42 <= 0 and var_27_38 or var_27_38 * (var_27_43 / var_27_42)

				if var_27_44 > 0 and var_27_38 < var_27_44 then
					arg_24_1.talkMaxDuration = var_27_44

					if var_27_44 + var_27_37 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_44 + var_27_37
					end
				end

				arg_24_1.text_.text = var_27_41
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121006", "story_v_out_104121.awb") ~= 0 then
					local var_27_45 = manager.audio:GetVoiceLength("story_v_out_104121", "104121006", "story_v_out_104121.awb") / 1000

					if var_27_45 + var_27_37 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_45 + var_27_37
					end

					if var_27_40.prefab_name ~= "" and arg_24_1.actors_[var_27_40.prefab_name] ~= nil then
						local var_27_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_40.prefab_name].transform, "story_v_out_104121", "104121006", "story_v_out_104121.awb")

						arg_24_1:RecordAudio("104121006", var_27_46)
						arg_24_1:RecordAudio("104121006", var_27_46)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104121", "104121006", "story_v_out_104121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104121", "104121006", "story_v_out_104121.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_47 = math.max(var_27_38, arg_24_1.talkMaxDuration)

			if var_27_37 <= arg_24_1.time_ and arg_24_1.time_ < var_27_37 + var_27_47 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_37) / var_27_47

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_37 + var_27_47 and arg_24_1.time_ < var_27_37 + var_27_47 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104121007
		arg_28_1.duration_ = 6.13

		local var_28_0 = {
			ja = 3.266,
			ko = 3.833,
			zh = 4.266,
			en = 6.133
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
				arg_28_0:Play104121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["10001_tpose"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10001_tpose == nil then
				arg_28_1.var_.characterEffect10001_tpose = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect10001_tpose and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_28_1.var_.characterEffect10001_tpose.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10001_tpose then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_28_1.var_.characterEffect10001_tpose.fillRatio = var_31_9
			end

			local var_31_10 = arg_28_1.actors_["10001_tpose"].transform
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.var_.moveOldPos10001_tpose = var_31_10.localPosition

				local var_31_12 = GameObjectTools.GetOrAddComponent(var_31_10.gameObject, typeof(DynamicBoneHelper))

				if var_31_12 then
					var_31_12:EnableDynamicBone(false)
				end
			end

			local var_31_13 = 0.001

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_13 then
				local var_31_14 = (arg_28_1.time_ - var_31_11) / var_31_13
				local var_31_15 = Vector3.New(0, 100, 0)

				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10001_tpose, var_31_15, var_31_14)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_10.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_10.localEulerAngles = var_31_17
			end

			if arg_28_1.time_ >= var_31_11 + var_31_13 and arg_28_1.time_ < var_31_11 + var_31_13 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(0, 100, 0)

				local var_31_18 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_18.x, var_31_18.y, var_31_18.z)

				local var_31_19 = var_31_10.localEulerAngles

				var_31_19.z = 0
				var_31_19.x = 0
				var_31_10.localEulerAngles = var_31_19

				local var_31_20 = GameObjectTools.GetOrAddComponent(var_31_10.gameObject, typeof(DynamicBoneHelper))

				if var_31_20 then
					var_31_20:EnableDynamicBone(true)
				end
			end

			local var_31_21 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_22 = 0

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_21.localPosition
			end

			local var_31_23 = 0.001

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_23 then
				local var_31_24 = (arg_28_1.time_ - var_31_22) / var_31_23
				local var_31_25 = Vector3.New(-0.2, -1.08, -5.9)

				var_31_21.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_25, var_31_24)

				local var_31_26 = manager.ui.mainCamera.transform.position - var_31_21.position

				var_31_21.forward = Vector3.New(var_31_26.x, var_31_26.y, var_31_26.z)

				local var_31_27 = var_31_21.localEulerAngles

				var_31_27.z = 0
				var_31_27.x = 0
				var_31_21.localEulerAngles = var_31_27
			end

			if arg_28_1.time_ >= var_31_22 + var_31_23 and arg_28_1.time_ < var_31_22 + var_31_23 + arg_31_0 then
				var_31_21.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_31_28 = manager.ui.mainCamera.transform.position - var_31_21.position

				var_31_21.forward = Vector3.New(var_31_28.x, var_31_28.y, var_31_28.z)

				local var_31_29 = var_31_21.localEulerAngles

				var_31_29.z = 0
				var_31_29.x = 0
				var_31_21.localEulerAngles = var_31_29
			end

			local var_31_30 = 0

			if var_31_30 < arg_28_1.time_ and arg_28_1.time_ <= var_31_30 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_31_31 = 0

			if var_31_31 < arg_28_1.time_ and arg_28_1.time_ <= var_31_31 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_31_32 = 0
			local var_31_33 = 0.4

			if var_31_32 < arg_28_1.time_ and arg_28_1.time_ <= var_31_32 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_34 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_35 = arg_28_1:GetWordFromCfg(104121007)
				local var_31_36 = arg_28_1:FormatText(var_31_35.content)

				arg_28_1.text_.text = var_31_36

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_37 = 16
				local var_31_38 = utf8.len(var_31_36)
				local var_31_39 = var_31_37 <= 0 and var_31_33 or var_31_33 * (var_31_38 / var_31_37)

				if var_31_39 > 0 and var_31_33 < var_31_39 then
					arg_28_1.talkMaxDuration = var_31_39

					if var_31_39 + var_31_32 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_39 + var_31_32
					end
				end

				arg_28_1.text_.text = var_31_36
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121007", "story_v_out_104121.awb") ~= 0 then
					local var_31_40 = manager.audio:GetVoiceLength("story_v_out_104121", "104121007", "story_v_out_104121.awb") / 1000

					if var_31_40 + var_31_32 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_40 + var_31_32
					end

					if var_31_35.prefab_name ~= "" and arg_28_1.actors_[var_31_35.prefab_name] ~= nil then
						local var_31_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_35.prefab_name].transform, "story_v_out_104121", "104121007", "story_v_out_104121.awb")

						arg_28_1:RecordAudio("104121007", var_31_41)
						arg_28_1:RecordAudio("104121007", var_31_41)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104121", "104121007", "story_v_out_104121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104121", "104121007", "story_v_out_104121.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_42 = math.max(var_31_33, arg_28_1.talkMaxDuration)

			if var_31_32 <= arg_28_1.time_ and arg_28_1.time_ < var_31_32 + var_31_42 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_32) / var_31_42

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_32 + var_31_42 and arg_28_1.time_ < var_31_32 + var_31_42 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play104121008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104121008
		arg_32_1.duration_ = 11.6

		local var_32_0 = {
			ja = 11.6,
			ko = 9.3,
			zh = 6.7,
			en = 8.533
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
				arg_32_0:Play104121009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10001_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10001_tpose == nil then
				arg_32_1.var_.characterEffect10001_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10001_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10001_tpose then
				arg_32_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1019ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1019ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_9
			end

			local var_35_10 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_10.localPosition
			end

			local var_35_12 = 0.001

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_11) / var_35_12
				local var_35_14 = Vector3.New(-0.2, -1.08, -5.9)

				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_14, var_35_13)

				local var_35_15 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_15.x, var_35_15.y, var_35_15.z)

				local var_35_16 = var_35_10.localEulerAngles

				var_35_16.z = 0
				var_35_16.x = 0
				var_35_10.localEulerAngles = var_35_16
			end

			if arg_32_1.time_ >= var_35_11 + var_35_12 and arg_32_1.time_ < var_35_11 + var_35_12 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_10.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_10.localEulerAngles = var_35_18
			end

			local var_35_19 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_20 = 0.033

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_19.localPosition
			end

			local var_35_21 = 0.5

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_21 then
				local var_35_22 = (arg_32_1.time_ - var_35_20) / var_35_21
				local var_35_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_35_19.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_23, var_35_22)

				local var_35_24 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_24.x, var_35_24.y, var_35_24.z)

				local var_35_25 = var_35_19.localEulerAngles

				var_35_25.z = 0
				var_35_25.x = 0
				var_35_19.localEulerAngles = var_35_25
			end

			if arg_32_1.time_ >= var_35_20 + var_35_21 and arg_32_1.time_ < var_35_20 + var_35_21 + arg_35_0 then
				var_35_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_35_26 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_26.x, var_35_26.y, var_35_26.z)

				local var_35_27 = var_35_19.localEulerAngles

				var_35_27.z = 0
				var_35_27.x = 0
				var_35_19.localEulerAngles = var_35_27
			end

			local var_35_28 = arg_32_1.actors_["10001_tpose"].transform
			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1.var_.moveOldPos10001_tpose = var_35_28.localPosition

				local var_35_30 = GameObjectTools.GetOrAddComponent(var_35_28.gameObject, typeof(DynamicBoneHelper))

				if var_35_30 then
					var_35_30:EnableDynamicBone(false)
				end
			end

			local var_35_31 = 0.001

			if var_35_29 <= arg_32_1.time_ and arg_32_1.time_ < var_35_29 + var_35_31 then
				local var_35_32 = (arg_32_1.time_ - var_35_29) / var_35_31
				local var_35_33 = Vector3.New(0.7, -1.23, -5.8)

				var_35_28.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10001_tpose, var_35_33, var_35_32)

				local var_35_34 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_34.x, var_35_34.y, var_35_34.z)

				local var_35_35 = var_35_28.localEulerAngles

				var_35_35.z = 0
				var_35_35.x = 0
				var_35_28.localEulerAngles = var_35_35
			end

			if arg_32_1.time_ >= var_35_29 + var_35_31 and arg_32_1.time_ < var_35_29 + var_35_31 + arg_35_0 then
				var_35_28.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_35_36 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_36.x, var_35_36.y, var_35_36.z)

				local var_35_37 = var_35_28.localEulerAngles

				var_35_37.z = 0
				var_35_37.x = 0
				var_35_28.localEulerAngles = var_35_37

				local var_35_38 = GameObjectTools.GetOrAddComponent(var_35_28.gameObject, typeof(DynamicBoneHelper))

				if var_35_38 then
					var_35_38:EnableDynamicBone(true)
				end
			end

			local var_35_39 = 0

			if var_35_39 < arg_32_1.time_ and arg_32_1.time_ <= var_35_39 + arg_35_0 then
				arg_32_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_1")
			end

			local var_35_40 = 0

			if var_35_40 < arg_32_1.time_ and arg_32_1.time_ <= var_35_40 + arg_35_0 then
				arg_32_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_35_41 = 0
			local var_35_42 = 0.9

			if var_35_41 < arg_32_1.time_ and arg_32_1.time_ <= var_35_41 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_43 = arg_32_1:FormatText(StoryNameCfg[31].name)

				arg_32_1.leftNameTxt_.text = var_35_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_44 = arg_32_1:GetWordFromCfg(104121008)
				local var_35_45 = arg_32_1:FormatText(var_35_44.content)

				arg_32_1.text_.text = var_35_45

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_46 = 35
				local var_35_47 = utf8.len(var_35_45)
				local var_35_48 = var_35_46 <= 0 and var_35_42 or var_35_42 * (var_35_47 / var_35_46)

				if var_35_48 > 0 and var_35_42 < var_35_48 then
					arg_32_1.talkMaxDuration = var_35_48

					if var_35_48 + var_35_41 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_48 + var_35_41
					end
				end

				arg_32_1.text_.text = var_35_45
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121008", "story_v_out_104121.awb") ~= 0 then
					local var_35_49 = manager.audio:GetVoiceLength("story_v_out_104121", "104121008", "story_v_out_104121.awb") / 1000

					if var_35_49 + var_35_41 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_49 + var_35_41
					end

					if var_35_44.prefab_name ~= "" and arg_32_1.actors_[var_35_44.prefab_name] ~= nil then
						local var_35_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_44.prefab_name].transform, "story_v_out_104121", "104121008", "story_v_out_104121.awb")

						arg_32_1:RecordAudio("104121008", var_35_50)
						arg_32_1:RecordAudio("104121008", var_35_50)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104121", "104121008", "story_v_out_104121.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104121", "104121008", "story_v_out_104121.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_51 = math.max(var_35_42, arg_32_1.talkMaxDuration)

			if var_35_41 <= arg_32_1.time_ and arg_32_1.time_ < var_35_41 + var_35_51 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_41) / var_35_51

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_41 + var_35_51 and arg_32_1.time_ < var_35_41 + var_35_51 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104121009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104121009
		arg_36_1.duration_ = 2.7

		local var_36_0 = {
			ja = 1.999999999999,
			ko = 2.7,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_36_0:Play104121010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1036ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1036ui_story == nil then
				arg_36_1.var_.characterEffect1036ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1036ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1036ui_story then
				arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["10001_tpose"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect10001_tpose == nil then
				arg_36_1.var_.characterEffect10001_tpose = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect10001_tpose and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_36_1.var_.characterEffect10001_tpose.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect10001_tpose then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_36_1.var_.characterEffect10001_tpose.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1019ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_10.localPosition
			end

			local var_39_12 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_10.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_10.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_11 + var_39_12 and arg_36_1.time_ < var_39_11 + var_39_12 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 100, 0)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_10.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_10.localEulerAngles = var_39_18
			end

			local var_39_19 = arg_36_1.actors_["1036ui_story"].transform
			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.var_.moveOldPos1036ui_story = var_39_19.localPosition
			end

			local var_39_21 = 0.001

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_20) / var_39_21
				local var_39_23 = Vector3.New(-0.7, -1.09, -5.78)

				var_39_19.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1036ui_story, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_19.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_19.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				var_39_19.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_19.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_19.localEulerAngles = var_39_27
			end

			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_30 = 0
			local var_39_31 = 0.15

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[5].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(104121009)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 6
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_31 or var_39_31 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_31 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37

					if var_39_37 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_30
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121009", "story_v_out_104121.awb") ~= 0 then
					local var_39_38 = manager.audio:GetVoiceLength("story_v_out_104121", "104121009", "story_v_out_104121.awb") / 1000

					if var_39_38 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_38 + var_39_30
					end

					if var_39_33.prefab_name ~= "" and arg_36_1.actors_[var_39_33.prefab_name] ~= nil then
						local var_39_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_33.prefab_name].transform, "story_v_out_104121", "104121009", "story_v_out_104121.awb")

						arg_36_1:RecordAudio("104121009", var_39_39)
						arg_36_1:RecordAudio("104121009", var_39_39)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104121", "104121009", "story_v_out_104121.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104121", "104121009", "story_v_out_104121.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_40 = math.max(var_39_31, arg_36_1.talkMaxDuration)

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_40 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_30) / var_39_40

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_30 + var_39_40 and arg_36_1.time_ < var_39_30 + var_39_40 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play104121010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104121010
		arg_40_1.duration_ = 11.73

		local var_40_0 = {
			ja = 11.6,
			ko = 11.133,
			zh = 11.733,
			en = 11.466
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
				arg_40_0:Play104121011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10001_tpose"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10001_tpose == nil then
				arg_40_1.var_.characterEffect10001_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10001_tpose and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10001_tpose then
				arg_40_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1036ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1036ui_story == nil then
				arg_40_1.var_.characterEffect1036ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1036ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1036ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1036ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1036ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action454")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_43_12 = 0
			local var_43_13 = 1.525

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[31].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(104121010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 61
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121010", "story_v_out_104121.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_104121", "104121010", "story_v_out_104121.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_104121", "104121010", "story_v_out_104121.awb")

						arg_40_1:RecordAudio("104121010", var_43_21)
						arg_40_1:RecordAudio("104121010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104121", "104121010", "story_v_out_104121.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104121", "104121010", "story_v_out_104121.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104121011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104121011
		arg_44_1.duration_ = 4.9

		local var_44_0 = {
			ja = 4.9,
			ko = 4,
			zh = 3.1,
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
				arg_44_0:Play104121012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["10001_tpose"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect10001_tpose == nil then
				arg_44_1.var_.characterEffect10001_tpose = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect10001_tpose and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_44_1.var_.characterEffect10001_tpose.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect10001_tpose then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_44_1.var_.characterEffect10001_tpose.fillRatio = var_47_9
			end

			local var_47_10 = arg_44_1.actors_["10001_tpose"].transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.moveOldPos10001_tpose = var_47_10.localPosition

				local var_47_12 = GameObjectTools.GetOrAddComponent(var_47_10.gameObject, typeof(DynamicBoneHelper))

				if var_47_12 then
					var_47_12:EnableDynamicBone(false)
				end
			end

			local var_47_13 = 0.001

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_13 then
				local var_47_14 = (arg_44_1.time_ - var_47_11) / var_47_13
				local var_47_15 = Vector3.New(0, 100, 0)

				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10001_tpose, var_47_15, var_47_14)

				local var_47_16 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_16.x, var_47_16.y, var_47_16.z)

				local var_47_17 = var_47_10.localEulerAngles

				var_47_17.z = 0
				var_47_17.x = 0
				var_47_10.localEulerAngles = var_47_17
			end

			if arg_44_1.time_ >= var_47_11 + var_47_13 and arg_44_1.time_ < var_47_11 + var_47_13 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0, 100, 0)

				local var_47_18 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_18.x, var_47_18.y, var_47_18.z)

				local var_47_19 = var_47_10.localEulerAngles

				var_47_19.z = 0
				var_47_19.x = 0
				var_47_10.localEulerAngles = var_47_19

				local var_47_20 = GameObjectTools.GetOrAddComponent(var_47_10.gameObject, typeof(DynamicBoneHelper))

				if var_47_20 then
					var_47_20:EnableDynamicBone(true)
				end
			end

			local var_47_21 = arg_44_1.actors_["1036ui_story"].transform
			local var_47_22 = 0

			if var_47_22 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				arg_44_1.var_.moveOldPos1036ui_story = var_47_21.localPosition
			end

			local var_47_23 = 0.001

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_23 then
				local var_47_24 = (arg_44_1.time_ - var_47_22) / var_47_23
				local var_47_25 = Vector3.New(0, 100, 0)

				var_47_21.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1036ui_story, var_47_25, var_47_24)

				local var_47_26 = manager.ui.mainCamera.transform.position - var_47_21.position

				var_47_21.forward = Vector3.New(var_47_26.x, var_47_26.y, var_47_26.z)

				local var_47_27 = var_47_21.localEulerAngles

				var_47_27.z = 0
				var_47_27.x = 0
				var_47_21.localEulerAngles = var_47_27
			end

			if arg_44_1.time_ >= var_47_22 + var_47_23 and arg_44_1.time_ < var_47_22 + var_47_23 + arg_47_0 then
				var_47_21.localPosition = Vector3.New(0, 100, 0)

				local var_47_28 = manager.ui.mainCamera.transform.position - var_47_21.position

				var_47_21.forward = Vector3.New(var_47_28.x, var_47_28.y, var_47_28.z)

				local var_47_29 = var_47_21.localEulerAngles

				var_47_29.z = 0
				var_47_29.x = 0
				var_47_21.localEulerAngles = var_47_29
			end

			local var_47_30 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_31 = 0

			if var_47_31 < arg_44_1.time_ and arg_44_1.time_ <= var_47_31 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_30.localPosition
			end

			local var_47_32 = 0.001

			if var_47_31 <= arg_44_1.time_ and arg_44_1.time_ < var_47_31 + var_47_32 then
				local var_47_33 = (arg_44_1.time_ - var_47_31) / var_47_32
				local var_47_34 = Vector3.New(0, -0.97, -6)

				var_47_30.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_34, var_47_33)

				local var_47_35 = manager.ui.mainCamera.transform.position - var_47_30.position

				var_47_30.forward = Vector3.New(var_47_35.x, var_47_35.y, var_47_35.z)

				local var_47_36 = var_47_30.localEulerAngles

				var_47_36.z = 0
				var_47_36.x = 0
				var_47_30.localEulerAngles = var_47_36
			end

			if arg_44_1.time_ >= var_47_31 + var_47_32 and arg_44_1.time_ < var_47_31 + var_47_32 + arg_47_0 then
				var_47_30.localPosition = Vector3.New(0, -0.97, -6)

				local var_47_37 = manager.ui.mainCamera.transform.position - var_47_30.position

				var_47_30.forward = Vector3.New(var_47_37.x, var_47_37.y, var_47_37.z)

				local var_47_38 = var_47_30.localEulerAngles

				var_47_38.z = 0
				var_47_38.x = 0
				var_47_30.localEulerAngles = var_47_38
			end

			local var_47_39 = 0

			if var_47_39 < arg_44_1.time_ and arg_44_1.time_ <= var_47_39 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_47_40 = 0

			if var_47_40 < arg_44_1.time_ and arg_44_1.time_ <= var_47_40 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_47_41 = 0
			local var_47_42 = 0.45

			if var_47_41 < arg_44_1.time_ and arg_44_1.time_ <= var_47_41 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_43 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_44 = arg_44_1:GetWordFromCfg(104121011)
				local var_47_45 = arg_44_1:FormatText(var_47_44.content)

				arg_44_1.text_.text = var_47_45

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_46 = 18
				local var_47_47 = utf8.len(var_47_45)
				local var_47_48 = var_47_46 <= 0 and var_47_42 or var_47_42 * (var_47_47 / var_47_46)

				if var_47_48 > 0 and var_47_42 < var_47_48 then
					arg_44_1.talkMaxDuration = var_47_48

					if var_47_48 + var_47_41 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_48 + var_47_41
					end
				end

				arg_44_1.text_.text = var_47_45
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121011", "story_v_out_104121.awb") ~= 0 then
					local var_47_49 = manager.audio:GetVoiceLength("story_v_out_104121", "104121011", "story_v_out_104121.awb") / 1000

					if var_47_49 + var_47_41 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_49 + var_47_41
					end

					if var_47_44.prefab_name ~= "" and arg_44_1.actors_[var_47_44.prefab_name] ~= nil then
						local var_47_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_44.prefab_name].transform, "story_v_out_104121", "104121011", "story_v_out_104121.awb")

						arg_44_1:RecordAudio("104121011", var_47_50)
						arg_44_1:RecordAudio("104121011", var_47_50)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104121", "104121011", "story_v_out_104121.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104121", "104121011", "story_v_out_104121.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_51 = math.max(var_47_42, arg_44_1.talkMaxDuration)

			if var_47_41 <= arg_44_1.time_ and arg_44_1.time_ < var_47_41 + var_47_51 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_41) / var_47_51

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_41 + var_47_51 and arg_44_1.time_ < var_47_41 + var_47_51 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_44_1:InitPlayNodeList()
	end,
	Play104121012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104121012
		arg_48_1.duration_ = 15.27

		local var_48_0 = {
			ja = 15.266,
			ko = 11.533,
			zh = 11.633,
			en = 15.1
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
				arg_48_0:Play104121013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10001_tpose"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10001_tpose == nil then
				arg_48_1.var_.characterEffect10001_tpose = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10001_tpose and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10001_tpose then
				arg_48_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1084ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["10001_tpose"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos10001_tpose = var_51_19.localPosition

				local var_51_21 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_21 then
					var_51_21:EnableDynamicBone(false)
				end
			end

			local var_51_22 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_20) / var_51_22
				local var_51_24 = Vector3.New(-0.7, -1.23, -5.8)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10001_tpose, var_51_24, var_51_23)

				local var_51_25 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_25.x, var_51_25.y, var_51_25.z)

				local var_51_26 = var_51_19.localEulerAngles

				var_51_26.z = 0
				var_51_26.x = 0
				var_51_19.localEulerAngles = var_51_26
			end

			if arg_48_1.time_ >= var_51_20 + var_51_22 and arg_48_1.time_ < var_51_20 + var_51_22 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(-0.7, -1.23, -5.8)

				local var_51_27 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_27.x, var_51_27.y, var_51_27.z)

				local var_51_28 = var_51_19.localEulerAngles

				var_51_28.z = 0
				var_51_28.x = 0
				var_51_19.localEulerAngles = var_51_28

				local var_51_29 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_29 then
					var_51_29:EnableDynamicBone(true)
				end
			end

			local var_51_30 = 0

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_51_31 = 0

			if var_51_31 < arg_48_1.time_ and arg_48_1.time_ <= var_51_31 + arg_51_0 then
				arg_48_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_51_32 = 0
			local var_51_33 = 1.525

			if var_51_32 < arg_48_1.time_ and arg_48_1.time_ <= var_51_32 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_34 = arg_48_1:FormatText(StoryNameCfg[31].name)

				arg_48_1.leftNameTxt_.text = var_51_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_35 = arg_48_1:GetWordFromCfg(104121012)
				local var_51_36 = arg_48_1:FormatText(var_51_35.content)

				arg_48_1.text_.text = var_51_36

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_37 = 61
				local var_51_38 = utf8.len(var_51_36)
				local var_51_39 = var_51_37 <= 0 and var_51_33 or var_51_33 * (var_51_38 / var_51_37)

				if var_51_39 > 0 and var_51_33 < var_51_39 then
					arg_48_1.talkMaxDuration = var_51_39

					if var_51_39 + var_51_32 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_39 + var_51_32
					end
				end

				arg_48_1.text_.text = var_51_36
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121012", "story_v_out_104121.awb") ~= 0 then
					local var_51_40 = manager.audio:GetVoiceLength("story_v_out_104121", "104121012", "story_v_out_104121.awb") / 1000

					if var_51_40 + var_51_32 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_40 + var_51_32
					end

					if var_51_35.prefab_name ~= "" and arg_48_1.actors_[var_51_35.prefab_name] ~= nil then
						local var_51_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_35.prefab_name].transform, "story_v_out_104121", "104121012", "story_v_out_104121.awb")

						arg_48_1:RecordAudio("104121012", var_51_41)
						arg_48_1:RecordAudio("104121012", var_51_41)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104121", "104121012", "story_v_out_104121.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104121", "104121012", "story_v_out_104121.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_42 = math.max(var_51_33, arg_48_1.talkMaxDuration)

			if var_51_32 <= arg_48_1.time_ and arg_48_1.time_ < var_51_32 + var_51_42 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_32) / var_51_42

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_32 + var_51_42 and arg_48_1.time_ < var_51_32 + var_51_42 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play104121013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104121013
		arg_52_1.duration_ = 4.6

		local var_52_0 = {
			ja = 4.6,
			ko = 2.866,
			zh = 2.5,
			en = 3.433
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
				arg_52_0:Play104121014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1036ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1036ui_story == nil then
				arg_52_1.var_.characterEffect1036ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1036ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1036ui_story then
				arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["10001_tpose"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10001_tpose == nil then
				arg_52_1.var_.characterEffect10001_tpose = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect10001_tpose and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_52_1.var_.characterEffect10001_tpose.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10001_tpose then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_52_1.var_.characterEffect10001_tpose.fillRatio = var_55_9
			end

			local var_55_10 = arg_52_1.actors_["1036ui_story"].transform
			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.var_.moveOldPos1036ui_story = var_55_10.localPosition
			end

			local var_55_12 = 0.001

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_11) / var_55_12
				local var_55_14 = Vector3.New(0.7, -1.09, -5.78)

				var_55_10.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1036ui_story, var_55_14, var_55_13)

				local var_55_15 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_15.x, var_55_15.y, var_55_15.z)

				local var_55_16 = var_55_10.localEulerAngles

				var_55_16.z = 0
				var_55_16.x = 0
				var_55_10.localEulerAngles = var_55_16
			end

			if arg_52_1.time_ >= var_55_11 + var_55_12 and arg_52_1.time_ < var_55_11 + var_55_12 + arg_55_0 then
				var_55_10.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_55_17 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_17.x, var_55_17.y, var_55_17.z)

				local var_55_18 = var_55_10.localEulerAngles

				var_55_18.z = 0
				var_55_18.x = 0
				var_55_10.localEulerAngles = var_55_18
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_21 = 0
			local var_55_22 = 0.225

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_23 = arg_52_1:FormatText(StoryNameCfg[5].name)

				arg_52_1.leftNameTxt_.text = var_55_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_24 = arg_52_1:GetWordFromCfg(104121013)
				local var_55_25 = arg_52_1:FormatText(var_55_24.content)

				arg_52_1.text_.text = var_55_25

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_26 = 9
				local var_55_27 = utf8.len(var_55_25)
				local var_55_28 = var_55_26 <= 0 and var_55_22 or var_55_22 * (var_55_27 / var_55_26)

				if var_55_28 > 0 and var_55_22 < var_55_28 then
					arg_52_1.talkMaxDuration = var_55_28

					if var_55_28 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_21
					end
				end

				arg_52_1.text_.text = var_55_25
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121013", "story_v_out_104121.awb") ~= 0 then
					local var_55_29 = manager.audio:GetVoiceLength("story_v_out_104121", "104121013", "story_v_out_104121.awb") / 1000

					if var_55_29 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_29 + var_55_21
					end

					if var_55_24.prefab_name ~= "" and arg_52_1.actors_[var_55_24.prefab_name] ~= nil then
						local var_55_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_24.prefab_name].transform, "story_v_out_104121", "104121013", "story_v_out_104121.awb")

						arg_52_1:RecordAudio("104121013", var_55_30)
						arg_52_1:RecordAudio("104121013", var_55_30)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104121", "104121013", "story_v_out_104121.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104121", "104121013", "story_v_out_104121.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_31 = math.max(var_55_22, arg_52_1.talkMaxDuration)

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_31 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_21) / var_55_31

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_21 + var_55_31 and arg_52_1.time_ < var_55_21 + var_55_31 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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
	Play104121014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104121014
		arg_56_1.duration_ = 6.23

		local var_56_0 = {
			ja = 5,
			ko = 3.433,
			zh = 6.233,
			en = 4.9
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
				arg_56_0:Play104121015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1036ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1036ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1036ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1036ui_story.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["1036ui_story"].transform
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.var_.moveOldPos1036ui_story = var_59_6.localPosition
			end

			local var_59_8 = 0.001

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_7) / var_59_8
				local var_59_10 = Vector3.New(0, 100, 0)

				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1036ui_story, var_59_10, var_59_9)

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

			local var_59_15 = arg_56_1.actors_["10001_tpose"].transform
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.var_.moveOldPos10001_tpose = var_59_15.localPosition

				local var_59_17 = GameObjectTools.GetOrAddComponent(var_59_15.gameObject, typeof(DynamicBoneHelper))

				if var_59_17 then
					var_59_17:EnableDynamicBone(false)
				end
			end

			local var_59_18 = 0.001

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_18 then
				local var_59_19 = (arg_56_1.time_ - var_59_16) / var_59_18
				local var_59_20 = Vector3.New(0, 100, 0)

				var_59_15.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10001_tpose, var_59_20, var_59_19)

				local var_59_21 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_21.x, var_59_21.y, var_59_21.z)

				local var_59_22 = var_59_15.localEulerAngles

				var_59_22.z = 0
				var_59_22.x = 0
				var_59_15.localEulerAngles = var_59_22
			end

			if arg_56_1.time_ >= var_59_16 + var_59_18 and arg_56_1.time_ < var_59_16 + var_59_18 + arg_59_0 then
				var_59_15.localPosition = Vector3.New(0, 100, 0)

				local var_59_23 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_23.x, var_59_23.y, var_59_23.z)

				local var_59_24 = var_59_15.localEulerAngles

				var_59_24.z = 0
				var_59_24.x = 0
				var_59_15.localEulerAngles = var_59_24

				local var_59_25 = GameObjectTools.GetOrAddComponent(var_59_15.gameObject, typeof(DynamicBoneHelper))

				if var_59_25 then
					var_59_25:EnableDynamicBone(true)
				end
			end

			local var_59_26 = 0
			local var_59_27 = 0.575

			if var_59_26 < arg_56_1.time_ and arg_56_1.time_ <= var_59_26 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_28 = arg_56_1:FormatText(StoryNameCfg[49].name)

				arg_56_1.leftNameTxt_.text = var_59_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_29 = arg_56_1:GetWordFromCfg(104121014)
				local var_59_30 = arg_56_1:FormatText(var_59_29.content)

				arg_56_1.text_.text = var_59_30

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_31 = 23
				local var_59_32 = utf8.len(var_59_30)
				local var_59_33 = var_59_31 <= 0 and var_59_27 or var_59_27 * (var_59_32 / var_59_31)

				if var_59_33 > 0 and var_59_27 < var_59_33 then
					arg_56_1.talkMaxDuration = var_59_33

					if var_59_33 + var_59_26 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_33 + var_59_26
					end
				end

				arg_56_1.text_.text = var_59_30
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121014", "story_v_out_104121.awb") ~= 0 then
					local var_59_34 = manager.audio:GetVoiceLength("story_v_out_104121", "104121014", "story_v_out_104121.awb") / 1000

					if var_59_34 + var_59_26 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_34 + var_59_26
					end

					if var_59_29.prefab_name ~= "" and arg_56_1.actors_[var_59_29.prefab_name] ~= nil then
						local var_59_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_29.prefab_name].transform, "story_v_out_104121", "104121014", "story_v_out_104121.awb")

						arg_56_1:RecordAudio("104121014", var_59_35)
						arg_56_1:RecordAudio("104121014", var_59_35)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104121", "104121014", "story_v_out_104121.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104121", "104121014", "story_v_out_104121.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_36 = math.max(var_59_27, arg_56_1.talkMaxDuration)

			if var_59_26 <= arg_56_1.time_ and arg_56_1.time_ < var_59_26 + var_59_36 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_26) / var_59_36

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_26 + var_59_36 and arg_56_1.time_ < var_59_26 + var_59_36 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
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
	Play104121015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104121015
		arg_60_1.duration_ = 4.03

		local var_60_0 = {
			ja = 4.033,
			ko = 2.7,
			zh = 3.033,
			en = 2.5
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
				arg_60_0:Play104121016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1011ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1011ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1011ui_story then
				arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1011ui_story"].transform
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.var_.moveOldPos1011ui_story = var_63_4.localPosition
			end

			local var_63_6 = 0.001

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6
				local var_63_8 = Vector3.New(-0.7, -0.71, -6)

				var_63_4.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1011ui_story, var_63_8, var_63_7)

				local var_63_9 = manager.ui.mainCamera.transform.position - var_63_4.position

				var_63_4.forward = Vector3.New(var_63_9.x, var_63_9.y, var_63_9.z)

				local var_63_10 = var_63_4.localEulerAngles

				var_63_10.z = 0
				var_63_10.x = 0
				var_63_4.localEulerAngles = var_63_10
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 then
				var_63_4.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_4.position

				var_63_4.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_4.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_4.localEulerAngles = var_63_12
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_15 = 0
			local var_63_16 = 0.275

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[37].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(104121015)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 11
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121015", "story_v_out_104121.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_104121", "104121015", "story_v_out_104121.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_104121", "104121015", "story_v_out_104121.awb")

						arg_60_1:RecordAudio("104121015", var_63_24)
						arg_60_1:RecordAudio("104121015", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104121", "104121015", "story_v_out_104121.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104121", "104121015", "story_v_out_104121.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play104121016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104121016
		arg_64_1.duration_ = 6.13

		local var_64_0 = {
			ja = 6.133,
			ko = 3.133,
			zh = 4.1,
			en = 5.566
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
				arg_64_0:Play104121017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1011ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1011ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1011ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1011ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0.7, -0.97, -6)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_67_21 = 0
			local var_67_22 = 0.575

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_23 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_24 = arg_64_1:GetWordFromCfg(104121016)
				local var_67_25 = arg_64_1:FormatText(var_67_24.content)

				arg_64_1.text_.text = var_67_25

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_26 = 23
				local var_67_27 = utf8.len(var_67_25)
				local var_67_28 = var_67_26 <= 0 and var_67_22 or var_67_22 * (var_67_27 / var_67_26)

				if var_67_28 > 0 and var_67_22 < var_67_28 then
					arg_64_1.talkMaxDuration = var_67_28

					if var_67_28 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_21
					end
				end

				arg_64_1.text_.text = var_67_25
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121016", "story_v_out_104121.awb") ~= 0 then
					local var_67_29 = manager.audio:GetVoiceLength("story_v_out_104121", "104121016", "story_v_out_104121.awb") / 1000

					if var_67_29 + var_67_21 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_29 + var_67_21
					end

					if var_67_24.prefab_name ~= "" and arg_64_1.actors_[var_67_24.prefab_name] ~= nil then
						local var_67_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_24.prefab_name].transform, "story_v_out_104121", "104121016", "story_v_out_104121.awb")

						arg_64_1:RecordAudio("104121016", var_67_30)
						arg_64_1:RecordAudio("104121016", var_67_30)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104121", "104121016", "story_v_out_104121.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104121", "104121016", "story_v_out_104121.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_31 = math.max(var_67_22, arg_64_1.talkMaxDuration)

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_21) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_21 + var_67_31 and arg_64_1.time_ < var_67_21 + var_67_31 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play104121017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104121017
		arg_68_1.duration_ = 13.1

		local var_68_0 = {
			ja = 13.1,
			ko = 11.9,
			zh = 12.366,
			en = 12.1
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
				arg_68_0:Play104121018(arg_68_1)
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
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_5
			end

			local var_71_6 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_7 = 0

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_6.localPosition
			end

			local var_71_8 = 0.001

			if var_71_7 <= arg_68_1.time_ and arg_68_1.time_ < var_71_7 + var_71_8 then
				local var_71_9 = (arg_68_1.time_ - var_71_7) / var_71_8
				local var_71_10 = Vector3.New(0, 100, 0)

				var_71_6.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_10, var_71_9)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_6.position

				var_71_6.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_6.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_6.localEulerAngles = var_71_12
			end

			if arg_68_1.time_ >= var_71_7 + var_71_8 and arg_68_1.time_ < var_71_7 + var_71_8 + arg_71_0 then
				var_71_6.localPosition = Vector3.New(0, 100, 0)

				local var_71_13 = manager.ui.mainCamera.transform.position - var_71_6.position

				var_71_6.forward = Vector3.New(var_71_13.x, var_71_13.y, var_71_13.z)

				local var_71_14 = var_71_6.localEulerAngles

				var_71_14.z = 0
				var_71_14.x = 0
				var_71_6.localEulerAngles = var_71_14
			end

			local var_71_15 = arg_68_1.actors_["1011ui_story"].transform
			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.var_.moveOldPos1011ui_story = var_71_15.localPosition
			end

			local var_71_17 = 0.001

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17
				local var_71_19 = Vector3.New(0, 100, 0)

				var_71_15.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1011ui_story, var_71_19, var_71_18)

				local var_71_20 = manager.ui.mainCamera.transform.position - var_71_15.position

				var_71_15.forward = Vector3.New(var_71_20.x, var_71_20.y, var_71_20.z)

				local var_71_21 = var_71_15.localEulerAngles

				var_71_21.z = 0
				var_71_21.x = 0
				var_71_15.localEulerAngles = var_71_21
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				var_71_15.localPosition = Vector3.New(0, 100, 0)

				local var_71_22 = manager.ui.mainCamera.transform.position - var_71_15.position

				var_71_15.forward = Vector3.New(var_71_22.x, var_71_22.y, var_71_22.z)

				local var_71_23 = var_71_15.localEulerAngles

				var_71_23.z = 0
				var_71_23.x = 0
				var_71_15.localEulerAngles = var_71_23
			end

			local var_71_24 = 0
			local var_71_25 = 1.175

			if var_71_24 < arg_68_1.time_ and arg_68_1.time_ <= var_71_24 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_26 = arg_68_1:FormatText(StoryNameCfg[49].name)

				arg_68_1.leftNameTxt_.text = var_71_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_27 = arg_68_1:GetWordFromCfg(104121017)
				local var_71_28 = arg_68_1:FormatText(var_71_27.content)

				arg_68_1.text_.text = var_71_28

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_29 = 47
				local var_71_30 = utf8.len(var_71_28)
				local var_71_31 = var_71_29 <= 0 and var_71_25 or var_71_25 * (var_71_30 / var_71_29)

				if var_71_31 > 0 and var_71_25 < var_71_31 then
					arg_68_1.talkMaxDuration = var_71_31

					if var_71_31 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_24
					end
				end

				arg_68_1.text_.text = var_71_28
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121017", "story_v_out_104121.awb") ~= 0 then
					local var_71_32 = manager.audio:GetVoiceLength("story_v_out_104121", "104121017", "story_v_out_104121.awb") / 1000

					if var_71_32 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_32 + var_71_24
					end

					if var_71_27.prefab_name ~= "" and arg_68_1.actors_[var_71_27.prefab_name] ~= nil then
						local var_71_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_27.prefab_name].transform, "story_v_out_104121", "104121017", "story_v_out_104121.awb")

						arg_68_1:RecordAudio("104121017", var_71_33)
						arg_68_1:RecordAudio("104121017", var_71_33)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104121", "104121017", "story_v_out_104121.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104121", "104121017", "story_v_out_104121.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_34 = math.max(var_71_25, arg_68_1.talkMaxDuration)

			if var_71_24 <= arg_68_1.time_ and arg_68_1.time_ < var_71_24 + var_71_34 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_24) / var_71_34

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_24 + var_71_34 and arg_68_1.time_ < var_71_24 + var_71_34 + arg_71_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play104121018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104121018
		arg_72_1.duration_ = 7

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104121019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_1 = 2

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_1 then
				local var_75_2 = (arg_72_1.time_ - var_75_0) / var_75_1
				local var_75_3 = Color.New(0, 0, 0)

				var_75_3.a = Mathf.Lerp(1, 0, var_75_2)
				arg_72_1.mask_.color = var_75_3
			end

			if arg_72_1.time_ >= var_75_0 + var_75_1 and arg_72_1.time_ < var_75_0 + var_75_1 + arg_75_0 then
				local var_75_4 = Color.New(0, 0, 0)
				local var_75_5 = 0

				arg_72_1.mask_.enabled = false
				var_75_4.a = var_75_5
				arg_72_1.mask_.color = var_75_4
			end

			local var_75_6 = "STblack"

			if arg_72_1.bgs_[var_75_6] == nil then
				local var_75_7 = Object.Instantiate(arg_72_1.paintGo_)

				var_75_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_75_6)
				var_75_7.name = var_75_6
				var_75_7.transform.parent = arg_72_1.stage_.transform
				var_75_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.bgs_[var_75_6] = var_75_7
			end

			local var_75_8 = 0

			if var_75_8 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				local var_75_9 = manager.ui.mainCamera.transform.localPosition
				local var_75_10 = Vector3.New(0, 0, 10) + Vector3.New(var_75_9.x, var_75_9.y, 0)
				local var_75_11 = arg_72_1.bgs_.STblack

				var_75_11.transform.localPosition = var_75_10
				var_75_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_12 = var_75_11:GetComponent("SpriteRenderer")

				if var_75_12 and var_75_12.sprite then
					local var_75_13 = (var_75_11.transform.localPosition - var_75_9).z
					local var_75_14 = manager.ui.mainCameraCom_
					local var_75_15 = 2 * var_75_13 * Mathf.Tan(var_75_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_16 = var_75_15 * var_75_14.aspect
					local var_75_17 = var_75_12.sprite.bounds.size.x
					local var_75_18 = var_75_12.sprite.bounds.size.y
					local var_75_19 = var_75_16 / var_75_17
					local var_75_20 = var_75_15 / var_75_18
					local var_75_21 = var_75_20 < var_75_19 and var_75_19 or var_75_20

					var_75_11.transform.localScale = Vector3.New(var_75_21, var_75_21, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "STblack" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_22 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_22.localPosition
			end

			local var_75_24 = 0.001

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_24 then
				local var_75_25 = (arg_72_1.time_ - var_75_23) / var_75_24
				local var_75_26 = Vector3.New(0, 100, 0)

				var_75_22.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_26, var_75_25)

				local var_75_27 = manager.ui.mainCamera.transform.position - var_75_22.position

				var_75_22.forward = Vector3.New(var_75_27.x, var_75_27.y, var_75_27.z)

				local var_75_28 = var_75_22.localEulerAngles

				var_75_28.z = 0
				var_75_28.x = 0
				var_75_22.localEulerAngles = var_75_28
			end

			if arg_72_1.time_ >= var_75_23 + var_75_24 and arg_72_1.time_ < var_75_23 + var_75_24 + arg_75_0 then
				var_75_22.localPosition = Vector3.New(0, 100, 0)

				local var_75_29 = manager.ui.mainCamera.transform.position - var_75_22.position

				var_75_22.forward = Vector3.New(var_75_29.x, var_75_29.y, var_75_29.z)

				local var_75_30 = var_75_22.localEulerAngles

				var_75_30.z = 0
				var_75_30.x = 0
				var_75_22.localEulerAngles = var_75_30
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_31 = 2
			local var_75_32 = 0.675

			if var_75_31 < arg_72_1.time_ and arg_72_1.time_ <= var_75_31 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_33 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_33:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_34 = arg_72_1:GetWordFromCfg(104121018)
				local var_75_35 = arg_72_1:FormatText(var_75_34.content)

				arg_72_1.text_.text = var_75_35

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_36 = 27
				local var_75_37 = utf8.len(var_75_35)
				local var_75_38 = var_75_36 <= 0 and var_75_32 or var_75_32 * (var_75_37 / var_75_36)

				if var_75_38 > 0 and var_75_32 < var_75_38 then
					arg_72_1.talkMaxDuration = var_75_38
					var_75_31 = var_75_31 + 0.3

					if var_75_38 + var_75_31 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_38 + var_75_31
					end
				end

				arg_72_1.text_.text = var_75_35
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_39 = var_75_31 + 0.3
			local var_75_40 = math.max(var_75_32, arg_72_1.talkMaxDuration)

			if var_75_39 <= arg_72_1.time_ and arg_72_1.time_ < var_75_39 + var_75_40 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_39) / var_75_40

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_39 + var_75_40 and arg_72_1.time_ < var_75_39 + var_75_40 + arg_75_0 then
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
	Play104121019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104121019
		arg_78_1.duration_ = 4.02

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play104121020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_1 = 2

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_1 then
				local var_81_2 = (arg_78_1.time_ - var_81_0) / var_81_1
				local var_81_3 = Color.New(0, 0, 0)

				var_81_3.a = Mathf.Lerp(1, 0, var_81_2)
				arg_78_1.mask_.color = var_81_3
			end

			if arg_78_1.time_ >= var_81_0 + var_81_1 and arg_78_1.time_ < var_81_0 + var_81_1 + arg_81_0 then
				local var_81_4 = Color.New(0, 0, 0)
				local var_81_5 = 0

				arg_78_1.mask_.enabled = false
				var_81_4.a = var_81_5
				arg_78_1.mask_.color = var_81_4
			end

			local var_81_6 = "S0409"

			if arg_78_1.bgs_[var_81_6] == nil then
				local var_81_7 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_6)
				var_81_7.name = var_81_6
				var_81_7.transform.parent = arg_78_1.stage_.transform
				var_81_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_6] = var_81_7
			end

			local var_81_8 = 0

			if var_81_8 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				local var_81_9 = manager.ui.mainCamera.transform.localPosition
				local var_81_10 = Vector3.New(0, 0, 10) + Vector3.New(var_81_9.x, var_81_9.y, 0)
				local var_81_11 = arg_78_1.bgs_.S0409

				var_81_11.transform.localPosition = var_81_10
				var_81_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_12 = var_81_11:GetComponent("SpriteRenderer")

				if var_81_12 and var_81_12.sprite then
					local var_81_13 = (var_81_11.transform.localPosition - var_81_9).z
					local var_81_14 = manager.ui.mainCameraCom_
					local var_81_15 = 2 * var_81_13 * Mathf.Tan(var_81_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_16 = var_81_15 * var_81_14.aspect
					local var_81_17 = var_81_12.sprite.bounds.size.x
					local var_81_18 = var_81_12.sprite.bounds.size.y
					local var_81_19 = var_81_16 / var_81_17
					local var_81_20 = var_81_15 / var_81_18
					local var_81_21 = var_81_20 < var_81_19 and var_81_19 or var_81_20

					var_81_11.transform.localScale = Vector3.New(var_81_21, var_81_21, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "S0409" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_22 = arg_78_1.bgs_.S0409.transform
			local var_81_23 = 0

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.var_.moveOldPosS0409 = var_81_22.localPosition
			end

			local var_81_24 = 0.001

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_24 then
				local var_81_25 = (arg_78_1.time_ - var_81_23) / var_81_24
				local var_81_26 = Vector3.New(0, 1, 7)

				var_81_22.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPosS0409, var_81_26, var_81_25)
			end

			if arg_78_1.time_ >= var_81_23 + var_81_24 and arg_78_1.time_ < var_81_23 + var_81_24 + arg_81_0 then
				var_81_22.localPosition = Vector3.New(0, 1, 7)
			end

			local var_81_27 = arg_78_1.bgs_.S0409.transform
			local var_81_28 = 0.0166666666666667

			if var_81_28 < arg_78_1.time_ and arg_78_1.time_ <= var_81_28 + arg_81_0 then
				arg_78_1.var_.moveOldPosS0409 = var_81_27.localPosition
			end

			local var_81_29 = 4

			if var_81_28 <= arg_78_1.time_ and arg_78_1.time_ < var_81_28 + var_81_29 then
				local var_81_30 = (arg_78_1.time_ - var_81_28) / var_81_29
				local var_81_31 = Vector3.New(0, 1, 5)

				var_81_27.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPosS0409, var_81_31, var_81_30)
			end

			if arg_78_1.time_ >= var_81_28 + var_81_29 and arg_78_1.time_ < var_81_28 + var_81_29 + arg_81_0 then
				var_81_27.localPosition = Vector3.New(0, 1, 5)
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_32 = 2
			local var_81_33 = 0.1

			if var_81_32 < arg_78_1.time_ and arg_78_1.time_ <= var_81_32 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_34 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_34:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_35 = arg_78_1:FormatText(StoryNameCfg[6].name)

				arg_78_1.leftNameTxt_.text = var_81_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_36 = arg_78_1:GetWordFromCfg(104121019)
				local var_81_37 = arg_78_1:FormatText(var_81_36.content)

				arg_78_1.text_.text = var_81_37

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_38 = 4
				local var_81_39 = utf8.len(var_81_37)
				local var_81_40 = var_81_38 <= 0 and var_81_33 or var_81_33 * (var_81_39 / var_81_38)

				if var_81_40 > 0 and var_81_33 < var_81_40 then
					arg_78_1.talkMaxDuration = var_81_40
					var_81_32 = var_81_32 + 0.3

					if var_81_40 + var_81_32 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_40 + var_81_32
					end
				end

				arg_78_1.text_.text = var_81_37
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121019", "story_v_out_104121.awb") ~= 0 then
					local var_81_41 = manager.audio:GetVoiceLength("story_v_out_104121", "104121019", "story_v_out_104121.awb") / 1000

					if var_81_41 + var_81_32 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_41 + var_81_32
					end

					if var_81_36.prefab_name ~= "" and arg_78_1.actors_[var_81_36.prefab_name] ~= nil then
						local var_81_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_36.prefab_name].transform, "story_v_out_104121", "104121019", "story_v_out_104121.awb")

						arg_78_1:RecordAudio("104121019", var_81_42)
						arg_78_1:RecordAudio("104121019", var_81_42)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104121", "104121019", "story_v_out_104121.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104121", "104121019", "story_v_out_104121.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_43 = var_81_32 + 0.3
			local var_81_44 = math.max(var_81_33, arg_78_1.talkMaxDuration)

			if var_81_43 <= arg_78_1.time_ and arg_78_1.time_ < var_81_43 + var_81_44 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_43) / var_81_44

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_43 + var_81_44 and arg_78_1.time_ < var_81_43 + var_81_44 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0409",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0409",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104121020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104121020
		arg_84_1.duration_ = 4.8

		local var_84_0 = {
			ja = 4.366,
			ko = 4.2,
			zh = 4.8,
			en = 4.133
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
			arg_84_1.auto_ = false
		end

		function arg_84_1.playNext_(arg_86_0)
			arg_84_1.onStoryFinished_()
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_1 = 2

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_1 then
				local var_87_2 = (arg_84_1.time_ - var_87_0) / var_87_1
				local var_87_3 = Color.New(1, 1, 1)

				var_87_3.a = Mathf.Lerp(1, 0, var_87_2)
				arg_84_1.mask_.color = var_87_3
			end

			if arg_84_1.time_ >= var_87_0 + var_87_1 and arg_84_1.time_ < var_87_0 + var_87_1 + arg_87_0 then
				local var_87_4 = Color.New(1, 1, 1)
				local var_87_5 = 0

				arg_84_1.mask_.enabled = false
				var_87_4.a = var_87_5
				arg_84_1.mask_.color = var_87_4
			end

			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				local var_87_7 = manager.ui.mainCamera.transform.localPosition
				local var_87_8 = Vector3.New(0, 0, 10) + Vector3.New(var_87_7.x, var_87_7.y, 0)
				local var_87_9 = arg_84_1.bgs_.S0409

				var_87_9.transform.localPosition = var_87_8
				var_87_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_10 = var_87_9:GetComponent("SpriteRenderer")

				if var_87_10 and var_87_10.sprite then
					local var_87_11 = (var_87_9.transform.localPosition - var_87_7).z
					local var_87_12 = manager.ui.mainCameraCom_
					local var_87_13 = 2 * var_87_11 * Mathf.Tan(var_87_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_87_14 = var_87_13 * var_87_12.aspect
					local var_87_15 = var_87_10.sprite.bounds.size.x
					local var_87_16 = var_87_10.sprite.bounds.size.y
					local var_87_17 = var_87_14 / var_87_15
					local var_87_18 = var_87_13 / var_87_16
					local var_87_19 = var_87_18 < var_87_17 and var_87_17 or var_87_18

					var_87_9.transform.localScale = Vector3.New(var_87_19, var_87_19, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "S0409" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_20 = manager.ui.mainCamera.transform
			local var_87_21 = 2

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 then
				arg_84_1.var_.shakeOldPos = var_87_20.localPosition
			end

			local var_87_22 = 0.666666666666667

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / 0.066
				local var_87_24, var_87_25 = math.modf(var_87_23)

				var_87_20.localPosition = Vector3.New(var_87_25 * 0.13, var_87_25 * 0.13, var_87_25 * 0.13) + arg_84_1.var_.shakeOldPos
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 then
				var_87_20.localPosition = arg_84_1.var_.shakeOldPos
			end

			local var_87_26 = arg_84_1.bgs_.S0409.transform
			local var_87_27 = 0

			if var_87_27 < arg_84_1.time_ and arg_84_1.time_ <= var_87_27 + arg_87_0 then
				arg_84_1.var_.moveOldPosS0409 = var_87_26.localPosition
			end

			local var_87_28 = 0.001

			if var_87_27 <= arg_84_1.time_ and arg_84_1.time_ < var_87_27 + var_87_28 then
				local var_87_29 = (arg_84_1.time_ - var_87_27) / var_87_28
				local var_87_30 = Vector3.New(0, 1, 10)

				var_87_26.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPosS0409, var_87_30, var_87_29)
			end

			if arg_84_1.time_ >= var_87_27 + var_87_28 and arg_84_1.time_ < var_87_27 + var_87_28 + arg_87_0 then
				var_87_26.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_31 = 2
			local var_87_32 = 0.25

			if var_87_31 < arg_84_1.time_ and arg_84_1.time_ <= var_87_31 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_33 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_33:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_34 = arg_84_1:FormatText(StoryNameCfg[13].name)

				arg_84_1.leftNameTxt_.text = var_87_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_35 = arg_84_1:GetWordFromCfg(104121020)
				local var_87_36 = arg_84_1:FormatText(var_87_35.content)

				arg_84_1.text_.text = var_87_36

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_37 = 10
				local var_87_38 = utf8.len(var_87_36)
				local var_87_39 = var_87_37 <= 0 and var_87_32 or var_87_32 * (var_87_38 / var_87_37)

				if var_87_39 > 0 and var_87_32 < var_87_39 then
					arg_84_1.talkMaxDuration = var_87_39
					var_87_31 = var_87_31 + 0.3

					if var_87_39 + var_87_31 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_39 + var_87_31
					end
				end

				arg_84_1.text_.text = var_87_36
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104121", "104121020", "story_v_out_104121.awb") ~= 0 then
					local var_87_40 = manager.audio:GetVoiceLength("story_v_out_104121", "104121020", "story_v_out_104121.awb") / 1000

					if var_87_40 + var_87_31 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_40 + var_87_31
					end

					if var_87_35.prefab_name ~= "" and arg_84_1.actors_[var_87_35.prefab_name] ~= nil then
						local var_87_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_35.prefab_name].transform, "story_v_out_104121", "104121020", "story_v_out_104121.awb")

						arg_84_1:RecordAudio("104121020", var_87_41)
						arg_84_1:RecordAudio("104121020", var_87_41)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104121", "104121020", "story_v_out_104121.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104121", "104121020", "story_v_out_104121.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_42 = var_87_31 + 0.3
			local var_87_43 = math.max(var_87_32, arg_84_1.talkMaxDuration)

			if var_87_42 <= arg_84_1.time_ and arg_84_1.time_ < var_87_42 + var_87_43 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_42) / var_87_43

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_42 + var_87_43 and arg_84_1.time_ < var_87_42 + var_87_43 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0409",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/S0409"
	},
	voices = {
		"story_v_out_104121.awb"
	}
}
