return {
	Play304051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304051001
		arg_1_1.duration_ = 4.73

		local var_1_0 = {
			zh = 3.666,
			ja = 4.733
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
				arg_1_0:Play304051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9005
			local var_4_9004
			local var_4_9003
			local var_4_9002
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.B04b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B04b")
				var_4_0.name = "B04b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B04b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B04b

				arg_1_1.bgs_.B04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04b" then
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

			local var_4_6 = 1.425

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

			local var_4_9 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1148ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect444233

				if not arg_1_1.var_.effect444233 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_16.name = "444233"
					arg_1_1.var_.effect444233 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9005)
				end

				var_4_16.transform.localPosition = Vector3.New(-1.41, -0.06, -0.09)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				local var_4_18 = arg_1_1.var_.effect444234

				if not arg_1_1.var_.effect444234 then
					var_4_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_18.name = "444234"
					arg_1_1.var_.effect444234 = var_4_18
				else
					var_4_18.transform:SetParent(var_4_9004)
				end

				var_4_18.transform.localPosition = Vector3.New(-0.25, -0.28, 0)
				var_4_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.433333333333334 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333334 + arg_4_0 then
				local var_4_20 = arg_1_1.var_.effect444235

				if not arg_1_1.var_.effect444235 then
					var_4_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_20.name = "444235"
					arg_1_1.var_.effect444235 = var_4_20
				else
					var_4_20.transform:SetParent(var_4_9003)
				end

				var_4_20.transform.localPosition = Vector3.New(0.63, -0.34, -1.1)
				var_4_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				if arg_1_1.var_.effect444233 then
					Object.Destroy(arg_1_1.var_.effect444233)

					arg_1_1.var_.effect444233 = nil
				end
			end

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				if arg_1_1.var_.effect444234 then
					Object.Destroy(arg_1_1.var_.effect444234)

					arg_1_1.var_.effect444234 = nil
				end
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				if arg_1_1.var_.effect444235 then
					Object.Destroy(arg_1_1.var_.effect444235)

					arg_1_1.var_.effect444235 = nil
				end
			end

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				local var_4_25 = arg_1_1.var_.effect4442331

				if not arg_1_1.var_.effect4442331 then
					var_4_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_25.name = "4442331"
					arg_1_1.var_.effect4442331 = var_4_25
				else
					var_4_25.transform:SetParent(var_4_9002)
				end

				var_4_25.transform.localPosition = Vector3.New(-1.79, -0.98, -0.09)
				var_4_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				local var_4_27 = arg_1_1.var_.effect4442342

				if not arg_1_1.var_.effect4442342 then
					var_4_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_27.name = "4442342"
					arg_1_1.var_.effect4442342 = var_4_27
				else
					var_4_27.transform:SetParent(var_4_9001)
				end

				var_4_27.transform.localPosition = Vector3.New(0.95, -1.1, 2.37)
				var_4_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.733333333333334 < arg_1_1.time_ and arg_1_1.time_ <= 0.733333333333334 + arg_4_0 then
				local var_4_29 = arg_1_1.var_.effect332323

				if not arg_1_1.var_.effect332323 then
					var_4_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_29.name = "332323"
					arg_1_1.var_.effect332323 = var_4_29
				else
					var_4_29.transform:SetParent(var_4_9000)
				end

				var_4_29.transform.localPosition = Vector3.New(1.27, 0.13, -1.1)
				var_4_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				if arg_1_1.var_.effect4442331 then
					Object.Destroy(arg_1_1.var_.effect4442331)

					arg_1_1.var_.effect4442331 = nil
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				if arg_1_1.var_.effect4442342 then
					Object.Destroy(arg_1_1.var_.effect4442342)

					arg_1_1.var_.effect4442342 = nil
				end
			end

			if 2.23333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 2.23333333333333 + arg_4_0 then
				if arg_1_1.var_.effect332323 then
					Object.Destroy(arg_1_1.var_.effect332323)

					arg_1_1.var_.effect332323 = nil
				end
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle02", "")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_38 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_40 = 1.2
			local var_4_41 = 0.225

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_43 = arg_1_1:GetWordFromCfg(304051001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 9 <= 0 and var_4_41 or var_4_41 * (utf8.len(var_4_44) / 9)

				if (9 <= 0 and var_4_41 or var_4_41 * (utf8.len(var_4_44) / 9)) > 0 and var_4_41 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_40 = var_4_40 + 0.3

					if var_4_46 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051001", "story_v_out_304051.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_304051", "304051001", "story_v_out_304051.awb") / 1000

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end

					if var_4_43.prefab_name ~= "" and arg_1_1.actors_[var_4_43.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_43.prefab_name].transform, "story_v_out_304051", "304051001", "story_v_out_304051.awb")

						arg_1_1:RecordAudio("304051001", var_4_48)
						arg_1_1:RecordAudio("304051001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304051", "304051001", "story_v_out_304051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304051", "304051001", "story_v_out_304051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_40 + 0.3
			local var_4_50 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_40 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = arg_8_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) then
				if arg_8_1.var_.characterEffect1148ui_story and not isNil(arg_8_1.actors_["1148ui_story"]) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1

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

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(304051002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 40 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 40)

				if (40 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 40)) > 0 and var_11_2 < var_11_5 then
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
	Play304051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.8

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(304051003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 72 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 72)

				if (72 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 72)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304051004
		arg_16_1.duration_ = 9.37

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play304051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["2018ui_story"]) and arg_16_1.var_.characterEffect2018ui_story == nil then
				arg_16_1.var_.characterEffect2018ui_story = arg_16_1.actors_["2018ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["2018ui_story"]) then
				if arg_16_1.var_.characterEffect2018ui_story and not isNil(arg_16_1.actors_["2018ui_story"]) then
					arg_16_1.var_.characterEffect2018ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["2018ui_story"]) and arg_16_1.var_.characterEffect2018ui_story then
				arg_16_1.var_.characterEffect2018ui_story.fillFlat = false
			end

			local var_19_2 = 0
			local var_19_3 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2018")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_4 = arg_16_1:GetWordFromCfg(304051004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 18 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 18)

				if (18 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 18)) > 0 and var_19_3 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051004", "story_v_out_304051.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_304051", "304051004", "story_v_out_304051.awb") / 1000

					if var_19_8 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_2
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_304051", "304051004", "story_v_out_304051.awb")

						arg_16_1:RecordAudio("304051004", var_19_9)
						arg_16_1:RecordAudio("304051004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304051", "304051004", "story_v_out_304051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304051", "304051004", "story_v_out_304051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_10 and arg_16_1.time_ < var_19_2 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304051005
		arg_20_1.duration_ = 11.57

		local var_20_0 = {
			zh = 7.2,
			ja = 11.566
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
				arg_20_0:Play304051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148ui_story = arg_20_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_23_0 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).z)
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles = arg_20_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_20_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).z)
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles = arg_20_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_23_1 = arg_20_1.actors_["1148ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = var_23_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 and not isNil(var_23_1) then
				if arg_20_1.var_.characterEffect1148ui_story and not isNil(var_23_1) then
					arg_20_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_2 and arg_20_1.time_ < 0 + var_23_2 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1148ui_story then
				arg_20_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["2018ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect2018ui_story == nil then
				arg_20_1.var_.characterEffect2018ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_5 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 and not isNil(var_23_4) then
				if arg_20_1.var_.characterEffect2018ui_story and not isNil(var_23_4) then
					arg_20_1.var_.characterEffect2018ui_story.fillFlat = true
					arg_20_1.var_.characterEffect2018ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_5)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect2018ui_story then
				arg_20_1.var_.characterEffect2018ui_story.fillFlat = true
				arg_20_1.var_.characterEffect2018ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.9

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(304051005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 36 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 36)

				if (36 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 36)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051005", "story_v_out_304051.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_304051", "304051005", "story_v_out_304051.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_304051", "304051005", "story_v_out_304051.awb")

						arg_20_1:RecordAudio("304051005", var_23_13)
						arg_20_1:RecordAudio("304051005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304051", "304051005", "story_v_out_304051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304051", "304051005", "story_v_out_304051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play304051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304051006
		arg_24_1.duration_ = 10.6

		local var_24_0 = {
			zh = 4.066,
			ja = 10.6
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
				arg_24_0:Play304051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1059ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1059ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1059ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1059ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["1059ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_3.localPosition
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_24_1.time_ - 0) / var_27_4)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			local var_27_5 = arg_24_1.actors_["1148ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1148ui_story = var_27_5.localPosition
			end

			local var_27_6 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 then
				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_24_1.time_ - 0) / var_27_6)
				var_27_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_5.position).x, (manager.ui.mainCamera.transform.position - var_27_5.position).y, (manager.ui.mainCamera.transform.position - var_27_5.position).z)
				var_27_5.localEulerAngles.z = 0
				var_27_5.localEulerAngles.x = 0
				var_27_5.localEulerAngles = var_27_5.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_27_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_5.position).x, (manager.ui.mainCamera.transform.position - var_27_5.position).y, (manager.ui.mainCamera.transform.position - var_27_5.position).z)
				var_27_5.localEulerAngles.z = 0
				var_27_5.localEulerAngles.x = 0
				var_27_5.localEulerAngles = var_27_5.localEulerAngles
			end

			local var_27_7 = arg_24_1.actors_["1059ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1059ui_story == nil then
				arg_24_1.var_.characterEffect1059ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect1059ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1059ui_story then
				arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_27_10 = arg_24_1.actors_["1148ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_10) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_11 and not isNil(var_27_10) then
				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_10) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_11)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_11 and arg_24_1.time_ < 0 + var_27_11 + arg_27_0 and not isNil(var_27_10) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_12 = 0
			local var_27_13 = 0.55

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_14 = arg_24_1:GetWordFromCfg(304051006)
				local var_27_15 = arg_24_1:FormatText(var_27_14.content)

				arg_24_1.text_.text = var_27_15

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 22 <= 0 and var_27_13 or var_27_13 * (utf8.len(var_27_15) / 22)

				if (22 <= 0 and var_27_13 or var_27_13 * (utf8.len(var_27_15) / 22)) > 0 and var_27_13 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_15
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051006", "story_v_out_304051.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_304051", "304051006", "story_v_out_304051.awb") / 1000

					if var_27_18 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_12
					end

					if var_27_14.prefab_name ~= "" and arg_24_1.actors_[var_27_14.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_14.prefab_name].transform, "story_v_out_304051", "304051006", "story_v_out_304051.awb")

						arg_24_1:RecordAudio("304051006", var_27_19)
						arg_24_1:RecordAudio("304051006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304051", "304051006", "story_v_out_304051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304051", "304051006", "story_v_out_304051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_20 and arg_24_1.time_ < var_27_12 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play304051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304051007
		arg_28_1.duration_ = 4.53

		local var_28_0 = {
			zh = 4.033,
			ja = 4.533
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
				arg_28_0:Play304051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = arg_28_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) then
				if arg_28_1.var_.characterEffect1148ui_story and not isNil(arg_28_1.actors_["1148ui_story"]) then
					arg_28_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) and arg_28_1.var_.characterEffect1148ui_story then
				arg_28_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1059ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1059ui_story == nil then
				arg_28_1.var_.characterEffect1059ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1059ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1059ui_story then
				arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action439")
			end

			local var_31_4 = 0
			local var_31_5 = 0.475

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(304051007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 19 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 19)

				if (19 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 19)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051007", "story_v_out_304051.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051007", "story_v_out_304051.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_304051", "304051007", "story_v_out_304051.awb")

						arg_28_1:RecordAudio("304051007", var_31_11)
						arg_28_1:RecordAudio("304051007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304051", "304051007", "story_v_out_304051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304051", "304051007", "story_v_out_304051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304051008
		arg_32_1.duration_ = 5.17

		local var_32_0 = {
			zh = 3.6,
			ja = 5.166
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
				arg_32_0:Play304051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.425

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(304051008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 17 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 17)

				if (17 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 17)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051008", "story_v_out_304051.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_304051", "304051008", "story_v_out_304051.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_304051", "304051008", "story_v_out_304051.awb")

						arg_32_1:RecordAudio("304051008", var_35_6)
						arg_32_1:RecordAudio("304051008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304051", "304051008", "story_v_out_304051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304051", "304051008", "story_v_out_304051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304051009
		arg_36_1.duration_ = 6.7

		local var_36_0 = {
			zh = 5.433,
			ja = 6.7
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
				arg_36_0:Play304051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1059ui_story"]) and arg_36_1.var_.characterEffect1059ui_story == nil then
				arg_36_1.var_.characterEffect1059ui_story = arg_36_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1059ui_story"]) then
				if arg_36_1.var_.characterEffect1059ui_story and not isNil(arg_36_1.actors_["1059ui_story"]) then
					arg_36_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1059ui_story"]) and arg_36_1.var_.characterEffect1059ui_story then
				arg_36_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1148ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1148ui_story == nil then
				arg_36_1.var_.characterEffect1148ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1148ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1148ui_story then
				arg_36_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action432")
			end

			local var_39_4 = 0
			local var_39_5 = 0.6

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(304051009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 24 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 24)

				if (24 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 24)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051009", "story_v_out_304051.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051009", "story_v_out_304051.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_304051", "304051009", "story_v_out_304051.awb")

						arg_36_1:RecordAudio("304051009", var_39_11)
						arg_36_1:RecordAudio("304051009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304051", "304051009", "story_v_out_304051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304051", "304051009", "story_v_out_304051.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304051010
		arg_40_1.duration_ = 9.1

		local var_40_0 = {
			zh = 3.966,
			ja = 9.1
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
				arg_40_0:Play304051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.5

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(304051010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 20)

				if (20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 20)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051010", "story_v_out_304051.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_304051", "304051010", "story_v_out_304051.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_304051", "304051010", "story_v_out_304051.awb")

						arg_40_1:RecordAudio("304051010", var_43_6)
						arg_40_1:RecordAudio("304051010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304051", "304051010", "story_v_out_304051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304051", "304051010", "story_v_out_304051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304051011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1059ui_story = arg_44_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1059ui_story"].transform.position).z)
				arg_44_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1059ui_story"].transform.localEulerAngles = arg_44_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1059ui_story"].transform.position).z)
				arg_44_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1059ui_story"].transform.localEulerAngles = arg_44_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1148ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1148ui_story = var_47_1.localPosition
			end

			local var_47_2 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 then
				var_47_1.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_2)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 then
				var_47_1.localPosition = Vector3.New(0, 100, 0)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			local var_47_3 = arg_44_1.actors_["1059ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1059ui_story == nil then
				arg_44_1.var_.characterEffect1059ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1059ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_4)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1059ui_story then
				arg_44_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_47_5 = 0
			local var_47_6 = 1.45

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(304051011).content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 58 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_7) / 58)

				if (58 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_7) / 58)) > 0 and var_47_6 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_10 and arg_44_1.time_ < var_47_5 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play304051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304051012
		arg_48_1.duration_ = 8.4

		local var_48_0 = {
			zh = 6.266,
			ja = 8.4
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
				arg_48_0:Play304051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1059ui_story = arg_48_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1059ui_story"].transform.position).z)
				arg_48_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1059ui_story"].transform.localEulerAngles = arg_48_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6)
				arg_48_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1059ui_story"].transform.position).z)
				arg_48_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1059ui_story"].transform.localEulerAngles = arg_48_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1059ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1059ui_story == nil then
				arg_48_1.var_.characterEffect1059ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1059ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1059ui_story then
				arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0
			local var_51_5 = 0.85

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(304051012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 34 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 34)

				if (34 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 34)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051012", "story_v_out_304051.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051012", "story_v_out_304051.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_304051", "304051012", "story_v_out_304051.awb")

						arg_48_1:RecordAudio("304051012", var_51_11)
						arg_48_1:RecordAudio("304051012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304051", "304051012", "story_v_out_304051.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304051", "304051012", "story_v_out_304051.awb")
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

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play304051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304051013
		arg_52_1.duration_ = 4.77

		local var_52_0 = {
			zh = 3.9,
			ja = 4.766
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
				arg_52_0:Play304051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1148ui_story = arg_52_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1148ui_story"].transform.position).z)
				arg_52_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1148ui_story"].transform.localEulerAngles = arg_52_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_52_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1148ui_story"].transform.position).z)
				arg_52_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1148ui_story"].transform.localEulerAngles = arg_52_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1148ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1148ui_story == nil then
				arg_52_1.var_.characterEffect1148ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1148ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1148ui_story then
				arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1059ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1059ui_story == nil then
				arg_52_1.var_.characterEffect1059ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_5 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 and not isNil(var_55_4) then
				if arg_52_1.var_.characterEffect1059ui_story and not isNil(var_55_4) then
					arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_5)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1059ui_story then
				arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action494")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_6 = 0
			local var_55_7 = 0.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(304051013)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 18 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 18)

				if (18 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 18)) > 0 and var_55_7 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051013", "story_v_out_304051.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_304051", "304051013", "story_v_out_304051.awb") / 1000

					if var_55_12 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_6
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_304051", "304051013", "story_v_out_304051.awb")

						arg_52_1:RecordAudio("304051013", var_55_13)
						arg_52_1:RecordAudio("304051013", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304051", "304051013", "story_v_out_304051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304051", "304051013", "story_v_out_304051.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play304051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304051014
		arg_56_1.duration_ = 2.7

		local var_56_0 = {
			zh = 2.666,
			ja = 2.7
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
				arg_56_0:Play304051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1059ui_story"]) and arg_56_1.var_.characterEffect1059ui_story == nil then
				arg_56_1.var_.characterEffect1059ui_story = arg_56_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1059ui_story"]) then
				if arg_56_1.var_.characterEffect1059ui_story and not isNil(arg_56_1.actors_["1059ui_story"]) then
					arg_56_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1059ui_story"]) and arg_56_1.var_.characterEffect1059ui_story then
				arg_56_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1148ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1148ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1148ui_story then
				arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_4 = 0
			local var_59_5 = 0.325

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(304051014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 13 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 13)

				if (13 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 13)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051014", "story_v_out_304051.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051014", "story_v_out_304051.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_304051", "304051014", "story_v_out_304051.awb")

						arg_56_1:RecordAudio("304051014", var_59_11)
						arg_56_1:RecordAudio("304051014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304051", "304051014", "story_v_out_304051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304051", "304051014", "story_v_out_304051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play304051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304051015
		arg_60_1.duration_ = 7.47

		local var_60_0 = {
			zh = 5.1,
			ja = 7.466
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
				arg_60_0:Play304051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story == nil then
				arg_60_1.var_.characterEffect1148ui_story = arg_60_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) then
				if arg_60_1.var_.characterEffect1148ui_story and not isNil(arg_60_1.actors_["1148ui_story"]) then
					arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story then
				arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
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

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.55

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(304051015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 22 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 22)

				if (22 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 22)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051015", "story_v_out_304051.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051015", "story_v_out_304051.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_304051", "304051015", "story_v_out_304051.awb")

						arg_60_1:RecordAudio("304051015", var_63_11)
						arg_60_1:RecordAudio("304051015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304051", "304051015", "story_v_out_304051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304051", "304051015", "story_v_out_304051.awb")
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
	Play304051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304051016
		arg_64_1.duration_ = 11.17

		local var_64_0 = {
			zh = 7.066,
			ja = 11.166
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
				arg_64_0:Play304051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1059ui_story"]) and arg_64_1.var_.characterEffect1059ui_story == nil then
				arg_64_1.var_.characterEffect1059ui_story = arg_64_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1059ui_story"]) then
				if arg_64_1.var_.characterEffect1059ui_story and not isNil(arg_64_1.actors_["1059ui_story"]) then
					arg_64_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1059ui_story"]) and arg_64_1.var_.characterEffect1059ui_story then
				arg_64_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1148ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1148ui_story == nil then
				arg_64_1.var_.characterEffect1148ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1148ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1148ui_story then
				arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_67_4 = 0
			local var_67_5 = 0.875

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(304051016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 35 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 35)

				if (35 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 35)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051016", "story_v_out_304051.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051016", "story_v_out_304051.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_304051", "304051016", "story_v_out_304051.awb")

						arg_64_1:RecordAudio("304051016", var_67_11)
						arg_64_1:RecordAudio("304051016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_304051", "304051016", "story_v_out_304051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_304051", "304051016", "story_v_out_304051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304051017
		arg_68_1.duration_ = 10.9

		local var_68_0 = {
			zh = 6.866,
			ja = 10.9
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
				arg_68_0:Play304051018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) and arg_68_1.var_.characterEffect1148ui_story == nil then
				arg_68_1.var_.characterEffect1148ui_story = arg_68_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) then
				if arg_68_1.var_.characterEffect1148ui_story and not isNil(arg_68_1.actors_["1148ui_story"]) then
					arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) and arg_68_1.var_.characterEffect1148ui_story then
				arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
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
			local var_71_5 = 0.775

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(304051017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 31 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 31)

				if (31 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 31)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051017", "story_v_out_304051.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051017", "story_v_out_304051.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_304051", "304051017", "story_v_out_304051.awb")

						arg_68_1:RecordAudio("304051017", var_71_11)
						arg_68_1:RecordAudio("304051017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304051", "304051017", "story_v_out_304051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304051", "304051017", "story_v_out_304051.awb")
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
	Play304051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304051018
		arg_72_1.duration_ = 6.2

		local var_72_0 = {
			zh = 5.5,
			ja = 6.2
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
				arg_72_0:Play304051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1059ui_story"]) and arg_72_1.var_.characterEffect1059ui_story == nil then
				arg_72_1.var_.characterEffect1059ui_story = arg_72_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1059ui_story"]) then
				if arg_72_1.var_.characterEffect1059ui_story and not isNil(arg_72_1.actors_["1059ui_story"]) then
					arg_72_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1059ui_story"]) and arg_72_1.var_.characterEffect1059ui_story then
				arg_72_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1148ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1148ui_story == nil then
				arg_72_1.var_.characterEffect1148ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect1148ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1148ui_story then
				arg_72_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_75_4 = 0
			local var_75_5 = 0.775

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(304051018)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 31 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 31)

				if (31 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 31)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051018", "story_v_out_304051.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051018", "story_v_out_304051.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_304051", "304051018", "story_v_out_304051.awb")

						arg_72_1:RecordAudio("304051018", var_75_11)
						arg_72_1:RecordAudio("304051018", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304051", "304051018", "story_v_out_304051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304051", "304051018", "story_v_out_304051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play304051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304051019
		arg_76_1.duration_ = 4.77

		local var_76_0 = {
			zh = 2.6,
			ja = 4.766
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
				arg_76_0:Play304051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1148ui_story"]) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = arg_76_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1148ui_story"]) then
				if arg_76_1.var_.characterEffect1148ui_story and not isNil(arg_76_1.actors_["1148ui_story"]) then
					arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1148ui_story"]) and arg_76_1.var_.characterEffect1148ui_story then
				arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1059ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1059ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action456")
			end

			local var_79_4 = 0
			local var_79_5 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(304051019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 8 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 8)

				if (8 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 8)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051019", "story_v_out_304051.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051019", "story_v_out_304051.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_304051", "304051019", "story_v_out_304051.awb")

						arg_76_1:RecordAudio("304051019", var_79_11)
						arg_76_1:RecordAudio("304051019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304051", "304051019", "story_v_out_304051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304051", "304051019", "story_v_out_304051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304051020
		arg_80_1.duration_ = 3.6

		local var_80_0 = {
			zh = 3.6,
			ja = 2.633
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
				arg_80_0:Play304051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.475

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(304051020)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 19 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 19)

				if (19 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 19)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051020", "story_v_out_304051.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_304051", "304051020", "story_v_out_304051.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_304051", "304051020", "story_v_out_304051.awb")

						arg_80_1:RecordAudio("304051020", var_83_6)
						arg_80_1:RecordAudio("304051020", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304051", "304051020", "story_v_out_304051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304051", "304051020", "story_v_out_304051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play304051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304051021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1059ui_story = arg_84_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1059ui_story"].transform.position).z)
				arg_84_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1059ui_story"].transform.localEulerAngles = arg_84_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1059ui_story"].transform.position).z)
				arg_84_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1059ui_story"].transform.localEulerAngles = arg_84_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1148ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148ui_story = var_87_1.localPosition
			end

			local var_87_2 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 then
				var_87_1.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_2)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 then
				var_87_1.localPosition = Vector3.New(0, 100, 0)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			local var_87_3 = arg_84_1.actors_["1148ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = var_87_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_4 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 and not isNil(var_87_3) then
				if arg_84_1.var_.characterEffect1148ui_story and not isNil(var_87_3) then
					arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_4)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1148ui_story then
				arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_87_5 = 0
			local var_87_6 = 1.45

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(304051021).content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 58 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 58)

				if (58 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 58)) > 0 and var_87_6 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_10 and arg_84_1.time_ < var_87_5 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
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
	Play304051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 304051022
		arg_88_1.duration_ = 5.7

		local var_88_0 = {
			zh = 5.333,
			ja = 5.7
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
			arg_88_1.auto_ = false
		end

		function arg_88_1.playNext_(arg_90_0)
			arg_88_1.onStoryFinished_()
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1059ui_story = arg_88_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1059ui_story"].transform.position).z)
				arg_88_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1059ui_story"].transform.localEulerAngles = arg_88_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_88_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1059ui_story"].transform.position).z)
				arg_88_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1059ui_story"].transform.localEulerAngles = arg_88_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1059ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1059ui_story == nil then
				arg_88_1.var_.characterEffect1059ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1059ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1059ui_story then
				arg_88_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_4 = 0
			local var_91_5 = 0.725

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(304051022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 29 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 29)

				if (29 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 29)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304051", "304051022", "story_v_out_304051.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_304051", "304051022", "story_v_out_304051.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_304051", "304051022", "story_v_out_304051.awb")

						arg_88_1:RecordAudio("304051022", var_91_11)
						arg_88_1:RecordAudio("304051022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_304051", "304051022", "story_v_out_304051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_304051", "304051022", "story_v_out_304051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04b"
	},
	voices = {
		"story_v_out_304051.awb"
	}
}
