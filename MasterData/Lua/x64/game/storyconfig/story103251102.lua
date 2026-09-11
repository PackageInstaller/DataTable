return {
	Play325112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325112001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2010 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2010")
				var_4_0.name = "ST2010"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2010 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2010

				arg_1_1.bgs_.ST2010.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2010" then
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

			local var_4_9 = 0.631675865563254

			if 0.631675865563254 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_10 = 0.733333333333333

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				local var_4_11 = Color.New(1, 1, 1)

				var_4_11.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_9) / var_4_10)
				arg_1_1.mask_.color = var_4_11
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				local var_4_12 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_12.a = 0
				arg_1_1.mask_.color = var_4_12
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword08", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			local var_4_18 = 1.5
			local var_4_19 = 1.2

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325112001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 48 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 48)

				if (48 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 48)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1.5,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325112002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325112002
		arg_8_1.duration_ = 6.8

		local var_8_0 = {
			zh = 6.8,
			ja = 5.966
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
				arg_8_0:Play325112003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.625

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(325112002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 25 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 25)

				if (25 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 25)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112002", "story_v_out_325112.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112002", "story_v_out_325112.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_325112", "325112002", "story_v_out_325112.awb")

						arg_8_1:RecordAudio("325112002", var_11_6)
						arg_8_1:RecordAudio("325112002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325112", "325112002", "story_v_out_325112.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325112", "325112002", "story_v_out_325112.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325112003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325112003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325112004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1059ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1059ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1059ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1059ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1059ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1059ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, 100, 0)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1059ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1059ui_story == nil then
				arg_12_1.var_.characterEffect1059ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1059ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_6)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1059ui_story then
				arg_12_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_15_7 = 0
			local var_15_8 = 1.125

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325112003).content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 45 <= 0 and var_15_8 or var_15_8 * (utf8.len(var_15_9) / 45)

				if (45 <= 0 and var_15_8 or var_15_8 * (utf8.len(var_15_9) / 45)) > 0 and var_15_8 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_7
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_12 = math.max(var_15_8, arg_12_1.talkMaxDuration)

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_12 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_7) / var_15_12

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_7 + var_15_12 and arg_12_1.time_ < var_15_7 + var_15_12 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play325112004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325112004
		arg_16_1.duration_ = 6.9

		local var_16_0 = {
			zh = 5.233,
			ja = 6.9
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
				arg_16_0:Play325112005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.55

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(325112004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 22 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 22)

				if (22 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 22)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112004", "story_v_out_325112.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112004", "story_v_out_325112.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_325112", "325112004", "story_v_out_325112.awb")

						arg_16_1:RecordAudio("325112004", var_19_6)
						arg_16_1:RecordAudio("325112004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325112", "325112004", "story_v_out_325112.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325112", "325112004", "story_v_out_325112.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325112005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325112005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325112006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(325112005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 31 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 31)

				if (31 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 31)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325112006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325112006
		arg_24_1.duration_ = 7.27

		local var_24_0 = {
			zh = 6.366,
			ja = 7.266
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
				arg_24_0:Play325112007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.55

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(325112006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 22 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 22)

				if (22 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 22)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112006", "story_v_out_325112.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112006", "story_v_out_325112.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_325112", "325112006", "story_v_out_325112.awb")

						arg_24_1:RecordAudio("325112006", var_27_6)
						arg_24_1:RecordAudio("325112006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325112", "325112006", "story_v_out_325112.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325112", "325112006", "story_v_out_325112.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325112007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325112007
		arg_28_1.duration_ = 9.93

		local var_28_0 = {
			zh = 7.166,
			ja = 9.933
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
				arg_28_0:Play325112008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1077ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1077ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1077ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1077ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1077ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1077ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_3.localPosition

				local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_4 then
					var_31_4:EnableDynamicBone(false)
				end
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_28_1.time_ - 0) / var_31_5)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(true)
				end
			end

			local var_31_7 = arg_28_1.actors_["1077ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 and not isNil(var_31_7) then
				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_7) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action9_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_31_10 = 0
			local var_31_11 = 0.675

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(325112007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 27 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 27)

				if (27 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 27)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112007", "story_v_out_325112.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_325112", "325112007", "story_v_out_325112.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_325112", "325112007", "story_v_out_325112.awb")

						arg_28_1:RecordAudio("325112007", var_31_17)
						arg_28_1:RecordAudio("325112007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325112", "325112007", "story_v_out_325112.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325112", "325112007", "story_v_out_325112.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325112008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325112008
		arg_32_1.duration_ = 5.93

		local var_32_0 = {
			zh = 4.833,
			ja = 5.933
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
				arg_32_0:Play325112009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1077ui_story"]) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = arg_32_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1077ui_story"]) then
				if arg_32_1.var_.characterEffect1077ui_story and not isNil(arg_32_1.actors_["1077ui_story"]) then
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1077ui_story"]) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.45

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(325112008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 18 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 18)

				if (18 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 18)) > 0 and var_35_2 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112008", "story_v_out_325112.awb") ~= 0 then
					local var_35_7 = manager.audio:GetVoiceLength("story_v_out_325112", "325112008", "story_v_out_325112.awb") / 1000

					if var_35_7 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_1
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_325112", "325112008", "story_v_out_325112.awb")

						arg_32_1:RecordAudio("325112008", var_35_8)
						arg_32_1:RecordAudio("325112008", var_35_8)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325112", "325112008", "story_v_out_325112.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325112", "325112008", "story_v_out_325112.awb")
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
	Play325112009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325112009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325112010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1059ui_story = arg_36_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1059ui_story"].transform.position).z)
				arg_36_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1059ui_story"].transform.localEulerAngles = arg_36_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1059ui_story"].transform.position).z)
				arg_36_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1059ui_story"].transform.localEulerAngles = arg_36_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1077ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1077ui_story = var_39_1.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_3)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, 100, 0)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(true)
				end
			end

			local var_39_5 = arg_36_1.actors_["1059ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1059ui_story == nil then
				arg_36_1.var_.characterEffect1059ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect1059ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_6)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1059ui_story then
				arg_36_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_36_1.time_ and arg_36_1.time_ <= 0.3 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword12", "")
			end

			local var_39_8 = 0
			local var_39_9 = 1.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(325112009).content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 46 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_10) / 46)

				if (46 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_10) / 46)) > 0 and var_39_9 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_13 and arg_36_1.time_ < var_39_8 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325112010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325112010
		arg_40_1.duration_ = 6.1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325112011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				local var_43_0 = arg_40_1.var_.effect34234

				if not arg_40_1.var_.effect34234 then
					var_43_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_43_0.name = "34234"
					arg_40_1.var_.effect34234 = var_43_0
				else
					var_43_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_43_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_43_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_43_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_43_0.transform.localScale = Vector3.New(var_43_0.transform.localScale.x * var_43_2, var_43_0.transform.localScale.y * var_43_2, var_43_0.transform.localScale.z * var_43_2)
			end

			if 1.475 < arg_40_1.time_ and arg_40_1.time_ <= 1.475 + arg_43_0 then
				if arg_40_1.var_.effect34234 then
					Object.Destroy(arg_40_1.var_.effect34234)

					arg_40_1.var_.effect34234 = nil
				end
			end

			local var_43_4 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_4 + 1.43333333333333 and arg_40_1.time_ < var_43_4 + 1.43333333333333 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_5 = 1.1
			local var_43_6 = 1.475

			if 1.1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_7 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_7:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_8 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(325112010).content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 59 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 59)

				if (59 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 59)) > 0 and var_43_6 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10
					var_43_5 = var_43_5 + 0.3

					if var_43_10 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = var_43_5 + 0.3
			local var_43_12 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_12 and arg_40_1.time_ < var_43_11 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325112011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325112011
		arg_46_1.duration_ = 3.7

		local var_46_0 = {
			zh = 3.7,
			ja = 2.933
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
				arg_46_0:Play325112012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1077ui_story = arg_46_1.actors_["1077ui_story"].transform.localPosition

				local var_49_0 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_0 then
					var_49_0:EnableDynamicBone(false)
				end
			end

			local var_49_1 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_1 then
				arg_46_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_1)
				arg_46_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).z)
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles = arg_46_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_1 and arg_46_1.time_ < 0 + var_49_1 + arg_49_0 then
				arg_46_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1077ui_story"].transform.position).z)
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1077ui_story"].transform.localEulerAngles = arg_46_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_49_2 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(true)
				end
			end

			local var_49_3 = arg_46_1.actors_["1077ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = var_49_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_4 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 and not isNil(var_49_3) then
				if arg_46_1.var_.characterEffect1077ui_story and not isNil(var_49_3) then
					arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1077ui_story then
				arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_49_6 = 0
			local var_49_7 = 0.15

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_8 = arg_46_1:GetWordFromCfg(325112011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 6 <= 0 and var_49_7 or var_49_7 * (utf8.len(var_49_9) / 6)

				if (6 <= 0 and var_49_7 or var_49_7 * (utf8.len(var_49_9) / 6)) > 0 and var_49_7 < var_49_11 then
					arg_46_1.talkMaxDuration = var_49_11

					if var_49_11 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112011", "story_v_out_325112.awb") ~= 0 then
					local var_49_12 = manager.audio:GetVoiceLength("story_v_out_325112", "325112011", "story_v_out_325112.awb") / 1000

					if var_49_12 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_6
					end

					if var_49_8.prefab_name ~= "" and arg_46_1.actors_[var_49_8.prefab_name] ~= nil then
						local var_49_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_8.prefab_name].transform, "story_v_out_325112", "325112011", "story_v_out_325112.awb")

						arg_46_1:RecordAudio("325112011", var_49_13)
						arg_46_1:RecordAudio("325112011", var_49_13)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325112", "325112011", "story_v_out_325112.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325112", "325112011", "story_v_out_325112.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_14 and arg_46_1.time_ < var_49_6 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play325112012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325112012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325112013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1077ui_story = arg_50_1.actors_["1077ui_story"].transform.localPosition

				local var_53_0 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_0 then
					var_53_0:EnableDynamicBone(false)
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_1)
				arg_50_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).z)
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles = arg_50_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1077ui_story"].transform.position).z)
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1077ui_story"].transform.localEulerAngles = arg_50_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_53_2 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(true)
				end
			end

			local var_53_3 = arg_50_1.actors_["1077ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect1077ui_story == nil then
				arg_50_1.var_.characterEffect1077ui_story = var_53_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 and not isNil(var_53_3) then
				if arg_50_1.var_.characterEffect1077ui_story and not isNil(var_53_3) then
					arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_4)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect1077ui_story then
				arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_53_5 = 0
			local var_53_6 = 1.15

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(325112012).content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 46 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 46)

				if (46 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 46)) > 0 and var_53_6 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_10 and arg_50_1.time_ < var_53_5 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play325112013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325112013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325112014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0.3 < arg_54_1.time_ and arg_54_1.time_ <= 0.3 + arg_57_0 then
				arg_54_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_barrier", "")
			end

			local var_57_1 = 0
			local var_57_2 = 0.975

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_3 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(325112013).content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 39 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 39)

				if (39 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 39)) > 0 and var_57_2 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_6 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_6 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_6

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_6 and arg_54_1.time_ < var_57_1 + var_57_6 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325112014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325112014
		arg_58_1.duration_ = 6.3

		local var_58_0 = {
			zh = 6.3,
			ja = 5.7
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325112015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.6

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(325112014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 24 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 24)

				if (24 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 24)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112014", "story_v_out_325112.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112014", "story_v_out_325112.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_325112", "325112014", "story_v_out_325112.awb")

						arg_58_1:RecordAudio("325112014", var_61_6)
						arg_58_1:RecordAudio("325112014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325112", "325112014", "story_v_out_325112.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325112", "325112014", "story_v_out_325112.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325112015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325112015
		arg_62_1.duration_ = 10.53

		local var_62_0 = {
			zh = 10.533,
			ja = 9.266
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325112016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1077ui_story = arg_62_1.actors_["1077ui_story"].transform.localPosition

				local var_65_0 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_0 then
					var_65_0:EnableDynamicBone(false)
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_1)
				arg_62_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1077ui_story"].transform.position).z)
				arg_62_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1077ui_story"].transform.localEulerAngles = arg_62_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1077ui_story"].transform.position).z)
				arg_62_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1077ui_story"].transform.localEulerAngles = arg_62_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_65_2 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(true)
				end
			end

			local var_65_3 = arg_62_1.actors_["1077ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = var_65_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_4 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 and not isNil(var_65_3) then
				if arg_62_1.var_.characterEffect1077ui_story and not isNil(var_65_3) then
					arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect1077ui_story then
				arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_65_6 = 0
			local var_65_7 = 0.675

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_8 = arg_62_1:GetWordFromCfg(325112015)
				local var_65_9 = arg_62_1:FormatText(var_65_8.content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 27 <= 0 and var_65_7 or var_65_7 * (utf8.len(var_65_9) / 27)

				if (27 <= 0 and var_65_7 or var_65_7 * (utf8.len(var_65_9) / 27)) > 0 and var_65_7 < var_65_11 then
					arg_62_1.talkMaxDuration = var_65_11

					if var_65_11 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112015", "story_v_out_325112.awb") ~= 0 then
					local var_65_12 = manager.audio:GetVoiceLength("story_v_out_325112", "325112015", "story_v_out_325112.awb") / 1000

					if var_65_12 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_6
					end

					if var_65_8.prefab_name ~= "" and arg_62_1.actors_[var_65_8.prefab_name] ~= nil then
						local var_65_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_8.prefab_name].transform, "story_v_out_325112", "325112015", "story_v_out_325112.awb")

						arg_62_1:RecordAudio("325112015", var_65_13)
						arg_62_1:RecordAudio("325112015", var_65_13)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325112", "325112015", "story_v_out_325112.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325112", "325112015", "story_v_out_325112.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play325112016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325112016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325112017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = arg_66_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).z)
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles = arg_66_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1059ui_story"].transform.position).z)
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1059ui_story"].transform.localEulerAngles = arg_66_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_69_1 = arg_66_1.actors_["1077ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_1.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_1.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_3)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0, 100, 0)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles

				local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_1.gameObject, typeof(DynamicBoneHelper))

				if var_69_4 then
					var_69_4:EnableDynamicBone(true)
				end
			end

			local var_69_5 = arg_66_1.actors_["1077ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 and not isNil(var_69_5) then
				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_6)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_66_1.time_ and arg_66_1.time_ <= 0.1 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep_back", "")
			end

			local var_69_8 = 0
			local var_69_9 = 0.95

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_10 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(325112016).content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_12 = 38 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_10) / 38)

				if (38 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_10) / 38)) > 0 and var_69_9 < var_69_12 then
					arg_66_1.talkMaxDuration = var_69_12

					if var_69_12 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_13 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_13 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_13

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_13 and arg_66_1.time_ < var_69_8 + var_69_13 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play325112017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325112017
		arg_70_1.duration_ = 3.13

		local var_70_0 = {
			zh = 2.5,
			ja = 3.133
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
				arg_70_0:Play325112018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.15

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(325112017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 6 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 6)

				if (6 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 6)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112017", "story_v_out_325112.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112017", "story_v_out_325112.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_325112", "325112017", "story_v_out_325112.awb")

						arg_70_1:RecordAudio("325112017", var_73_6)
						arg_70_1:RecordAudio("325112017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325112", "325112017", "story_v_out_325112.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325112", "325112017", "story_v_out_325112.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325112018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325112018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325112019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0.5 < arg_74_1.time_ and arg_74_1.time_ <= 0.5 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword02", "")
			end

			local var_77_1 = 0
			local var_77_2 = 0.75

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(325112018).content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 30 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_3) / 30)

				if (30 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_3) / 30)) > 0 and var_77_2 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_6 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_6 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_6

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_6 and arg_74_1.time_ < var_77_1 + var_77_6 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325112019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325112019
		arg_78_1.duration_ = 3.1

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325112020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.275

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(325112019)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 11 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 11)

				if (11 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 11)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112019", "story_v_out_325112.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112019", "story_v_out_325112.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_325112", "325112019", "story_v_out_325112.awb")

						arg_78_1:RecordAudio("325112019", var_81_6)
						arg_78_1:RecordAudio("325112019", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325112", "325112019", "story_v_out_325112.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325112", "325112019", "story_v_out_325112.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325112020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325112020
		arg_82_1.duration_ = 4.83

		local var_82_0 = {
			zh = 3.433,
			ja = 4.833
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
				arg_82_0:Play325112021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.25

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(325112020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 10 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 10)

				if (10 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 10)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112020", "story_v_out_325112.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112020", "story_v_out_325112.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_325112", "325112020", "story_v_out_325112.awb")

						arg_82_1:RecordAudio("325112020", var_85_6)
						arg_82_1:RecordAudio("325112020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325112", "325112020", "story_v_out_325112.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325112", "325112020", "story_v_out_325112.awb")
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
	Play325112021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325112021
		arg_86_1.duration_ = 9.3

		local var_86_0 = {
			zh = 7.333,
			ja = 9.3
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
				arg_86_0:Play325112022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.625

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(325112021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 25 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 25)

				if (25 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 25)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112021", "story_v_out_325112.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112021", "story_v_out_325112.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_325112", "325112021", "story_v_out_325112.awb")

						arg_86_1:RecordAudio("325112021", var_89_6)
						arg_86_1:RecordAudio("325112021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325112", "325112021", "story_v_out_325112.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325112", "325112021", "story_v_out_325112.awb")
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
	Play325112022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325112022
		arg_90_1.duration_ = 6.23

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325112023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_9002
			local var_93_9001
			local var_93_9000

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1059ui_story"]) and arg_90_1.var_.characterEffect1059ui_story == nil then
				arg_90_1.var_.characterEffect1059ui_story = arg_90_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1059ui_story"]) then
				if arg_90_1.var_.characterEffect1059ui_story and not isNil(arg_90_1.actors_["1059ui_story"]) then
					arg_90_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1059ui_story"]) and arg_90_1.var_.characterEffect1059ui_story then
				arg_90_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				local var_93_1 = arg_90_1.var_.effect4324

				if not arg_90_1.var_.effect4324 then
					var_93_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_93_1.name = "4324"
					arg_90_1.var_.effect4324 = var_93_1
				else
					var_93_1.transform:SetParent(var_93_9002)
				end

				var_93_1.transform.localPosition = Vector3.New(0, 0, 0.48)
				var_93_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_93_1.transform.localScale = Vector3.New(var_93_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_93_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_93_1.transform.localScale.z)
			end

			if 2.73333333333333 < arg_90_1.time_ and arg_90_1.time_ <= 2.73333333333333 + arg_93_0 then
				if arg_90_1.var_.effect4324 then
					Object.Destroy(arg_90_1.var_.effect4324)

					arg_90_1.var_.effect4324 = nil
				end
			end

			if 0.333333333333333 < arg_90_1.time_ and arg_90_1.time_ <= 0.333333333333333 + arg_93_0 then
				local var_93_4 = arg_90_1.var_.effect43241

				if not arg_90_1.var_.effect43241 then
					var_93_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_93_4.name = "43241"
					arg_90_1.var_.effect43241 = var_93_4
				else
					var_93_4.transform:SetParent(var_93_9001)
				end

				var_93_4.transform.localPosition = Vector3.New(0, 0, -1.78)
				var_93_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_93_4.transform.localScale = Vector3.New(var_93_4.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_93_4.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_93_4.transform.localScale.z)
			end

			if 3.06666666666667 < arg_90_1.time_ and arg_90_1.time_ <= 3.06666666666667 + arg_93_0 then
				if arg_90_1.var_.effect43241 then
					Object.Destroy(arg_90_1.var_.effect43241)

					arg_90_1.var_.effect43241 = nil
				end
			end

			if 0.733333333333333 < arg_90_1.time_ and arg_90_1.time_ <= 0.733333333333333 + arg_93_0 then
				local var_93_7 = arg_90_1.var_.effect42432

				if not arg_90_1.var_.effect42432 then
					var_93_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_93_7.name = "42432"
					arg_90_1.var_.effect42432 = var_93_7
				else
					var_93_7.transform:SetParent(var_93_9000)
				end

				var_93_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_93_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_93_9 = 0

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.allBtn_.enabled = false
			end

			if arg_90_1.time_ >= var_93_9 + 1.96666666666667 and arg_90_1.time_ < var_93_9 + 1.96666666666667 + arg_93_0 then
				arg_90_1.allBtn_.enabled = true
			end

			if 0.4 < arg_90_1.time_ and arg_90_1.time_ <= 0.4 + arg_93_0 then
				arg_90_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_power", "")
			end

			if 0.3 < arg_90_1.time_ and arg_90_1.time_ <= 0.3 + arg_93_0 then
				arg_90_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword07", "")
			end

			if arg_90_1.frameCnt_ <= 1 then
				arg_90_1.dialog_:SetActive(false)
			end

			local var_93_12 = 1.23333333333333
			local var_93_13 = 1.725

			if 1.23333333333333 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				arg_90_1.dialog_:SetActive(true)

				arg_90_1.dialogCg_.alpha = 0

				local var_93_14 = LeanTween.value(arg_90_1.dialog_, 0, 1, 0.3)

				var_93_14:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_90_1.dialogCg_.alpha = arg_94_0
				end))
				var_93_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_90_1.dialog_)
					var_93_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_90_1.duration_ = arg_90_1.duration_ + 0.3

				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(325112022).content)

				arg_90_1.text_.text = var_93_15

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 69 <= 0 and var_93_13 or var_93_13 * (utf8.len(var_93_15) / 69)

				if (69 <= 0 and var_93_13 or var_93_13 * (utf8.len(var_93_15) / 69)) > 0 and var_93_13 < var_93_17 then
					arg_90_1.talkMaxDuration = var_93_17
					var_93_12 = var_93_12 + 0.3

					if var_93_17 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_17 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_15
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_18 = var_93_12 + 0.3
			local var_93_19 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 + 0.3 <= arg_90_1.time_ and arg_90_1.time_ < var_93_18 + var_93_19 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_18) / var_93_19

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_18 + var_93_19 and arg_90_1.time_ < var_93_18 + var_93_19 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325112023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325112023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325112024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 1.4

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(325112023).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 56 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 56)

				if (56 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 56)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325112024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325112024
		arg_100_1.duration_ = 11.03

		local var_100_0 = {
			zh = 4.866,
			ja = 11.033
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
				arg_100_0:Play325112025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:GetWordFromCfg(325112024)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 17)

				if (17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 17)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112024", "story_v_out_325112.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112024", "story_v_out_325112.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_325112", "325112024", "story_v_out_325112.awb")

						arg_100_1:RecordAudio("325112024", var_103_6)
						arg_100_1:RecordAudio("325112024", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325112", "325112024", "story_v_out_325112.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325112", "325112024", "story_v_out_325112.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325112025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325112025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325112026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.875

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(325112025).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 35 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 35)

				if (35 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 35)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325112026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325112026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325112027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.4

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(325112026).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 56 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 56)

				if (56 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 56)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325112027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325112027
		arg_112_1.duration_ = 6.27

		local var_112_0 = {
			zh = 3.533,
			ja = 6.266
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
				arg_112_0:Play325112028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.25

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
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

				local var_115_1 = arg_112_1:GetWordFromCfg(325112027)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 10 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 10)

				if (10 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 10)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112027", "story_v_out_325112.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_325112", "325112027", "story_v_out_325112.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_325112", "325112027", "story_v_out_325112.awb")

						arg_112_1:RecordAudio("325112027", var_115_6)
						arg_112_1:RecordAudio("325112027", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325112", "325112027", "story_v_out_325112.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325112", "325112027", "story_v_out_325112.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325112028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325112028
		arg_116_1.duration_ = 7.3

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
			arg_116_1.auto_ = false
		end

		function arg_116_1.playNext_(arg_118_0)
			arg_116_1.onStoryFinished_()
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_9000

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				local var_119_0 = arg_116_1.var_.effecteqewe

				if not arg_116_1.var_.effecteqewe then
					var_119_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), manager.ui.mainCamera.transform)
					var_119_0.name = "eqewe"
					arg_116_1.var_.effecteqewe = var_119_0
				else
					var_119_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_119_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_119_0.transform.localScale = Vector3.New(var_119_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_119_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_119_0.transform.localScale.z)
			end

			if 1.96793889906257 < arg_116_1.time_ and arg_116_1.time_ <= 1.96793889906257 + arg_119_0 then
				local var_119_2 = arg_116_1.var_.effectewqe

				if not arg_116_1.var_.effectewqe then
					var_119_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), manager.ui.mainCamera.transform)
					var_119_2.name = "ewqe"
					arg_116_1.var_.effectewqe = var_119_2
				else
					var_119_2.transform:SetParent(var_119_9000)
				end

				var_119_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_119_4 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_4 + 2.53333333333333 and arg_116_1.time_ < var_119_4 + 2.53333333333333 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_5 = 0.266666666666667

			if 0.266666666666667 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_6 = 0.733333333333333

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 then
				local var_119_7 = Color.New(1, 1, 1)

				var_119_7.a = Mathf.Lerp(1, 0, (arg_116_1.time_ - var_119_5) / var_119_6)
				arg_116_1.mask_.color = var_119_7
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 then
				local var_119_8 = Color.New(1, 1, 1)

				arg_116_1.mask_.enabled = false
				var_119_8.a = 0
				arg_116_1.mask_.color = var_119_8
			end

			if 0.6 < arg_116_1.time_ and arg_116_1.time_ <= 0.6 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_151", "se_story_151_door", "")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_11 = 2.3
			local var_119_12 = 1.1

			if 2.3 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_13 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_13:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_14 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(325112028).content)

				arg_116_1.text_.text = var_119_14

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_16 = 44 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_14) / 44)

				if (44 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_14) / 44)) > 0 and var_119_12 < var_119_16 then
					arg_116_1.talkMaxDuration = var_119_16
					var_119_11 = var_119_11 + 0.3

					if var_119_16 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_14
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_17 = var_119_11 + 0.3
			local var_119_18 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_17) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_17 + var_119_18 and arg_116_1.time_ < var_119_17 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2010"
	},
	voices = {
		"story_v_out_325112.awb"
	}
}
