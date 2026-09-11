return {
	Play304111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304111001
		arg_1_1.duration_ = 7.73

		local var_1_0 = {
			zh = 6.89966666666667,
			ja = 7.73266666666667
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
				arg_1_0:Play304111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B03e == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03e")
				var_4_0.name = "B03e"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B03e = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B03e

				arg_1_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03e" then
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

			local var_4_9 = "4010ui_story"

			if arg_1_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["4010ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect4010ui_story == nil then
				arg_1_1.var_.characterEffect4010ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect4010ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect4010ui_story then
				arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.56666666666667
			local var_4_22 = 0.675

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(304111001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 27 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 27)

				if (27 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 27)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111001", "story_v_out_304111.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_304111", "304111001", "story_v_out_304111.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_304111", "304111001", "story_v_out_304111.awb")

						arg_1_1:RecordAudio("304111001", var_4_29)
						arg_1_1:RecordAudio("304111001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304111", "304111001", "story_v_out_304111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304111", "304111001", "story_v_out_304111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304111002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["4010ui_story"]) and arg_8_1.var_.characterEffect4010ui_story == nil then
				arg_8_1.var_.characterEffect4010ui_story = arg_8_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["4010ui_story"]) then
				if arg_8_1.var_.characterEffect4010ui_story and not isNil(arg_8_1.actors_["4010ui_story"]) then
					arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_8_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["4010ui_story"]) and arg_8_1.var_.characterEffect4010ui_story then
				arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_8_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.1

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

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(304111002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 44 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 44)

				if (44 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 44)) > 0 and var_11_2 < var_11_5 then
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
	Play304111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304111003
		arg_12_1.duration_ = 10.4

		local var_12_0 = {
			zh = 9.333,
			ja = 10.4
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
				arg_12_0:Play304111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["10045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10045ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "10045ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["10045ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["10045ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["10045ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["10045ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["10045ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10045ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10045ui_story, Vector3.New(-0.7, -1.18, -6.05), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(-0.7, -1.18, -6.05)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["10045ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect10045ui_story == nil then
				arg_12_1.var_.characterEffect10045ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect10045ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect10045ui_story then
				arg_12_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_15_8 = 0
			local var_15_9 = 0.775

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(304111003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 31 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 31)

				if (31 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 31)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111003", "story_v_out_304111.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_304111", "304111003", "story_v_out_304111.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_304111", "304111003", "story_v_out_304111.awb")

						arg_12_1:RecordAudio("304111003", var_15_15)
						arg_12_1:RecordAudio("304111003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304111", "304111003", "story_v_out_304111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304111", "304111003", "story_v_out_304111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play304111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304111004
		arg_16_1.duration_ = 11.13

		local var_16_0 = {
			zh = 10.6,
			ja = 11.133
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
				arg_16_0:Play304111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos4010ui_story = arg_16_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).z)
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles = arg_16_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0.7, -1.59, -5.2)
				arg_16_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4010ui_story"].transform.position).z)
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["4010ui_story"].transform.localEulerAngles = arg_16_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["4010ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect4010ui_story == nil then
				arg_16_1.var_.characterEffect4010ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect4010ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect4010ui_story then
				arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["10045ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect10045ui_story == nil then
				arg_16_1.var_.characterEffect10045ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_5 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 and not isNil(var_19_4) then
				if arg_16_1.var_.characterEffect10045ui_story and not isNil(var_19_4) then
					arg_16_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_16_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_5)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect10045ui_story then
				arg_16_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_16_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.925

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(304111004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 37 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 37)

				if (37 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 37)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111004", "story_v_out_304111.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_304111", "304111004", "story_v_out_304111.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_304111", "304111004", "story_v_out_304111.awb")

						arg_16_1:RecordAudio("304111004", var_19_13)
						arg_16_1:RecordAudio("304111004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304111", "304111004", "story_v_out_304111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304111", "304111004", "story_v_out_304111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play304111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304111005
		arg_20_1.duration_ = 14.8

		local var_20_0 = {
			zh = 8.9,
			ja = 14.8
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
				arg_20_0:Play304111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["10045ui_story"]) and arg_20_1.var_.characterEffect10045ui_story == nil then
				arg_20_1.var_.characterEffect10045ui_story = arg_20_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["10045ui_story"]) then
				if arg_20_1.var_.characterEffect10045ui_story and not isNil(arg_20_1.actors_["10045ui_story"]) then
					arg_20_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["10045ui_story"]) and arg_20_1.var_.characterEffect10045ui_story then
				arg_20_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["4010ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect4010ui_story == nil then
				arg_20_1.var_.characterEffect4010ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect4010ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_20_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect4010ui_story then
				arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_20_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_23_4 = 0
			local var_23_5 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(304111005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 31 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 31)

				if (31 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 31)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111005", "story_v_out_304111.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111005", "story_v_out_304111.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_304111", "304111005", "story_v_out_304111.awb")

						arg_20_1:RecordAudio("304111005", var_23_11)
						arg_20_1:RecordAudio("304111005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304111", "304111005", "story_v_out_304111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304111", "304111005", "story_v_out_304111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304111006
		arg_24_1.duration_ = 20.1

		local var_24_0 = {
			zh = 10.366,
			ja = 20.1
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
				arg_24_0:Play304111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = arg_24_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) then
				if arg_24_1.var_.characterEffect4010ui_story and not isNil(arg_24_1.actors_["4010ui_story"]) then
					arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) and arg_24_1.var_.characterEffect4010ui_story then
				arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["10045ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect10045ui_story == nil then
				arg_24_1.var_.characterEffect10045ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect10045ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect10045ui_story then
				arg_24_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_27_4 = 0
			local var_27_5 = 1.2

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(304111006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 49 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 49)

				if (49 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 49)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111006", "story_v_out_304111.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111006", "story_v_out_304111.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_304111", "304111006", "story_v_out_304111.awb")

						arg_24_1:RecordAudio("304111006", var_27_11)
						arg_24_1:RecordAudio("304111006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304111", "304111006", "story_v_out_304111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304111", "304111006", "story_v_out_304111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304111007
		arg_28_1.duration_ = 13.17

		local var_28_0 = {
			zh = 9,
			ja = 13.166
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
				arg_28_0:Play304111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(304111007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 40 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 40)

				if (40 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 40)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111007", "story_v_out_304111.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_304111", "304111007", "story_v_out_304111.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_304111", "304111007", "story_v_out_304111.awb")

						arg_28_1:RecordAudio("304111007", var_31_6)
						arg_28_1:RecordAudio("304111007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304111", "304111007", "story_v_out_304111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304111", "304111007", "story_v_out_304111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304111008
		arg_32_1.duration_ = 7.13

		local var_32_0 = {
			zh = 5.533,
			ja = 7.133
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
				arg_32_0:Play304111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10045ui_story"]) and arg_32_1.var_.characterEffect10045ui_story == nil then
				arg_32_1.var_.characterEffect10045ui_story = arg_32_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10045ui_story"]) then
				if arg_32_1.var_.characterEffect10045ui_story and not isNil(arg_32_1.actors_["10045ui_story"]) then
					arg_32_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10045ui_story"]) and arg_32_1.var_.characterEffect10045ui_story then
				arg_32_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["4010ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect4010ui_story == nil then
				arg_32_1.var_.characterEffect4010ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect4010ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_32_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect4010ui_story then
				arg_32_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_32_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.45

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(304111008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 18 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 18)

				if (18 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 18)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111008", "story_v_out_304111.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111008", "story_v_out_304111.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_304111", "304111008", "story_v_out_304111.awb")

						arg_32_1:RecordAudio("304111008", var_35_11)
						arg_32_1:RecordAudio("304111008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304111", "304111008", "story_v_out_304111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304111", "304111008", "story_v_out_304111.awb")
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
	Play304111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304111009
		arg_36_1.duration_ = 7.5

		local var_36_0 = {
			zh = 7,
			ja = 7.5
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
				arg_36_0:Play304111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.65

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(304111009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 26 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 26)

				if (26 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 26)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111009", "story_v_out_304111.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_304111", "304111009", "story_v_out_304111.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_304111", "304111009", "story_v_out_304111.awb")

						arg_36_1:RecordAudio("304111009", var_39_6)
						arg_36_1:RecordAudio("304111009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304111", "304111009", "story_v_out_304111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304111", "304111009", "story_v_out_304111.awb")
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
	Play304111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304111010
		arg_40_1.duration_ = 12.03

		local var_40_0 = {
			zh = 5.966,
			ja = 12.033
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
				arg_40_0:Play304111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = arg_40_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) then
				if arg_40_1.var_.characterEffect4010ui_story and not isNil(arg_40_1.actors_["4010ui_story"]) then
					arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) and arg_40_1.var_.characterEffect4010ui_story then
				arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["10045ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10045ui_story == nil then
				arg_40_1.var_.characterEffect10045ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect10045ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10045ui_story then
				arg_40_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action443")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.675

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(304111010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 27 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 27)

				if (27 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 27)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111010", "story_v_out_304111.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111010", "story_v_out_304111.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_304111", "304111010", "story_v_out_304111.awb")

						arg_40_1:RecordAudio("304111010", var_43_11)
						arg_40_1:RecordAudio("304111010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304111", "304111010", "story_v_out_304111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304111", "304111010", "story_v_out_304111.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304111011
		arg_44_1.duration_ = 6.23

		local var_44_0 = {
			zh = 4.2,
			ja = 6.233
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
				arg_44_0:Play304111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10045ui_story"]) and arg_44_1.var_.characterEffect10045ui_story == nil then
				arg_44_1.var_.characterEffect10045ui_story = arg_44_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10045ui_story"]) then
				if arg_44_1.var_.characterEffect10045ui_story and not isNil(arg_44_1.actors_["10045ui_story"]) then
					arg_44_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10045ui_story"]) and arg_44_1.var_.characterEffect10045ui_story then
				arg_44_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["4010ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect4010ui_story == nil then
				arg_44_1.var_.characterEffect4010ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect4010ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect4010ui_story then
				arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_47_4 = 0
			local var_47_5 = 0.375

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(304111011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 15 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 15)

				if (15 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 15)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111011", "story_v_out_304111.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111011", "story_v_out_304111.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_304111", "304111011", "story_v_out_304111.awb")

						arg_44_1:RecordAudio("304111011", var_47_11)
						arg_44_1:RecordAudio("304111011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304111", "304111011", "story_v_out_304111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304111", "304111011", "story_v_out_304111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304111012
		arg_48_1.duration_ = 2.87

		local var_48_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_48_0:Play304111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = arg_48_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) then
				if arg_48_1.var_.characterEffect4010ui_story and not isNil(arg_48_1.actors_["4010ui_story"]) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["10045ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10045ui_story == nil then
				arg_48_1.var_.characterEffect10045ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect10045ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10045ui_story then
				arg_48_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0
			local var_51_5 = 0.2

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(304111012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 8 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 8)

				if (8 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 8)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111012", "story_v_out_304111.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111012", "story_v_out_304111.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_304111", "304111012", "story_v_out_304111.awb")

						arg_48_1:RecordAudio("304111012", var_51_11)
						arg_48_1:RecordAudio("304111012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304111", "304111012", "story_v_out_304111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304111", "304111012", "story_v_out_304111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304111013
		arg_52_1.duration_ = 7.9

		local var_52_0 = {
			zh = 6.2,
			ja = 7.9
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
				arg_52_0:Play304111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10045ui_story"]) and arg_52_1.var_.characterEffect10045ui_story == nil then
				arg_52_1.var_.characterEffect10045ui_story = arg_52_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10045ui_story"]) then
				if arg_52_1.var_.characterEffect10045ui_story and not isNil(arg_52_1.actors_["10045ui_story"]) then
					arg_52_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10045ui_story"]) and arg_52_1.var_.characterEffect10045ui_story then
				arg_52_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["4010ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_52_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect4010ui_story then
				arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_52_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action3_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.525

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(304111013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 21 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 21)

				if (21 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 21)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111013", "story_v_out_304111.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111013", "story_v_out_304111.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_304111", "304111013", "story_v_out_304111.awb")

						arg_52_1:RecordAudio("304111013", var_55_11)
						arg_52_1:RecordAudio("304111013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304111", "304111013", "story_v_out_304111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304111", "304111013", "story_v_out_304111.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304111014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play304111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10045ui_story = arg_56_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10045ui_story"].transform.position).z)
				arg_56_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10045ui_story"].transform.localEulerAngles = arg_56_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10045ui_story"].transform.position).z)
				arg_56_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10045ui_story"].transform.localEulerAngles = arg_56_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["4010ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos4010ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = arg_56_1.actors_["10045ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect10045ui_story == nil then
				arg_56_1.var_.characterEffect10045ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect10045ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_4)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect10045ui_story then
				arg_56_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_59_5 = 0
			local var_59_6 = 1.05

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(304111014).content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 42 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 42)

				if (42 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 42)) > 0 and var_59_6 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_10 and arg_56_1.time_ < var_59_5 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play304111015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304111015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play304111016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.25

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(304111015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 49 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 49)

				if (49 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 49)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304111016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304111016
		arg_64_1.duration_ = 8.4

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304111017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.bgs_.S0301 == nil then
				local var_67_0 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0301")
				var_67_0.name = "S0301"
				var_67_0.transform.parent = arg_64_1.stage_.transform
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_.S0301 = var_67_0
			end

			if 1.5 < arg_64_1.time_ and arg_64_1.time_ <= 1.5 + arg_67_0 then
				local var_67_1 = arg_64_1.bgs_.S0301

				arg_64_1.bgs_.S0301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_67_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_2 = var_67_1:GetComponent("SpriteRenderer")

				if var_67_2 and var_67_2.sprite then
					local var_67_3 = 2 * (var_67_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_67_1.transform.localScale = Vector3.New(var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "S0301" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_4 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_4 + 0.3 and arg_64_1.time_ < var_67_4 + 0.3 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_5 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_6 = 1.53333333333333

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 then
				local var_67_7 = Color.New(0, 0, 0)

				var_67_7.a = Mathf.Lerp(0, 1, (arg_64_1.time_ - var_67_5) / var_67_6)
				arg_64_1.mask_.color = var_67_7
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 then
				local var_67_8 = Color.New(0, 0, 0)

				var_67_8.a = 1
				arg_64_1.mask_.color = var_67_8
			end

			local var_67_9 = 1.53333333333333

			if 1.53333333333333 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_10 = 2.1

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 then
				local var_67_11 = Color.New(0, 0, 0)

				var_67_11.a = Mathf.Lerp(1, 0, (arg_64_1.time_ - var_67_9) / var_67_10)
				arg_64_1.mask_.color = var_67_11
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 then
				local var_67_12 = Color.New(0, 0, 0)

				arg_64_1.mask_.enabled = false
				var_67_12.a = 0
				arg_64_1.mask_.color = var_67_12
			end

			local var_67_13 = arg_64_1.bgs_.S0301.transform

			if 1.53333333333333 < arg_64_1.time_ and arg_64_1.time_ <= 1.53333333333333 + arg_67_0 then
				arg_64_1.var_.moveOldPosS0301 = var_67_13.localPosition
			end

			local var_67_14 = 2

			if 1.53333333333333 <= arg_64_1.time_ and arg_64_1.time_ < 1.53333333333333 + var_67_14 then
				var_67_13.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPosS0301, Vector3.New(0, 1.09, 9), (arg_64_1.time_ - 1.53333333333333) / var_67_14)
			end

			if arg_64_1.time_ >= 1.53333333333333 + var_67_14 and arg_64_1.time_ < 1.53333333333333 + var_67_14 + arg_67_0 then
				var_67_13.localPosition = Vector3.New(0, 1.09, 9)
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_15 = 3.4
			local var_67_16 = 1.125

			if 3.4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_17 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_17:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(304111016).content)

				arg_64_1.text_.text = var_67_18

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 45 <= 0 and var_67_16 or var_67_16 * (utf8.len(var_67_18) / 45)

				if (45 <= 0 and var_67_16 or var_67_16 * (utf8.len(var_67_18) / 45)) > 0 and var_67_16 < var_67_20 then
					arg_64_1.talkMaxDuration = var_67_20
					var_67_15 = var_67_15 + 0.3

					if var_67_20 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_20 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_18
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_21 = var_67_15 + 0.3
			local var_67_22 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_21) / var_67_22

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 6.23),
					endPos = Vector3.New(0, 1.09, 9),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play304111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304111017
		arg_70_1.duration_ = 4.47

		local var_70_0 = {
			zh = 4.466,
			ja = 1.333
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
				arg_70_0:Play304111018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_70_1.stage_.transform)

				var_73_0.name = "1036ui_story"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1036ui_story"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["1036ui_story" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["1036ui_story" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_3 = arg_70_1.actors_["1036ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1036ui_story == nil then
				arg_70_1.var_.characterEffect1036ui_story = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect1036ui_story and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1036ui_story then
				arg_70_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_73_6 = 0
			local var_73_7 = 0.05

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(304111017)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 2 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 2)

				if (2 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 2)) > 0 and var_73_7 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111017", "story_v_out_304111.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_304111", "304111017", "story_v_out_304111.awb") / 1000

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_304111", "304111017", "story_v_out_304111.awb")

						arg_70_1:RecordAudio("304111017", var_73_13)
						arg_70_1:RecordAudio("304111017", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_304111", "304111017", "story_v_out_304111.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_304111", "304111017", "story_v_out_304111.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304111018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304111018
		arg_74_1.duration_ = 8.32

		local var_74_0 = {
			zh = 6.549999999999,
			ja = 8.315999999999
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play304111019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if arg_74_1.bgs_.B06c == nil then
				local var_77_0 = Object.Instantiate(arg_74_1.paintGo_)

				var_77_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B06c")
				var_77_0.name = "B06c"
				var_77_0.transform.parent = arg_74_1.stage_.transform
				var_77_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.bgs_.B06c = var_77_0
			end

			if 1.699999999999 < arg_74_1.time_ and arg_74_1.time_ <= 1.699999999999 + arg_77_0 then
				local var_77_1 = arg_74_1.bgs_.B06c

				arg_74_1.bgs_.B06c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_77_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_2 = var_77_1:GetComponent("SpriteRenderer")

				if var_77_2 and var_77_2.sprite then
					local var_77_3 = 2 * (var_77_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_77_1.transform.localScale = Vector3.New(var_77_3 / var_77_2.sprite.bounds.size.y < var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x and var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x or var_77_3 / var_77_2.sprite.bounds.size.y, var_77_3 / var_77_2.sprite.bounds.size.y < var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x and var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x or var_77_3 / var_77_2.sprite.bounds.size.y, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "B06c" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_77_4 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			if arg_74_1.time_ >= var_77_4 + 0.3 and arg_74_1.time_ < var_77_4 + 0.3 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end

			local var_77_5 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_6 = 1.7

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 then
				local var_77_7 = Color.New(0, 0, 0)

				var_77_7.a = Mathf.Lerp(0, 1, (arg_74_1.time_ - var_77_5) / var_77_6)
				arg_74_1.mask_.color = var_77_7
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 then
				local var_77_8 = Color.New(0, 0, 0)

				var_77_8.a = 1
				arg_74_1.mask_.color = var_77_8
			end

			local var_77_9 = 1.7

			if 1.7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_10 = 2

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_10 then
				local var_77_11 = Color.New(0, 0, 0)

				var_77_11.a = Mathf.Lerp(1, 0, (arg_74_1.time_ - var_77_9) / var_77_10)
				arg_74_1.mask_.color = var_77_11
			end

			if arg_74_1.time_ >= var_77_9 + var_77_10 and arg_74_1.time_ < var_77_9 + var_77_10 + arg_77_0 then
				local var_77_12 = Color.New(0, 0, 0)

				arg_74_1.mask_.enabled = false
				var_77_12.a = 0
				arg_74_1.mask_.color = var_77_12
			end

			local var_77_13 = "1019ui_story"

			if arg_74_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_77_14 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_74_1.stage_.transform)

				var_77_14.name = var_77_13
				var_77_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.actors_[var_77_13] = var_77_14

				local var_77_15 = var_77_14:GetComponentInChildren(typeof(CharacterEffect))

				var_77_15.enabled = true

				local var_77_16 = GameObjectTools.GetOrAddComponent(var_77_14, typeof(DynamicBoneHelper))

				if var_77_16 then
					var_77_16:EnableDynamicBone(false)
				end

				arg_74_1:ShowWeapon(var_77_15.transform, false)

				arg_74_1.var_[var_77_13 .. "Animator"] = var_77_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_74_1.var_[var_77_13 .. "Animator"].applyRootMotion = true
				arg_74_1.var_[var_77_13 .. "LipSync"] = var_77_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_77_17 = arg_74_1.actors_["1019ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_17) and arg_74_1.var_.characterEffect1019ui_story == nil then
				arg_74_1.var_.characterEffect1019ui_story = var_77_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_18 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_18 and not isNil(var_77_17) then
				if arg_74_1.var_.characterEffect1019ui_story and not isNil(var_77_17) then
					arg_74_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_18 and arg_74_1.time_ < 0 + var_77_18 + arg_77_0 and not isNil(var_77_17) and arg_74_1.var_.characterEffect1019ui_story then
				arg_74_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_77_20 = arg_74_1.actors_["1036ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_20) and arg_74_1.var_.characterEffect1036ui_story == nil then
				arg_74_1.var_.characterEffect1036ui_story = var_77_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_21 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_21 and not isNil(var_77_20) then
				if arg_74_1.var_.characterEffect1036ui_story and not isNil(var_77_20) then
					arg_74_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_21)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_21 and arg_74_1.time_ < 0 + var_77_21 + arg_77_0 and not isNil(var_77_20) and arg_74_1.var_.characterEffect1036ui_story then
				arg_74_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_74_1.time_ and arg_74_1.time_ <= 1.2 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_74_1.time_ and arg_74_1.time_ <= 0.2 + arg_77_0 then
				arg_74_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 1.2 < arg_74_1.time_ and arg_74_1.time_ <= 1.2 + arg_77_0 then
				arg_74_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_77_26 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_74_1.bgmTxt_.text ~= var_77_26 and arg_74_1.bgmTxt_.text ~= "" then
						if arg_74_1.bgmTxt2_.text ~= "" then
							arg_74_1.bgmTxt_.text = arg_74_1.bgmTxt2_.text
						end

						arg_74_1.bgmTxt2_.text = var_77_26

						arg_74_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_74_1.bgmTxt_.text = var_77_26
						arg_74_1.bgmTxt2_.text = var_77_26
					end

					if arg_74_1.bgmTimer then
						arg_74_1.bgmTimer:Stop()

						arg_74_1.bgmTimer = nil
					end

					if arg_74_1.settingData.show_music_name == 1 then
						arg_74_1.musicController:SetSelectedState("show")
						arg_74_1.musicAnimator_:Play("open", 0, 0)

						if arg_74_1.settingData.music_time ~= 0 then
							arg_74_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_74_1.settingData.music_time), function()
								if arg_74_1 == nil or isNil(arg_74_1.bgmTxt_) then
									return
								end

								arg_74_1.musicController:SetSelectedState("hide")
								arg_74_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_28 = 3.249999999999
			local var_77_29 = 0.45

			if 3.249999999999 < arg_74_1.time_ and arg_74_1.time_ <= var_77_28 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_30 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_30:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_74_1.dialogCg_.alpha = arg_79_0
				end))
				var_77_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_31 = arg_74_1:GetWordFromCfg(304111018)
				local var_77_32 = arg_74_1:FormatText(var_77_31.content)

				arg_74_1.text_.text = var_77_32

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_34 = 18 <= 0 and var_77_29 or var_77_29 * (utf8.len(var_77_32) / 18)

				if (18 <= 0 and var_77_29 or var_77_29 * (utf8.len(var_77_32) / 18)) > 0 and var_77_29 < var_77_34 then
					arg_74_1.talkMaxDuration = var_77_34
					var_77_28 = var_77_28 + 0.3

					if var_77_34 + var_77_28 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_34 + var_77_28
					end
				end

				arg_74_1.text_.text = var_77_32
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111018", "story_v_out_304111.awb") ~= 0 then
					local var_77_35 = manager.audio:GetVoiceLength("story_v_out_304111", "304111018", "story_v_out_304111.awb") / 1000

					if var_77_35 + var_77_28 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_35 + var_77_28
					end

					if var_77_31.prefab_name ~= "" and arg_74_1.actors_[var_77_31.prefab_name] ~= nil then
						local var_77_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_31.prefab_name].transform, "story_v_out_304111", "304111018", "story_v_out_304111.awb")

						arg_74_1:RecordAudio("304111018", var_77_36)
						arg_74_1:RecordAudio("304111018", var_77_36)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304111", "304111018", "story_v_out_304111.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304111", "304111018", "story_v_out_304111.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_37 = var_77_28 + 0.3
			local var_77_38 = math.max(var_77_29, arg_74_1.talkMaxDuration)

			if var_77_28 + 0.3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_37 + var_77_38 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_37) / var_77_38

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_37 + var_77_38 and arg_74_1.time_ < var_77_37 + var_77_38 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304111019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 304111019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play304111020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) and arg_81_1.var_.characterEffect1019ui_story == nil then
				arg_81_1.var_.characterEffect1019ui_story = arg_81_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) then
				if arg_81_1.var_.characterEffect1019ui_story and not isNil(arg_81_1.actors_["1019ui_story"]) then
					arg_81_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) and arg_81_1.var_.characterEffect1019ui_story then
				arg_81_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 1.425

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(304111019).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 57 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 57)

				if (57 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 57)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play304111020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 304111020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play304111021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("calling")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(304111020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 55 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 55)

				if (55 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 55)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play304111021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 304111021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play304111022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.975

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_89_1.callingController_:SetSelectedState("calling")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(304111021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 39 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 39)

				if (39 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 39)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play304111022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 304111022
		arg_93_1.duration_ = 7.8

		local var_93_0 = {
			zh = 4.6,
			ja = 7.8
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play304111023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1019ui_story = arg_93_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1019ui_story"].transform.position).z)
				arg_93_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1019ui_story"].transform.localEulerAngles = arg_93_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_93_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1019ui_story"].transform.position).z)
				arg_93_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1019ui_story"].transform.localEulerAngles = arg_93_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1019ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1019ui_story == nil then
				arg_93_1.var_.characterEffect1019ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1019ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1019ui_story then
				arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 0.575

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(304111022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 23 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 23)

				if (23 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 23)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111022", "story_v_out_304111.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111022", "story_v_out_304111.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_304111", "304111022", "story_v_out_304111.awb")

						arg_93_1:RecordAudio("304111022", var_96_11)
						arg_93_1:RecordAudio("304111022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_304111", "304111022", "story_v_out_304111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_304111", "304111022", "story_v_out_304111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play304111023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 304111023
		arg_97_1.duration_ = 3.8

		local var_97_0 = {
			zh = 3.8,
			ja = 1.999999999999
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play304111024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if arg_97_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_100_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_97_1.stage_.transform)

				var_100_0.name = "1084ui_story"
				var_100_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1084ui_story"] = var_100_0

				local var_100_1 = var_100_0:GetComponentInChildren(typeof(CharacterEffect))

				var_100_1.enabled = true

				local var_100_2 = GameObjectTools.GetOrAddComponent(var_100_0, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(false)
				end

				arg_97_1:ShowWeapon(var_100_1.transform, false)

				arg_97_1.var_["1084ui_story" .. "Animator"] = var_100_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_97_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_97_1.var_["1084ui_story" .. "LipSync"] = var_100_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_100_3 = arg_97_1.actors_["1084ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["1019ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1019ui_story = var_100_5.localPosition
			end

			local var_100_6 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_6)
				var_100_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_5.position).x, (manager.ui.mainCamera.transform.position - var_100_5.position).y, (manager.ui.mainCamera.transform.position - var_100_5.position).z)
				var_100_5.localEulerAngles.z = 0
				var_100_5.localEulerAngles.x = 0
				var_100_5.localEulerAngles = var_100_5.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(0, 100, 0)
				var_100_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_5.position).x, (manager.ui.mainCamera.transform.position - var_100_5.position).y, (manager.ui.mainCamera.transform.position - var_100_5.position).z)
				var_100_5.localEulerAngles.z = 0
				var_100_5.localEulerAngles.x = 0
				var_100_5.localEulerAngles = var_100_5.localEulerAngles
			end

			local var_100_7 = arg_97_1.actors_["1084ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_8 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_8 and not isNil(var_100_7) then
				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_7) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_8 and arg_97_1.time_ < 0 + var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_100_10 = arg_97_1.actors_["1019ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_10) and arg_97_1.var_.characterEffect1019ui_story == nil then
				arg_97_1.var_.characterEffect1019ui_story = var_100_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_11 and not isNil(var_100_10) then
				if arg_97_1.var_.characterEffect1019ui_story and not isNil(var_100_10) then
					arg_97_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_11)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_11 and arg_97_1.time_ < 0 + var_100_11 + arg_100_0 and not isNil(var_100_10) and arg_97_1.var_.characterEffect1019ui_story then
				arg_97_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_12 = 0
			local var_100_13 = 0.425

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(304111023)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_17 = 17 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 17)

				if (17 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 17)) > 0 and var_100_13 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17

					if var_100_17 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111023", "story_v_out_304111.awb") ~= 0 then
					local var_100_18 = manager.audio:GetVoiceLength("story_v_out_304111", "304111023", "story_v_out_304111.awb") / 1000

					if var_100_18 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_12
					end

					if var_100_14.prefab_name ~= "" and arg_97_1.actors_[var_100_14.prefab_name] ~= nil then
						local var_100_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_14.prefab_name].transform, "story_v_out_304111", "304111023", "story_v_out_304111.awb")

						arg_97_1:RecordAudio("304111023", var_100_19)
						arg_97_1:RecordAudio("304111023", var_100_19)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_304111", "304111023", "story_v_out_304111.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_304111", "304111023", "story_v_out_304111.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_20 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_12) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_12 + var_100_20 and arg_97_1.time_ < var_100_12 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304111024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 304111024
		arg_101_1.duration_ = 5.9

		local var_101_0 = {
			zh = 4.2,
			ja = 5.9
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play304111025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_104_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_101_1.stage_.transform)

				var_104_0.name = "1011ui_story"
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1011ui_story"] = var_104_0

				local var_104_1 = var_104_0:GetComponentInChildren(typeof(CharacterEffect))

				var_104_1.enabled = true

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end

				arg_101_1:ShowWeapon(var_104_1.transform, false)

				arg_101_1.var_["1011ui_story" .. "Animator"] = var_104_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_101_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_101_1.var_["1011ui_story" .. "LipSync"] = var_104_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_104_3 = arg_101_1.actors_["1011ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1011ui_story = var_104_3.localPosition
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_101_1.time_ - 0) / var_104_4)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			local var_104_5 = arg_101_1.actors_["1011ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1011ui_story == nil then
				arg_101_1.var_.characterEffect1011ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.characterEffect1011ui_story and not isNil(var_104_5) then
					arg_101_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1011ui_story then
				arg_101_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_104_8 = arg_101_1.actors_["1084ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_9 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_9 and not isNil(var_104_8) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_8) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_9)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_9 and arg_101_1.time_ < 0 + var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_10 = 0
			local var_104_11 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_12 = arg_101_1:GetWordFromCfg(304111024)
				local var_104_13 = arg_101_1:FormatText(var_104_12.content)

				arg_101_1.text_.text = var_104_13

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_15 = 18 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 18)

				if (18 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 18)) > 0 and var_104_11 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_13
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111024", "story_v_out_304111.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_304111", "304111024", "story_v_out_304111.awb") / 1000

					if var_104_16 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_10
					end

					if var_104_12.prefab_name ~= "" and arg_101_1.actors_[var_104_12.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_12.prefab_name].transform, "story_v_out_304111", "304111024", "story_v_out_304111.awb")

						arg_101_1:RecordAudio("304111024", var_104_17)
						arg_101_1:RecordAudio("304111024", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_304111", "304111024", "story_v_out_304111.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_304111", "304111024", "story_v_out_304111.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_10) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_10 + var_104_18 and arg_101_1.time_ < var_104_10 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play304111025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 304111025
		arg_105_1.duration_ = 8

		local var_105_0 = {
			zh = 7.6,
			ja = 8
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play304111026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1019ui_story = arg_105_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1019ui_story"].transform.position).z)
				arg_105_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1019ui_story"].transform.localEulerAngles = arg_105_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_105_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1019ui_story"].transform.position).z)
				arg_105_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1019ui_story"].transform.localEulerAngles = arg_105_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1011ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1011ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(0, 100, 0)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			local var_108_3 = arg_105_1.actors_["1019ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect1019ui_story == nil then
				arg_105_1.var_.characterEffect1019ui_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect1019ui_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect1019ui_story then
				arg_105_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_108_6 = arg_105_1.actors_["1011ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1011ui_story == nil then
				arg_105_1.var_.characterEffect1011ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect1011ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1011ui_story then
				arg_105_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_8 = 0
			local var_108_9 = 0.875

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(304111025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 35 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 35)

				if (35 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 35)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111025", "story_v_out_304111.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_304111", "304111025", "story_v_out_304111.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_304111", "304111025", "story_v_out_304111.awb")

						arg_105_1:RecordAudio("304111025", var_108_15)
						arg_105_1:RecordAudio("304111025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_304111", "304111025", "story_v_out_304111.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_304111", "304111025", "story_v_out_304111.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play304111026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 304111026
		arg_109_1.duration_ = 2.93

		local var_109_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play304111027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = arg_109_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(arg_109_1.actors_["1084ui_story"]) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_112_2 = arg_109_1.actors_["1019ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1019ui_story == nil then
				arg_109_1.var_.characterEffect1019ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect1019ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1019ui_story then
				arg_109_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action489")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_4 = 0
			local var_112_5 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(304111026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 14 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 14)

				if (14 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 14)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111026", "story_v_out_304111.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111026", "story_v_out_304111.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_304111", "304111026", "story_v_out_304111.awb")

						arg_109_1:RecordAudio("304111026", var_112_11)
						arg_109_1:RecordAudio("304111026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_304111", "304111026", "story_v_out_304111.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_304111", "304111026", "story_v_out_304111.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play304111027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 304111027
		arg_113_1.duration_ = 3.57

		local var_113_0 = {
			zh = 3.566,
			ja = 1.333
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play304111028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(304111027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 18)

				if (18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 18)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111027", "story_v_out_304111.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_304111", "304111027", "story_v_out_304111.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_304111", "304111027", "story_v_out_304111.awb")

						arg_113_1:RecordAudio("304111027", var_116_6)
						arg_113_1:RecordAudio("304111027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_304111", "304111027", "story_v_out_304111.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_304111", "304111027", "story_v_out_304111.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play304111028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 304111028
		arg_117_1.duration_ = 2.5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play304111029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) and arg_117_1.var_.characterEffect1019ui_story == nil then
				arg_117_1.var_.characterEffect1019ui_story = arg_117_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) then
				if arg_117_1.var_.characterEffect1019ui_story and not isNil(arg_117_1.actors_["1019ui_story"]) then
					arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) and arg_117_1.var_.characterEffect1019ui_story then
				arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["1084ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1084ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_4 = 0
			local var_120_5 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(304111028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 13 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 13)

				if (13 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 13)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111028", "story_v_out_304111.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111028", "story_v_out_304111.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_304111", "304111028", "story_v_out_304111.awb")

						arg_117_1:RecordAudio("304111028", var_120_11)
						arg_117_1:RecordAudio("304111028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_304111", "304111028", "story_v_out_304111.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_304111", "304111028", "story_v_out_304111.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play304111029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 304111029
		arg_121_1.duration_ = 8.2

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play304111030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 1.73333333333333 < arg_121_1.time_ and arg_121_1.time_ <= 1.73333333333333 + arg_124_0 then
				local var_124_0 = arg_121_1.bgs_.B06c

				arg_121_1.bgs_.B06c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_1 = var_124_0:GetComponent("SpriteRenderer")

				if var_124_1 and var_124_1.sprite then
					local var_124_2 = 2 * (var_124_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_0.transform.localScale = Vector3.New(var_124_2 / var_124_1.sprite.bounds.size.y < var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x and var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x or var_124_2 / var_124_1.sprite.bounds.size.y, var_124_2 / var_124_1.sprite.bounds.size.y < var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x and var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x or var_124_2 / var_124_1.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "B06c" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_3 = 1.73333333333333

			if 1.73333333333333 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			if arg_121_1.time_ >= var_124_3 + 0.3 and arg_121_1.time_ < var_124_3 + 0.3 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_4 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_5 = 1.73333333333333

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_5 then
				local var_124_6 = Color.New(0, 0, 0)

				var_124_6.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - var_124_4) / var_124_5)
				arg_121_1.mask_.color = var_124_6
			end

			if arg_121_1.time_ >= var_124_4 + var_124_5 and arg_121_1.time_ < var_124_4 + var_124_5 + arg_124_0 then
				local var_124_7 = Color.New(0, 0, 0)

				var_124_7.a = 1
				arg_121_1.mask_.color = var_124_7
			end

			local var_124_8 = 1.73333333333333

			if 1.73333333333333 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_9 = 2

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 then
				local var_124_10 = Color.New(0, 0, 0)

				var_124_10.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_8) / var_124_9)
				arg_121_1.mask_.color = var_124_10
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 then
				local var_124_11 = Color.New(0, 0, 0)

				arg_121_1.mask_.enabled = false
				var_124_11.a = 0
				arg_121_1.mask_.color = var_124_11
			end

			local var_124_12 = arg_121_1.actors_["1019ui_story"].transform

			if 1.73333333333333 < arg_121_1.time_ and arg_121_1.time_ <= 1.73333333333333 + arg_124_0 then
				arg_121_1.var_.moveOldPos1019ui_story = var_124_12.localPosition
			end

			local var_124_13 = 0.001

			if 1.73333333333333 <= arg_121_1.time_ and arg_121_1.time_ < 1.73333333333333 + var_124_13 then
				var_124_12.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.73333333333333) / var_124_13)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			if arg_121_1.time_ >= 1.73333333333333 + var_124_13 and arg_121_1.time_ < 1.73333333333333 + var_124_13 + arg_124_0 then
				var_124_12.localPosition = Vector3.New(0, 100, 0)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			local var_124_14 = arg_121_1.actors_["1084ui_story"].transform

			if 1.73333333333333 < arg_121_1.time_ and arg_121_1.time_ <= 1.73333333333333 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = var_124_14.localPosition
			end

			local var_124_15 = 0.001

			if 1.73333333333333 <= arg_121_1.time_ and arg_121_1.time_ < 1.73333333333333 + var_124_15 then
				var_124_14.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.73333333333333) / var_124_15)
				var_124_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_14.position).x, (manager.ui.mainCamera.transform.position - var_124_14.position).y, (manager.ui.mainCamera.transform.position - var_124_14.position).z)
				var_124_14.localEulerAngles.z = 0
				var_124_14.localEulerAngles.x = 0
				var_124_14.localEulerAngles = var_124_14.localEulerAngles
			end

			if arg_121_1.time_ >= 1.73333333333333 + var_124_15 and arg_121_1.time_ < 1.73333333333333 + var_124_15 + arg_124_0 then
				var_124_14.localPosition = Vector3.New(0, 100, 0)
				var_124_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_14.position).x, (manager.ui.mainCamera.transform.position - var_124_14.position).y, (manager.ui.mainCamera.transform.position - var_124_14.position).z)
				var_124_14.localEulerAngles.z = 0
				var_124_14.localEulerAngles.x = 0
				var_124_14.localEulerAngles = var_124_14.localEulerAngles
			end

			local var_124_16 = arg_121_1.actors_["1019ui_story"]

			if 1.73333333333333 < arg_121_1.time_ and arg_121_1.time_ <= 1.73333333333333 + arg_124_0 and not isNil(var_124_16) and arg_121_1.var_.characterEffect1019ui_story == nil then
				arg_121_1.var_.characterEffect1019ui_story = var_124_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_17 = 0.200000002980232

			if 1.73333333333333 <= arg_121_1.time_ and arg_121_1.time_ < 1.73333333333333 + var_124_17 and not isNil(var_124_16) then
				if arg_121_1.var_.characterEffect1019ui_story and not isNil(var_124_16) then
					arg_121_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.73333333333333) / var_124_17)
				end
			end

			if arg_121_1.time_ >= 1.73333333333333 + var_124_17 and arg_121_1.time_ < 1.73333333333333 + var_124_17 + arg_124_0 and not isNil(var_124_16) and arg_121_1.var_.characterEffect1019ui_story then
				arg_121_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_18 = 3.2
			local var_124_19 = 1.525

			if 3.2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_18 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_20 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_20:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_21 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(304111029).content)

				arg_121_1.text_.text = var_124_21

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_23 = 61 <= 0 and var_124_19 or var_124_19 * (utf8.len(var_124_21) / 61)

				if (61 <= 0 and var_124_19 or var_124_19 * (utf8.len(var_124_21) / 61)) > 0 and var_124_19 < var_124_23 then
					arg_121_1.talkMaxDuration = var_124_23
					var_124_18 = var_124_18 + 0.3

					if var_124_23 + var_124_18 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_18
					end
				end

				arg_121_1.text_.text = var_124_21
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_24 = var_124_18 + 0.3
			local var_124_25 = math.max(var_124_19, arg_121_1.talkMaxDuration)

			if var_124_18 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_24 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_24) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_24 + var_124_25 and arg_121_1.time_ < var_124_24 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play304111030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 304111030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play304111031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.925

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(304111030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 37 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 37)

				if (37 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 37)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play304111031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 304111031
		arg_131_1.duration_ = 4.9

		local var_131_0 = {
			zh = 3.966,
			ja = 4.9
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play304111032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["2030ui_story"]) and arg_131_1.var_.characterEffect2030ui_story == nil then
				arg_131_1.var_.characterEffect2030ui_story = arg_131_1.actors_["2030ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["2030ui_story"]) then
				if arg_131_1.var_.characterEffect2030ui_story and not isNil(arg_131_1.actors_["2030ui_story"]) then
					arg_131_1.var_.characterEffect2030ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["2030ui_story"]) and arg_131_1.var_.characterEffect2030ui_story then
				arg_131_1.var_.characterEffect2030ui_story.fillFlat = false
			end

			local var_134_2 = 0
			local var_134_3 = 0.45

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_4 = arg_131_1:GetWordFromCfg(304111031)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 18 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 18)

				if (18 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 18)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111031", "story_v_out_304111.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_304111", "304111031", "story_v_out_304111.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_304111", "304111031", "story_v_out_304111.awb")

						arg_131_1:RecordAudio("304111031", var_134_9)
						arg_131_1:RecordAudio("304111031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_304111", "304111031", "story_v_out_304111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_304111", "304111031", "story_v_out_304111.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play304111032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 304111032
		arg_135_1.duration_ = 3.5

		local var_135_0 = {
			zh = 3.5,
			ja = 1.999999999999
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play304111033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1084ui_story = arg_135_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).z)
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles = arg_135_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_135_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).z)
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles = arg_135_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1084ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_138_4 = arg_135_1.actors_["2030ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect2030ui_story == nil then
				arg_135_1.var_.characterEffect2030ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_5 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 and not isNil(var_138_4) then
				if arg_135_1.var_.characterEffect2030ui_story and not isNil(var_138_4) then
					arg_135_1.var_.characterEffect2030ui_story.fillFlat = true
					arg_135_1.var_.characterEffect2030ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_5)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect2030ui_story then
				arg_135_1.var_.characterEffect2030ui_story.fillFlat = true
				arg_135_1.var_.characterEffect2030ui_story.fillRatio = 0.5
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_2")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_138_6 = 0
			local var_138_7 = 0.375

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(304111032)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 15 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 15)

				if (15 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 15)) > 0 and var_138_7 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111032", "story_v_out_304111.awb") ~= 0 then
					local var_138_12 = manager.audio:GetVoiceLength("story_v_out_304111", "304111032", "story_v_out_304111.awb") / 1000

					if var_138_12 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_6
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_304111", "304111032", "story_v_out_304111.awb")

						arg_135_1:RecordAudio("304111032", var_138_13)
						arg_135_1:RecordAudio("304111032", var_138_13)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_304111", "304111032", "story_v_out_304111.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_304111", "304111032", "story_v_out_304111.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play304111033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 304111033
		arg_139_1.duration_ = 4.87

		local var_139_0 = {
			zh = 3.9,
			ja = 4.866
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play304111034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_142_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_139_1.stage_.transform)

				var_142_0.name = "3008ui_story"
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["3008ui_story"] = var_142_0

				local var_142_1 = var_142_0:GetComponentInChildren(typeof(CharacterEffect))

				var_142_1.enabled = true

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end

				arg_139_1:ShowWeapon(var_142_1.transform, false)

				arg_139_1.var_["3008ui_story" .. "Animator"] = var_142_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_139_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_139_1.var_["3008ui_story" .. "LipSync"] = var_142_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_142_3 = arg_139_1.actors_["3008ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos3008ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(0, -1.51, -4.3)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["1084ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_5.localPosition
			end

			local var_142_6 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 then
				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_6)
				var_142_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_5.position).x, (manager.ui.mainCamera.transform.position - var_142_5.position).y, (manager.ui.mainCamera.transform.position - var_142_5.position).z)
				var_142_5.localEulerAngles.z = 0
				var_142_5.localEulerAngles.x = 0
				var_142_5.localEulerAngles = var_142_5.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(0, 100, 0)
				var_142_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_5.position).x, (manager.ui.mainCamera.transform.position - var_142_5.position).y, (manager.ui.mainCamera.transform.position - var_142_5.position).z)
				var_142_5.localEulerAngles.z = 0
				var_142_5.localEulerAngles.x = 0
				var_142_5.localEulerAngles = var_142_5.localEulerAngles
			end

			local var_142_7 = arg_139_1.actors_["3008ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.characterEffect3008ui_story == nil then
				arg_139_1.var_.characterEffect3008ui_story = var_142_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_8 and not isNil(var_142_7) then
				if arg_139_1.var_.characterEffect3008ui_story and not isNil(var_142_7) then
					arg_139_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_8 and arg_139_1.time_ < 0 + var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.characterEffect3008ui_story then
				arg_139_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_142_10 = arg_139_1.actors_["1084ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_10) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_11 and not isNil(var_142_10) then
				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_10) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_11)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_11 and arg_139_1.time_ < 0 + var_142_11 + arg_142_0 and not isNil(var_142_10) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_142_12 = 0
			local var_142_13 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:GetWordFromCfg(304111033)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 16 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_15) / 16)

				if (16 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_15) / 16)) > 0 and var_142_13 < var_142_17 then
					arg_139_1.talkMaxDuration = var_142_17

					if var_142_17 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111033", "story_v_out_304111.awb") ~= 0 then
					local var_142_18 = manager.audio:GetVoiceLength("story_v_out_304111", "304111033", "story_v_out_304111.awb") / 1000

					if var_142_18 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_12
					end

					if var_142_14.prefab_name ~= "" and arg_139_1.actors_[var_142_14.prefab_name] ~= nil then
						local var_142_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_14.prefab_name].transform, "story_v_out_304111", "304111033", "story_v_out_304111.awb")

						arg_139_1:RecordAudio("304111033", var_142_19)
						arg_139_1:RecordAudio("304111033", var_142_19)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_304111", "304111033", "story_v_out_304111.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_304111", "304111033", "story_v_out_304111.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_20 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_20 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_20

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_20 and arg_139_1.time_ < var_142_12 + var_142_20 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play304111034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 304111034
		arg_143_1.duration_ = 2.17

		local var_143_0 = {
			zh = 2,
			ja = 2.166
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play304111035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.175

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(304111034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 7 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 7)

				if (7 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 7)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111034", "story_v_out_304111.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_304111", "304111034", "story_v_out_304111.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_304111", "304111034", "story_v_out_304111.awb")

						arg_143_1:RecordAudio("304111034", var_146_6)
						arg_143_1:RecordAudio("304111034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_304111", "304111034", "story_v_out_304111.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_304111", "304111034", "story_v_out_304111.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play304111035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 304111035
		arg_147_1.duration_ = 1.33

		local var_147_0 = {
			zh = 1.3,
			ja = 1.333
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play304111036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1084ui_story"]) and arg_147_1.var_.characterEffect1084ui_story == nil then
				arg_147_1.var_.characterEffect1084ui_story = arg_147_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1084ui_story"]) then
				if arg_147_1.var_.characterEffect1084ui_story and not isNil(arg_147_1.actors_["1084ui_story"]) then
					arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1084ui_story"]) and arg_147_1.var_.characterEffect1084ui_story then
				arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_150_2 = arg_147_1.actors_["3008ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect3008ui_story == nil then
				arg_147_1.var_.characterEffect3008ui_story = var_150_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_3 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.characterEffect3008ui_story and not isNil(var_150_2) then
					arg_147_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_147_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_3)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect3008ui_story then
				arg_147_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_147_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_150_4 = 0
			local var_150_5 = 0.1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_6 = arg_147_1:GetWordFromCfg(304111035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 4 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 4)

				if (4 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 4)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111035", "story_v_out_304111.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111035", "story_v_out_304111.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_304111", "304111035", "story_v_out_304111.awb")

						arg_147_1:RecordAudio("304111035", var_150_11)
						arg_147_1:RecordAudio("304111035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_304111", "304111035", "story_v_out_304111.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_304111", "304111035", "story_v_out_304111.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play304111036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 304111036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play304111037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos3008ui_story = arg_151_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["3008ui_story"].transform.position).z)
				arg_151_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["3008ui_story"].transform.localEulerAngles = arg_151_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["3008ui_story"].transform.position).z)
				arg_151_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["3008ui_story"].transform.localEulerAngles = arg_151_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1084ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_151_1.time_ and arg_151_1.time_ <= 0.3 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword04", "")
			end

			local var_154_4 = 0
			local var_154_5 = 1.25

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(304111036).content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 50 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_6) / 50)

				if (50 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_6) / 50)) > 0 and var_154_5 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_9 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_9 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_9

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_9 and arg_151_1.time_ < var_154_4 + var_154_9 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play304111037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 304111037
		arg_155_1.duration_ = 6

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play304111038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_9000

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_0 = arg_155_1.var_.effect33322221

				if not arg_155_1.var_.effect33322221 then
					var_158_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), manager.ui.mainCamera.transform)
					var_158_0.name = "33322221"
					arg_155_1.var_.effect33322221 = var_158_0
				else
					var_158_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_158_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_158_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_158_0.transform.localScale = Vector3.New(var_158_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_158_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_158_0.transform.localScale.z)
			end

			if 0.366666666666667 < arg_155_1.time_ and arg_155_1.time_ <= 0.366666666666667 + arg_158_0 then
				local var_158_2 = arg_155_1.var_.effect2131

				if not arg_155_1.var_.effect2131 then
					var_158_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_158_2.name = "2131"
					arg_155_1.var_.effect2131 = var_158_2
				else
					var_158_2.transform:SetParent(var_158_9000)
				end

				var_158_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_158_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_158_2.transform.localScale = Vector3.New(var_158_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_158_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_158_2.transform.localScale.z)
			end

			if 2.23333333333333 < arg_155_1.time_ and arg_155_1.time_ <= 2.23333333333333 + arg_158_0 then
				if arg_155_1.var_.effect2131 then
					Object.Destroy(arg_155_1.var_.effect2131)

					arg_155_1.var_.effect2131 = nil
				end
			end

			local var_158_5 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			if arg_155_1.time_ >= var_158_5 + 1 and arg_155_1.time_ < var_158_5 + 1 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end

			if 0.3 < arg_155_1.time_ and arg_155_1.time_ <= 0.3 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_explosion", "")
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_7 = 1
			local var_158_8 = 1.25

			if 1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_9 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_9:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(304111037).content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_12 = 50 <= 0 and var_158_8 or var_158_8 * (utf8.len(var_158_10) / 50)

				if (50 <= 0 and var_158_8 or var_158_8 * (utf8.len(var_158_10) / 50)) > 0 and var_158_8 < var_158_12 then
					arg_155_1.talkMaxDuration = var_158_12
					var_158_7 = var_158_7 + 0.3

					if var_158_12 + var_158_7 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_7
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_13 = var_158_7 + 0.3
			local var_158_14 = math.max(var_158_8, arg_155_1.talkMaxDuration)

			if var_158_7 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_13 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_13) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_13 + var_158_14 and arg_155_1.time_ < var_158_13 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play304111038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 304111038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play304111039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.075

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(304111038).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 43 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 43)

				if (43 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 43)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play304111039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 304111039
		arg_165_1.duration_ = 7.23

		local var_165_0 = {
			zh = 5.266,
			ja = 7.233
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play304111040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos3008ui_story = arg_165_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos3008ui_story, Vector3.New(-1.04, -1.51, -4.3), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["3008ui_story"].transform.position).z)
				arg_165_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["3008ui_story"].transform.localEulerAngles = arg_165_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(-1.04, -1.51, -4.3)
				arg_165_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["3008ui_story"].transform.position).z)
				arg_165_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["3008ui_story"].transform.localEulerAngles = arg_165_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["3008ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect3008ui_story == nil then
				arg_165_1.var_.characterEffect3008ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect3008ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect3008ui_story then
				arg_165_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_4 = 0
			local var_168_5 = 0.575

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(304111039)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 23 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 23)

				if (23 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 23)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111039", "story_v_out_304111.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111039", "story_v_out_304111.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_304111", "304111039", "story_v_out_304111.awb")

						arg_165_1:RecordAudio("304111039", var_168_11)
						arg_165_1:RecordAudio("304111039", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_304111", "304111039", "story_v_out_304111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_304111", "304111039", "story_v_out_304111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play304111040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 304111040
		arg_169_1.duration_ = 13.8

		local var_169_0 = {
			zh = 5.333,
			ja = 13.8
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play304111041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if arg_169_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_172_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_169_1.stage_.transform)

				var_172_0.name = "3009ui_story"
				var_172_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["3009ui_story"] = var_172_0

				local var_172_1 = var_172_0:GetComponentInChildren(typeof(CharacterEffect))

				var_172_1.enabled = true

				local var_172_2 = GameObjectTools.GetOrAddComponent(var_172_0, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(false)
				end

				arg_169_1:ShowWeapon(var_172_1.transform, false)

				arg_169_1.var_["3009ui_story" .. "Animator"] = var_172_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_169_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_169_1.var_["3009ui_story" .. "LipSync"] = var_172_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_172_3 = arg_169_1.actors_["3009ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos3009ui_story = var_172_3.localPosition
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_3.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_169_1.time_ - 0) / var_172_4)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_3.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			local var_172_5 = arg_169_1.actors_["3009ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect3009ui_story == nil then
				arg_169_1.var_.characterEffect3009ui_story = var_172_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.characterEffect3009ui_story and not isNil(var_172_5) then
					arg_169_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect3009ui_story then
				arg_169_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_172_8 = arg_169_1.actors_["3008ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.characterEffect3008ui_story == nil then
				arg_169_1.var_.characterEffect3008ui_story = var_172_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_9 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_9 and not isNil(var_172_8) then
				if arg_169_1.var_.characterEffect3008ui_story and not isNil(var_172_8) then
					arg_169_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_169_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_9)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_9 and arg_169_1.time_ < 0 + var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.characterEffect3008ui_story then
				arg_169_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_169_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action3_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_172_10 = 0
			local var_172_11 = 0.65

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_12 = arg_169_1:GetWordFromCfg(304111040)
				local var_172_13 = arg_169_1:FormatText(var_172_12.content)

				arg_169_1.text_.text = var_172_13

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_15 = 26 <= 0 and var_172_11 or var_172_11 * (utf8.len(var_172_13) / 26)

				if (26 <= 0 and var_172_11 or var_172_11 * (utf8.len(var_172_13) / 26)) > 0 and var_172_11 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_10
					end
				end

				arg_169_1.text_.text = var_172_13
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111040", "story_v_out_304111.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_304111", "304111040", "story_v_out_304111.awb") / 1000

					if var_172_16 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_10
					end

					if var_172_12.prefab_name ~= "" and arg_169_1.actors_[var_172_12.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_12.prefab_name].transform, "story_v_out_304111", "304111040", "story_v_out_304111.awb")

						arg_169_1:RecordAudio("304111040", var_172_17)
						arg_169_1:RecordAudio("304111040", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_304111", "304111040", "story_v_out_304111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_304111", "304111040", "story_v_out_304111.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_10) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_10 + var_172_18 and arg_169_1.time_ < var_172_10 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play304111041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 304111041
		arg_173_1.duration_ = 7.6

		local var_173_0 = {
			zh = 5.933,
			ja = 7.6
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play304111042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["3008ui_story"]) and arg_173_1.var_.characterEffect3008ui_story == nil then
				arg_173_1.var_.characterEffect3008ui_story = arg_173_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["3008ui_story"]) then
				if arg_173_1.var_.characterEffect3008ui_story and not isNil(arg_173_1.actors_["3008ui_story"]) then
					arg_173_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["3008ui_story"]) and arg_173_1.var_.characterEffect3008ui_story then
				arg_173_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["3009ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect3009ui_story == nil then
				arg_173_1.var_.characterEffect3009ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect3009ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_173_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect3009ui_story then
				arg_173_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_173_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_176_4 = 0
			local var_176_5 = 0.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(304111041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 25 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 25)

				if (25 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 25)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111041", "story_v_out_304111.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111041", "story_v_out_304111.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_304111", "304111041", "story_v_out_304111.awb")

						arg_173_1:RecordAudio("304111041", var_176_11)
						arg_173_1:RecordAudio("304111041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_304111", "304111041", "story_v_out_304111.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_304111", "304111041", "story_v_out_304111.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play304111042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 304111042
		arg_177_1.duration_ = 4.83

		local var_177_0 = {
			zh = 4.833,
			ja = 1.333
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play304111043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1084ui_story"]) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = arg_177_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1084ui_story"]) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(arg_177_1.actors_["1084ui_story"]) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1084ui_story"]) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["3008ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect3008ui_story == nil then
				arg_177_1.var_.characterEffect3008ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect3008ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_177_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect3008ui_story then
				arg_177_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_177_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_180_4 = 0
			local var_180_5 = 0.55

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_6 = arg_177_1:GetWordFromCfg(304111042)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 22 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 22)

				if (22 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 22)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111042", "story_v_out_304111.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111042", "story_v_out_304111.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_304111", "304111042", "story_v_out_304111.awb")

						arg_177_1:RecordAudio("304111042", var_180_11)
						arg_177_1:RecordAudio("304111042", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_304111", "304111042", "story_v_out_304111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_304111", "304111042", "story_v_out_304111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play304111043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 304111043
		arg_181_1.duration_ = 6.9

		local var_181_0 = {
			zh = 4.333,
			ja = 6.9
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play304111044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["3008ui_story"]) and arg_181_1.var_.characterEffect3008ui_story == nil then
				arg_181_1.var_.characterEffect3008ui_story = arg_181_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["3008ui_story"]) then
				if arg_181_1.var_.characterEffect3008ui_story and not isNil(arg_181_1.actors_["3008ui_story"]) then
					arg_181_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["3008ui_story"]) and arg_181_1.var_.characterEffect3008ui_story then
				arg_181_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["1084ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect1084ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_184_4 = 0
			local var_184_5 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(304111043)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 18 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 18)

				if (18 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 18)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111043", "story_v_out_304111.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111043", "story_v_out_304111.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_304111", "304111043", "story_v_out_304111.awb")

						arg_181_1:RecordAudio("304111043", var_184_11)
						arg_181_1:RecordAudio("304111043", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_304111", "304111043", "story_v_out_304111.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_304111", "304111043", "story_v_out_304111.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play304111044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 304111044
		arg_185_1.duration_ = 6.63

		local var_185_0 = {
			zh = 3.2,
			ja = 6.633
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play304111045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["3009ui_story"]) and arg_185_1.var_.characterEffect3009ui_story == nil then
				arg_185_1.var_.characterEffect3009ui_story = arg_185_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["3009ui_story"]) then
				if arg_185_1.var_.characterEffect3009ui_story and not isNil(arg_185_1.actors_["3009ui_story"]) then
					arg_185_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["3009ui_story"]) and arg_185_1.var_.characterEffect3009ui_story then
				arg_185_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_188_2 = arg_185_1.actors_["3008ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect3008ui_story == nil then
				arg_185_1.var_.characterEffect3008ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_3 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.characterEffect3008ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_185_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_3)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect3008ui_story then
				arg_185_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_185_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action3_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_188_4 = 0
			local var_188_5 = 0.375

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(304111044)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 15 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 15)

				if (15 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 15)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111044", "story_v_out_304111.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111044", "story_v_out_304111.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_304111", "304111044", "story_v_out_304111.awb")

						arg_185_1:RecordAudio("304111044", var_188_11)
						arg_185_1:RecordAudio("304111044", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_304111", "304111044", "story_v_out_304111.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_304111", "304111044", "story_v_out_304111.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play304111045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 304111045
		arg_189_1.duration_ = 5.43

		local var_189_0 = {
			zh = 4.933,
			ja = 5.433
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play304111046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["3008ui_story"]) and arg_189_1.var_.characterEffect3008ui_story == nil then
				arg_189_1.var_.characterEffect3008ui_story = arg_189_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["3008ui_story"]) then
				if arg_189_1.var_.characterEffect3008ui_story and not isNil(arg_189_1.actors_["3008ui_story"]) then
					arg_189_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["3008ui_story"]) and arg_189_1.var_.characterEffect3008ui_story then
				arg_189_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["3009ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect3009ui_story == nil then
				arg_189_1.var_.characterEffect3009ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect3009ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_189_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect3009ui_story then
				arg_189_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_189_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 0.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(304111045)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 26 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 26)

				if (26 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 26)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111045", "story_v_out_304111.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111045", "story_v_out_304111.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_304111", "304111045", "story_v_out_304111.awb")

						arg_189_1:RecordAudio("304111045", var_192_11)
						arg_189_1:RecordAudio("304111045", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_304111", "304111045", "story_v_out_304111.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_304111", "304111045", "story_v_out_304111.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play304111046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 304111046
		arg_193_1.duration_ = 8.3

		local var_193_0 = {
			zh = 5.933,
			ja = 8.3
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play304111047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["3009ui_story"]) and arg_193_1.var_.characterEffect3009ui_story == nil then
				arg_193_1.var_.characterEffect3009ui_story = arg_193_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["3009ui_story"]) then
				if arg_193_1.var_.characterEffect3009ui_story and not isNil(arg_193_1.actors_["3009ui_story"]) then
					arg_193_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["3009ui_story"]) and arg_193_1.var_.characterEffect3009ui_story then
				arg_193_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_196_2 = arg_193_1.actors_["3008ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect3008ui_story == nil then
				arg_193_1.var_.characterEffect3008ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect3008ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_193_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect3008ui_story then
				arg_193_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_193_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_196_4 = 0
			local var_196_5 = 0.725

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(304111046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 29 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 29)

				if (29 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 29)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111046", "story_v_out_304111.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111046", "story_v_out_304111.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_304111", "304111046", "story_v_out_304111.awb")

						arg_193_1:RecordAudio("304111046", var_196_11)
						arg_193_1:RecordAudio("304111046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_304111", "304111046", "story_v_out_304111.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_304111", "304111046", "story_v_out_304111.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play304111047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 304111047
		arg_197_1.duration_ = 7

		local var_197_0 = {
			zh = 7,
			ja = 5.766
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play304111048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["3008ui_story"]) and arg_197_1.var_.characterEffect3008ui_story == nil then
				arg_197_1.var_.characterEffect3008ui_story = arg_197_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["3008ui_story"]) then
				if arg_197_1.var_.characterEffect3008ui_story and not isNil(arg_197_1.actors_["3008ui_story"]) then
					arg_197_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["3008ui_story"]) and arg_197_1.var_.characterEffect3008ui_story then
				arg_197_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_200_2 = arg_197_1.actors_["3009ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect3009ui_story == nil then
				arg_197_1.var_.characterEffect3009ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect3009ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_197_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect3009ui_story then
				arg_197_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_197_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action475")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_4 = 0
			local var_200_5 = 0.475

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(304111047)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 19 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 19)

				if (19 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 19)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111047", "story_v_out_304111.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111047", "story_v_out_304111.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_304111", "304111047", "story_v_out_304111.awb")

						arg_197_1:RecordAudio("304111047", var_200_11)
						arg_197_1:RecordAudio("304111047", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_304111", "304111047", "story_v_out_304111.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_304111", "304111047", "story_v_out_304111.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play304111048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 304111048
		arg_201_1.duration_ = 4.97

		local var_201_0 = {
			zh = 4.4,
			ja = 4.966
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play304111049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1011ui_story = arg_201_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1011ui_story"].transform.position).z)
				arg_201_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1011ui_story"].transform.localEulerAngles = arg_201_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_201_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1011ui_story"].transform.position).z)
				arg_201_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1011ui_story"].transform.localEulerAngles = arg_201_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["3008ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos3008ui_story = var_204_1.localPosition
			end

			local var_204_2 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 then
				var_204_1.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_2)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 then
				var_204_1.localPosition = Vector3.New(0, 100, 0)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			local var_204_3 = arg_201_1.actors_["3009ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos3009ui_story = var_204_3.localPosition
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_3.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_4)
				var_204_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_3.position).x, (manager.ui.mainCamera.transform.position - var_204_3.position).y, (manager.ui.mainCamera.transform.position - var_204_3.position).z)
				var_204_3.localEulerAngles.z = 0
				var_204_3.localEulerAngles.x = 0
				var_204_3.localEulerAngles = var_204_3.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_3.localPosition = Vector3.New(0, 100, 0)
				var_204_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_3.position).x, (manager.ui.mainCamera.transform.position - var_204_3.position).y, (manager.ui.mainCamera.transform.position - var_204_3.position).z)
				var_204_3.localEulerAngles.z = 0
				var_204_3.localEulerAngles.x = 0
				var_204_3.localEulerAngles = var_204_3.localEulerAngles
			end

			local var_204_5 = arg_201_1.actors_["1011ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.characterEffect1011ui_story == nil then
				arg_201_1.var_.characterEffect1011ui_story = var_204_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.characterEffect1011ui_story and not isNil(var_204_5) then
					arg_201_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.characterEffect1011ui_story then
				arg_201_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_204_8 = arg_201_1.actors_["3008ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.characterEffect3008ui_story == nil then
				arg_201_1.var_.characterEffect3008ui_story = var_204_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_9 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_9 and not isNil(var_204_8) then
				if arg_201_1.var_.characterEffect3008ui_story and not isNil(var_204_8) then
					arg_201_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_201_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_9)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_9 and arg_201_1.time_ < 0 + var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.characterEffect3008ui_story then
				arg_201_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_201_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_204_10 = 0
			local var_204_11 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_12 = arg_201_1:GetWordFromCfg(304111048)
				local var_204_13 = arg_201_1:FormatText(var_204_12.content)

				arg_201_1.text_.text = var_204_13

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_15 = 19 <= 0 and var_204_11 or var_204_11 * (utf8.len(var_204_13) / 19)

				if (19 <= 0 and var_204_11 or var_204_11 * (utf8.len(var_204_13) / 19)) > 0 and var_204_11 < var_204_15 then
					arg_201_1.talkMaxDuration = var_204_15

					if var_204_15 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_15 + var_204_10
					end
				end

				arg_201_1.text_.text = var_204_13
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111048", "story_v_out_304111.awb") ~= 0 then
					local var_204_16 = manager.audio:GetVoiceLength("story_v_out_304111", "304111048", "story_v_out_304111.awb") / 1000

					if var_204_16 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_16 + var_204_10
					end

					if var_204_12.prefab_name ~= "" and arg_201_1.actors_[var_204_12.prefab_name] ~= nil then
						local var_204_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_12.prefab_name].transform, "story_v_out_304111", "304111048", "story_v_out_304111.awb")

						arg_201_1:RecordAudio("304111048", var_204_17)
						arg_201_1:RecordAudio("304111048", var_204_17)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_304111", "304111048", "story_v_out_304111.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_304111", "304111048", "story_v_out_304111.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_18 = math.max(var_204_11, arg_201_1.talkMaxDuration)

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_18 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_10) / var_204_18

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_10 + var_204_18 and arg_201_1.time_ < var_204_10 + var_204_18 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
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
	Play304111049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 304111049
		arg_205_1.duration_ = 4.5

		local var_205_0 = {
			zh = 4.5,
			ja = 3.933
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play304111050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos3009ui_story = arg_205_1.actors_["3009ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["3009ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos3009ui_story, Vector3.New(-0.7, -1.75, -4.8), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["3009ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["3009ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["3009ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["3009ui_story"].transform.position).z)
				arg_205_1.actors_["3009ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["3009ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["3009ui_story"].transform.localEulerAngles = arg_205_1.actors_["3009ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["3009ui_story"].transform.localPosition = Vector3.New(-0.7, -1.75, -4.8)
				arg_205_1.actors_["3009ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["3009ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["3009ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["3009ui_story"].transform.position).z)
				arg_205_1.actors_["3009ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["3009ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["3009ui_story"].transform.localEulerAngles = arg_205_1.actors_["3009ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1011ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1011ui_story = var_208_1.localPosition
			end

			local var_208_2 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(0, 100, 0)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			local var_208_3 = arg_205_1.actors_["3009ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect3009ui_story == nil then
				arg_205_1.var_.characterEffect3009ui_story = var_208_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_3) then
				if arg_205_1.var_.characterEffect3009ui_story and not isNil(var_208_3) then
					arg_205_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect3009ui_story then
				arg_205_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_208_6 = arg_205_1.actors_["1011ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1011ui_story == nil then
				arg_205_1.var_.characterEffect1011ui_story = var_208_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.characterEffect1011ui_story and not isNil(var_208_6) then
					arg_205_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_7)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1011ui_story then
				arg_205_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action4_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_208_8 = 0
			local var_208_9 = 0.45

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(304111049)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 18 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 18)

				if (18 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 18)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111049", "story_v_out_304111.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_304111", "304111049", "story_v_out_304111.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_304111", "304111049", "story_v_out_304111.awb")

						arg_205_1:RecordAudio("304111049", var_208_15)
						arg_205_1:RecordAudio("304111049", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_304111", "304111049", "story_v_out_304111.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_304111", "304111049", "story_v_out_304111.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play304111050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 304111050
		arg_209_1.duration_ = 6.83

		local var_209_0 = {
			zh = 5.1,
			ja = 6.833
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play304111051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1019ui_story = arg_209_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1019ui_story"].transform.position).z)
				arg_209_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1019ui_story"].transform.localEulerAngles = arg_209_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_209_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1019ui_story"].transform.position).z)
				arg_209_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1019ui_story"].transform.localEulerAngles = arg_209_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1019ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1019ui_story == nil then
				arg_209_1.var_.characterEffect1019ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1019ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1019ui_story then
				arg_209_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["3009ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect3009ui_story == nil then
				arg_209_1.var_.characterEffect3009ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect3009ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_209_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect3009ui_story then
				arg_209_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_209_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_6 = 0
			local var_212_7 = 0.625

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(304111050)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 25 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 25)

				if (25 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 25)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111050", "story_v_out_304111.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_304111", "304111050", "story_v_out_304111.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_304111", "304111050", "story_v_out_304111.awb")

						arg_209_1:RecordAudio("304111050", var_212_13)
						arg_209_1:RecordAudio("304111050", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_304111", "304111050", "story_v_out_304111.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_304111", "304111050", "story_v_out_304111.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304111051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 304111051
		arg_213_1.duration_ = 6.5

		local var_213_0 = {
			zh = 4.166,
			ja = 6.5
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play304111052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["3009ui_story"]) and arg_213_1.var_.characterEffect3009ui_story == nil then
				arg_213_1.var_.characterEffect3009ui_story = arg_213_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["3009ui_story"]) then
				if arg_213_1.var_.characterEffect3009ui_story and not isNil(arg_213_1.actors_["3009ui_story"]) then
					arg_213_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["3009ui_story"]) and arg_213_1.var_.characterEffect3009ui_story then
				arg_213_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_216_2 = arg_213_1.actors_["1019ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1019ui_story == nil then
				arg_213_1.var_.characterEffect1019ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_3 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.characterEffect1019ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_3)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1019ui_story then
				arg_213_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action4_2")
			end

			local var_216_4 = 0
			local var_216_5 = 0.325

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(304111051)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 13 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 13)

				if (13 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 13)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111051", "story_v_out_304111.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_304111", "304111051", "story_v_out_304111.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_304111", "304111051", "story_v_out_304111.awb")

						arg_213_1:RecordAudio("304111051", var_216_11)
						arg_213_1:RecordAudio("304111051", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_304111", "304111051", "story_v_out_304111.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_304111", "304111051", "story_v_out_304111.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play304111052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 304111052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play304111053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos3009ui_story = arg_217_1.actors_["3009ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["3009ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["3009ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["3009ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["3009ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["3009ui_story"].transform.position).z)
				arg_217_1.actors_["3009ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["3009ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["3009ui_story"].transform.localEulerAngles = arg_217_1.actors_["3009ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["3009ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["3009ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["3009ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["3009ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["3009ui_story"].transform.position).z)
				arg_217_1.actors_["3009ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["3009ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["3009ui_story"].transform.localEulerAngles = arg_217_1.actors_["3009ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1019ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1019ui_story = var_220_1.localPosition
			end

			local var_220_2 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 then
				var_220_1.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_2)
				var_220_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_1.position).x, (manager.ui.mainCamera.transform.position - var_220_1.position).y, (manager.ui.mainCamera.transform.position - var_220_1.position).z)
				var_220_1.localEulerAngles.z = 0
				var_220_1.localEulerAngles.x = 0
				var_220_1.localEulerAngles = var_220_1.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 then
				var_220_1.localPosition = Vector3.New(0, 100, 0)
				var_220_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_1.position).x, (manager.ui.mainCamera.transform.position - var_220_1.position).y, (manager.ui.mainCamera.transform.position - var_220_1.position).z)
				var_220_1.localEulerAngles.z = 0
				var_220_1.localEulerAngles.x = 0
				var_220_1.localEulerAngles = var_220_1.localEulerAngles
			end

			local var_220_3 = arg_217_1.actors_["3009ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect3009ui_story == nil then
				arg_217_1.var_.characterEffect3009ui_story = var_220_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_4 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 and not isNil(var_220_3) then
				if arg_217_1.var_.characterEffect3009ui_story and not isNil(var_220_3) then
					arg_217_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_217_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_4)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect3009ui_story then
				arg_217_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_217_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_220_5 = 0
			local var_220_6 = 0.775

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(304111052).content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 31 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_7) / 31)

				if (31 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_7) / 31)) > 0 and var_220_6 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_10 and arg_217_1.time_ < var_220_5 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play304111053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 304111053
		arg_221_1.duration_ = 8.17

		local var_221_0 = {
			zh = 5.766,
			ja = 8.166
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
			arg_221_1.auto_ = false
		end

		function arg_221_1.playNext_(arg_223_0)
			arg_221_1.onStoryFinished_()
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.575

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(304111053)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 23 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 23)

				if (23 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 23)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304111", "304111053", "story_v_out_304111.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_304111", "304111053", "story_v_out_304111.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_304111", "304111053", "story_v_out_304111.awb")

						arg_221_1:RecordAudio("304111053", var_224_6)
						arg_221_1:RecordAudio("304111053", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_304111", "304111053", "story_v_out_304111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_304111", "304111053", "story_v_out_304111.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03e",
		"TextureConfig/Background/S0301",
		"TextureConfig/Background/B06c"
	},
	voices = {
		"story_v_out_304111.awb"
	}
}
