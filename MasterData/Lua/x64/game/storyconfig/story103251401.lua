return {
	Play325141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325141001
		arg_1_1.duration_ = 5.8

		local var_1_0 = {
			zh = 4.99966666666667,
			ja = 5.79966666666667
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
				arg_1_0:Play325141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J29g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J29g")
				var_4_0.name = "J29g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J29g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J29g

				arg_1_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J29g" then
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

			local var_4_6 = 2

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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 1.76666666666667
			local var_4_14 = 0.1

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(325141001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 4 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 4)

				if (4 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 4)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141001", "story_v_out_325141.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_325141", "325141001", "story_v_out_325141.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_325141", "325141001", "story_v_out_325141.awb")

						arg_1_1:RecordAudio("325141001", var_4_21)
						arg_1_1:RecordAudio("325141001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325141", "325141001", "story_v_out_325141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325141", "325141001", "story_v_out_325141.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325141002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325141002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325141003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0.8 < arg_8_1.time_ and arg_8_1.time_ <= 0.8 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_151", "se_story_151_break_drop", "")
			end

			local var_11_1 = 0
			local var_11_2 = 1.5

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325141002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 60 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 60)

				if (60 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 60)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325141003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325141003
		arg_12_1.duration_ = 4.6

		local var_12_0 = {
			zh = 2.333,
			ja = 4.6
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
				arg_12_0:Play325141004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.225

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(325141003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 9 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 9)

				if (9 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 9)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141003", "story_v_out_325141.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_325141", "325141003", "story_v_out_325141.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_325141", "325141003", "story_v_out_325141.awb")

						arg_12_1:RecordAudio("325141003", var_15_6)
						arg_12_1:RecordAudio("325141003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325141", "325141003", "story_v_out_325141.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325141", "325141003", "story_v_out_325141.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325141004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325141004
		arg_16_1.duration_ = 11.4

		local var_16_0 = {
			zh = 5.7,
			ja = 11.4
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
				arg_16_0:Play325141005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["10180ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10180ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "10180ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["10180ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["10180ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["10180ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["10180ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["10180ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10180ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["10180ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect10180ui_story == nil then
				arg_16_1.var_.characterEffect10180ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect10180ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect10180ui_story then
				arg_16_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_19_10 = "1059ui_story"

			if arg_16_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_19_11 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_16_1.stage_.transform)

				var_19_11.name = var_19_10
				var_19_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_10] = var_19_11

				local var_19_12 = var_19_11:GetComponentInChildren(typeof(CharacterEffect))

				var_19_12.enabled = true

				local var_19_13 = GameObjectTools.GetOrAddComponent(var_19_11, typeof(DynamicBoneHelper))

				if var_19_13 then
					var_19_13:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_12.transform, false)

				arg_16_1.var_[var_19_10 .. "Animator"] = var_19_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_10 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_10 .. "LipSync"] = var_19_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_14 = arg_16_1.actors_["1059ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_15 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_15 and not isNil(var_19_14) then
				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_15)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_15 and arg_16_1.time_ < 0 + var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1059ui_story then
				arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_16 = 0
			local var_19_17 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(325141004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_21 = 18 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_19) / 18)

				if (18 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_19) / 18)) > 0 and var_19_17 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_16
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141004", "story_v_out_325141.awb") ~= 0 then
					local var_19_22 = manager.audio:GetVoiceLength("story_v_out_325141", "325141004", "story_v_out_325141.awb") / 1000

					if var_19_22 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_16
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_out_325141", "325141004", "story_v_out_325141.awb")

						arg_16_1:RecordAudio("325141004", var_19_23)
						arg_16_1:RecordAudio("325141004", var_19_23)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325141", "325141004", "story_v_out_325141.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325141", "325141004", "story_v_out_325141.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = math.max(var_19_17, arg_16_1.talkMaxDuration)

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_16) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_16 + var_19_24 and arg_16_1.time_ < var_19_16 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325141005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325141005
		arg_20_1.duration_ = 6.93

		local var_20_0 = {
			zh = 4.1,
			ja = 6.933
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
				arg_20_0:Play325141006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["10180ui_story"]) and arg_20_1.var_.characterEffect10180ui_story == nil then
				arg_20_1.var_.characterEffect10180ui_story = arg_20_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["10180ui_story"]) then
				if arg_20_1.var_.characterEffect10180ui_story and not isNil(arg_20_1.actors_["10180ui_story"]) then
					arg_20_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["10180ui_story"]) and arg_20_1.var_.characterEffect10180ui_story then
				arg_20_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.5

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(325141005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 20 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 20)

				if (20 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 20)) > 0 and var_23_2 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141005", "story_v_out_325141.awb") ~= 0 then
					local var_23_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141005", "story_v_out_325141.awb") / 1000

					if var_23_7 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_1
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_325141", "325141005", "story_v_out_325141.awb")

						arg_20_1:RecordAudio("325141005", var_23_8)
						arg_20_1:RecordAudio("325141005", var_23_8)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325141", "325141005", "story_v_out_325141.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325141", "325141005", "story_v_out_325141.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_9 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_9 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_9

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_9 and arg_20_1.time_ < var_23_1 + var_23_9 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325141006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325141006
		arg_24_1.duration_ = 10.93

		local var_24_0 = {
			zh = 7.366,
			ja = 10.933
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
				arg_24_0:Play325141007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10180ui_story"]) and arg_24_1.var_.characterEffect10180ui_story == nil then
				arg_24_1.var_.characterEffect10180ui_story = arg_24_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10180ui_story"]) then
				if arg_24_1.var_.characterEffect10180ui_story and not isNil(arg_24_1.actors_["10180ui_story"]) then
					arg_24_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10180ui_story"]) and arg_24_1.var_.characterEffect10180ui_story then
				arg_24_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_27_2 = 0
			local var_27_3 = 0.675

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(325141006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 27 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 27)

				if (27 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 27)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141006", "story_v_out_325141.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_325141", "325141006", "story_v_out_325141.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_325141", "325141006", "story_v_out_325141.awb")

						arg_24_1:RecordAudio("325141006", var_27_9)
						arg_24_1:RecordAudio("325141006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325141", "325141006", "story_v_out_325141.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325141", "325141006", "story_v_out_325141.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325141007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325141007
		arg_28_1.duration_ = 7.27

		local var_28_0 = {
			zh = 5,
			ja = 7.266
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
				arg_28_0:Play325141008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10180ui_story"]) and arg_28_1.var_.characterEffect10180ui_story == nil then
				arg_28_1.var_.characterEffect10180ui_story = arg_28_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10180ui_story"]) then
				if arg_28_1.var_.characterEffect10180ui_story and not isNil(arg_28_1.actors_["10180ui_story"]) then
					arg_28_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10180ui_story"]) and arg_28_1.var_.characterEffect10180ui_story then
				arg_28_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.45

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(325141007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 18 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 18)

				if (18 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 18)) > 0 and var_31_2 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141007", "story_v_out_325141.awb") ~= 0 then
					local var_31_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141007", "story_v_out_325141.awb") / 1000

					if var_31_7 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_1
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_325141", "325141007", "story_v_out_325141.awb")

						arg_28_1:RecordAudio("325141007", var_31_8)
						arg_28_1:RecordAudio("325141007", var_31_8)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325141", "325141007", "story_v_out_325141.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325141", "325141007", "story_v_out_325141.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_9 and arg_28_1.time_ < var_31_1 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325141008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325141008
		arg_32_1.duration_ = 6.2

		local var_32_0 = {
			zh = 3.466,
			ja = 6.2
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
				arg_32_0:Play325141009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10180ui_story"]) and arg_32_1.var_.characterEffect10180ui_story == nil then
				arg_32_1.var_.characterEffect10180ui_story = arg_32_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10180ui_story"]) then
				if arg_32_1.var_.characterEffect10180ui_story and not isNil(arg_32_1.actors_["10180ui_story"]) then
					arg_32_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10180ui_story"]) and arg_32_1.var_.characterEffect10180ui_story then
				arg_32_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1059ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1059ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1059ui_story then
				arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action4819")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.275

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(325141008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 11 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 11)

				if (11 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 11)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141008", "story_v_out_325141.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141008", "story_v_out_325141.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_325141", "325141008", "story_v_out_325141.awb")

						arg_32_1:RecordAudio("325141008", var_35_11)
						arg_32_1:RecordAudio("325141008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325141", "325141008", "story_v_out_325141.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325141", "325141008", "story_v_out_325141.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325141009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325141009
		arg_36_1.duration_ = 10.1

		local var_36_0 = {
			zh = 5.133,
			ja = 10.1
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
				arg_36_0:Play325141010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(325141009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 19 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 19)

				if (19 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 19)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141009", "story_v_out_325141.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_325141", "325141009", "story_v_out_325141.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_325141", "325141009", "story_v_out_325141.awb")

						arg_36_1:RecordAudio("325141009", var_39_6)
						arg_36_1:RecordAudio("325141009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325141", "325141009", "story_v_out_325141.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325141", "325141009", "story_v_out_325141.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325141010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325141010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325141011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10180ui_story = arg_40_1.actors_["10180ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10180ui_story"].transform.position).z)
				arg_40_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10180ui_story"].transform.localEulerAngles = arg_40_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10180ui_story"].transform.position).z)
				arg_40_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10180ui_story"].transform.localEulerAngles = arg_40_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = arg_40_1.actors_["1059ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1059ui_story = var_43_3.localPosition
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_4)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0, 100, 0)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			local var_43_5 = arg_40_1.actors_["10180ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect10180ui_story == nil then
				arg_40_1.var_.characterEffect10180ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 and not isNil(var_43_5) then
				if arg_40_1.var_.characterEffect10180ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_6)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect10180ui_story then
				arg_40_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_43_7 = 0
			local var_43_8 = 0.925

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_9 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(325141010).content)

				arg_40_1.text_.text = var_43_9

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 37 <= 0 and var_43_8 or var_43_8 * (utf8.len(var_43_9) / 37)

				if (37 <= 0 and var_43_8 or var_43_8 * (utf8.len(var_43_9) / 37)) > 0 and var_43_8 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_7 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_7
					end
				end

				arg_40_1.text_.text = var_43_9
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_8, arg_40_1.talkMaxDuration)

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_7) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_7 + var_43_12 and arg_40_1.time_ < var_43_7 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play325141011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325141011
		arg_44_1.duration_ = 6.03

		local var_44_0 = {
			zh = 5.666,
			ja = 6.033
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
				arg_44_0:Play325141012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.3

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(325141011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 12 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 12)

				if (12 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 12)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141011", "story_v_out_325141.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_325141", "325141011", "story_v_out_325141.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_325141", "325141011", "story_v_out_325141.awb")

						arg_44_1:RecordAudio("325141011", var_47_6)
						arg_44_1:RecordAudio("325141011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325141", "325141011", "story_v_out_325141.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325141", "325141011", "story_v_out_325141.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325141012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325141012
		arg_48_1.duration_ = 6.87

		local var_48_0 = {
			zh = 6.4,
			ja = 6.866
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
				arg_48_0:Play325141013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10180ui_story = arg_48_1.actors_["10180ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10180ui_story"].transform.position).z)
				arg_48_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10180ui_story"].transform.localEulerAngles = arg_48_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_48_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10180ui_story"].transform.position).z)
				arg_48_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10180ui_story"].transform.localEulerAngles = arg_48_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["10180ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect10180ui_story == nil then
				arg_48_1.var_.characterEffect10180ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect10180ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect10180ui_story then
				arg_48_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action19_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_6 = 0
			local var_51_7 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(325141012)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 19 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 19)

				if (19 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 19)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141012", "story_v_out_325141.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_325141", "325141012", "story_v_out_325141.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_325141", "325141012", "story_v_out_325141.awb")

						arg_48_1:RecordAudio("325141012", var_51_13)
						arg_48_1:RecordAudio("325141012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325141", "325141012", "story_v_out_325141.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325141", "325141012", "story_v_out_325141.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325141013
		arg_52_1.duration_ = 18.9

		local var_52_0 = {
			zh = 9.1,
			ja = 18.9
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
				arg_52_0:Play325141014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(325141013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 40 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 40)

				if (40 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 40)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141013", "story_v_out_325141.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_325141", "325141013", "story_v_out_325141.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_325141", "325141013", "story_v_out_325141.awb")

						arg_52_1:RecordAudio("325141013", var_55_6)
						arg_52_1:RecordAudio("325141013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325141", "325141013", "story_v_out_325141.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325141", "325141013", "story_v_out_325141.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325141014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325141014
		arg_56_1.duration_ = 7.53

		local var_56_0 = {
			zh = 3.433,
			ja = 7.533
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
				arg_56_0:Play325141015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10180ui_story"]) and arg_56_1.var_.characterEffect10180ui_story == nil then
				arg_56_1.var_.characterEffect10180ui_story = arg_56_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10180ui_story"]) then
				if arg_56_1.var_.characterEffect10180ui_story and not isNil(arg_56_1.actors_["10180ui_story"]) then
					arg_56_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10180ui_story"]) and arg_56_1.var_.characterEffect10180ui_story then
				arg_56_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.25

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(325141014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 10 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 10)

				if (10 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 10)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141014", "story_v_out_325141.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141014", "story_v_out_325141.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_325141", "325141014", "story_v_out_325141.awb")

						arg_56_1:RecordAudio("325141014", var_59_8)
						arg_56_1:RecordAudio("325141014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325141", "325141014", "story_v_out_325141.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325141", "325141014", "story_v_out_325141.awb")
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
	Play325141015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325141015
		arg_60_1.duration_ = 23.03

		local var_60_0 = {
			zh = 13.033,
			ja = 23.033
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
				arg_60_0:Play325141016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10180ui_story"]) and arg_60_1.var_.characterEffect10180ui_story == nil then
				arg_60_1.var_.characterEffect10180ui_story = arg_60_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10180ui_story"]) then
				if arg_60_1.var_.characterEffect10180ui_story and not isNil(arg_60_1.actors_["10180ui_story"]) then
					arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10180ui_story"]) and arg_60_1.var_.characterEffect10180ui_story then
				arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1059ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1059ui_story == nil then
				arg_60_1.var_.characterEffect1059ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1059ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1059ui_story then
				arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_63_4 = 0
			local var_63_5 = 1.15

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(325141015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 46 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 46)

				if (46 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 46)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141015", "story_v_out_325141.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141015", "story_v_out_325141.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_325141", "325141015", "story_v_out_325141.awb")

						arg_60_1:RecordAudio("325141015", var_63_11)
						arg_60_1:RecordAudio("325141015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325141", "325141015", "story_v_out_325141.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325141", "325141015", "story_v_out_325141.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325141016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325141016
		arg_64_1.duration_ = 7.6

		local var_64_0 = {
			zh = 2.7,
			ja = 7.6
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
				arg_64_0:Play325141017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10180ui_story"]) and arg_64_1.var_.characterEffect10180ui_story == nil then
				arg_64_1.var_.characterEffect10180ui_story = arg_64_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10180ui_story"]) then
				if arg_64_1.var_.characterEffect10180ui_story and not isNil(arg_64_1.actors_["10180ui_story"]) then
					arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10180ui_story"]) and arg_64_1.var_.characterEffect10180ui_story then
				arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.275

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(325141016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 11 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 11)

				if (11 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 11)) > 0 and var_67_2 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141016", "story_v_out_325141.awb") ~= 0 then
					local var_67_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141016", "story_v_out_325141.awb") / 1000

					if var_67_7 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_1
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_325141", "325141016", "story_v_out_325141.awb")

						arg_64_1:RecordAudio("325141016", var_67_8)
						arg_64_1:RecordAudio("325141016", var_67_8)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325141", "325141016", "story_v_out_325141.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325141", "325141016", "story_v_out_325141.awb")
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
	Play325141017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325141017
		arg_68_1.duration_ = 9.5

		local var_68_0 = {
			zh = 6.866,
			ja = 9.5
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
				arg_68_0:Play325141018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10180ui_story"]) and arg_68_1.var_.characterEffect10180ui_story == nil then
				arg_68_1.var_.characterEffect10180ui_story = arg_68_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10180ui_story"]) then
				if arg_68_1.var_.characterEffect10180ui_story and not isNil(arg_68_1.actors_["10180ui_story"]) then
					arg_68_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10180ui_story"]) and arg_68_1.var_.characterEffect10180ui_story then
				arg_68_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1059ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1059ui_story == nil then
				arg_68_1.var_.characterEffect1059ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1059ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1059ui_story then
				arg_68_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_71_4 = 0
			local var_71_5 = 0.625

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(325141017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 25 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 25)

				if (25 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 25)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141017", "story_v_out_325141.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141017", "story_v_out_325141.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_325141", "325141017", "story_v_out_325141.awb")

						arg_68_1:RecordAudio("325141017", var_71_11)
						arg_68_1:RecordAudio("325141017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325141", "325141017", "story_v_out_325141.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325141", "325141017", "story_v_out_325141.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325141018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325141018
		arg_72_1.duration_ = 24.4

		local var_72_0 = {
			zh = 11.666,
			ja = 24.4
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
				arg_72_0:Play325141019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_0 = 0
			local var_75_1 = 1.05

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(325141018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 42 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 42)

				if (42 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 42)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141018", "story_v_out_325141.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_325141", "325141018", "story_v_out_325141.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_325141", "325141018", "story_v_out_325141.awb")

						arg_72_1:RecordAudio("325141018", var_75_7)
						arg_72_1:RecordAudio("325141018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325141", "325141018", "story_v_out_325141.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325141", "325141018", "story_v_out_325141.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325141019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325141019
		arg_76_1.duration_ = 10.93

		local var_76_0 = {
			zh = 4.766,
			ja = 10.933
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
				arg_76_0:Play325141020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10180ui_story"]) and arg_76_1.var_.characterEffect10180ui_story == nil then
				arg_76_1.var_.characterEffect10180ui_story = arg_76_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10180ui_story"]) then
				if arg_76_1.var_.characterEffect10180ui_story and not isNil(arg_76_1.actors_["10180ui_story"]) then
					arg_76_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10180ui_story"]) and arg_76_1.var_.characterEffect10180ui_story then
				arg_76_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.475

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(325141019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 19 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 19)

				if (19 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 19)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141019", "story_v_out_325141.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141019", "story_v_out_325141.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_325141", "325141019", "story_v_out_325141.awb")

						arg_76_1:RecordAudio("325141019", var_79_8)
						arg_76_1:RecordAudio("325141019", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325141", "325141019", "story_v_out_325141.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325141", "325141019", "story_v_out_325141.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_9 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_9

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_9 and arg_76_1.time_ < var_79_1 + var_79_9 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325141020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325141020
		arg_80_1.duration_ = 11.83

		local var_80_0 = {
			zh = 7.733,
			ja = 11.833
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
				arg_80_0:Play325141021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10180ui_story"]) and arg_80_1.var_.characterEffect10180ui_story == nil then
				arg_80_1.var_.characterEffect10180ui_story = arg_80_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10180ui_story"]) then
				if arg_80_1.var_.characterEffect10180ui_story and not isNil(arg_80_1.actors_["10180ui_story"]) then
					arg_80_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10180ui_story"]) and arg_80_1.var_.characterEffect10180ui_story then
				arg_80_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1059ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_83_4 = 0
			local var_83_5 = 0.7

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(325141020)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 28 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 28)

				if (28 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 28)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141020", "story_v_out_325141.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141020", "story_v_out_325141.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_325141", "325141020", "story_v_out_325141.awb")

						arg_80_1:RecordAudio("325141020", var_83_11)
						arg_80_1:RecordAudio("325141020", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325141", "325141020", "story_v_out_325141.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325141", "325141020", "story_v_out_325141.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325141021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325141021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325141022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10180ui_story = arg_84_1.actors_["10180ui_story"].transform.localPosition

				local var_87_0 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_0 then
					var_87_0:EnableDynamicBone(false)
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_1)
				arg_84_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10180ui_story"].transform.position).z)
				arg_84_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["10180ui_story"].transform.localEulerAngles = arg_84_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10180ui_story"].transform.position).z)
				arg_84_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["10180ui_story"].transform.localEulerAngles = arg_84_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_87_2 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(true)
				end
			end

			local var_87_3 = arg_84_1.actors_["1059ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1059ui_story = var_87_3.localPosition
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_4)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(0, 100, 0)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			local var_87_5 = arg_84_1.actors_["10180ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect10180ui_story == nil then
				arg_84_1.var_.characterEffect10180ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect10180ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_6)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect10180ui_story then
				arg_84_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_87_7 = 0
			local var_87_8 = 0.675

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(325141021).content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 27 <= 0 and var_87_8 or var_87_8 * (utf8.len(var_87_9) / 27)

				if (27 <= 0 and var_87_8 or var_87_8 * (utf8.len(var_87_9) / 27)) > 0 and var_87_8 < var_87_11 then
					arg_84_1.talkMaxDuration = var_87_11

					if var_87_11 + var_87_7 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_7
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_8, arg_84_1.talkMaxDuration)

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_7) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_7 + var_87_12 and arg_84_1.time_ < var_87_7 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play325141022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325141022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325141023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.95

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(325141022).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 38 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 38)

				if (38 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 38)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325141023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325141023
		arg_92_1.duration_ = 8.9

		local var_92_0 = {
			zh = 5.666,
			ja = 8.9
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
				arg_92_0:Play325141024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10180ui_story = arg_92_1.actors_["10180ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).z)
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles = arg_92_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_92_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10180ui_story"].transform.position).z)
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10180ui_story"].transform.localEulerAngles = arg_92_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["10180ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect10180ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_6 = 0
			local var_95_7 = 0.425

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(325141023)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 17 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_9) / 17)

				if (17 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_9) / 17)) > 0 and var_95_7 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141023", "story_v_out_325141.awb") ~= 0 then
					local var_95_12 = manager.audio:GetVoiceLength("story_v_out_325141", "325141023", "story_v_out_325141.awb") / 1000

					if var_95_12 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_6
					end

					if var_95_8.prefab_name ~= "" and arg_92_1.actors_[var_95_8.prefab_name] ~= nil then
						local var_95_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_8.prefab_name].transform, "story_v_out_325141", "325141023", "story_v_out_325141.awb")

						arg_92_1:RecordAudio("325141023", var_95_13)
						arg_92_1:RecordAudio("325141023", var_95_13)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325141", "325141023", "story_v_out_325141.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325141", "325141023", "story_v_out_325141.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325141024
		arg_96_1.duration_ = 3.8

		local var_96_0 = {
			zh = 1.966,
			ja = 3.8
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
				arg_96_0:Play325141025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10180ui_story"]) and arg_96_1.var_.characterEffect10180ui_story == nil then
				arg_96_1.var_.characterEffect10180ui_story = arg_96_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10180ui_story"]) then
				if arg_96_1.var_.characterEffect10180ui_story and not isNil(arg_96_1.actors_["10180ui_story"]) then
					arg_96_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10180ui_story"]) and arg_96_1.var_.characterEffect10180ui_story then
				arg_96_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(325141024)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 9)

				if (9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 9)) > 0 and var_99_2 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141024", "story_v_out_325141.awb") ~= 0 then
					local var_99_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141024", "story_v_out_325141.awb") / 1000

					if var_99_7 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_1
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_325141", "325141024", "story_v_out_325141.awb")

						arg_96_1:RecordAudio("325141024", var_99_8)
						arg_96_1:RecordAudio("325141024", var_99_8)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325141", "325141024", "story_v_out_325141.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325141", "325141024", "story_v_out_325141.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_9 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_9 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_9

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_9 and arg_96_1.time_ < var_99_1 + var_99_9 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325141025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325141025
		arg_100_1.duration_ = 12.7

		local var_100_0 = {
			zh = 5.333,
			ja = 12.7
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
				arg_100_0:Play325141026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["10180ui_story"]) and arg_100_1.var_.characterEffect10180ui_story == nil then
				arg_100_1.var_.characterEffect10180ui_story = arg_100_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["10180ui_story"]) then
				if arg_100_1.var_.characterEffect10180ui_story and not isNil(arg_100_1.actors_["10180ui_story"]) then
					arg_100_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["10180ui_story"]) and arg_100_1.var_.characterEffect10180ui_story then
				arg_100_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1059ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1059ui_story == nil then
				arg_100_1.var_.characterEffect1059ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect1059ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1059ui_story then
				arg_100_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_103_4 = 0
			local var_103_5 = 0.45

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(325141025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 18 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 18)

				if (18 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 18)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141025", "story_v_out_325141.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141025", "story_v_out_325141.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_325141", "325141025", "story_v_out_325141.awb")

						arg_100_1:RecordAudio("325141025", var_103_11)
						arg_100_1:RecordAudio("325141025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325141", "325141025", "story_v_out_325141.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325141", "325141025", "story_v_out_325141.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325141026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325141026
		arg_104_1.duration_ = 14.57

		local var_104_0 = {
			zh = 12.266,
			ja = 14.566
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
				arg_104_0:Play325141027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) and arg_104_1.var_.characterEffect10180ui_story == nil then
				arg_104_1.var_.characterEffect10180ui_story = arg_104_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) then
				if arg_104_1.var_.characterEffect10180ui_story and not isNil(arg_104_1.actors_["10180ui_story"]) then
					arg_104_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) and arg_104_1.var_.characterEffect10180ui_story then
				arg_104_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 0.95

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(325141026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_6 = 38 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_4) / 38)

				if (38 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_4) / 38)) > 0 and var_107_2 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141026", "story_v_out_325141.awb") ~= 0 then
					local var_107_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141026", "story_v_out_325141.awb") / 1000

					if var_107_7 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_1
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_325141", "325141026", "story_v_out_325141.awb")

						arg_104_1:RecordAudio("325141026", var_107_8)
						arg_104_1:RecordAudio("325141026", var_107_8)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325141", "325141026", "story_v_out_325141.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325141", "325141026", "story_v_out_325141.awb")
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
	Play325141027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325141027
		arg_108_1.duration_ = 2.27

		local var_108_0 = {
			zh = 2.166,
			ja = 2.266
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
				arg_108_0:Play325141028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10180ui_story"]) and arg_108_1.var_.characterEffect10180ui_story == nil then
				arg_108_1.var_.characterEffect10180ui_story = arg_108_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10180ui_story"]) then
				if arg_108_1.var_.characterEffect10180ui_story and not isNil(arg_108_1.actors_["10180ui_story"]) then
					arg_108_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10180ui_story"]) and arg_108_1.var_.characterEffect10180ui_story then
				arg_108_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["1059ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect1059ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1059ui_story then
				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_111_4 = 0
			local var_111_5 = 0.2

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(325141027)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 8 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 8)

				if (8 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 8)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141027", "story_v_out_325141.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141027", "story_v_out_325141.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_325141", "325141027", "story_v_out_325141.awb")

						arg_108_1:RecordAudio("325141027", var_111_11)
						arg_108_1:RecordAudio("325141027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_325141", "325141027", "story_v_out_325141.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_325141", "325141027", "story_v_out_325141.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325141028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325141028
		arg_112_1.duration_ = 8.53

		local var_112_0 = {
			zh = 8.533,
			ja = 6.966
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
				arg_112_0:Play325141029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10180ui_story"]) and arg_112_1.var_.characterEffect10180ui_story == nil then
				arg_112_1.var_.characterEffect10180ui_story = arg_112_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10180ui_story"]) then
				if arg_112_1.var_.characterEffect10180ui_story and not isNil(arg_112_1.actors_["10180ui_story"]) then
					arg_112_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10180ui_story"]) and arg_112_1.var_.characterEffect10180ui_story then
				arg_112_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.4

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(325141028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 16 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 16)

				if (16 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 16)) > 0 and var_115_2 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141028", "story_v_out_325141.awb") ~= 0 then
					local var_115_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141028", "story_v_out_325141.awb") / 1000

					if var_115_7 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_1
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_325141", "325141028", "story_v_out_325141.awb")

						arg_112_1:RecordAudio("325141028", var_115_8)
						arg_112_1:RecordAudio("325141028", var_115_8)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325141", "325141028", "story_v_out_325141.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325141", "325141028", "story_v_out_325141.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_9 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_9

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_9 and arg_112_1.time_ < var_115_1 + var_115_9 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325141029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325141029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325141030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10180ui_story = arg_116_1.actors_["10180ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).z)
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles = arg_116_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10180ui_story"].transform.position).z)
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10180ui_story"].transform.localEulerAngles = arg_116_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = arg_116_1.actors_["1059ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1059ui_story = var_119_3.localPosition
			end

			local var_119_4 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				var_119_3.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_4)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				var_119_3.localPosition = Vector3.New(0, 100, 0)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			local var_119_5 = arg_116_1.actors_["1059ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1059ui_story == nil then
				arg_116_1.var_.characterEffect1059ui_story = var_119_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_6 and not isNil(var_119_5) then
				if arg_116_1.var_.characterEffect1059ui_story and not isNil(var_119_5) then
					arg_116_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_6)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_6 and arg_116_1.time_ < 0 + var_119_6 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1059ui_story then
				arg_116_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_116_1.time_ and arg_116_1.time_ <= 0.3 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_150", "se_story_150_stab", "")
			end

			local var_119_8 = 0
			local var_119_9 = 1.175

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(325141029).content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_12 = 47 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_10) / 47)

				if (47 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_10) / 47)) > 0 and var_119_9 < var_119_12 then
					arg_116_1.talkMaxDuration = var_119_12

					if var_119_12 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_13 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_13 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_13

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_13 and arg_116_1.time_ < var_119_8 + var_119_13 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play325141030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325141030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325141031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(325141030).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 44 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 44)

				if (44 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 44)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play325141031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325141031
		arg_124_1.duration_ = 10.93

		local var_124_0 = {
			zh = 4.6,
			ja = 10.933
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
				arg_124_0:Play325141032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10180ui_story = arg_124_1.actors_["10180ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10180ui_story"].transform.position).z)
				arg_124_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["10180ui_story"].transform.localEulerAngles = arg_124_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_124_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10180ui_story"].transform.position).z)
				arg_124_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["10180ui_story"].transform.localEulerAngles = arg_124_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = arg_124_1.actors_["10180ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect10180ui_story == nil then
				arg_124_1.var_.characterEffect10180ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect10180ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect10180ui_story then
				arg_124_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action449")
			end

			local var_127_6 = 0
			local var_127_7 = 0.45

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(325141031)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 18 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 18)

				if (18 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 18)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141031", "story_v_out_325141.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_325141", "325141031", "story_v_out_325141.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_325141", "325141031", "story_v_out_325141.awb")

						arg_124_1:RecordAudio("325141031", var_127_13)
						arg_124_1:RecordAudio("325141031", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325141", "325141031", "story_v_out_325141.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325141", "325141031", "story_v_out_325141.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play325141032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325141032
		arg_128_1.duration_ = 6.8

		local var_128_0 = {
			zh = 6.8,
			ja = 6.1
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
				arg_128_0:Play325141033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10180ui_story"]) and arg_128_1.var_.characterEffect10180ui_story == nil then
				arg_128_1.var_.characterEffect10180ui_story = arg_128_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10180ui_story"]) then
				if arg_128_1.var_.characterEffect10180ui_story and not isNil(arg_128_1.actors_["10180ui_story"]) then
					arg_128_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10180ui_story"]) and arg_128_1.var_.characterEffect10180ui_story then
				arg_128_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_131_1 = 0
			local var_131_2 = 0.275

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(325141032)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_6 = 11 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_4) / 11)

				if (11 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_4) / 11)) > 0 and var_131_2 < var_131_6 then
					arg_128_1.talkMaxDuration = var_131_6

					if var_131_6 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141032", "story_v_out_325141.awb") ~= 0 then
					local var_131_7 = manager.audio:GetVoiceLength("story_v_out_325141", "325141032", "story_v_out_325141.awb") / 1000

					if var_131_7 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_1
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_325141", "325141032", "story_v_out_325141.awb")

						arg_128_1:RecordAudio("325141032", var_131_8)
						arg_128_1:RecordAudio("325141032", var_131_8)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325141", "325141032", "story_v_out_325141.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325141", "325141032", "story_v_out_325141.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_9 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_9 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_9

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_9 and arg_128_1.time_ < var_131_1 + var_131_9 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325141033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325141033
		arg_132_1.duration_ = 5.23

		local var_132_0 = {
			zh = 3.7,
			ja = 5.233
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
				arg_132_0:Play325141034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["10180ui_story"]) and arg_132_1.var_.characterEffect10180ui_story == nil then
				arg_132_1.var_.characterEffect10180ui_story = arg_132_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["10180ui_story"]) then
				if arg_132_1.var_.characterEffect10180ui_story and not isNil(arg_132_1.actors_["10180ui_story"]) then
					arg_132_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10180ui_story"]) and arg_132_1.var_.characterEffect10180ui_story then
				arg_132_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_135_2 = arg_132_1.actors_["1059ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1059ui_story == nil then
				arg_132_1.var_.characterEffect1059ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.characterEffect1059ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_3)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1059ui_story then
				arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_135_4 = 0
			local var_135_5 = 0.25

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(325141033)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 10 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 10)

				if (10 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 10)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141033", "story_v_out_325141.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141033", "story_v_out_325141.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_325141", "325141033", "story_v_out_325141.awb")

						arg_132_1:RecordAudio("325141033", var_135_11)
						arg_132_1:RecordAudio("325141033", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325141", "325141033", "story_v_out_325141.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325141", "325141033", "story_v_out_325141.awb")
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

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325141034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325141034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325141035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10180ui_story = arg_136_1.actors_["10180ui_story"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10180ui_story"].transform.position).z)
				arg_136_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10180ui_story"].transform.localEulerAngles = arg_136_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10180ui_story"].transform.position).z)
				arg_136_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10180ui_story"].transform.localEulerAngles = arg_136_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["1059ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_3.localPosition
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_4)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, 100, 0)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			local var_139_5 = arg_136_1.actors_["10180ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect10180ui_story == nil then
				arg_136_1.var_.characterEffect10180ui_story = var_139_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_6 and not isNil(var_139_5) then
				if arg_136_1.var_.characterEffect10180ui_story and not isNil(var_139_5) then
					arg_136_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_6)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_6 and arg_136_1.time_ < 0 + var_139_6 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect10180ui_story then
				arg_136_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_136_1.time_ and arg_136_1.time_ <= 0.4 + arg_139_0 then
				arg_136_1:AudioAction("play", "effect", "se_story_151", "se_story_151_stab", "")
			end

			local var_139_8 = 0
			local var_139_9 = 1.475

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(325141034).content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_12 = 59 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_10) / 59)

				if (59 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_10) / 59)) > 0 and var_139_9 < var_139_12 then
					arg_136_1.talkMaxDuration = var_139_12

					if var_139_12 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_13 and arg_136_1.time_ < var_139_8 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play325141035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325141035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325141036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.15

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(325141035).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 46 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 46)

				if (46 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 46)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325141036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325141036
		arg_144_1.duration_ = 6.5

		local var_144_0 = {
			zh = 5.3,
			ja = 6.5
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
				arg_144_0:Play325141037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10180ui_story = arg_144_1.actors_["10180ui_story"].transform.localPosition

				local var_147_0 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_0 then
					var_147_0:EnableDynamicBone(false)
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_144_1.time_ - 0) / var_147_1)
				arg_144_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["10180ui_story"].transform.position).z)
				arg_144_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["10180ui_story"].transform.localEulerAngles = arg_144_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_144_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["10180ui_story"].transform.position).z)
				arg_144_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["10180ui_story"].transform.localEulerAngles = arg_144_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_147_2 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(true)
				end
			end

			local var_147_3 = arg_144_1.actors_["10180ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_3) and arg_144_1.var_.characterEffect10180ui_story == nil then
				arg_144_1.var_.characterEffect10180ui_story = var_147_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_4 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 and not isNil(var_147_3) then
				if arg_144_1.var_.characterEffect10180ui_story and not isNil(var_147_3) then
					arg_144_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 and not isNil(var_147_3) and arg_144_1.var_.characterEffect10180ui_story then
				arg_144_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action9_2")
			end

			local var_147_6 = 0
			local var_147_7 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_8 = arg_144_1:GetWordFromCfg(325141036)
				local var_147_9 = arg_144_1:FormatText(var_147_8.content)

				arg_144_1.text_.text = var_147_9

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 16 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 16)

				if (16 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 16)) > 0 and var_147_7 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_9
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141036", "story_v_out_325141.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_325141", "325141036", "story_v_out_325141.awb") / 1000

					if var_147_12 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_6
					end

					if var_147_8.prefab_name ~= "" and arg_144_1.actors_[var_147_8.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_8.prefab_name].transform, "story_v_out_325141", "325141036", "story_v_out_325141.awb")

						arg_144_1:RecordAudio("325141036", var_147_13)
						arg_144_1:RecordAudio("325141036", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325141", "325141036", "story_v_out_325141.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325141", "325141036", "story_v_out_325141.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play325141037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325141037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325141038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10180ui_story = arg_148_1.actors_["10180ui_story"].transform.localPosition

				local var_151_0 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_0 then
					var_151_0:EnableDynamicBone(false)
				end
			end

			local var_151_1 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_1 then
				arg_148_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_1)
				arg_148_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10180ui_story"].transform.position).z)
				arg_148_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["10180ui_story"].transform.localEulerAngles = arg_148_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_1 and arg_148_1.time_ < 0 + var_151_1 + arg_151_0 then
				arg_148_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10180ui_story"].transform.position).z)
				arg_148_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["10180ui_story"].transform.localEulerAngles = arg_148_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_151_2 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(true)
				end
			end

			local var_151_3 = arg_148_1.actors_["10180ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_3) and arg_148_1.var_.characterEffect10180ui_story == nil then
				arg_148_1.var_.characterEffect10180ui_story = var_151_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_4 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 and not isNil(var_151_3) then
				if arg_148_1.var_.characterEffect10180ui_story and not isNil(var_151_3) then
					arg_148_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_4)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 and not isNil(var_151_3) and arg_148_1.var_.characterEffect10180ui_story then
				arg_148_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_151_5 = 0
			local var_151_6 = 1.175

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(325141037).content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 47 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_7) / 47)

				if (47 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_7) / 47)) > 0 and var_151_6 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_10 and arg_148_1.time_ < var_151_5 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play325141038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325141038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325141039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.675

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(325141038).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 27)

				if (27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 27)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325141039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325141039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
			arg_156_1.auto_ = false
		end

		function arg_156_1.playNext_(arg_158_0)
			arg_156_1.onStoryFinished_()
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_159_1 = 0
			local var_159_2 = 0.75

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(325141039).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 30 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 30)

				if (30 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 30)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J29g"
	},
	voices = {
		"story_v_out_325141.awb"
	}
}
