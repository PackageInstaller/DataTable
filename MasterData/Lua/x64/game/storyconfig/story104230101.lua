return {
	Play423011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423011001
		arg_1_1.duration_ = 8.63

		local var_1_0 = {
			zh = 7.2,
			ja = 8.633
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
				arg_1_0:Play423011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.I25g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25g")
				var_4_0.name = "I25g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I25g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I25g

				arg_1_1.bgs_.I25g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I25g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.var_.effectfengsha1

				if not arg_1_1.var_.effectfengsha1 then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_4_9.name = "fengsha1"
					arg_1_1.var_.effectfengsha1 = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9001)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_town_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			if 1.16666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.16666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_144", "se_story_144_crack", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_19 = arg_1_1.var_.effecthuaijiudianying1

				if not arg_1_1.var_.effecthuaijiudianying1 then
					var_4_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xuehuaping"), manager.ui.mainCamera.transform)
					var_4_19.name = "huaijiudianying1"
					arg_1_1.var_.effecthuaijiudianying1 = var_4_19
				else
					var_4_19.transform:SetParent(var_4_9000)
				end

				var_4_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_21 = 0

			arg_1_1.isInRecall_ = true

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_1_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_1_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_4_22 = 0.1

			if var_4_21 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_21) / var_4_22)
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.675

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_3")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_1_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_4_26 = arg_1_1:GetWordFromCfg(423011001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 27 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 27)

				if (27 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 27)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011001", "story_v_out_423011.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_423011", "423011001", "story_v_out_423011.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_423011", "423011001", "story_v_out_423011.awb")

						arg_1_1:RecordAudio("423011001", var_4_31)
						arg_1_1:RecordAudio("423011001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423011", "423011001", "story_v_out_423011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423011", "423011001", "story_v_out_423011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play423011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423011002
		arg_9_1.duration_ = 6

		local var_9_0 = {
			zh = 4,
			ja = 6
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_9_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_12_1 = arg_9_1:GetWordFromCfg(423011002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 17)

				if (17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 17)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011002", "story_v_out_423011.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011002", "story_v_out_423011.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_423011", "423011002", "story_v_out_423011.awb")

						arg_9_1:RecordAudio("423011002", var_12_6)
						arg_9_1:RecordAudio("423011002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423011", "423011002", "story_v_out_423011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423011", "423011002", "story_v_out_423011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_16_0 = 0.6

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				local var_16_1, var_16_2 = math.modf((arg_13_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_16_2 * 0.13, var_16_2 * 0.13, var_16_2 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				manager.ui.mainCamera.transform.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_3 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_3 + 0.6 and arg_13_1.time_ < var_16_3 + 0.6 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_13_1.time_ and arg_13_1.time_ <= 0.166666666666667 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_144", "se_story_144_doorhit", "")
			end

			local var_16_5 = 0
			local var_16_6 = 1.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_7 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_7:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(423011003).content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 57 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 57)

				if (57 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 57)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10
					var_16_5 = var_16_5 + 0.3

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = var_16_5 + 0.3
			local var_16_12 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_12 and arg_13_1.time_ < var_16_11 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 423011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play423011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			local var_22_1 = 0
			local var_22_2 = 1.25

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

				local var_22_3 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(423011004).content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 50 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 50)

				if (50 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 50)) > 0 and var_22_2 < var_22_5 then
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
	Play423011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 423011005
		arg_23_1.duration_ = 3.7

		local var_23_0 = {
			zh = 3,
			ja = 3.7
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
				arg_23_0:Play423011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1083"] == nil then
				local var_26_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_26_0) then
					local var_26_1 = Object.Instantiate(var_26_0, arg_23_1.canvasGo_.transform)

					var_26_1.transform:SetSiblingIndex(1)

					var_26_1.name = "1083"
					var_26_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_23_1.actors_["1083"] = var_26_1

					if arg_23_1.isInRecall_ then
						for iter_26_0, iter_26_1 in ipairs((var_26_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_26_1.color = arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_26_2 = arg_23_1.actors_["1083"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps1083 == nil then
				arg_23_1.var_.actorSpriteComps1083 = var_26_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_3 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 and not isNil(var_26_2) then
				if arg_23_1.var_.actorSpriteComps1083 then
					for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_26_3 then
							if arg_23_1.isInRecall_ then
								iter_26_3.color = Color.New(Mathf.Lerp(iter_26_3.color.r, arg_23_1.hightColor1.r, (arg_23_1.time_ - 0) / var_26_3), Mathf.Lerp(iter_26_3.color.g, arg_23_1.hightColor1.g, (arg_23_1.time_ - 0) / var_26_3), (Mathf.Lerp(iter_26_3.color.b, arg_23_1.hightColor1.b, (arg_23_1.time_ - 0) / var_26_3)))
							else
								local var_26_4 = Mathf.Lerp(iter_26_3.color.r, 1, (arg_23_1.time_ - 0) / var_26_3)

								iter_26_3.color = Color.New(var_26_4, var_26_4, var_26_4)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps1083 then
				for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_26_5 then
						iter_26_5.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps1083 = nil
			end

			local var_26_5 = arg_23_1.actors_["1083"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1083 = var_26_5.localPosition
				var_26_5.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1083", 3)

				for iter_26_6 = 0, var_26_5.childCount - 1 do
					local var_26_6 = var_26_5:GetChild(iter_26_6)

					if var_26_6.name == "" or not string.find(var_26_6.name, "split") then
						var_26_6.gameObject:SetActive(true)
					else
						var_26_6.gameObject:SetActive(false)
					end
				end
			end

			local var_26_7 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_23_1.time_ - 0) / var_26_7)
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_8 = arg_23_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_8 then
					arg_23_1.var_.alphaOldValue1083 = var_26_8.alpha
					arg_23_1.var_.characterEffect1083 = var_26_8
				end

				arg_23_1.var_.alphaOldValue1083 = 0
			end

			local var_26_9 = 0.5

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_9 then
				if arg_23_1.var_.characterEffect1083 then
					arg_23_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_23_1.var_.alphaOldValue1083, 1, (arg_23_1.time_ - 0) / var_26_9)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_9 and arg_23_1.time_ < 0 + var_26_9 + arg_26_0 and arg_23_1.var_.characterEffect1083 then
				arg_23_1.var_.characterEffect1083.alpha = 1
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep_cowboy", "")
			end

			local var_26_11 = 0
			local var_26_12 = 0.2

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1325].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_13 = arg_23_1:GetWordFromCfg(423011005)
				local var_26_14 = arg_23_1:FormatText(var_26_13.content)

				arg_23_1.text_.text = var_26_14

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 8 <= 0 and var_26_12 or var_26_12 * (utf8.len(var_26_14) / 8)

				if (8 <= 0 and var_26_12 or var_26_12 * (utf8.len(var_26_14) / 8)) > 0 and var_26_12 < var_26_16 then
					arg_23_1.talkMaxDuration = var_26_16

					if var_26_16 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_16 + var_26_11
					end
				end

				arg_23_1.text_.text = var_26_14
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011005", "story_v_out_423011.awb") ~= 0 then
					local var_26_17 = manager.audio:GetVoiceLength("story_v_out_423011", "423011005", "story_v_out_423011.awb") / 1000

					if var_26_17 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_17 + var_26_11
					end

					if var_26_13.prefab_name ~= "" and arg_23_1.actors_[var_26_13.prefab_name] ~= nil then
						local var_26_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_13.prefab_name].transform, "story_v_out_423011", "423011005", "story_v_out_423011.awb")

						arg_23_1:RecordAudio("423011005", var_26_18)
						arg_23_1:RecordAudio("423011005", var_26_18)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_423011", "423011005", "story_v_out_423011.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_423011", "423011005", "story_v_out_423011.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_19 = math.max(var_26_12, arg_23_1.talkMaxDuration)

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_19 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_11) / var_26_19

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_11 + var_26_19 and arg_23_1.time_ < var_26_11 + var_26_19 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play423011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 423011006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play423011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1083"]) and arg_27_1.var_.actorSpriteComps1083 == nil then
				arg_27_1.var_.actorSpriteComps1083 = arg_27_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1083"]) then
				if arg_27_1.var_.actorSpriteComps1083 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1083"]) and arg_27_1.var_.actorSpriteComps1083 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps1083 = nil
			end

			local var_30_2 = arg_27_1.actors_["1083"].transform

			if 0.6 < arg_27_1.time_ and arg_27_1.time_ <= 0.6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1083 = var_30_2.localPosition
				var_30_2.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1083", 7)

				for iter_30_4 = 0, var_30_2.childCount - 1 do
					local var_30_3 = var_30_2:GetChild(iter_30_4)

					if var_30_3.name == "" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if 0.6 <= arg_27_1.time_ and arg_27_1.time_ < 0.6 + var_30_4 then
				var_30_2.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_27_1.time_ - 0.6) / var_30_4)
			end

			if arg_27_1.time_ >= 0.6 + var_30_4 and arg_27_1.time_ < 0.6 + var_30_4 + arg_30_0 then
				var_30_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_5 = arg_27_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_5 then
					arg_27_1.var_.alphaOldValue1083 = var_30_5.alpha
					arg_27_1.var_.characterEffect1083 = var_30_5
				end

				arg_27_1.var_.alphaOldValue1083 = 1
			end

			local var_30_6 = 0.5

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 then
				if arg_27_1.var_.characterEffect1083 then
					arg_27_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_27_1.var_.alphaOldValue1083, 0, (arg_27_1.time_ - 0) / var_30_6)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and arg_27_1.var_.characterEffect1083 then
				arg_27_1.var_.characterEffect1083.alpha = 0
			end

			if 0.634 < arg_27_1.time_ and arg_27_1.time_ <= 0.634 + arg_30_0 then
				local var_30_7 = arg_27_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_7 then
					arg_27_1.var_.alphaOldValue1083 = var_30_7.alpha
					arg_27_1.var_.characterEffect1083 = var_30_7
				end

				arg_27_1.var_.alphaOldValue1083 = 0
			end

			local var_30_8 = 0.0333333333333333

			if 0.634 <= arg_27_1.time_ and arg_27_1.time_ < 0.634 + var_30_8 then
				if arg_27_1.var_.characterEffect1083 then
					arg_27_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_27_1.var_.alphaOldValue1083, 1, (arg_27_1.time_ - 0.634) / var_30_8)
				end
			end

			if arg_27_1.time_ >= 0.634 + var_30_8 and arg_27_1.time_ < 0.634 + var_30_8 + arg_30_0 and arg_27_1.var_.characterEffect1083 then
				arg_27_1.var_.characterEffect1083.alpha = 1
			end

			local var_30_9 = 0
			local var_30_10 = 1.2

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_11 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(423011006).content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 48 <= 0 and var_30_10 or var_30_10 * (utf8.len(var_30_11) / 48)

				if (48 <= 0 and var_30_10 or var_30_10 * (utf8.len(var_30_11) / 48)) > 0 and var_30_10 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_9 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_9
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_10, arg_27_1.talkMaxDuration)

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_9) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_9 + var_30_14 and arg_27_1.time_ < var_30_9 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play423011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 423011007
		arg_31_1.duration_ = 3.47

		local var_31_0 = {
			zh = 2.266,
			ja = 3.466
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play423011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["10148"] == nil then
				local var_34_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_34_0) then
					local var_34_1 = Object.Instantiate(var_34_0, arg_31_1.canvasGo_.transform)

					var_34_1.transform:SetSiblingIndex(1)

					var_34_1.name = "10148"
					var_34_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_31_1.actors_["10148"] = var_34_1

					if arg_31_1.isInRecall_ then
						for iter_34_0, iter_34_1 in ipairs((var_34_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_34_1.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_34_2 = arg_31_1.actors_["10148"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps10148 == nil then
				arg_31_1.var_.actorSpriteComps10148 = var_34_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_3 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.actorSpriteComps10148 then
					for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_34_3 then
							if arg_31_1.isInRecall_ then
								iter_34_3.color = Color.New(Mathf.Lerp(iter_34_3.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_3), Mathf.Lerp(iter_34_3.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_3), (Mathf.Lerp(iter_34_3.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_3)))
							else
								local var_34_4 = Mathf.Lerp(iter_34_3.color.r, 1, (arg_31_1.time_ - 0) / var_34_3)

								iter_34_3.color = Color.New(var_34_4, var_34_4, var_34_4)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps10148 then
				for iter_34_4, iter_34_5 in pairs(arg_31_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_34_5 then
						iter_34_5.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps10148 = nil
			end

			local var_34_5 = arg_31_1.actors_["10148"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10148 = var_34_5.localPosition
				var_34_5.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10148", 3)

				for iter_34_6 = 0, var_34_5.childCount - 1 do
					local var_34_6 = var_34_5:GetChild(iter_34_6)

					if var_34_6.name == "split_6" or not string.find(var_34_6.name, "split") then
						var_34_6.gameObject:SetActive(true)
					else
						var_34_6.gameObject:SetActive(false)
					end
				end
			end

			local var_34_7 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				var_34_5.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_31_1.time_ - 0) / var_34_7)
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				var_34_5.localPosition = Vector3.New(0, -350, -270)
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_8 = arg_31_1.actors_["10148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_34_8 then
					arg_31_1.var_.alphaOldValue10148 = var_34_8.alpha
					arg_31_1.var_.characterEffect10148 = var_34_8
				end

				arg_31_1.var_.alphaOldValue10148 = 0
			end

			local var_34_9 = 0.5

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_9 then
				if arg_31_1.var_.characterEffect10148 then
					arg_31_1.var_.characterEffect10148.alpha = Mathf.Lerp(arg_31_1.var_.alphaOldValue10148, 1, (arg_31_1.time_ - 0) / var_34_9)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_9 and arg_31_1.time_ < 0 + var_34_9 + arg_34_0 and arg_31_1.var_.characterEffect10148 then
				arg_31_1.var_.characterEffect10148.alpha = 1
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_10 = 0.5
			local var_34_11 = 0.2

			if 0.5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_12 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_12:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1326].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_13 = arg_31_1:GetWordFromCfg(423011007)
				local var_34_14 = arg_31_1:FormatText(var_34_13.content)

				arg_31_1.text_.text = var_34_14

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 8 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_14) / 8)

				if (8 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_14) / 8)) > 0 and var_34_11 < var_34_16 then
					arg_31_1.talkMaxDuration = var_34_16
					var_34_10 = var_34_10 + 0.3

					if var_34_16 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_14
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011007", "story_v_out_423011.awb") ~= 0 then
					local var_34_17 = manager.audio:GetVoiceLength("story_v_out_423011", "423011007", "story_v_out_423011.awb") / 1000

					if var_34_17 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_17 + var_34_10
					end

					if var_34_13.prefab_name ~= "" and arg_31_1.actors_[var_34_13.prefab_name] ~= nil then
						local var_34_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_13.prefab_name].transform, "story_v_out_423011", "423011007", "story_v_out_423011.awb")

						arg_31_1:RecordAudio("423011007", var_34_18)
						arg_31_1:RecordAudio("423011007", var_34_18)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_423011", "423011007", "story_v_out_423011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_423011", "423011007", "story_v_out_423011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_19 = var_34_10 + 0.3
			local var_34_20 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_10 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_19 + var_34_20 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_19) / var_34_20

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_19 + var_34_20 and arg_31_1.time_ < var_34_19 + var_34_20 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play423011008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423011008
		arg_37_1.duration_ = 3.63

		local var_37_0 = {
			zh = 3.266,
			ja = 3.633
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423011009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.35

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1326].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(423011008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 14 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 14)

				if (14 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 14)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011008", "story_v_out_423011.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011008", "story_v_out_423011.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_423011", "423011008", "story_v_out_423011.awb")

						arg_37_1:RecordAudio("423011008", var_40_6)
						arg_37_1:RecordAudio("423011008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423011", "423011008", "story_v_out_423011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423011", "423011008", "story_v_out_423011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423011009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423011009
		arg_41_1.duration_ = 8.63

		local var_41_0 = {
			zh = 8.633,
			ja = 7.266
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play423011010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1083"]) and arg_41_1.var_.actorSpriteComps1083 == nil then
				arg_41_1.var_.actorSpriteComps1083 = arg_41_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1083"]) then
				if arg_41_1.var_.actorSpriteComps1083 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 1, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1083"]) and arg_41_1.var_.actorSpriteComps1083 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1083 = nil
			end

			local var_44_2 = arg_41_1.actors_["10148"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10148 == nil then
				arg_41_1.var_.actorSpriteComps10148 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10148 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10148 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10148 = nil
			end

			local var_44_5 = arg_41_1.actors_["1083"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 4)

				for iter_44_8 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_8)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_44_8 = arg_41_1.actors_["10148"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10148 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10148", 2)

				for iter_44_9 = 0, var_44_8.childCount - 1 do
					local var_44_9 = var_44_8:GetChild(iter_44_9)

					if var_44_9.name == "split_6" or not string.find(var_44_9.name, "split") then
						var_44_9.gameObject:SetActive(true)
					else
						var_44_9.gameObject:SetActive(false)
					end
				end
			end

			local var_44_10 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_41_1.time_ - 0) / var_44_10)
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_44_11 = 0
			local var_44_12 = 0.775

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1325].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(423011009)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 31 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 31)

				if (31 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 31)) > 0 and var_44_12 < var_44_16 then
					arg_41_1.talkMaxDuration = var_44_16

					if var_44_16 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011009", "story_v_out_423011.awb") ~= 0 then
					local var_44_17 = manager.audio:GetVoiceLength("story_v_out_423011", "423011009", "story_v_out_423011.awb") / 1000

					if var_44_17 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_11
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_423011", "423011009", "story_v_out_423011.awb")

						arg_41_1:RecordAudio("423011009", var_44_18)
						arg_41_1:RecordAudio("423011009", var_44_18)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423011", "423011009", "story_v_out_423011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423011", "423011009", "story_v_out_423011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_19 and arg_41_1.time_ < var_44_11 + var_44_19 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play423011010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423011010
		arg_45_1.duration_ = 6.23

		local var_45_0 = {
			zh = 5.166,
			ja = 6.233
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play423011011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1325].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(423011010)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 21)

				if (21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 21)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011010", "story_v_out_423011.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011010", "story_v_out_423011.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_423011", "423011010", "story_v_out_423011.awb")

						arg_45_1:RecordAudio("423011010", var_48_6)
						arg_45_1:RecordAudio("423011010", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423011", "423011010", "story_v_out_423011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423011", "423011010", "story_v_out_423011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play423011011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423011011
		arg_49_1.duration_ = 5.2

		local var_49_0 = {
			zh = 3.366,
			ja = 5.2
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play423011012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10148"]) and arg_49_1.var_.actorSpriteComps10148 == nil then
				arg_49_1.var_.actorSpriteComps10148 = arg_49_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10148"]) then
				if arg_49_1.var_.actorSpriteComps10148 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10148"]) and arg_49_1.var_.actorSpriteComps10148 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10148 = nil
			end

			local var_52_2 = arg_49_1.actors_["1083"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1083 == nil then
				arg_49_1.var_.actorSpriteComps1083 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1083 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								iter_52_5.color = Color.New(Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_5.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_5.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1083 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_52_7 then
						iter_52_7.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1083 = nil
			end

			local var_52_5 = arg_49_1.actors_["10148"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10148 = var_52_5.localPosition
				var_52_5.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10148", 2)

				for iter_52_8 = 0, var_52_5.childCount - 1 do
					local var_52_6 = var_52_5:GetChild(iter_52_8)

					if var_52_6.name == "split_1" or not string.find(var_52_6.name, "split") then
						var_52_6.gameObject:SetActive(true)
					else
						var_52_6.gameObject:SetActive(false)
					end
				end
			end

			local var_52_7 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_49_1.time_ - 0) / var_52_7)
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_52_8 = 0
			local var_52_9 = 0.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1326].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(423011011)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 11 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 11)

				if (11 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 11)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011011", "story_v_out_423011.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_423011", "423011011", "story_v_out_423011.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_423011", "423011011", "story_v_out_423011.awb")

						arg_49_1:RecordAudio("423011011", var_52_15)
						arg_49_1:RecordAudio("423011011", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423011", "423011011", "story_v_out_423011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423011", "423011011", "story_v_out_423011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play423011012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423011012
		arg_53_1.duration_ = 5.7

		local var_53_0 = {
			zh = 5.7,
			ja = 4.133
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play423011013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1326].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(423011012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 25)

				if (25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 25)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011012", "story_v_out_423011.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011012", "story_v_out_423011.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_423011", "423011012", "story_v_out_423011.awb")

						arg_53_1:RecordAudio("423011012", var_56_6)
						arg_53_1:RecordAudio("423011012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423011", "423011012", "story_v_out_423011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423011", "423011012", "story_v_out_423011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play423011013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423011013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play423011014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10148"]) and arg_57_1.var_.actorSpriteComps10148 == nil then
				arg_57_1.var_.actorSpriteComps10148 = arg_57_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10148"]) then
				if arg_57_1.var_.actorSpriteComps10148 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10148"]) and arg_57_1.var_.actorSpriteComps10148 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10148 = nil
			end

			local var_60_2 = arg_57_1.actors_["10148"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10148 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10148", 7)

				for iter_60_4 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_4)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_5 = arg_57_1.actors_["1083"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1083 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1083", 7)

				for iter_60_5 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_5)

					if var_60_6.name == "" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.533333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.533333333333333 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_144", "se_story_144_foley_gun03", "")
			end

			local var_60_9 = 0
			local var_60_10 = 1.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(423011013).content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 54 <= 0 and var_60_10 or var_60_10 * (utf8.len(var_60_11) / 54)

				if (54 <= 0 and var_60_10 or var_60_10 * (utf8.len(var_60_11) / 54)) > 0 and var_60_10 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_9
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_10, arg_57_1.talkMaxDuration)

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_14 and arg_57_1.time_ < var_60_9 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play423011014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423011014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play423011015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(423011014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 57 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 57)

				if (57 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 57)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play423011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423011015
		arg_65_1.duration_ = 3.73

		local var_65_0 = {
			zh = 3.733,
			ja = 3.7
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play423011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1083"]) and arg_65_1.var_.actorSpriteComps1083 == nil then
				arg_65_1.var_.actorSpriteComps1083 = arg_65_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1083"]) then
				if arg_65_1.var_.actorSpriteComps1083 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1083"]) and arg_65_1.var_.actorSpriteComps1083 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1083 = nil
			end

			local var_68_2 = arg_65_1.actors_["1083"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1083 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1083", 3)

				for iter_68_4 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_4)

					if var_68_3.name == "split_7" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0.034 < arg_65_1.time_ and arg_65_1.time_ <= 0.034 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_144", "se_story_144_bell01", "")
			end

			local var_68_6 = 0
			local var_68_7 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1325].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(423011015)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 14 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 14)

				if (14 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 14)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011015", "story_v_out_423011.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_423011", "423011015", "story_v_out_423011.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_423011", "423011015", "story_v_out_423011.awb")

						arg_65_1:RecordAudio("423011015", var_68_13)
						arg_65_1:RecordAudio("423011015", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_423011", "423011015", "story_v_out_423011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_423011", "423011015", "story_v_out_423011.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play423011016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423011016
		arg_69_1.duration_ = 7

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play423011017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_9003
			local var_72_9002
			local var_72_9001
			local var_72_9000

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1083"]) and arg_69_1.var_.actorSpriteComps1083 == nil then
				arg_69_1.var_.actorSpriteComps1083 = arg_69_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1083"]) then
				if arg_69_1.var_.actorSpriteComps1083 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1083"]) and arg_69_1.var_.actorSpriteComps1083 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1083 = nil
			end

			local var_72_2 = arg_69_1.actors_["1083"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1083 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1083", 7)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_5 = arg_69_1.var_.effectjilieqiangsheng1

				if not arg_69_1.var_.effectjilieqiangsheng1 then
					var_72_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_72_5.name = "jilieqiangsheng1"
					arg_69_1.var_.effectjilieqiangsheng1 = var_72_5
				else
					var_72_5.transform:SetParent(var_72_9003)
				end

				var_72_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_72_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_69_1.time_ and arg_69_1.time_ <= 2.5 + arg_72_0 then
				if arg_69_1.var_.effectjilieqiangsheng1 then
					Object.Destroy(arg_69_1.var_.effectjilieqiangsheng1)

					arg_69_1.var_.effectjilieqiangsheng1 = nil
				end
			end

			if 0.3 < arg_69_1.time_ and arg_69_1.time_ <= 0.3 + arg_72_0 then
				local var_72_8 = arg_69_1.var_.effectjilieqiangsheng2

				if not arg_69_1.var_.effectjilieqiangsheng2 then
					var_72_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_72_8.name = "jilieqiangsheng2"
					arg_69_1.var_.effectjilieqiangsheng2 = var_72_8
				else
					var_72_8.transform:SetParent(var_72_9002)
				end

				var_72_8.transform.localPosition = Vector3.New(2.32, 0, 0)
				var_72_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_69_1.time_ and arg_69_1.time_ <= 2.5 + arg_72_0 then
				if arg_69_1.var_.effectjilieqiangsheng2 then
					Object.Destroy(arg_69_1.var_.effectjilieqiangsheng2)

					arg_69_1.var_.effectjilieqiangsheng2 = nil
				end
			end

			if 0.6 < arg_69_1.time_ and arg_69_1.time_ <= 0.6 + arg_72_0 then
				local var_72_11 = arg_69_1.var_.effectjilieqiangsheng3

				if not arg_69_1.var_.effectjilieqiangsheng3 then
					var_72_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_72_11.name = "jilieqiangsheng3"
					arg_69_1.var_.effectjilieqiangsheng3 = var_72_11
				else
					var_72_11.transform:SetParent(var_72_9001)
				end

				var_72_11.transform.localPosition = Vector3.New(0.75, -1.71, 0)
				var_72_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_69_1.time_ and arg_69_1.time_ <= 2.5 + arg_72_0 then
				if arg_69_1.var_.effectjilieqiangsheng3 then
					Object.Destroy(arg_69_1.var_.effectjilieqiangsheng3)

					arg_69_1.var_.effectjilieqiangsheng3 = nil
				end
			end

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= 1 + arg_72_0 then
				local var_72_14 = arg_69_1.var_.effectjilieqiangsheng4

				if not arg_69_1.var_.effectjilieqiangsheng4 then
					var_72_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_72_14.name = "jilieqiangsheng4"
					arg_69_1.var_.effectjilieqiangsheng4 = var_72_14
				else
					var_72_14.transform:SetParent(var_72_9000)
				end

				var_72_14.transform.localPosition = Vector3.New(-1.47, -0.85, 0)
				var_72_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_69_1.time_ and arg_69_1.time_ <= 2.5 + arg_72_0 then
				if arg_69_1.var_.effectjilieqiangsheng4 then
					Object.Destroy(arg_69_1.var_.effectjilieqiangsheng4)

					arg_69_1.var_.effectjilieqiangsheng4 = nil
				end
			end

			local var_72_17 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_17 + 2 and arg_69_1.time_ < var_72_17 + 2 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			if 0.034 < arg_69_1.time_ and arg_69_1.time_ <= 0.034 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle02", "")
			end

			local var_72_19 = manager.ui.mainCamera.transform

			if 0.034 < arg_69_1.time_ and arg_69_1.time_ <= 0.034 + arg_72_0 then
				arg_69_1.var_.shakeOldPos = var_72_19.localPosition
			end

			local var_72_20 = 1

			if 0.034 <= arg_69_1.time_ and arg_69_1.time_ < 0.034 + var_72_20 then
				local var_72_21, var_72_22 = math.modf((arg_69_1.time_ - 0.034) / 0.066)

				var_72_19.localPosition = Vector3.New(var_72_22 * 0.13, var_72_22 * 0.13, var_72_22 * 0.13) + arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.time_ >= 0.034 + var_72_20 and arg_69_1.time_ < 0.034 + var_72_20 + arg_72_0 then
				var_72_19.localPosition = arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_23 = 2
			local var_72_24 = 1.625

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_25 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_25:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(423011016).content)

				arg_69_1.text_.text = var_72_26

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 65 <= 0 and var_72_24 or var_72_24 * (utf8.len(var_72_26) / 65)

				if (65 <= 0 and var_72_24 or var_72_24 * (utf8.len(var_72_26) / 65)) > 0 and var_72_24 < var_72_28 then
					arg_69_1.talkMaxDuration = var_72_28
					var_72_23 = var_72_23 + 0.3

					if var_72_28 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_26
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_29 = var_72_23 + 0.3
			local var_72_30 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_29 + var_72_30 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_29) / var_72_30

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_29 + var_72_30 and arg_69_1.time_ < var_72_29 + var_72_30 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play423011017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423011017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play423011018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0.1 < arg_75_1.time_ and arg_75_1.time_ <= 0.1 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep_cowboy", "")
			end

			local var_78_1 = 0
			local var_78_2 = 1.95

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(423011017).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 86 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 86)

				if (86 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 86)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play423011018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423011018
		arg_79_1.duration_ = 8.8

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play423011019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.bgs_.ST0111 == nil then
				local var_82_0 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0111")
				var_82_0.name = "ST0111"
				var_82_0.transform.parent = arg_79_1.stage_.transform
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_.ST0111 = var_82_0
			end

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= 2 + arg_82_0 then
				local var_82_1 = arg_79_1.bgs_.ST0111

				arg_79_1.bgs_.ST0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_2 = var_82_1:GetComponent("SpriteRenderer")

				if var_82_2 and var_82_2.sprite then
					local var_82_3 = 2 * (var_82_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_1.transform.localScale = Vector3.New(var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "ST0111" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_4 = 3.8

			if 3.8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_4 + 0.3 and arg_79_1.time_ < var_82_4 + 0.3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_5 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_6 = 2

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 then
				local var_82_7 = Color.New(0, 0, 0)

				var_82_7.a = Mathf.Lerp(0, 1, (arg_79_1.time_ - var_82_5) / var_82_6)
				arg_79_1.mask_.color = var_82_7
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 then
				local var_82_8 = Color.New(0, 0, 0)

				var_82_8.a = 1
				arg_79_1.mask_.color = var_82_8
			end

			local var_82_9 = 2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_10 = 2

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 then
				local var_82_11 = Color.New(0, 0, 0)

				var_82_11.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_9) / var_82_10)
				arg_79_1.mask_.color = var_82_11
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 then
				local var_82_12 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_12.a = 0
				arg_79_1.mask_.color = var_82_12
			end

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= 2 + arg_82_0 then
				if arg_79_1.var_.effectfengsha1 then
					Object.Destroy(arg_79_1.var_.effectfengsha1)

					arg_79_1.var_.effectfengsha1 = nil
				end
			end

			if 0.133333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 0.133333333333333 + arg_82_0 then
				arg_79_1:AudioAction("stop", "effect", "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			if 0.133333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 0.133333333333333 + arg_82_0 then
				arg_79_1:AudioAction("stop", "effect", "se_story_144", "se_story_144_amb_town_loop", "")
			end

			if 1.6 < arg_79_1.time_ and arg_79_1.time_ <= 1.6 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_train", "")
			end

			local var_82_17 = 2

			arg_79_1.isInRecall_ = false

			if var_82_17 < arg_79_1.time_ and arg_79_1.time_ <= var_82_17 + arg_82_0 then
				arg_79_1.screenFilterGo_:SetActive(false)

				for iter_82_2, iter_82_3 in pairs(arg_79_1.actors_) do
					for iter_82_4, iter_82_5 in ipairs((iter_82_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_82_5.color = iter_82_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_82_18 = 0.1

			if var_82_17 <= arg_79_1.time_ and arg_79_1.time_ < var_82_17 + var_82_18 then
				arg_79_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_17) / var_82_18)
			end

			if arg_79_1.time_ >= var_82_17 + var_82_18 and arg_79_1.time_ < var_82_17 + var_82_18 + arg_82_0 then
				arg_79_1.screenFilterEffect_.weight = 0
			end

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= 2 + arg_82_0 then
				if arg_79_1.var_.effecthuaijiudianying1 then
					Object.Destroy(arg_79_1.var_.effecthuaijiudianying1)

					arg_79_1.var_.effecthuaijiudianying1 = nil
				end
			end

			if 1.6 < arg_79_1.time_ and arg_79_1.time_ <= 1.6 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_144", "se_story_144_bgm_street_down", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_21 = 3.8
			local var_82_22 = 1.675

			if 3.8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_23 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_23:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(423011018).content)

				arg_79_1.text_.text = var_82_24

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 67 <= 0 and var_82_22 or var_82_22 * (utf8.len(var_82_24) / 67)

				if (67 <= 0 and var_82_22 or var_82_22 * (utf8.len(var_82_24) / 67)) > 0 and var_82_22 < var_82_26 then
					arg_79_1.talkMaxDuration = var_82_26
					var_82_21 = var_82_21 + 0.3

					if var_82_26 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_26 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_24
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_27 = var_82_21 + 0.3
			local var_82_28 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_27 + var_82_28 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_27) / var_82_28

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_27 + var_82_28 and arg_79_1.time_ < var_82_27 + var_82_28 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play423011019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423011019
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423011020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.575

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

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(423011019).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 23 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 23)

				if (23 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 23)) > 0 and var_88_0 < var_88_3 then
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
	Play423011020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423011020
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play423011021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.7

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

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(423011020).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 28 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 28)

				if (28 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 28)) > 0 and var_92_0 < var_92_3 then
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
	Play423011021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423011021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play423011022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.825

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(423011021).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 33 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 33)

				if (33 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 33)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423011022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423011022
		arg_97_1.duration_ = 7.73

		local var_97_0 = {
			zh = 5.9,
			ja = 7.733
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
				arg_97_0:Play423011023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.7

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[224].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(423011022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 28 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 28)

				if (28 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 28)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011022", "story_v_out_423011.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011022", "story_v_out_423011.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_423011", "423011022", "story_v_out_423011.awb")

						arg_97_1:RecordAudio("423011022", var_100_6)
						arg_97_1:RecordAudio("423011022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_423011", "423011022", "story_v_out_423011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_423011", "423011022", "story_v_out_423011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play423011023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423011023
		arg_101_1.duration_ = 7.03

		local var_101_0 = {
			zh = 4.833,
			ja = 7.033
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
				arg_101_0:Play423011024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(423011023)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 49 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 49)

				if (49 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 49)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011023", "story_v_out_423011.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011023", "story_v_out_423011.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_423011", "423011023", "story_v_out_423011.awb")

						arg_101_1:RecordAudio("423011023", var_104_6)
						arg_101_1:RecordAudio("423011023", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423011", "423011023", "story_v_out_423011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423011", "423011023", "story_v_out_423011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play423011024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423011024
		arg_105_1.duration_ = 9.9

		local var_105_0 = {
			zh = 7.8,
			ja = 9.9
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
				arg_105_0:Play423011025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.275

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(423011024)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 51 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 51)

				if (51 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 51)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011024", "story_v_out_423011.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011024", "story_v_out_423011.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_423011", "423011024", "story_v_out_423011.awb")

						arg_105_1:RecordAudio("423011024", var_108_6)
						arg_105_1:RecordAudio("423011024", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423011", "423011024", "story_v_out_423011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423011", "423011024", "story_v_out_423011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play423011025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423011025
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play423011026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.325

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(423011025).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 13 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 13)

				if (13 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 13)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play423011026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423011026
		arg_113_1.duration_ = 7.5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play423011027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_9001
			local var_116_9000

			if arg_113_1.bgs_.ST0113 == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0113")
				var_116_0.name = "ST0113"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.ST0113 = var_116_0
			end

			if 1 < arg_113_1.time_ and arg_113_1.time_ <= 1 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.ST0113

				arg_113_1.bgs_.ST0113.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST0113" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_5 = 1

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_5 then
				local var_116_6 = Color.New(0, 0, 0)

				var_116_6.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_4) / var_116_5)
				arg_113_1.mask_.color = var_116_6
			end

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = 1
				arg_113_1.mask_.color = var_116_7
			end

			local var_116_8 = 1

			if 1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_9 = 1

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 then
				local var_116_10 = Color.New(0, 0, 0)

				var_116_10.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_8) / var_116_9)
				arg_113_1.mask_.color = var_116_10
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 then
				local var_116_11 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_11.a = 0
				arg_113_1.mask_.color = var_116_11
			end

			if 1 < arg_113_1.time_ and arg_113_1.time_ <= 1 + arg_116_0 then
				local var_116_12 = arg_113_1.var_.effectchechuangwai2

				if not arg_113_1.var_.effectchechuangwai2 then
					var_116_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_116_12.name = "chechuangwai2"
					arg_113_1.var_.effectchechuangwai2 = var_116_12
				else
					var_116_12.transform:SetParent(var_116_9001)
				end

				var_116_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_12.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_116_14 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_116_2, iter_116_3 in ipairs((var_116_12.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_116_3.transform.localScale = Vector3.New(iter_116_3.transform.localScale.x / var_116_14 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_116_3.transform.localScale.y / var_116_14, iter_116_3.transform.localScale.z)
				end
			end

			local var_116_16 = arg_113_1.bgs_.ST0113.transform

			if 1 < arg_113_1.time_ and arg_113_1.time_ <= 1 + arg_116_0 then
				arg_113_1.var_.moveOldPosST0113 = var_116_16.localPosition
			end

			local var_116_17 = 6.5

			if 1 <= arg_113_1.time_ and arg_113_1.time_ < 1 + var_116_17 then
				var_116_16.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPosST0113, Vector3.New(0, 1, 10), (arg_113_1.time_ - 1) / var_116_17)
			end

			if arg_113_1.time_ >= 1 + var_116_17 and arg_113_1.time_ < 1 + var_116_17 + arg_116_0 then
				var_116_16.localPosition = Vector3.New(0, 1, 10)
			end

			if 1 < arg_113_1.time_ and arg_113_1.time_ <= 1 + arg_116_0 then
				local var_116_18 = arg_113_1.var_.effectchechuangwai1

				if not arg_113_1.var_.effectchechuangwai1 then
					var_116_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_116_18.name = "chechuangwai1"
					arg_113_1.var_.effectchechuangwai1 = var_116_18
				else
					var_116_18.transform:SetParent(var_116_9000)
				end

				var_116_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_116_20 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_116_4, iter_116_5 in ipairs((var_116_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_116_5.transform.localScale = Vector3.New(iter_116_5.transform.localScale.x / var_116_20 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_116_5.transform.localScale.y / var_116_20, iter_116_5.transform.localScale.z)
				end
			end

			local var_116_22 = 2
			local var_116_23 = 1.325

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_24 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(423011026).content)

				arg_113_1.text_.text = var_116_24

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_26 = 53 <= 0 and var_116_23 or var_116_23 * (utf8.len(var_116_24) / 53)

				if (53 <= 0 and var_116_23 or var_116_23 * (utf8.len(var_116_24) / 53)) > 0 and var_116_23 < var_116_26 then
					arg_113_1.talkMaxDuration = var_116_26

					if var_116_26 + var_116_22 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_26 + var_116_22
					end
				end

				arg_113_1.text_.text = var_116_24
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_27 = math.max(var_116_23, arg_113_1.talkMaxDuration)

			if var_116_22 <= arg_113_1.time_ and arg_113_1.time_ < var_116_22 + var_116_27 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_22) / var_116_27

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_22 + var_116_27 and arg_113_1.time_ < var_116_22 + var_116_27 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0113",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 6.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInSine
				}
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play423011027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423011027
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play423011028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_120_1 = 0
			local var_120_2 = 0.625

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(423011027).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 25 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 25)

				if (25 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 25)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play423011028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423011028
		arg_121_1.duration_ = 7

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play423011029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 1 < arg_121_1.time_ and arg_121_1.time_ <= 1 + arg_124_0 then
				local var_124_0 = arg_121_1.bgs_.ST0111

				arg_121_1.bgs_.ST0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_1 = var_124_0:GetComponent("SpriteRenderer")

				if var_124_1 and var_124_1.sprite then
					local var_124_2 = 2 * (var_124_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_0.transform.localScale = Vector3.New(var_124_2 / var_124_1.sprite.bounds.size.y < var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x and var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x or var_124_2 / var_124_1.sprite.bounds.size.y, var_124_2 / var_124_1.sprite.bounds.size.y < var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x and var_124_2 * manager.ui.mainCameraCom_.aspect / var_124_1.sprite.bounds.size.x or var_124_2 / var_124_1.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST0111" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_3 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_4 = 1

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_4 then
				local var_124_5 = Color.New(0, 0, 0)

				var_124_5.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - var_124_3) / var_124_4)
				arg_121_1.mask_.color = var_124_5
			end

			if arg_121_1.time_ >= var_124_3 + var_124_4 and arg_121_1.time_ < var_124_3 + var_124_4 + arg_124_0 then
				local var_124_6 = Color.New(0, 0, 0)

				var_124_6.a = 1
				arg_121_1.mask_.color = var_124_6
			end

			local var_124_7 = 1

			if 1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_8 = 1

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 then
				local var_124_9 = Color.New(0, 0, 0)

				var_124_9.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_7) / var_124_8)
				arg_121_1.mask_.color = var_124_9
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 then
				local var_124_10 = Color.New(0, 0, 0)

				arg_121_1.mask_.enabled = false
				var_124_10.a = 0
				arg_121_1.mask_.color = var_124_10
			end

			if 1 < arg_121_1.time_ and arg_121_1.time_ <= 1 + arg_124_0 then
				if arg_121_1.var_.effectchechuangwai2 then
					Object.Destroy(arg_121_1.var_.effectchechuangwai2)

					arg_121_1.var_.effectchechuangwai2 = nil
				end
			end

			if 1 < arg_121_1.time_ and arg_121_1.time_ <= 1 + arg_124_0 then
				if arg_121_1.var_.effectchechuangwai1 then
					Object.Destroy(arg_121_1.var_.effectchechuangwai1)

					arg_121_1.var_.effectchechuangwai1 = nil
				end
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_13 = 2
			local var_124_14 = 0.325

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_15 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_15:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_16 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(423011028).content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_18 = 13 <= 0 and var_124_14 or var_124_14 * (utf8.len(var_124_16) / 13)

				if (13 <= 0 and var_124_14 or var_124_14 * (utf8.len(var_124_16) / 13)) > 0 and var_124_14 < var_124_18 then
					arg_121_1.talkMaxDuration = var_124_18
					var_124_13 = var_124_13 + 0.3

					if var_124_18 + var_124_13 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_13
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_19 = var_124_13 + 0.3
			local var_124_20 = math.max(var_124_14, arg_121_1.talkMaxDuration)

			if var_124_13 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_19 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_19) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_19 + var_124_20 and arg_121_1.time_ < var_124_19 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play423011029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423011029
		arg_127_1.duration_ = 9.3

		local var_127_0 = {
			zh = 5.5,
			ja = 9.3
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play423011030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["1047"] == nil then
				local var_130_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_130_0) then
					local var_130_1 = Object.Instantiate(var_130_0, arg_127_1.canvasGo_.transform)

					var_130_1.transform:SetSiblingIndex(1)

					var_130_1.name = "1047"
					var_130_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_127_1.actors_["1047"] = var_130_1

					if arg_127_1.isInRecall_ then
						for iter_130_0, iter_130_1 in ipairs((var_130_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_130_1.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_130_2 = arg_127_1.actors_["1047"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1047 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1047", 3)

				for iter_130_2 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_2)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:SetSpriteNiuquEffect("1047", true)
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				local var_130_6 = arg_127_1.actors_["1047"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_6 then
					arg_127_1.var_.alphaOldValue1047 = var_130_6.alpha
					arg_127_1.var_.characterEffect1047 = var_130_6
				end
			end

			local var_130_7 = 0.5

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				if arg_127_1.var_.characterEffect1047 then
					arg_127_1.var_.characterEffect1047.alpha = Mathf.Lerp(arg_127_1.var_.alphaOldValue1047, 0.6, (arg_127_1.time_ - 0) / var_130_7)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 and arg_127_1.var_.characterEffect1047 then
				arg_127_1.var_.characterEffect1047.alpha = 0.6
			end

			local var_130_8 = 0
			local var_130_9 = 0.825

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:GetWordFromCfg(423011029)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 33 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 33)

				if (33 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 33)) > 0 and var_130_9 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011029", "story_v_out_423011.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_423011", "423011029", "story_v_out_423011.awb") / 1000

					if var_130_14 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_8
					end

					if var_130_10.prefab_name ~= "" and arg_127_1.actors_[var_130_10.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_10.prefab_name].transform, "story_v_out_423011", "423011029", "story_v_out_423011.awb")

						arg_127_1:RecordAudio("423011029", var_130_15)
						arg_127_1:RecordAudio("423011029", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_423011", "423011029", "story_v_out_423011.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_423011", "423011029", "story_v_out_423011.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_16 and arg_127_1.time_ < var_130_8 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play423011030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 423011030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play423011031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.725

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(423011030).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 29 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 29)

				if (29 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 29)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play423011031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423011031
		arg_135_1.duration_ = 7.9

		local var_135_0 = {
			zh = 6.3,
			ja = 7.9
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
				arg_135_0:Play423011032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.675

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(423011031)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 27 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 27)

				if (27 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 27)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011031", "story_v_out_423011.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011031", "story_v_out_423011.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_423011", "423011031", "story_v_out_423011.awb")

						arg_135_1:RecordAudio("423011031", var_138_6)
						arg_135_1:RecordAudio("423011031", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_423011", "423011031", "story_v_out_423011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_423011", "423011031", "story_v_out_423011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play423011032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423011032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play423011033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.6

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(423011032).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 24 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 24)

				if (24 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 24)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play423011033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 423011033
		arg_143_1.duration_ = 4.33

		local var_143_0 = {
			zh = 3.933,
			ja = 4.333
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
				arg_143_0:Play423011034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(423011033)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 17 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 17)

				if (17 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 17)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011033", "story_v_out_423011.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011033", "story_v_out_423011.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_423011", "423011033", "story_v_out_423011.awb")

						arg_143_1:RecordAudio("423011033", var_146_6)
						arg_143_1:RecordAudio("423011033", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_423011", "423011033", "story_v_out_423011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_423011", "423011033", "story_v_out_423011.awb")
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
	Play423011034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 423011034
		arg_147_1.duration_ = 1

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"

			SetActive(arg_147_1.choicesGo_, true)

			for iter_148_0, iter_148_1 in ipairs(arg_147_1.choices_) do
				SetActive(iter_148_1.go, iter_148_0 <= 2)
			end

			arg_147_1.choices_[1].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1359].name)
			arg_147_1.choices_[2].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1360].name)
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play423011035(arg_147_1)
			end

			if arg_149_0 == 2 then
				arg_147_0:Play423011038(arg_147_1)
			end

			arg_147_1:RecordChoiceLog(423011034, 1359, 1360)
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= 0 + 0.5 and arg_147_1.time_ < 0 + 0.5 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play423011035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 423011035
		arg_151_1.duration_ = 5.97

		local var_151_0 = {
			zh = 5,
			ja = 5.966
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play423011036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.625

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(423011035)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 25 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 25)

				if (25 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 25)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011035", "story_v_out_423011.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011035", "story_v_out_423011.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_423011", "423011035", "story_v_out_423011.awb")

						arg_151_1:RecordAudio("423011035", var_154_6)
						arg_151_1:RecordAudio("423011035", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_423011", "423011035", "story_v_out_423011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_423011", "423011035", "story_v_out_423011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play423011036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 423011036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play423011037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(423011036).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 6 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 6)

				if (6 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 6)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play423011037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 423011037
		arg_159_1.duration_ = 3.6

		local var_159_0 = {
			zh = 2.533,
			ja = 3.6
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play423011041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(423011037)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 10 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 10)

				if (10 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 10)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011037", "story_v_out_423011.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011037", "story_v_out_423011.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_423011", "423011037", "story_v_out_423011.awb")

						arg_159_1:RecordAudio("423011037", var_162_6)
						arg_159_1:RecordAudio("423011037", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_423011", "423011037", "story_v_out_423011.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_423011", "423011037", "story_v_out_423011.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play423011041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423011041
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play423011042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.95

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(423011041).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 38 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 38)

				if (38 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 38)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play423011042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423011042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play423011043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.75

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(423011042).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 30 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 30)

				if (30 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 30)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play423011043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423011043
		arg_171_1.duration_ = 9.03

		local var_171_0 = {
			zh = 4.366,
			ja = 9.033
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play423011044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.475

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(423011043)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 19 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 19)

				if (19 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 19)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011043", "story_v_out_423011.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011043", "story_v_out_423011.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_423011", "423011043", "story_v_out_423011.awb")

						arg_171_1:RecordAudio("423011043", var_174_6)
						arg_171_1:RecordAudio("423011043", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_423011", "423011043", "story_v_out_423011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_423011", "423011043", "story_v_out_423011.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play423011044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423011044
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play423011045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(423011044).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 21)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play423011045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423011045
		arg_179_1.duration_ = 12.53

		local var_179_0 = {
			zh = 8.1,
			ja = 12.533
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play423011046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.9

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(423011045)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 36 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 36)

				if (36 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 36)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011045", "story_v_out_423011.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011045", "story_v_out_423011.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_423011", "423011045", "story_v_out_423011.awb")

						arg_179_1:RecordAudio("423011045", var_182_6)
						arg_179_1:RecordAudio("423011045", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_423011", "423011045", "story_v_out_423011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_423011", "423011045", "story_v_out_423011.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play423011046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423011046
		arg_183_1.duration_ = 10.9

		local var_183_0 = {
			zh = 6.833,
			ja = 10.9
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play423011047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.7

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(423011046)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 28 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 28)

				if (28 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 28)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011046", "story_v_out_423011.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011046", "story_v_out_423011.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_423011", "423011046", "story_v_out_423011.awb")

						arg_183_1:RecordAudio("423011046", var_186_6)
						arg_183_1:RecordAudio("423011046", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_423011", "423011046", "story_v_out_423011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_423011", "423011046", "story_v_out_423011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play423011047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423011047
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423011048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.5

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(423011047).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 20 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 20)

				if (20 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 20)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play423011048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423011048
		arg_191_1.duration_ = 12

		local var_191_0 = {
			zh = 5.966,
			ja = 12
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play423011049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.675

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(423011048)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 27 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 27)

				if (27 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 27)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011048", "story_v_out_423011.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011048", "story_v_out_423011.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_423011", "423011048", "story_v_out_423011.awb")

						arg_191_1:RecordAudio("423011048", var_194_6)
						arg_191_1:RecordAudio("423011048", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_423011", "423011048", "story_v_out_423011.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_423011", "423011048", "story_v_out_423011.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play423011049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423011049
		arg_195_1.duration_ = 9.2

		local var_195_0 = {
			zh = 5.5,
			ja = 9.2
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play423011050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.675

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(423011049)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 27 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 27)

				if (27 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 27)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011049", "story_v_out_423011.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011049", "story_v_out_423011.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_423011", "423011049", "story_v_out_423011.awb")

						arg_195_1:RecordAudio("423011049", var_198_6)
						arg_195_1:RecordAudio("423011049", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_423011", "423011049", "story_v_out_423011.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_423011", "423011049", "story_v_out_423011.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play423011050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 423011050
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play423011051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.55

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(423011050).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 22 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 22)

				if (22 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 22)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play423011051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 423011051
		arg_203_1.duration_ = 7.2

		local var_203_0 = {
			zh = 6,
			ja = 7.2
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play423011052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(423011051)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 26 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 26)

				if (26 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 26)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011051", "story_v_out_423011.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011051", "story_v_out_423011.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_423011", "423011051", "story_v_out_423011.awb")

						arg_203_1:RecordAudio("423011051", var_206_6)
						arg_203_1:RecordAudio("423011051", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_423011", "423011051", "story_v_out_423011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_423011", "423011051", "story_v_out_423011.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play423011052 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 423011052
		arg_207_1.duration_ = 9

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play423011053(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 2 < arg_207_1.time_ and arg_207_1.time_ <= 2 + arg_210_0 then
				local var_210_0 = arg_207_1.bgs_.ST0111

				arg_207_1.bgs_.ST0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_1 = var_210_0:GetComponent("SpriteRenderer")

				if var_210_1 and var_210_1.sprite then
					local var_210_2 = 2 * (var_210_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_0.transform.localScale = Vector3.New(var_210_2 / var_210_1.sprite.bounds.size.y < var_210_2 * manager.ui.mainCameraCom_.aspect / var_210_1.sprite.bounds.size.x and var_210_2 * manager.ui.mainCameraCom_.aspect / var_210_1.sprite.bounds.size.x or var_210_2 / var_210_1.sprite.bounds.size.y, var_210_2 / var_210_1.sprite.bounds.size.y < var_210_2 * manager.ui.mainCameraCom_.aspect / var_210_1.sprite.bounds.size.x and var_210_2 * manager.ui.mainCameraCom_.aspect / var_210_1.sprite.bounds.size.x or var_210_2 / var_210_1.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "ST0111" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_3 = 3.999999999999

			if 3.999999999999 < arg_207_1.time_ and arg_207_1.time_ <= var_210_3 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			if arg_207_1.time_ >= var_210_3 + 0.3 and arg_207_1.time_ < var_210_3 + 0.3 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_4 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_5 = 2

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_5 then
				local var_210_6 = Color.New(0, 0, 0)

				var_210_6.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_4) / var_210_5)
				arg_207_1.mask_.color = var_210_6
			end

			if arg_207_1.time_ >= var_210_4 + var_210_5 and arg_207_1.time_ < var_210_4 + var_210_5 + arg_210_0 then
				local var_210_7 = Color.New(0, 0, 0)

				var_210_7.a = 1
				arg_207_1.mask_.color = var_210_7
			end

			local var_210_8 = 2

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_9 = 2

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 then
				local var_210_10 = Color.New(0, 0, 0)

				var_210_10.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_8) / var_210_9)
				arg_207_1.mask_.color = var_210_10
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 then
				local var_210_11 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_11.a = 0
				arg_207_1.mask_.color = var_210_11
			end

			local var_210_12 = arg_207_1.actors_["1047"]

			if 1.966 < arg_207_1.time_ and arg_207_1.time_ <= 1.966 + arg_210_0 and not isNil(var_210_12) and arg_207_1.var_.actorSpriteComps1047 == nil then
				arg_207_1.var_.actorSpriteComps1047 = var_210_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_13 = 0.034

			if 1.966 <= arg_207_1.time_ and arg_207_1.time_ < 1.966 + var_210_13 and not isNil(var_210_12) then
				if arg_207_1.var_.actorSpriteComps1047 then
					for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_210_3 then
							if arg_207_1.isInRecall_ then
								iter_210_3.color = Color.New(Mathf.Lerp(iter_210_3.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 1.966) / var_210_13), Mathf.Lerp(iter_210_3.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 1.966) / var_210_13), (Mathf.Lerp(iter_210_3.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 1.966) / var_210_13)))
							else
								local var_210_14 = Mathf.Lerp(iter_210_3.color.r, 0.5, (arg_207_1.time_ - 1.966) / var_210_13)

								iter_210_3.color = Color.New(var_210_14, var_210_14, var_210_14)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 1.966 + var_210_13 and arg_207_1.time_ < 1.966 + var_210_13 + arg_210_0 and not isNil(var_210_12) and arg_207_1.var_.actorSpriteComps1047 then
				for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_210_5 then
						iter_210_5.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps1047 = nil
			end

			local var_210_15 = arg_207_1.actors_["1047"].transform

			if 1.966 < arg_207_1.time_ and arg_207_1.time_ <= 1.966 + arg_210_0 then
				arg_207_1.var_.moveOldPos1047 = var_210_15.localPosition
				var_210_15.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1047", 7)

				for iter_210_6 = 0, var_210_15.childCount - 1 do
					local var_210_16 = var_210_15:GetChild(iter_210_6)

					if var_210_16.name == "" or not string.find(var_210_16.name, "split") then
						var_210_16.gameObject:SetActive(true)
					else
						var_210_16.gameObject:SetActive(false)
					end
				end
			end

			local var_210_17 = 0.001

			if 1.966 <= arg_207_1.time_ and arg_207_1.time_ < 1.966 + var_210_17 then
				var_210_15.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_207_1.time_ - 1.966) / var_210_17)
			end

			if arg_207_1.time_ >= 1.966 + var_210_17 and arg_207_1.time_ < 1.966 + var_210_17 + arg_210_0 then
				var_210_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= 2 + arg_210_0 then
				arg_207_1:SetSpriteNiuquEffect("1047", false)
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_19 = 4
			local var_210_20 = 0.6

			if 4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_21 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_21:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_22 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(423011052).content)

				arg_207_1.text_.text = var_210_22

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_24 = 24 <= 0 and var_210_20 or var_210_20 * (utf8.len(var_210_22) / 24)

				if (24 <= 0 and var_210_20 or var_210_20 * (utf8.len(var_210_22) / 24)) > 0 and var_210_20 < var_210_24 then
					arg_207_1.talkMaxDuration = var_210_24
					var_210_19 = var_210_19 + 0.3

					if var_210_24 + var_210_19 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_24 + var_210_19
					end
				end

				arg_207_1.text_.text = var_210_22
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = var_210_19 + 0.3
			local var_210_26 = math.max(var_210_20, arg_207_1.talkMaxDuration)

			if var_210_19 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_25 + var_210_26 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_25) / var_210_26

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_25 + var_210_26 and arg_207_1.time_ < var_210_25 + var_210_26 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play423011053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423011053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play423011054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.575

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(423011053).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 23)

				if (23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 23)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423011054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423011054
		arg_217_1.duration_ = 18.3

		local var_217_0 = {
			zh = 11.466,
			ja = 18.3
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play423011055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(423011054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 52 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 52)

				if (52 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 52)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011054", "story_v_out_423011.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011054", "story_v_out_423011.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_423011", "423011054", "story_v_out_423011.awb")

						arg_217_1:RecordAudio("423011054", var_220_6)
						arg_217_1:RecordAudio("423011054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_423011", "423011054", "story_v_out_423011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_423011", "423011054", "story_v_out_423011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play423011055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423011055
		arg_221_1.duration_ = 13.83

		local var_221_0 = {
			zh = 10.4,
			ja = 13.833
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
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play423011056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.125

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(423011055)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 45 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 45)

				if (45 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 45)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011055", "story_v_out_423011.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011055", "story_v_out_423011.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_423011", "423011055", "story_v_out_423011.awb")

						arg_221_1:RecordAudio("423011055", var_224_6)
						arg_221_1:RecordAudio("423011055", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_423011", "423011055", "story_v_out_423011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_423011", "423011055", "story_v_out_423011.awb")
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
	Play423011056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423011056
		arg_225_1.duration_ = 11.47

		local var_225_0 = {
			zh = 6.733,
			ja = 11.466
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play423011057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0.1 < arg_225_1.time_ and arg_225_1.time_ <= 0.1 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_16", "se_story_16_channel", "")
			end

			local var_228_1 = 0
			local var_228_2 = 0.725

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(423011056)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 29 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 29)

				if (29 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 29)) > 0 and var_228_2 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011056", "story_v_out_423011.awb") ~= 0 then
					local var_228_7 = manager.audio:GetVoiceLength("story_v_out_423011", "423011056", "story_v_out_423011.awb") / 1000

					if var_228_7 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_1
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_423011", "423011056", "story_v_out_423011.awb")

						arg_225_1:RecordAudio("423011056", var_228_8)
						arg_225_1:RecordAudio("423011056", var_228_8)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_423011", "423011056", "story_v_out_423011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_423011", "423011056", "story_v_out_423011.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_9 and arg_225_1.time_ < var_228_1 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play423011057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 423011057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play423011058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.425

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(423011057).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 57 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 57)

				if (57 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 57)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play423011058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 423011058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play423011059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.4

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(423011058).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 16 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 16)

				if (16 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 16)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play423011059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 423011059
		arg_237_1.duration_ = 5.23

		local var_237_0 = {
			zh = 5.233,
			ja = 3.966
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play423011060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.5

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_1 = arg_237_1:GetWordFromCfg(423011059)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 20 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 20)

				if (20 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 20)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011059", "story_v_out_423011.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011059", "story_v_out_423011.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_423011", "423011059", "story_v_out_423011.awb")

						arg_237_1:RecordAudio("423011059", var_240_6)
						arg_237_1:RecordAudio("423011059", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_423011", "423011059", "story_v_out_423011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_423011", "423011059", "story_v_out_423011.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play423011060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 423011060
		arg_241_1.duration_ = 7

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play423011061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0.1 < arg_241_1.time_ and arg_241_1.time_ <= 0.1 + arg_244_0 then
				arg_241_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_244_0 = 1

			if 0.1 <= arg_241_1.time_ and arg_241_1.time_ < 0.1 + var_244_0 then
				local var_244_1, var_244_2 = math.modf((arg_241_1.time_ - 0.1) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_244_2 * 0.13, var_244_2 * 0.13, var_244_2 * 0.13) + arg_241_1.var_.shakeOldPos
			end

			if arg_241_1.time_ >= 0.1 + var_244_0 and arg_241_1.time_ < 0.1 + var_244_0 + arg_244_0 then
				manager.ui.mainCamera.transform.localPosition = arg_241_1.var_.shakeOldPos
			end

			local var_244_3 = 0

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			if arg_241_1.time_ >= var_244_3 + 2 and arg_241_1.time_ < var_244_3 + 2 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_4

			if 0.533333333333333 < arg_241_1.time_ and arg_241_1.time_ <= 0.533333333333333 + arg_244_0 then
				local var_244_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_244_5 then
					var_244_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_244_5.radialBlurScale = 1
					var_244_5.radialBlurGradient = 1
					var_244_5.radialBlurIntensity = 1

					if var_244_4 then
						var_244_5.radialBlurTarget = var_244_4.transform
					end
				end
			end

			local var_244_6 = 1.5

			if 0.533333333333333 <= arg_241_1.time_ and arg_241_1.time_ < 0.533333333333333 + var_244_6 then
				local var_244_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_244_7 then
					var_244_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_244_7.radialBlurScale = Mathf.Lerp(1, 0.625, (arg_241_1.time_ - 0.533333333333333) / var_244_6)
					var_244_7.radialBlurGradient = Mathf.Lerp(1, 1, (arg_241_1.time_ - 0.533333333333333) / var_244_6)
					var_244_7.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_241_1.time_ - 0.533333333333333) / var_244_6)
				end
			end

			if arg_241_1.time_ >= 0.533333333333333 + var_244_6 and arg_241_1.time_ < 0.533333333333333 + var_244_6 + arg_244_0 then
				local var_244_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_244_8 then
					var_244_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_244_8.radialBlurScale = 0.625
					var_244_8.radialBlurGradient = 1
					var_244_8.radialBlurIntensity = 1
				end
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:AudioAction("play", "effect", "se_story_144", "se_story_144_train_shake", "")
			end

			if 0.1 < arg_241_1.time_ and arg_241_1.time_ <= 0.1 + arg_244_0 then
				arg_241_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_244_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_12 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_12

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_12
						arg_241_1.bgmTxt2_.text = var_244_12
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_241_1.time_ and arg_241_1.time_ <= 0.166666666666667 + arg_244_0 then
				arg_241_1:AudioAction("stop", "effect", "se_story_144", "se_story_144_amb_train", "")
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_14 = 2
			local var_244_15 = 1.425

			if 2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_16 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_16:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_241_1.dialogCg_.alpha = arg_246_0
				end))
				var_244_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_17 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(423011060).content)

				arg_241_1.text_.text = var_244_17

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_19 = 57 <= 0 and var_244_15 or var_244_15 * (utf8.len(var_244_17) / 57)

				if (57 <= 0 and var_244_15 or var_244_15 * (utf8.len(var_244_17) / 57)) > 0 and var_244_15 < var_244_19 then
					arg_241_1.talkMaxDuration = var_244_19
					var_244_14 = var_244_14 + 0.3

					if var_244_19 + var_244_14 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_14
					end
				end

				arg_241_1.text_.text = var_244_17
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_20 = var_244_14 + 0.3
			local var_244_21 = math.max(var_244_15, arg_241_1.talkMaxDuration)

			if var_244_14 + 0.3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_20 + var_244_21 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_20) / var_244_21

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_20 + var_244_21 and arg_241_1.time_ < var_244_20 + var_244_21 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play423011061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 423011061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play423011062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_9000

			if 0.1 < arg_248_1.time_ and arg_248_1.time_ <= 0.1 + arg_251_0 then
				arg_248_1:AudioAction("play", "effect", "se_story_129", "se_story_129_alarm", "")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				local var_251_1 = arg_248_1.var_.effectliechebaozhajinggao1

				if not arg_248_1.var_.effectliechebaozhajinggao1 then
					var_251_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_251_1.name = "liechebaozhajinggao1"
					arg_248_1.var_.effectliechebaozhajinggao1 = var_251_1
				else
					var_251_1.transform:SetParent(var_251_9000)
				end

				var_251_1.transform.localPosition = Vector3.New(0, 0, -2)
				var_251_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_251_1.transform.localScale = Vector3.New(var_251_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_251_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_251_1.transform.localScale.z)
			end

			local var_251_3 = 0
			local var_251_4 = 1.575

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_3 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_5 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(423011061).content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 63 <= 0 and var_251_4 or var_251_4 * (utf8.len(var_251_5) / 63)

				if (63 <= 0 and var_251_4 or var_251_4 * (utf8.len(var_251_5) / 63)) > 0 and var_251_4 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_3 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_3
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_4, arg_248_1.talkMaxDuration)

			if var_251_3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_3 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_3) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_3 + var_251_8 and arg_248_1.time_ < var_251_3 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play423011062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 423011062
		arg_252_1.duration_ = 7.83

		local var_252_0 = {
			zh = 7.033,
			ja = 7.833
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
				arg_252_0:Play423011063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 5.63333333333333 < arg_252_1.time_ and arg_252_1.time_ <= 5.63333333333333 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_140", "se_story_140_microphone", "")
			end

			local var_255_1 = 0
			local var_255_2 = 0.85

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_252_1.callingController_:SetSelectedState("calling")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(423011062)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 34 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 34)

				if (34 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 34)) > 0 and var_255_2 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011062", "story_v_out_423011.awb") ~= 0 then
					local var_255_7 = manager.audio:GetVoiceLength("story_v_out_423011", "423011062", "story_v_out_423011.awb") / 1000

					if var_255_7 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_1
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_423011", "423011062", "story_v_out_423011.awb")

						arg_252_1:RecordAudio("423011062", var_255_8)
						arg_252_1:RecordAudio("423011062", var_255_8)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_423011", "423011062", "story_v_out_423011.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_423011", "423011062", "story_v_out_423011.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_9 and arg_252_1.time_ < var_255_1 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play423011063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 423011063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play423011064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_259_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_2 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_2

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_2
						arg_256_1.bgmTxt2_.text = var_259_2
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_256_1.time_ and arg_256_1.time_ <= 0.500666666666667 + arg_259_0 then
				arg_256_1:AudioAction("play", "music", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_259_5 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if "" ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_5 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_5

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_5
						arg_256_1.bgmTxt2_.text = var_259_5
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_259_6 = 0
			local var_259_7 = 1.6

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_8 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(423011063).content)

				arg_256_1.text_.text = var_259_8

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_10 = 64 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_8) / 64)

				if (64 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_8) / 64)) > 0 and var_259_7 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_8
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_11 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_11 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_11

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_11 and arg_256_1.time_ < var_259_6 + var_259_11 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play423011064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 423011064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play423011065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.225

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(423011064).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 9 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 9)

				if (9 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 9)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play423011065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 423011065
		arg_266_1.duration_ = 10.43

		local var_266_0 = {
			zh = 6.1,
			ja = 10.433
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
				arg_266_0:Play423011066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.725

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:GetWordFromCfg(423011065)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 29 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 29)

				if (29 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 29)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011065", "story_v_out_423011.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011065", "story_v_out_423011.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_423011", "423011065", "story_v_out_423011.awb")

						arg_266_1:RecordAudio("423011065", var_269_6)
						arg_266_1:RecordAudio("423011065", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_423011", "423011065", "story_v_out_423011.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_423011", "423011065", "story_v_out_423011.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play423011066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 423011066
		arg_270_1.duration_ = 5.53

		local var_270_0 = {
			zh = 5.4,
			ja = 5.533
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
				arg_270_0:Play423011067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.75

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:GetWordFromCfg(423011066)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 30 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 30)

				if (30 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 30)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011066", "story_v_out_423011.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011066", "story_v_out_423011.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_423011", "423011066", "story_v_out_423011.awb")

						arg_270_1:RecordAudio("423011066", var_273_6)
						arg_270_1:RecordAudio("423011066", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_423011", "423011066", "story_v_out_423011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_423011", "423011066", "story_v_out_423011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play423011067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 423011067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play423011068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.575

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(423011067).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 23 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 23)

				if (23 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 23)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play423011068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 423011068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play423011069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 1.45

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(423011068).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 58 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 58)

				if (58 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 58)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play423011069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 423011069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play423011070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_9000

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_285_0 then
					var_285_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_285_0.radialBlurScale = 1
					var_285_0.radialBlurGradient = 1
					var_285_0.radialBlurIntensity = 1

					if nil then
						var_285_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_285_1 = 1.5

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				local var_285_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_285_2 then
					var_285_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_285_2.radialBlurScale = Mathf.Lerp(1, 0, (arg_282_1.time_ - 0) / var_285_1)
					var_285_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_282_1.time_ - 0) / var_285_1)
					var_285_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_282_1.time_ - 0) / var_285_1)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				local var_285_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_285_3 then
					var_285_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_285_3.radialBlurScale = 0
					var_285_3.radialBlurGradient = 1
					var_285_3.radialBlurIntensity = 1
				end
			end

			local var_285_4 = 0

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			if arg_282_1.time_ >= var_285_4 + 1.5 and arg_282_1.time_ < var_285_4 + 1.5 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				if arg_282_1.var_.effectliechebaozhajinggao1 then
					Object.Destroy(arg_282_1.var_.effectliechebaozhajinggao1)

					arg_282_1.var_.effectliechebaozhajinggao1 = nil
				end
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_6 = arg_282_1.var_.effectliechebaozhajinggao2

				if not arg_282_1.var_.effectliechebaozhajinggao2 then
					var_285_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_out"), manager.ui.mainCamera.transform)
					var_285_6.name = "liechebaozhajinggao2"
					arg_282_1.var_.effectliechebaozhajinggao2 = var_285_6
				else
					var_285_6.transform:SetParent(var_285_9000)
				end

				var_285_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_285_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_285_8 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_285_0, iter_285_1 in ipairs((var_285_6.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_285_1.transform.localScale = Vector3.New(iter_285_1.transform.localScale.x / var_285_8 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_285_1.transform.localScale.y / var_285_8, iter_285_1.transform.localScale.z)
				end
			end

			if 2 < arg_282_1.time_ and arg_282_1.time_ <= 2 + arg_285_0 then
				if arg_282_1.var_.effectliechebaozhajinggao2 then
					Object.Destroy(arg_282_1.var_.effectliechebaozhajinggao2)

					arg_282_1.var_.effectliechebaozhajinggao2 = nil
				end
			end

			local var_285_11 = 0
			local var_285_12 = 1.7

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_11 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_13 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(423011069).content)

				arg_282_1.text_.text = var_285_13

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_15 = 68 <= 0 and var_285_12 or var_285_12 * (utf8.len(var_285_13) / 68)

				if (68 <= 0 and var_285_12 or var_285_12 * (utf8.len(var_285_13) / 68)) > 0 and var_285_12 < var_285_15 then
					arg_282_1.talkMaxDuration = var_285_15

					if var_285_15 + var_285_11 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_15 + var_285_11
					end
				end

				arg_282_1.text_.text = var_285_13
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_16 = math.max(var_285_12, arg_282_1.talkMaxDuration)

			if var_285_11 <= arg_282_1.time_ and arg_282_1.time_ < var_285_11 + var_285_16 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_11) / var_285_16

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_11 + var_285_16 and arg_282_1.time_ < var_285_11 + var_285_16 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play423011070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 423011070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play423011071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.225

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(423011070).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 9 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 9)

				if (9 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 9)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play423011071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 423011071
		arg_290_1.duration_ = 9.4

		local var_290_0 = {
			zh = 7.3,
			ja = 9.4
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
				arg_290_0:Play423011072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.85

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:GetWordFromCfg(423011071)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 34 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 34)

				if (34 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 34)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011071", "story_v_out_423011.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011071", "story_v_out_423011.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_423011", "423011071", "story_v_out_423011.awb")

						arg_290_1:RecordAudio("423011071", var_293_6)
						arg_290_1:RecordAudio("423011071", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_423011", "423011071", "story_v_out_423011.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_423011", "423011071", "story_v_out_423011.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play423011072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 423011072
		arg_294_1.duration_ = 7.1

		local var_294_0 = {
			zh = 4.8,
			ja = 7.1
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
				arg_294_0:Play423011073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.7

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:GetWordFromCfg(423011072)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 28 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 28)

				if (28 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 28)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011072", "story_v_out_423011.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011072", "story_v_out_423011.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_423011", "423011072", "story_v_out_423011.awb")

						arg_294_1:RecordAudio("423011072", var_297_6)
						arg_294_1:RecordAudio("423011072", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_423011", "423011072", "story_v_out_423011.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_423011", "423011072", "story_v_out_423011.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play423011073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 423011073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play423011074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0.4 < arg_298_1.time_ and arg_298_1.time_ <= 0.4 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story_144", "se_story_144_countdown", "")
			end

			local var_301_1 = 0
			local var_301_2 = 0.65

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(423011073).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 26 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 26)

				if (26 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 26)) > 0 and var_301_2 < var_301_5 then
					arg_298_1.talkMaxDuration = var_301_5

					if var_301_5 + var_301_1 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + var_301_1
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_6 = math.max(var_301_2, arg_298_1.talkMaxDuration)

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_6 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_1) / var_301_6

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_1 + var_301_6 and arg_298_1.time_ < var_301_1 + var_301_6 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play423011074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 423011074
		arg_302_1.duration_ = 5.2

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play423011075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_9001
			local var_305_9000

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				local var_305_0 = arg_302_1.var_.effectshuangchongbaozha

				if not arg_302_1.var_.effectshuangchongbaozha then
					var_305_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_305_0.name = "shuangchongbaozha"
					arg_302_1.var_.effectshuangchongbaozha = var_305_0
				else
					var_305_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_305_0.transform.localPosition = Vector3.New(-5, 1, -3)
				var_305_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5 < arg_302_1.time_ and arg_302_1.time_ <= 5 + arg_305_0 then
				if arg_302_1.var_.effectshuangchongbaozha then
					Object.Destroy(arg_302_1.var_.effectshuangchongbaozha)

					arg_302_1.var_.effectshuangchongbaozha = nil
				end
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				local var_305_3 = arg_302_1.var_.effectshuangchongbaozha1

				if not arg_302_1.var_.effectshuangchongbaozha1 then
					var_305_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_305_3.name = "shuangchongbaozha1"
					arg_302_1.var_.effectshuangchongbaozha1 = var_305_3
				else
					var_305_3.transform:SetParent(var_305_9001)
				end

				var_305_3.transform.localPosition = Vector3.New(6, 1, -3)
				var_305_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5 < arg_302_1.time_ and arg_302_1.time_ <= 5 + arg_305_0 then
				if arg_302_1.var_.effectshuangchongbaozha1 then
					Object.Destroy(arg_302_1.var_.effectshuangchongbaozha1)

					arg_302_1.var_.effectshuangchongbaozha1 = nil
				end
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "se_story_144", "se_story_144_explosion02", "")
			end

			local var_305_7 = manager.ui.mainCamera.transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.shakeOldPos = var_305_7.localPosition
			end

			local var_305_8 = 1

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_8 then
				local var_305_9, var_305_10 = math.modf((arg_302_1.time_ - 0) / 0.066)

				var_305_7.localPosition = Vector3.New(var_305_10 * 0.13, var_305_10 * 0.13, var_305_10 * 0.13) + arg_302_1.var_.shakeOldPos
			end

			if arg_302_1.time_ >= 0 + var_305_8 and arg_302_1.time_ < 0 + var_305_8 + arg_305_0 then
				var_305_7.localPosition = arg_302_1.var_.shakeOldPos
			end

			if 0.266666666666667 < arg_302_1.time_ and arg_302_1.time_ <= 0.266666666666667 + arg_305_0 then
				local var_305_11 = arg_302_1.var_.effectliechebaozha2

				if not arg_302_1.var_.effectliechebaozha2 then
					var_305_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_305_11.name = "liechebaozha2"
					arg_302_1.var_.effectliechebaozha2 = var_305_11
				else
					var_305_11.transform:SetParent(var_305_9000)
				end

				var_305_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_305_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.266666666666667 < arg_302_1.time_ and arg_302_1.time_ <= 0.266666666666667 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			local var_305_14 = 0
			local var_305_15 = 1.125

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_16 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(423011074).content)

				arg_302_1.text_.text = var_305_16

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_18 = 45 <= 0 and var_305_15 or var_305_15 * (utf8.len(var_305_16) / 45)

				if (45 <= 0 and var_305_15 or var_305_15 * (utf8.len(var_305_16) / 45)) > 0 and var_305_15 < var_305_18 then
					arg_302_1.talkMaxDuration = var_305_18

					if var_305_18 + var_305_14 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_18 + var_305_14
					end
				end

				arg_302_1.text_.text = var_305_16
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_19 = math.max(var_305_15, arg_302_1.talkMaxDuration)

			if var_305_14 <= arg_302_1.time_ and arg_302_1.time_ < var_305_14 + var_305_19 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_14) / var_305_19

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_14 + var_305_19 and arg_302_1.time_ < var_305_14 + var_305_19 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play423011075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 423011075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play423011076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.5

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(423011075).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 60 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 60)

				if (60 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 60)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play423011076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 423011076
		arg_310_1.duration_ = 8.31

		local var_310_0 = {
			zh = 5.575,
			ja = 8.308
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play423011077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_313_0 = 0.6

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				local var_313_1, var_313_2 = math.modf((arg_310_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_313_2 * 0.13, var_313_2 * 0.13, var_313_2 * 0.13) + arg_310_1.var_.shakeOldPos
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				manager.ui.mainCamera.transform.localPosition = arg_310_1.var_.shakeOldPos
			end

			local var_313_3 = 0

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_3 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			if arg_310_1.time_ >= var_313_3 + 0.6 and arg_310_1.time_ < var_313_3 + 0.6 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_310_1.time_ and arg_310_1.time_ <= 0.166666666666667 + arg_313_0 then
				arg_310_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun01", "")
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_5 = 0.375
			local var_313_6 = 0.625

			if 0.375 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_7 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_7:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_8 = arg_310_1:GetWordFromCfg(423011076)
				local var_313_9 = arg_310_1:FormatText(var_313_8.content)

				arg_310_1.text_.text = var_313_9

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 25 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_9) / 25)

				if (25 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_9) / 25)) > 0 and var_313_6 < var_313_11 then
					arg_310_1.talkMaxDuration = var_313_11
					var_313_5 = var_313_5 + 0.3

					if var_313_11 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_9
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011076", "story_v_out_423011.awb") ~= 0 then
					local var_313_12 = manager.audio:GetVoiceLength("story_v_out_423011", "423011076", "story_v_out_423011.awb") / 1000

					if var_313_12 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_12 + var_313_5
					end

					if var_313_8.prefab_name ~= "" and arg_310_1.actors_[var_313_8.prefab_name] ~= nil then
						local var_313_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_8.prefab_name].transform, "story_v_out_423011", "423011076", "story_v_out_423011.awb")

						arg_310_1:RecordAudio("423011076", var_313_13)
						arg_310_1:RecordAudio("423011076", var_313_13)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_423011", "423011076", "story_v_out_423011.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_423011", "423011076", "story_v_out_423011.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = var_313_5 + 0.3
			local var_313_15 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 + 0.3 <= arg_310_1.time_ and arg_310_1.time_ < var_313_14 + var_313_15 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_14) / var_313_15

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_14 + var_313_15 and arg_310_1.time_ < var_313_14 + var_313_15 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play423011077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 423011077
		arg_316_1.duration_ = 8.6

		local var_316_0 = {
			zh = 5.9,
			ja = 8.6
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play423011078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.575

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(423011077)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 23 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 23)

				if (23 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 23)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011077", "story_v_out_423011.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011077", "story_v_out_423011.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_423011", "423011077", "story_v_out_423011.awb")

						arg_316_1:RecordAudio("423011077", var_319_6)
						arg_316_1:RecordAudio("423011077", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_423011", "423011077", "story_v_out_423011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_423011", "423011077", "story_v_out_423011.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play423011078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 423011078
		arg_320_1.duration_ = 10.8

		local var_320_0 = {
			zh = 10.8,
			ja = 7.666
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play423011079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 1.125

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:GetWordFromCfg(423011078)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 45 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 45)

				if (45 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 45)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011078", "story_v_out_423011.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011078", "story_v_out_423011.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_423011", "423011078", "story_v_out_423011.awb")

						arg_320_1:RecordAudio("423011078", var_323_6)
						arg_320_1:RecordAudio("423011078", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_423011", "423011078", "story_v_out_423011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_423011", "423011078", "story_v_out_423011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play423011079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 423011079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play423011080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.55

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(423011079).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 62 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 62)

				if (62 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 62)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play423011080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 423011080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play423011081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.675

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(423011080).content)

				arg_328_1.text_.text = var_331_1

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_3 = 27 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 27)

				if (27 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 27)) > 0 and var_331_0 < var_331_3 then
					arg_328_1.talkMaxDuration = var_331_3

					if var_331_3 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_3 + 0
					end
				end

				arg_328_1.text_.text = var_331_1
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_4 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_4

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play423011081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 423011081
		arg_332_1.duration_ = 13.37

		local var_332_0 = {
			zh = 7.4,
			ja = 13.366
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play423011082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.75

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_1 = arg_332_1:GetWordFromCfg(423011081)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 30 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 30)

				if (30 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 30)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011081", "story_v_out_423011.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011081", "story_v_out_423011.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_423011", "423011081", "story_v_out_423011.awb")

						arg_332_1:RecordAudio("423011081", var_335_6)
						arg_332_1:RecordAudio("423011081", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_423011", "423011081", "story_v_out_423011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_423011", "423011081", "story_v_out_423011.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play423011082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 423011082
		arg_336_1.duration_ = 6.27

		local var_336_0 = {
			zh = 5.333,
			ja = 6.266
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play423011083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.55

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1329].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_1 = arg_336_1:GetWordFromCfg(423011082)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 22 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 22)

				if (22 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 22)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011082", "story_v_out_423011.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011082", "story_v_out_423011.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_423011", "423011082", "story_v_out_423011.awb")

						arg_336_1:RecordAudio("423011082", var_339_6)
						arg_336_1:RecordAudio("423011082", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_423011", "423011082", "story_v_out_423011.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_423011", "423011082", "story_v_out_423011.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play423011083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 423011083
		arg_340_1.duration_ = 3.37

		local var_340_0 = {
			zh = 2.066,
			ja = 3.366
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play423011084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 1.325

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:GetWordFromCfg(423011083)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 53 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 53)

				if (53 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 53)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011083", "story_v_out_423011.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011083", "story_v_out_423011.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_out_423011", "423011083", "story_v_out_423011.awb")

						arg_340_1:RecordAudio("423011083", var_343_6)
						arg_340_1:RecordAudio("423011083", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_423011", "423011083", "story_v_out_423011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_423011", "423011083", "story_v_out_423011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play423011084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 423011084
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play423011085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.975

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(423011084).content)

				arg_344_1.text_.text = var_347_1

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_3 = 39 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 39)

				if (39 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 39)) > 0 and var_347_0 < var_347_3 then
					arg_344_1.talkMaxDuration = var_347_3

					if var_347_3 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_3 + 0
					end
				end

				arg_344_1.text_.text = var_347_1
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_4 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_4 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_4

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_4 and arg_344_1.time_ < 0 + var_347_4 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play423011085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 423011085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play423011086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.825

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(423011085).content)

				arg_348_1.text_.text = var_351_1

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_3 = 33 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 33)

				if (33 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 33)) > 0 and var_351_0 < var_351_3 then
					arg_348_1.talkMaxDuration = var_351_3

					if var_351_3 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_3 + 0
					end
				end

				arg_348_1.text_.text = var_351_1
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_4 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_4

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play423011086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 423011086
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play423011087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.7

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_1 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(423011086).content)

				arg_352_1.text_.text = var_355_1

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_3 = 28 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 28)

				if (28 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 28)) > 0 and var_355_0 < var_355_3 then
					arg_352_1.talkMaxDuration = var_355_3

					if var_355_3 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_3 + 0
					end
				end

				arg_352_1.text_.text = var_355_1
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_4 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_4

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play423011087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 423011087
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play423011088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0.166666666666667 < arg_356_1.time_ and arg_356_1.time_ <= 0.166666666666667 + arg_359_0 then
				arg_356_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_359_1 = 0
			local var_359_2 = 1.075

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(423011087).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 43 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 43)

				if (43 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 43)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play423011088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 423011088
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play423011089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				local var_363_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_363_0 then
					var_363_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_363_0.radialBlurScale = 0
					var_363_0.radialBlurGradient = 1
					var_363_0.radialBlurIntensity = 1

					if nil then
						var_363_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_363_1 = 1

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_1 then
				local var_363_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_363_2 then
					var_363_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_363_2.radialBlurScale = Mathf.Lerp(0, 0, (arg_360_1.time_ - 0) / var_363_1)
					var_363_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_360_1.time_ - 0) / var_363_1)
					var_363_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_360_1.time_ - 0) / var_363_1)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_1 and arg_360_1.time_ < 0 + var_363_1 + arg_363_0 then
				local var_363_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_363_3 then
					var_363_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_363_3.radialBlurScale = 0
					var_363_3.radialBlurGradient = 1
					var_363_3.radialBlurIntensity = 1
				end
			end

			if 0.233333333333333 < arg_360_1.time_ and arg_360_1.time_ <= 0.233333333333333 + arg_363_0 then
				arg_360_1:AudioAction("play", "effect", "se_story", "se_story_explosion", "")
			end

			local var_363_5 = 0
			local var_363_6 = 1.55

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_7 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(423011088).content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 62 <= 0 and var_363_6 or var_363_6 * (utf8.len(var_363_7) / 62)

				if (62 <= 0 and var_363_6 or var_363_6 * (utf8.len(var_363_7) / 62)) > 0 and var_363_6 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_5 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_5
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_6, arg_360_1.talkMaxDuration)

			if var_363_5 <= arg_360_1.time_ and arg_360_1.time_ < var_363_5 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_5) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_5 + var_363_10 and arg_360_1.time_ < var_363_5 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play423011089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 423011089
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play423011090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.175

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(423011089).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 7 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 7)

				if (7 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 7)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play423011090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 423011090
		arg_368_1.duration_ = 2.9

		local var_368_0 = {
			zh = 2.033,
			ja = 2.9
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play423011091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.175

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1329].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:GetWordFromCfg(423011090)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 7 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 7)

				if (7 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 7)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011090", "story_v_out_423011.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011090", "story_v_out_423011.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_423011", "423011090", "story_v_out_423011.awb")

						arg_368_1:RecordAudio("423011090", var_371_6)
						arg_368_1:RecordAudio("423011090", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_423011", "423011090", "story_v_out_423011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_423011", "423011090", "story_v_out_423011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play423011091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 423011091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play423011092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 1.6

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(423011091).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 64 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 64)

				if (64 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 64)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play423011092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 423011092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play423011093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0.15 < arg_376_1.time_ and arg_376_1.time_ <= 0.15 + arg_379_0 then
				arg_376_1:AudioAction("play", "effect", "se_story_144", "se_story_144_motorcycle_gun", "")
			end

			local var_379_1 = 0
			local var_379_2 = 1.15

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(423011092).content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 46 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 46)

				if (46 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 46)) > 0 and var_379_2 < var_379_5 then
					arg_376_1.talkMaxDuration = var_379_5

					if var_379_5 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_6 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_6 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_6

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_6 and arg_376_1.time_ < var_379_1 + var_379_6 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play423011093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 423011093
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play423011094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.55

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(423011093).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 22 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 22)

				if (22 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 22)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play423011094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 423011094
		arg_384_1.duration_ = 2.3

		local var_384_0 = {
			zh = 1.6,
			ja = 2.3
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play423011095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.175

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:GetWordFromCfg(423011094)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 7 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 7)

				if (7 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 7)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011094", "story_v_out_423011.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011094", "story_v_out_423011.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_423011", "423011094", "story_v_out_423011.awb")

						arg_384_1:RecordAudio("423011094", var_387_6)
						arg_384_1:RecordAudio("423011094", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_423011", "423011094", "story_v_out_423011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_423011", "423011094", "story_v_out_423011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play423011095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 423011095
		arg_388_1.duration_ = 9.97

		local var_388_0 = {
			zh = 8.133,
			ja = 9.966
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play423011096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 2 < arg_388_1.time_ and arg_388_1.time_ <= 2 + arg_391_0 then
				local var_391_0 = arg_388_1.bgs_.ST0111

				arg_388_1.bgs_.ST0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_391_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_1 = var_391_0:GetComponent("SpriteRenderer")

				if var_391_1 and var_391_1.sprite then
					local var_391_2 = 2 * (var_391_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_391_0.transform.localScale = Vector3.New(var_391_2 / var_391_1.sprite.bounds.size.y < var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x and var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x or var_391_2 / var_391_1.sprite.bounds.size.y, var_391_2 / var_391_1.sprite.bounds.size.y < var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x and var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x or var_391_2 / var_391_1.sprite.bounds.size.y, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "ST0111" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_3 = 3.999999999999

			if 3.999999999999 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			if arg_388_1.time_ >= var_391_3 + 0.3 and arg_388_1.time_ < var_391_3 + 0.3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_4 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_5 = 2

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_5 then
				local var_391_6 = Color.New(0, 0, 0)

				var_391_6.a = Mathf.Lerp(0, 1, (arg_388_1.time_ - var_391_4) / var_391_5)
				arg_388_1.mask_.color = var_391_6
			end

			if arg_388_1.time_ >= var_391_4 + var_391_5 and arg_388_1.time_ < var_391_4 + var_391_5 + arg_391_0 then
				local var_391_7 = Color.New(0, 0, 0)

				var_391_7.a = 1
				arg_388_1.mask_.color = var_391_7
			end

			local var_391_8 = 2

			if 2 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_9 = 2

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_9 then
				local var_391_10 = Color.New(0, 0, 0)

				var_391_10.a = Mathf.Lerp(1, 0, (arg_388_1.time_ - var_391_8) / var_391_9)
				arg_388_1.mask_.color = var_391_10
			end

			if arg_388_1.time_ >= var_391_8 + var_391_9 and arg_388_1.time_ < var_391_8 + var_391_9 + arg_391_0 then
				local var_391_11 = Color.New(0, 0, 0)

				arg_388_1.mask_.enabled = false
				var_391_11.a = 0
				arg_388_1.mask_.color = var_391_11
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_12 = 4
			local var_391_13 = 0.5

			if 4 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_14 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_14:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1329].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_15 = arg_388_1:GetWordFromCfg(423011095)
				local var_391_16 = arg_388_1:FormatText(var_391_15.content)

				arg_388_1.text_.text = var_391_16

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_18 = 21 <= 0 and var_391_13 or var_391_13 * (utf8.len(var_391_16) / 21)

				if (21 <= 0 and var_391_13 or var_391_13 * (utf8.len(var_391_16) / 21)) > 0 and var_391_13 < var_391_18 then
					arg_388_1.talkMaxDuration = var_391_18
					var_391_12 = var_391_12 + 0.3

					if var_391_18 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_18 + var_391_12
					end
				end

				arg_388_1.text_.text = var_391_16
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011095", "story_v_out_423011.awb") ~= 0 then
					local var_391_19 = manager.audio:GetVoiceLength("story_v_out_423011", "423011095", "story_v_out_423011.awb") / 1000

					if var_391_19 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_19 + var_391_12
					end

					if var_391_15.prefab_name ~= "" and arg_388_1.actors_[var_391_15.prefab_name] ~= nil then
						local var_391_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_15.prefab_name].transform, "story_v_out_423011", "423011095", "story_v_out_423011.awb")

						arg_388_1:RecordAudio("423011095", var_391_20)
						arg_388_1:RecordAudio("423011095", var_391_20)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_423011", "423011095", "story_v_out_423011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_423011", "423011095", "story_v_out_423011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_21 = var_391_12 + 0.3
			local var_391_22 = math.max(var_391_13, arg_388_1.talkMaxDuration)

			if var_391_12 + 0.3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_21 + var_391_22 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_21) / var_391_22

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_21 + var_391_22 and arg_388_1.time_ < var_391_21 + var_391_22 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play423011096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 423011096
		arg_394_1.duration_ = 6.33

		local var_394_0 = {
			zh = 3.266,
			ja = 6.333
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play423011097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.4

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[1328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_1 = arg_394_1:GetWordFromCfg(423011096)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 16 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 16)

				if (16 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 16)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011096", "story_v_out_423011.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011096", "story_v_out_423011.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_out_423011", "423011096", "story_v_out_423011.awb")

						arg_394_1:RecordAudio("423011096", var_397_6)
						arg_394_1:RecordAudio("423011096", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_423011", "423011096", "story_v_out_423011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_423011", "423011096", "story_v_out_423011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play423011097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 423011097
		arg_398_1.duration_ = 7.87

		local var_398_0 = {
			zh = 6.933,
			ja = 7.866
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play423011098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.775

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_1 = arg_398_1:GetWordFromCfg(423011097)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 32 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 32)

				if (32 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 32)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011097", "story_v_out_423011.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011097", "story_v_out_423011.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_423011", "423011097", "story_v_out_423011.awb")

						arg_398_1:RecordAudio("423011097", var_401_6)
						arg_398_1:RecordAudio("423011097", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_423011", "423011097", "story_v_out_423011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_423011", "423011097", "story_v_out_423011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play423011098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 423011098
		arg_402_1.duration_ = 3.77

		local var_402_0 = {
			zh = 3.766,
			ja = 3.633
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play423011099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.375

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:GetWordFromCfg(423011098)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 15 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 15)

				if (15 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 15)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011098", "story_v_out_423011.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011098", "story_v_out_423011.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_out_423011", "423011098", "story_v_out_423011.awb")

						arg_402_1:RecordAudio("423011098", var_405_6)
						arg_402_1:RecordAudio("423011098", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_423011", "423011098", "story_v_out_423011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_423011", "423011098", "story_v_out_423011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play423011099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 423011099
		arg_406_1.duration_ = 12.37

		local var_406_0 = {
			zh = 8.2,
			ja = 12.366
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play423011100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_409_0 = 0.5

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 then
				local var_409_1, var_409_2 = math.modf((arg_406_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_409_2 * 0.13, var_409_2 * 0.13, var_409_2 * 0.13) + arg_406_1.var_.shakeOldPos
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 then
				manager.ui.mainCamera.transform.localPosition = arg_406_1.var_.shakeOldPos
			end

			local var_409_3 = 0

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_3 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			if arg_406_1.time_ >= var_409_3 + 0.5 and arg_406_1.time_ < var_409_3 + 0.5 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_4 = 0
			local var_409_5 = 1.075

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_6 = arg_406_1:GetWordFromCfg(423011099)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 43 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 43)

				if (43 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 43)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011099", "story_v_out_423011.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_out_423011", "423011099", "story_v_out_423011.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_out_423011", "423011099", "story_v_out_423011.awb")

						arg_406_1:RecordAudio("423011099", var_409_11)
						arg_406_1:RecordAudio("423011099", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_423011", "423011099", "story_v_out_423011.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_423011", "423011099", "story_v_out_423011.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play423011100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 423011100
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play423011101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.775

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(423011100).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 31 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 31)

				if (31 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 31)) > 0 and var_413_0 < var_413_3 then
					arg_410_1.talkMaxDuration = var_413_3

					if var_413_3 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_3 + 0
					end
				end

				arg_410_1.text_.text = var_413_1
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_4 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_4

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play423011101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 423011101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play423011102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 1.225

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(423011101).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 49 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 49)

				if (49 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 49)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play423011102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 423011102
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play423011103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.775

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(423011102).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 31 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 31)

				if (31 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 31)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play423011103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 423011103
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play423011104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.925

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(423011103).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 37 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 37)

				if (37 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 37)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play423011104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 423011104
		arg_426_1.duration_ = 13.23

		local var_426_0 = {
			zh = 10.366,
			ja = 13.233
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play423011105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 1.025

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:GetWordFromCfg(423011104)
				local var_429_2 = arg_426_1:FormatText(var_429_1.content)

				arg_426_1.text_.text = var_429_2

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 41 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 41)

				if (41 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 41)) > 0 and var_429_0 < var_429_4 then
					arg_426_1.talkMaxDuration = var_429_4

					if var_429_4 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_4 + 0
					end
				end

				arg_426_1.text_.text = var_429_2
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011104", "story_v_out_423011.awb") ~= 0 then
					local var_429_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011104", "story_v_out_423011.awb") / 1000

					if var_429_5 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + 0
					end

					if var_429_1.prefab_name ~= "" and arg_426_1.actors_[var_429_1.prefab_name] ~= nil then
						local var_429_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_1.prefab_name].transform, "story_v_out_423011", "423011104", "story_v_out_423011.awb")

						arg_426_1:RecordAudio("423011104", var_429_6)
						arg_426_1:RecordAudio("423011104", var_429_6)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_423011", "423011104", "story_v_out_423011.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_423011", "423011104", "story_v_out_423011.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play423011105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 423011105
		arg_430_1.duration_ = 6.87

		local var_430_0 = {
			zh = 5.2,
			ja = 6.866
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play423011106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.65

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_1 = arg_430_1:GetWordFromCfg(423011105)
				local var_433_2 = arg_430_1:FormatText(var_433_1.content)

				arg_430_1.text_.text = var_433_2

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 26 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 26)

				if (26 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 26)) > 0 and var_433_0 < var_433_4 then
					arg_430_1.talkMaxDuration = var_433_4

					if var_433_4 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_4 + 0
					end
				end

				arg_430_1.text_.text = var_433_2
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011105", "story_v_out_423011.awb") ~= 0 then
					local var_433_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011105", "story_v_out_423011.awb") / 1000

					if var_433_5 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + 0
					end

					if var_433_1.prefab_name ~= "" and arg_430_1.actors_[var_433_1.prefab_name] ~= nil then
						local var_433_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_1.prefab_name].transform, "story_v_out_423011", "423011105", "story_v_out_423011.awb")

						arg_430_1:RecordAudio("423011105", var_433_6)
						arg_430_1:RecordAudio("423011105", var_433_6)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_423011", "423011105", "story_v_out_423011.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_423011", "423011105", "story_v_out_423011.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play423011106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 423011106
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play423011107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.9

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_1 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(423011106).content)

				arg_434_1.text_.text = var_437_1

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_3 = 36 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 36)

				if (36 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 36)) > 0 and var_437_0 < var_437_3 then
					arg_434_1.talkMaxDuration = var_437_3

					if var_437_3 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_3 + 0
					end
				end

				arg_434_1.text_.text = var_437_1
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_4 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_4

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play423011107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 423011107
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play423011108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0.533333333333333 < arg_438_1.time_ and arg_438_1.time_ <= 0.533333333333333 + arg_441_0 then
				arg_438_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_hitdoor", "")
			end

			local var_441_1 = 0
			local var_441_2 = 1.05

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_3 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(423011107).content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 42 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 42)

				if (42 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 42)) > 0 and var_441_2 < var_441_5 then
					arg_438_1.talkMaxDuration = var_441_5

					if var_441_5 + var_441_1 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + var_441_1
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_6 = math.max(var_441_2, arg_438_1.talkMaxDuration)

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_6 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_1) / var_441_6

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_1 + var_441_6 and arg_438_1.time_ < var_441_1 + var_441_6 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play423011108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 423011108
		arg_442_1.duration_ = 14.47

		local var_442_0 = {
			zh = 13.9,
			ja = 14.466
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play423011109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_9000

			if arg_442_1.bgs_.SS2301 == nil then
				local var_445_0 = Object.Instantiate(arg_442_1.paintGo_)

				var_445_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2301")
				var_445_0.name = "SS2301"
				var_445_0.transform.parent = arg_442_1.stage_.transform
				var_445_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.bgs_.SS2301 = var_445_0
			end

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= 2 + arg_445_0 then
				local var_445_1 = arg_442_1.bgs_.SS2301

				arg_442_1.bgs_.SS2301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_445_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_2 = var_445_1:GetComponent("SpriteRenderer")

				if var_445_2 and var_445_2.sprite then
					local var_445_3 = 2 * (var_445_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_445_1.transform.localScale = Vector3.New(var_445_3 / var_445_2.sprite.bounds.size.y < var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x and var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x or var_445_3 / var_445_2.sprite.bounds.size.y, var_445_3 / var_445_2.sprite.bounds.size.y < var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x and var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x or var_445_3 / var_445_2.sprite.bounds.size.y, 0)
				end

				for iter_445_0, iter_445_1 in pairs(arg_442_1.bgs_) do
					if iter_445_0 ~= "SS2301" then
						iter_445_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_445_4 = 4

			if 4 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			if arg_442_1.time_ >= var_445_4 + 0.3 and arg_442_1.time_ < var_445_4 + 0.3 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end

			local var_445_5 = 0

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_5 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_6 = 2

			if var_445_5 <= arg_442_1.time_ and arg_442_1.time_ < var_445_5 + var_445_6 then
				local var_445_7 = Color.New(0, 0, 0)

				var_445_7.a = Mathf.Lerp(0, 1, (arg_442_1.time_ - var_445_5) / var_445_6)
				arg_442_1.mask_.color = var_445_7
			end

			if arg_442_1.time_ >= var_445_5 + var_445_6 and arg_442_1.time_ < var_445_5 + var_445_6 + arg_445_0 then
				local var_445_8 = Color.New(0, 0, 0)

				var_445_8.a = 1
				arg_442_1.mask_.color = var_445_8
			end

			local var_445_9 = 2

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= var_445_9 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_10 = 2

			if var_445_9 <= arg_442_1.time_ and arg_442_1.time_ < var_445_9 + var_445_10 then
				local var_445_11 = Color.New(0, 0, 0)

				var_445_11.a = Mathf.Lerp(1, 0, (arg_442_1.time_ - var_445_9) / var_445_10)
				arg_442_1.mask_.color = var_445_11
			end

			if arg_442_1.time_ >= var_445_9 + var_445_10 and arg_442_1.time_ < var_445_9 + var_445_10 + arg_445_0 then
				local var_445_12 = Color.New(0, 0, 0)

				arg_442_1.mask_.enabled = false
				var_445_12.a = 0
				arg_442_1.mask_.color = var_445_12
			end

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= 2 + arg_445_0 then
				if arg_442_1.var_.effectliechebaozha2 then
					Object.Destroy(arg_442_1.var_.effectliechebaozha2)

					arg_442_1.var_.effectliechebaozha2 = nil
				end
			end

			local var_445_14 = arg_442_1.bgs_.SS2301.transform

			if 1.9 < arg_442_1.time_ and arg_442_1.time_ <= 1.9 + arg_445_0 then
				arg_442_1.var_.moveOldPosSS2301 = var_445_14.localPosition
			end

			local var_445_15 = 0.1

			if 1.9 <= arg_442_1.time_ and arg_442_1.time_ < 1.9 + var_445_15 then
				var_445_14.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPosSS2301, Vector3.New(0, 1, 9.5), (arg_442_1.time_ - 1.9) / var_445_15)
			end

			if arg_442_1.time_ >= 1.9 + var_445_15 and arg_442_1.time_ < 1.9 + var_445_15 + arg_445_0 then
				var_445_14.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_445_16 = arg_442_1.bgs_.SS2301.transform

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= 2 + arg_445_0 then
				arg_442_1.var_.moveOldPosSS2301 = var_445_16.localPosition
			end

			local var_445_17 = 4.5

			if 2 <= arg_442_1.time_ and arg_442_1.time_ < 2 + var_445_17 then
				var_445_16.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPosSS2301, Vector3.New(0, 1, 10), (arg_442_1.time_ - 2) / var_445_17)
			end

			if arg_442_1.time_ >= 2 + var_445_17 and arg_442_1.time_ < 2 + var_445_17 + arg_445_0 then
				var_445_16.localPosition = Vector3.New(0, 1, 10)
			end

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= 2 + arg_445_0 then
				local var_445_18 = arg_442_1.var_.effectcangmendakai

				if not arg_442_1.var_.effectcangmendakai then
					var_445_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_445_18.name = "cangmendakai"
					arg_442_1.var_.effectcangmendakai = var_445_18
				else
					var_445_18.transform:SetParent(var_445_9000)
				end

				var_445_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_445_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.56666666666667 < arg_442_1.time_ and arg_442_1.time_ <= 1.56666666666667 + arg_445_0 then
				arg_442_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			if 0.166666666666667 < arg_442_1.time_ and arg_442_1.time_ <= 0.166666666666667 + arg_445_0 then
				arg_442_1:AudioAction("stop", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			if arg_442_1.frameCnt_ <= 1 then
				arg_442_1.dialog_:SetActive(false)
			end

			local var_445_22 = 4
			local var_445_23 = 0.85

			if 4 < arg_442_1.time_ and arg_442_1.time_ <= var_445_22 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0

				arg_442_1.dialog_:SetActive(true)

				arg_442_1.dialogCg_.alpha = 0

				local var_445_24 = LeanTween.value(arg_442_1.dialog_, 0, 1, 0.3)

				var_445_24:setOnUpdate(LuaHelper.FloatAction(function(arg_446_0)
					arg_442_1.dialogCg_.alpha = arg_446_0
				end))
				var_445_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_442_1.dialog_)
					var_445_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_442_1.duration_ = arg_442_1.duration_ + 0.3

				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_25 = arg_442_1:GetWordFromCfg(423011108)
				local var_445_26 = arg_442_1:FormatText(var_445_25.content)

				arg_442_1.text_.text = var_445_26

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_28 = 34 <= 0 and var_445_23 or var_445_23 * (utf8.len(var_445_26) / 34)

				if (34 <= 0 and var_445_23 or var_445_23 * (utf8.len(var_445_26) / 34)) > 0 and var_445_23 < var_445_28 then
					arg_442_1.talkMaxDuration = var_445_28
					var_445_22 = var_445_22 + 0.3

					if var_445_28 + var_445_22 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_28 + var_445_22
					end
				end

				arg_442_1.text_.text = var_445_26
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011108", "story_v_out_423011.awb") ~= 0 then
					local var_445_29 = manager.audio:GetVoiceLength("story_v_out_423011", "423011108", "story_v_out_423011.awb") / 1000

					if var_445_29 + var_445_22 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_29 + var_445_22
					end

					if var_445_25.prefab_name ~= "" and arg_442_1.actors_[var_445_25.prefab_name] ~= nil then
						local var_445_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_25.prefab_name].transform, "story_v_out_423011", "423011108", "story_v_out_423011.awb")

						arg_442_1:RecordAudio("423011108", var_445_30)
						arg_442_1:RecordAudio("423011108", var_445_30)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_423011", "423011108", "story_v_out_423011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_423011", "423011108", "story_v_out_423011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_31 = var_445_22 + 0.3
			local var_445_32 = math.max(var_445_23, arg_442_1.talkMaxDuration)

			if var_445_22 + 0.3 <= arg_442_1.time_ and arg_442_1.time_ < var_445_31 + var_445_32 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_31) / var_445_32

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_31 + var_445_32 and arg_442_1.time_ < var_445_31 + var_445_32 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play423011109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 423011109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play423011110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0.333333333333333 < arg_448_1.time_ and arg_448_1.time_ <= 0.333333333333333 + arg_451_0 then
				arg_448_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep02", "")
			end

			local var_451_1 = 0
			local var_451_2 = 0.875

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_3 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(423011109).content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 35 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 35)

				if (35 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 35)) > 0 and var_451_2 < var_451_5 then
					arg_448_1.talkMaxDuration = var_451_5

					if var_451_5 + var_451_1 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + var_451_1
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_6 = math.max(var_451_2, arg_448_1.talkMaxDuration)

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_6 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_1) / var_451_6

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_1 + var_451_6 and arg_448_1.time_ < var_451_1 + var_451_6 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play423011110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 423011110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play423011111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.9

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_1 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(423011110).content)

				arg_452_1.text_.text = var_455_1

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_3 = 36 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 36)

				if (36 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 36)) > 0 and var_455_0 < var_455_3 then
					arg_452_1.talkMaxDuration = var_455_3

					if var_455_3 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_3 + 0
					end
				end

				arg_452_1.text_.text = var_455_1
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_4 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_4

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play423011111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 423011111
		arg_456_1.duration_ = 7.43

		local var_456_0 = {
			zh = 5.366,
			ja = 7.433
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play423011112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.55

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_1 = arg_456_1:GetWordFromCfg(423011111)
				local var_459_2 = arg_456_1:FormatText(var_459_1.content)

				arg_456_1.text_.text = var_459_2

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_4 = 22 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 22)

				if (22 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 22)) > 0 and var_459_0 < var_459_4 then
					arg_456_1.talkMaxDuration = var_459_4

					if var_459_4 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_4 + 0
					end
				end

				arg_456_1.text_.text = var_459_2
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011111", "story_v_out_423011.awb") ~= 0 then
					local var_459_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011111", "story_v_out_423011.awb") / 1000

					if var_459_5 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + 0
					end

					if var_459_1.prefab_name ~= "" and arg_456_1.actors_[var_459_1.prefab_name] ~= nil then
						local var_459_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_1.prefab_name].transform, "story_v_out_423011", "423011111", "story_v_out_423011.awb")

						arg_456_1:RecordAudio("423011111", var_459_6)
						arg_456_1:RecordAudio("423011111", var_459_6)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_423011", "423011111", "story_v_out_423011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_423011", "423011111", "story_v_out_423011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_7 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_7

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play423011112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 423011112
		arg_460_1.duration_ = 9.83

		local var_460_0 = {
			zh = 9.266,
			ja = 9.833
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play423011113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 1.05

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_1 = arg_460_1:GetWordFromCfg(423011112)
				local var_463_2 = arg_460_1:FormatText(var_463_1.content)

				arg_460_1.text_.text = var_463_2

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_4 = 42 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_2) / 42)

				if (42 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_2) / 42)) > 0 and var_463_0 < var_463_4 then
					arg_460_1.talkMaxDuration = var_463_4

					if var_463_4 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_4 + 0
					end
				end

				arg_460_1.text_.text = var_463_2
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011112", "story_v_out_423011.awb") ~= 0 then
					local var_463_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011112", "story_v_out_423011.awb") / 1000

					if var_463_5 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + 0
					end

					if var_463_1.prefab_name ~= "" and arg_460_1.actors_[var_463_1.prefab_name] ~= nil then
						local var_463_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_1.prefab_name].transform, "story_v_out_423011", "423011112", "story_v_out_423011.awb")

						arg_460_1:RecordAudio("423011112", var_463_6)
						arg_460_1:RecordAudio("423011112", var_463_6)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_423011", "423011112", "story_v_out_423011.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_423011", "423011112", "story_v_out_423011.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_7 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_7 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_7

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_7 and arg_460_1.time_ < 0 + var_463_7 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play423011113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 423011113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play423011114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 1.425

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_1 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(423011113).content)

				arg_464_1.text_.text = var_467_1

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_3 = 57 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_1) / 57)

				if (57 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_1) / 57)) > 0 and var_467_0 < var_467_3 then
					arg_464_1.talkMaxDuration = var_467_3

					if var_467_3 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_3 + 0
					end
				end

				arg_464_1.text_.text = var_467_1
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_4 = math.max(var_467_0, arg_464_1.talkMaxDuration)

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - 0) / var_467_4

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play423011114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 423011114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play423011115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 1.4

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(423011114).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 56 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 56)

				if (56 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 56)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play423011115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 423011115
		arg_472_1.duration_ = 11.07

		local var_472_0 = {
			zh = 9.43333333333333,
			ja = 11.0663333333333
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play423011116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_9000

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				local var_475_0 = arg_472_1.var_.effecttanmaozi1

				if not arg_472_1.var_.effecttanmaozi1 then
					var_475_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_475_0.name = "tanmaozi1"
					arg_472_1.var_.effecttanmaozi1 = var_475_0
				else
					var_475_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_475_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_475_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_472_1.time_ and arg_472_1.time_ <= 1.2 + arg_475_0 then
				local var_475_2 = arg_472_1.var_.effecttanmaozi2

				if not arg_472_1.var_.effecttanmaozi2 then
					var_475_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_475_2.name = "tanmaozi2"
					arg_472_1.var_.effecttanmaozi2 = var_475_2
				else
					var_475_2.transform:SetParent(var_475_9000)
				end

				var_475_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_475_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_472_1.time_ and arg_472_1.time_ <= 1.2 + arg_475_0 then
				if arg_472_1.var_.effecttanmaozi1 then
					Object.Destroy(arg_472_1.var_.effecttanmaozi1)

					arg_472_1.var_.effecttanmaozi1 = nil
				end
			end

			local var_475_5 = arg_472_1.bgs_.SS2301.transform

			if 1.18333333333333 < arg_472_1.time_ and arg_472_1.time_ <= 1.18333333333333 + arg_475_0 then
				arg_472_1.var_.moveOldPosSS2301 = var_475_5.localPosition
			end

			local var_475_6 = 0.001

			if 1.18333333333333 <= arg_472_1.time_ and arg_472_1.time_ < 1.18333333333333 + var_475_6 then
				var_475_5.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPosSS2301, Vector3.New(0, 0, 4.5), (arg_472_1.time_ - 1.18333333333333) / var_475_6)
			end

			if arg_472_1.time_ >= 1.18333333333333 + var_475_6 and arg_472_1.time_ < 1.18333333333333 + var_475_6 + arg_475_0 then
				var_475_5.localPosition = Vector3.New(0, 0, 4.5)
			end

			local var_475_7 = arg_472_1.bgs_.SS2301.transform

			if 1.2 < arg_472_1.time_ and arg_472_1.time_ <= 1.2 + arg_475_0 then
				arg_472_1.var_.moveOldPosSS2301 = var_475_7.localPosition
			end

			local var_475_8 = 5

			if 1.2 <= arg_472_1.time_ and arg_472_1.time_ < 1.2 + var_475_8 then
				var_475_7.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPosSS2301, Vector3.New(0, 0, 5), (arg_472_1.time_ - 1.2) / var_475_8)
			end

			if arg_472_1.time_ >= 1.2 + var_475_8 and arg_472_1.time_ < 1.2 + var_475_8 + arg_475_0 then
				var_475_7.localPosition = Vector3.New(0, 0, 5)
			end

			local var_475_9 = 2.23333333333333

			if 2.23333333333333 < arg_472_1.time_ and arg_472_1.time_ <= var_475_9 + arg_475_0 then
				arg_472_1.allBtn_.enabled = false
			end

			if arg_472_1.time_ >= var_475_9 + 1.5 and arg_472_1.time_ < var_475_9 + 1.5 + arg_475_0 then
				arg_472_1.allBtn_.enabled = true
			end

			if arg_472_1.frameCnt_ <= 1 then
				arg_472_1.dialog_:SetActive(false)
			end

			local var_475_10 = 2.23333333333333
			local var_475_11 = 0.675

			if 2.23333333333333 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0

				arg_472_1.dialog_:SetActive(true)

				arg_472_1.dialogCg_.alpha = 0

				local var_475_12 = LeanTween.value(arg_472_1.dialog_, 0, 1, 0.3)

				var_475_12:setOnUpdate(LuaHelper.FloatAction(function(arg_476_0)
					arg_472_1.dialogCg_.alpha = arg_476_0
				end))
				var_475_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_472_1.dialog_)
					var_475_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_472_1.duration_ = arg_472_1.duration_ + 0.3

				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_13 = arg_472_1:GetWordFromCfg(423011115)
				local var_475_14 = arg_472_1:FormatText(var_475_13.content)

				arg_472_1.text_.text = var_475_14

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_16 = 27 <= 0 and var_475_11 or var_475_11 * (utf8.len(var_475_14) / 27)

				if (27 <= 0 and var_475_11 or var_475_11 * (utf8.len(var_475_14) / 27)) > 0 and var_475_11 < var_475_16 then
					arg_472_1.talkMaxDuration = var_475_16
					var_475_10 = var_475_10 + 0.3

					if var_475_16 + var_475_10 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_16 + var_475_10
					end
				end

				arg_472_1.text_.text = var_475_14
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011115", "story_v_out_423011.awb") ~= 0 then
					local var_475_17 = manager.audio:GetVoiceLength("story_v_out_423011", "423011115", "story_v_out_423011.awb") / 1000

					if var_475_17 + var_475_10 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_17 + var_475_10
					end

					if var_475_13.prefab_name ~= "" and arg_472_1.actors_[var_475_13.prefab_name] ~= nil then
						local var_475_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_13.prefab_name].transform, "story_v_out_423011", "423011115", "story_v_out_423011.awb")

						arg_472_1:RecordAudio("423011115", var_475_18)
						arg_472_1:RecordAudio("423011115", var_475_18)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_423011", "423011115", "story_v_out_423011.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_423011", "423011115", "story_v_out_423011.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_19 = var_475_10 + 0.3
			local var_475_20 = math.max(var_475_11, arg_472_1.talkMaxDuration)

			if var_475_10 + 0.3 <= arg_472_1.time_ and arg_472_1.time_ < var_475_19 + var_475_20 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_19) / var_475_20

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_19 + var_475_20 and arg_472_1.time_ < var_475_19 + var_475_20 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.18333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play423011116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 423011116
		arg_478_1.duration_ = 8.9

		local var_478_0 = {
			zh = 8.9,
			ja = 7.633
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play423011117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 1.025

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:GetWordFromCfg(423011116)
				local var_481_2 = arg_478_1:FormatText(var_481_1.content)

				arg_478_1.text_.text = var_481_2

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 41 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 41)

				if (41 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 41)) > 0 and var_481_0 < var_481_4 then
					arg_478_1.talkMaxDuration = var_481_4

					if var_481_4 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_4 + 0
					end
				end

				arg_478_1.text_.text = var_481_2
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011116", "story_v_out_423011.awb") ~= 0 then
					local var_481_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011116", "story_v_out_423011.awb") / 1000

					if var_481_5 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + 0
					end

					if var_481_1.prefab_name ~= "" and arg_478_1.actors_[var_481_1.prefab_name] ~= nil then
						local var_481_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_1.prefab_name].transform, "story_v_out_423011", "423011116", "story_v_out_423011.awb")

						arg_478_1:RecordAudio("423011116", var_481_6)
						arg_478_1:RecordAudio("423011116", var_481_6)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_423011", "423011116", "story_v_out_423011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_423011", "423011116", "story_v_out_423011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_7 and arg_478_1.time_ < 0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play423011117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 423011117
		arg_482_1.duration_ = 12.3

		local var_482_0 = {
			zh = 10.466,
			ja = 12.3
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play423011118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.8

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:GetWordFromCfg(423011117)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 32 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 32)

				if (32 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 32)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011117", "story_v_out_423011.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011117", "story_v_out_423011.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_out_423011", "423011117", "story_v_out_423011.awb")

						arg_482_1:RecordAudio("423011117", var_485_6)
						arg_482_1:RecordAudio("423011117", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_423011", "423011117", "story_v_out_423011.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_423011", "423011117", "story_v_out_423011.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play423011118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 423011118
		arg_486_1.duration_ = 3.07

		local var_486_0 = {
			zh = 2.7,
			ja = 3.066
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play423011119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.175

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_1 = arg_486_1:GetWordFromCfg(423011118)
				local var_489_2 = arg_486_1:FormatText(var_489_1.content)

				arg_486_1.text_.text = var_489_2

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 7 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 7)

				if (7 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 7)) > 0 and var_489_0 < var_489_4 then
					arg_486_1.talkMaxDuration = var_489_4

					if var_489_4 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_4 + 0
					end
				end

				arg_486_1.text_.text = var_489_2
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011118", "story_v_out_423011.awb") ~= 0 then
					local var_489_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011118", "story_v_out_423011.awb") / 1000

					if var_489_5 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + 0
					end

					if var_489_1.prefab_name ~= "" and arg_486_1.actors_[var_489_1.prefab_name] ~= nil then
						local var_489_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_1.prefab_name].transform, "story_v_out_423011", "423011118", "story_v_out_423011.awb")

						arg_486_1:RecordAudio("423011118", var_489_6)
						arg_486_1:RecordAudio("423011118", var_489_6)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_423011", "423011118", "story_v_out_423011.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_423011", "423011118", "story_v_out_423011.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_7 and arg_486_1.time_ < 0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play423011119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 423011119
		arg_490_1.duration_ = 3.9

		local var_490_0 = {
			zh = 2.166,
			ja = 3.9
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play423011120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0.4

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_1 = arg_490_1:GetWordFromCfg(423011119)
				local var_493_2 = arg_490_1:FormatText(var_493_1.content)

				arg_490_1.text_.text = var_493_2

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_4 = 16 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 16)

				if (16 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 16)) > 0 and var_493_0 < var_493_4 then
					arg_490_1.talkMaxDuration = var_493_4

					if var_493_4 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_4 + 0
					end
				end

				arg_490_1.text_.text = var_493_2
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011119", "story_v_out_423011.awb") ~= 0 then
					local var_493_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011119", "story_v_out_423011.awb") / 1000

					if var_493_5 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + 0
					end

					if var_493_1.prefab_name ~= "" and arg_490_1.actors_[var_493_1.prefab_name] ~= nil then
						local var_493_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_1.prefab_name].transform, "story_v_out_423011", "423011119", "story_v_out_423011.awb")

						arg_490_1:RecordAudio("423011119", var_493_6)
						arg_490_1:RecordAudio("423011119", var_493_6)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_423011", "423011119", "story_v_out_423011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_423011", "423011119", "story_v_out_423011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_7 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_7

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play423011120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 423011120
		arg_494_1.duration_ = 9

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play423011121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if arg_494_1.bgs_.SS2301a == nil then
				local var_497_0 = Object.Instantiate(arg_494_1.paintGo_)

				var_497_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2301a")
				var_497_0.name = "SS2301a"
				var_497_0.transform.parent = arg_494_1.stage_.transform
				var_497_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_494_1.bgs_.SS2301a = var_497_0
			end

			if 2 < arg_494_1.time_ and arg_494_1.time_ <= 2 + arg_497_0 then
				local var_497_1 = arg_494_1.bgs_.SS2301a

				arg_494_1.bgs_.SS2301a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_497_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_497_2 = var_497_1:GetComponent("SpriteRenderer")

				if var_497_2 and var_497_2.sprite then
					local var_497_3 = 2 * (var_497_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_497_1.transform.localScale = Vector3.New(var_497_3 / var_497_2.sprite.bounds.size.y < var_497_3 * manager.ui.mainCameraCom_.aspect / var_497_2.sprite.bounds.size.x and var_497_3 * manager.ui.mainCameraCom_.aspect / var_497_2.sprite.bounds.size.x or var_497_3 / var_497_2.sprite.bounds.size.y, var_497_3 / var_497_2.sprite.bounds.size.y < var_497_3 * manager.ui.mainCameraCom_.aspect / var_497_2.sprite.bounds.size.x and var_497_3 * manager.ui.mainCameraCom_.aspect / var_497_2.sprite.bounds.size.x or var_497_3 / var_497_2.sprite.bounds.size.y, 0)
				end

				for iter_497_0, iter_497_1 in pairs(arg_494_1.bgs_) do
					if iter_497_0 ~= "SS2301a" then
						iter_497_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_497_4 = 4

			if 4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			if arg_494_1.time_ >= var_497_4 + 0.3 and arg_494_1.time_ < var_497_4 + 0.3 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			local var_497_5 = 0

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_5 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_6 = 2

			if var_497_5 <= arg_494_1.time_ and arg_494_1.time_ < var_497_5 + var_497_6 then
				local var_497_7 = Color.New(0, 0, 0)

				var_497_7.a = Mathf.Lerp(0, 1, (arg_494_1.time_ - var_497_5) / var_497_6)
				arg_494_1.mask_.color = var_497_7
			end

			if arg_494_1.time_ >= var_497_5 + var_497_6 and arg_494_1.time_ < var_497_5 + var_497_6 + arg_497_0 then
				local var_497_8 = Color.New(0, 0, 0)

				var_497_8.a = 1
				arg_494_1.mask_.color = var_497_8
			end

			local var_497_9 = 2

			if 2 < arg_494_1.time_ and arg_494_1.time_ <= var_497_9 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_10 = 2

			if var_497_9 <= arg_494_1.time_ and arg_494_1.time_ < var_497_9 + var_497_10 then
				local var_497_11 = Color.New(0, 0, 0)

				var_497_11.a = Mathf.Lerp(1, 0, (arg_494_1.time_ - var_497_9) / var_497_10)
				arg_494_1.mask_.color = var_497_11
			end

			if arg_494_1.time_ >= var_497_9 + var_497_10 and arg_494_1.time_ < var_497_9 + var_497_10 + arg_497_0 then
				local var_497_12 = Color.New(0, 0, 0)

				arg_494_1.mask_.enabled = false
				var_497_12.a = 0
				arg_494_1.mask_.color = var_497_12
			end

			if arg_494_1.frameCnt_ <= 1 then
				arg_494_1.dialog_:SetActive(false)
			end

			local var_497_13 = 4
			local var_497_14 = 1.075

			if 4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_13 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0

				arg_494_1.dialog_:SetActive(true)

				arg_494_1.dialogCg_.alpha = 0

				local var_497_15 = LeanTween.value(arg_494_1.dialog_, 0, 1, 0.3)

				var_497_15:setOnUpdate(LuaHelper.FloatAction(function(arg_498_0)
					arg_494_1.dialogCg_.alpha = arg_498_0
				end))
				var_497_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_494_1.dialog_)
					var_497_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_494_1.duration_ = arg_494_1.duration_ + 0.3

				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_16 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(423011120).content)

				arg_494_1.text_.text = var_497_16

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_18 = 43 <= 0 and var_497_14 or var_497_14 * (utf8.len(var_497_16) / 43)

				if (43 <= 0 and var_497_14 or var_497_14 * (utf8.len(var_497_16) / 43)) > 0 and var_497_14 < var_497_18 then
					arg_494_1.talkMaxDuration = var_497_18
					var_497_13 = var_497_13 + 0.3

					if var_497_18 + var_497_13 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_18 + var_497_13
					end
				end

				arg_494_1.text_.text = var_497_16
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_19 = var_497_13 + 0.3
			local var_497_20 = math.max(var_497_14, arg_494_1.talkMaxDuration)

			if var_497_13 + 0.3 <= arg_494_1.time_ and arg_494_1.time_ < var_497_19 + var_497_20 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_19) / var_497_20

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_19 + var_497_20 and arg_494_1.time_ < var_497_19 + var_497_20 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play423011121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 423011121
		arg_500_1.duration_ = 7.73

		local var_500_0 = {
			zh = 5.7,
			ja = 7.733
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play423011122(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.675

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_1 = arg_500_1:GetWordFromCfg(423011121)
				local var_503_2 = arg_500_1:FormatText(var_503_1.content)

				arg_500_1.text_.text = var_503_2

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 27 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_2) / 27)

				if (27 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_2) / 27)) > 0 and var_503_0 < var_503_4 then
					arg_500_1.talkMaxDuration = var_503_4

					if var_503_4 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_4 + 0
					end
				end

				arg_500_1.text_.text = var_503_2
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011121", "story_v_out_423011.awb") ~= 0 then
					local var_503_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011121", "story_v_out_423011.awb") / 1000

					if var_503_5 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_5 + 0
					end

					if var_503_1.prefab_name ~= "" and arg_500_1.actors_[var_503_1.prefab_name] ~= nil then
						local var_503_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_1.prefab_name].transform, "story_v_out_423011", "423011121", "story_v_out_423011.awb")

						arg_500_1:RecordAudio("423011121", var_503_6)
						arg_500_1:RecordAudio("423011121", var_503_6)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_423011", "423011121", "story_v_out_423011.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_423011", "423011121", "story_v_out_423011.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_7 and arg_500_1.time_ < 0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play423011122 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 423011122
		arg_504_1.duration_ = 6.8

		local var_504_0 = {
			zh = 5.8,
			ja = 6.8
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play423011123(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0.6

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_1 = arg_504_1:GetWordFromCfg(423011122)
				local var_507_2 = arg_504_1:FormatText(var_507_1.content)

				arg_504_1.text_.text = var_507_2

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 24 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_2) / 24)

				if (24 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_2) / 24)) > 0 and var_507_0 < var_507_4 then
					arg_504_1.talkMaxDuration = var_507_4

					if var_507_4 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_4 + 0
					end
				end

				arg_504_1.text_.text = var_507_2
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011122", "story_v_out_423011.awb") ~= 0 then
					local var_507_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011122", "story_v_out_423011.awb") / 1000

					if var_507_5 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + 0
					end

					if var_507_1.prefab_name ~= "" and arg_504_1.actors_[var_507_1.prefab_name] ~= nil then
						local var_507_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_1.prefab_name].transform, "story_v_out_423011", "423011122", "story_v_out_423011.awb")

						arg_504_1:RecordAudio("423011122", var_507_6)
						arg_504_1:RecordAudio("423011122", var_507_6)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_423011", "423011122", "story_v_out_423011.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_423011", "423011122", "story_v_out_423011.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_7 and arg_504_1.time_ < 0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play423011123 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 423011123
		arg_508_1.duration_ = 2.3

		local var_508_0 = {
			zh = 2.166,
			ja = 2.3
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play423011124(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0.175

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_1 = arg_508_1:GetWordFromCfg(423011123)
				local var_511_2 = arg_508_1:FormatText(var_511_1.content)

				arg_508_1.text_.text = var_511_2

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_4 = 7 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_2) / 7)

				if (7 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_2) / 7)) > 0 and var_511_0 < var_511_4 then
					arg_508_1.talkMaxDuration = var_511_4

					if var_511_4 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_4 + 0
					end
				end

				arg_508_1.text_.text = var_511_2
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011123", "story_v_out_423011.awb") ~= 0 then
					local var_511_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011123", "story_v_out_423011.awb") / 1000

					if var_511_5 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_5 + 0
					end

					if var_511_1.prefab_name ~= "" and arg_508_1.actors_[var_511_1.prefab_name] ~= nil then
						local var_511_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_1.prefab_name].transform, "story_v_out_423011", "423011123", "story_v_out_423011.awb")

						arg_508_1:RecordAudio("423011123", var_511_6)
						arg_508_1:RecordAudio("423011123", var_511_6)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_423011", "423011123", "story_v_out_423011.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_423011", "423011123", "story_v_out_423011.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_7 = math.max(var_511_0, arg_508_1.talkMaxDuration)

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_7 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - 0) / var_511_7

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= 0 + var_511_7 and arg_508_1.time_ < 0 + var_511_7 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play423011124 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 423011124
		arg_512_1.duration_ = 2.6

		local var_512_0 = {
			zh = 2.6,
			ja = 2.333
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play423011125(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_9000

			if 0.866666666666667 < arg_512_1.time_ and arg_512_1.time_ <= 0.866666666666667 + arg_515_0 then
				local var_515_0 = arg_512_1.var_.effectaishizhenjing1

				if not arg_512_1.var_.effectaishizhenjing1 then
					var_515_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_515_0.name = "aishizhenjing1"
					arg_512_1.var_.effectaishizhenjing1 = var_515_0
				else
					var_515_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_515_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_515_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.86666666666667 < arg_512_1.time_ and arg_512_1.time_ <= 1.86666666666667 + arg_515_0 then
				if arg_512_1.var_.effectaishizhenjing1 then
					Object.Destroy(arg_512_1.var_.effectaishizhenjing1)

					arg_512_1.var_.effectaishizhenjing1 = nil
				end
			end

			if 0.233333333333334 < arg_512_1.time_ and arg_512_1.time_ <= 0.233333333333334 + arg_515_0 then
				local var_515_3 = arg_512_1.var_.effectaishizhenjing2

				if not arg_512_1.var_.effectaishizhenjing2 then
					var_515_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_moviemask"), manager.ui.mainCamera.transform)
					var_515_3.name = "aishizhenjing2"
					arg_512_1.var_.effectaishizhenjing2 = var_515_3
				else
					var_515_3.transform:SetParent(var_515_9000)
				end

				var_515_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_515_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_515_5 = arg_512_1.bgs_.SS2301a.transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPosSS2301a = var_515_5.localPosition
			end

			local var_515_6 = 1.3

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_6 then
				var_515_5.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPosSS2301a, Vector3.New(0, -1.2, 0), (arg_512_1.time_ - 0) / var_515_6)
			end

			if arg_512_1.time_ >= 0 + var_515_6 and arg_512_1.time_ < 0 + var_515_6 + arg_515_0 then
				var_515_5.localPosition = Vector3.New(0, -1.2, 0)
			end

			local var_515_7 = manager.ui.mainCamera.transform

			if 0.866666666666667 < arg_512_1.time_ and arg_512_1.time_ <= 0.866666666666667 + arg_515_0 then
				arg_512_1.var_.shakeOldPos = var_515_7.localPosition
			end

			local var_515_8 = 0.6

			if 0.866666666666667 <= arg_512_1.time_ and arg_512_1.time_ < 0.866666666666667 + var_515_8 then
				local var_515_9, var_515_10 = math.modf((arg_512_1.time_ - 0.866666666666667) / 0.066)

				var_515_7.localPosition = Vector3.New(var_515_10 * 0.13, var_515_10 * 0.13, var_515_10 * 0.13) + arg_512_1.var_.shakeOldPos
			end

			if arg_512_1.time_ >= 0.866666666666667 + var_515_8 and arg_512_1.time_ < 0.866666666666667 + var_515_8 + arg_515_0 then
				var_515_7.localPosition = arg_512_1.var_.shakeOldPos
			end

			if 0.866666666666667 < arg_512_1.time_ and arg_512_1.time_ <= 0.866666666666667 + arg_515_0 then
				arg_512_1:AudioAction("play", "effect", "se_story_144", "se_story_144_thunder02", "")
			end

			if arg_512_1.frameCnt_ <= 1 then
				arg_512_1.dialog_:SetActive(false)
			end

			local var_515_12 = 1
			local var_515_13 = 0.125

			if 1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_12 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0

				arg_512_1.dialog_:SetActive(true)

				arg_512_1.dialogCg_.alpha = 0

				local var_515_14 = LeanTween.value(arg_512_1.dialog_, 0, 1, 0.3)

				var_515_14:setOnUpdate(LuaHelper.FloatAction(function(arg_516_0)
					arg_512_1.dialogCg_.alpha = arg_516_0
				end))
				var_515_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_512_1.dialog_)
					var_515_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_512_1.duration_ = arg_512_1.duration_ + 0.3

				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_15 = arg_512_1:GetWordFromCfg(423011124)
				local var_515_16 = arg_512_1:FormatText(var_515_15.content)

				arg_512_1.text_.text = var_515_16

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_18 = 5 <= 0 and var_515_13 or var_515_13 * (utf8.len(var_515_16) / 5)

				if (5 <= 0 and var_515_13 or var_515_13 * (utf8.len(var_515_16) / 5)) > 0 and var_515_13 < var_515_18 then
					arg_512_1.talkMaxDuration = var_515_18
					var_515_12 = var_515_12 + 0.3

					if var_515_18 + var_515_12 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_18 + var_515_12
					end
				end

				arg_512_1.text_.text = var_515_16
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011124", "story_v_out_423011.awb") ~= 0 then
					local var_515_19 = manager.audio:GetVoiceLength("story_v_out_423011", "423011124", "story_v_out_423011.awb") / 1000

					if var_515_19 + var_515_12 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_19 + var_515_12
					end

					if var_515_15.prefab_name ~= "" and arg_512_1.actors_[var_515_15.prefab_name] ~= nil then
						local var_515_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_15.prefab_name].transform, "story_v_out_423011", "423011124", "story_v_out_423011.awb")

						arg_512_1:RecordAudio("423011124", var_515_20)
						arg_512_1:RecordAudio("423011124", var_515_20)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_423011", "423011124", "story_v_out_423011.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_423011", "423011124", "story_v_out_423011.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_21 = var_515_12 + 0.3
			local var_515_22 = math.max(var_515_13, arg_512_1.talkMaxDuration)

			if var_515_12 + 0.3 <= arg_512_1.time_ and arg_512_1.time_ < var_515_21 + var_515_22 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_21) / var_515_22

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_21 + var_515_22 and arg_512_1.time_ < var_515_21 + var_515_22 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2301a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, -1.2, 0),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play423011125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 423011125
		arg_518_1.duration_ = 4.5

		local var_518_0 = {
			zh = 2.466,
			ja = 4.5
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play423011126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0.275

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_1 = arg_518_1:GetWordFromCfg(423011125)
				local var_521_2 = arg_518_1:FormatText(var_521_1.content)

				arg_518_1.text_.text = var_521_2

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_4 = 11 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_2) / 11)

				if (11 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_2) / 11)) > 0 and var_521_0 < var_521_4 then
					arg_518_1.talkMaxDuration = var_521_4

					if var_521_4 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_4 + 0
					end
				end

				arg_518_1.text_.text = var_521_2
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011125", "story_v_out_423011.awb") ~= 0 then
					local var_521_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011125", "story_v_out_423011.awb") / 1000

					if var_521_5 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + 0
					end

					if var_521_1.prefab_name ~= "" and arg_518_1.actors_[var_521_1.prefab_name] ~= nil then
						local var_521_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_1.prefab_name].transform, "story_v_out_423011", "423011125", "story_v_out_423011.awb")

						arg_518_1:RecordAudio("423011125", var_521_6)
						arg_518_1:RecordAudio("423011125", var_521_6)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_423011", "423011125", "story_v_out_423011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_423011", "423011125", "story_v_out_423011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_7 = math.max(var_521_0, arg_518_1.talkMaxDuration)

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_7 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - 0) / var_521_7

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= 0 + var_521_7 and arg_518_1.time_ < 0 + var_521_7 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play423011126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 423011126
		arg_522_1.duration_ = 9

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play423011127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 2 < arg_522_1.time_ and arg_522_1.time_ <= 2 + arg_525_0 then
				local var_525_0 = arg_522_1.bgs_.ST0111

				arg_522_1.bgs_.ST0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_525_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_1 = var_525_0:GetComponent("SpriteRenderer")

				if var_525_1 and var_525_1.sprite then
					local var_525_2 = 2 * (var_525_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_525_0.transform.localScale = Vector3.New(var_525_2 / var_525_1.sprite.bounds.size.y < var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x and var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x or var_525_2 / var_525_1.sprite.bounds.size.y, var_525_2 / var_525_1.sprite.bounds.size.y < var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x and var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x or var_525_2 / var_525_1.sprite.bounds.size.y, 0)
				end

				for iter_525_0, iter_525_1 in pairs(arg_522_1.bgs_) do
					if iter_525_0 ~= "ST0111" then
						iter_525_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_525_3 = 4

			if 4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_3 + arg_525_0 then
				arg_522_1.allBtn_.enabled = false
			end

			if arg_522_1.time_ >= var_525_3 + 0.3 and arg_522_1.time_ < var_525_3 + 0.3 + arg_525_0 then
				arg_522_1.allBtn_.enabled = true
			end

			local var_525_4 = 0

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_5 = 2

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_5 then
				local var_525_6 = Color.New(0, 0, 0)

				var_525_6.a = Mathf.Lerp(0, 1, (arg_522_1.time_ - var_525_4) / var_525_5)
				arg_522_1.mask_.color = var_525_6
			end

			if arg_522_1.time_ >= var_525_4 + var_525_5 and arg_522_1.time_ < var_525_4 + var_525_5 + arg_525_0 then
				local var_525_7 = Color.New(0, 0, 0)

				var_525_7.a = 1
				arg_522_1.mask_.color = var_525_7
			end

			local var_525_8 = 2

			if 2 < arg_522_1.time_ and arg_522_1.time_ <= var_525_8 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_9 = 2

			if var_525_8 <= arg_522_1.time_ and arg_522_1.time_ < var_525_8 + var_525_9 then
				local var_525_10 = Color.New(0, 0, 0)

				var_525_10.a = Mathf.Lerp(1, 0, (arg_522_1.time_ - var_525_8) / var_525_9)
				arg_522_1.mask_.color = var_525_10
			end

			if arg_522_1.time_ >= var_525_8 + var_525_9 and arg_522_1.time_ < var_525_8 + var_525_9 + arg_525_0 then
				local var_525_11 = Color.New(0, 0, 0)

				arg_522_1.mask_.enabled = false
				var_525_11.a = 0
				arg_522_1.mask_.color = var_525_11
			end

			if 2 < arg_522_1.time_ and arg_522_1.time_ <= 2 + arg_525_0 then
				if arg_522_1.var_.effectaishizhenjing2 then
					Object.Destroy(arg_522_1.var_.effectaishizhenjing2)

					arg_522_1.var_.effectaishizhenjing2 = nil
				end
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_13 = 4
			local var_525_14 = 1.325

			if 4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_13 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_15 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_15:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_16 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(423011126).content)

				arg_522_1.text_.text = var_525_16

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_18 = 53 <= 0 and var_525_14 or var_525_14 * (utf8.len(var_525_16) / 53)

				if (53 <= 0 and var_525_14 or var_525_14 * (utf8.len(var_525_16) / 53)) > 0 and var_525_14 < var_525_18 then
					arg_522_1.talkMaxDuration = var_525_18
					var_525_13 = var_525_13 + 0.3

					if var_525_18 + var_525_13 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_18 + var_525_13
					end
				end

				arg_522_1.text_.text = var_525_16
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_19 = var_525_13 + 0.3
			local var_525_20 = math.max(var_525_14, arg_522_1.talkMaxDuration)

			if var_525_13 + 0.3 <= arg_522_1.time_ and arg_522_1.time_ < var_525_19 + var_525_20 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_19) / var_525_20

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_19 + var_525_20 and arg_522_1.time_ < var_525_19 + var_525_20 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play423011127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 423011127
		arg_528_1.duration_ = 8.57

		local var_528_0 = {
			zh = 8.566,
			ja = 8.5
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play423011128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(arg_528_1.actors_["1083"]) and arg_528_1.var_.actorSpriteComps1083 == nil then
				arg_528_1.var_.actorSpriteComps1083 = arg_528_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_531_0 = 0.2

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_0 and not isNil(arg_528_1.actors_["1083"]) then
				if arg_528_1.var_.actorSpriteComps1083 then
					for iter_531_0, iter_531_1 in pairs(arg_528_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_531_1 then
							if arg_528_1.isInRecall_ then
								iter_531_1.color = Color.New(Mathf.Lerp(iter_531_1.color.r, arg_528_1.hightColor1.r, (arg_528_1.time_ - 0) / var_531_0), Mathf.Lerp(iter_531_1.color.g, arg_528_1.hightColor1.g, (arg_528_1.time_ - 0) / var_531_0), (Mathf.Lerp(iter_531_1.color.b, arg_528_1.hightColor1.b, (arg_528_1.time_ - 0) / var_531_0)))
							else
								local var_531_1 = Mathf.Lerp(iter_531_1.color.r, 1, (arg_528_1.time_ - 0) / var_531_0)

								iter_531_1.color = Color.New(var_531_1, var_531_1, var_531_1)
							end
						end
					end
				end
			end

			if arg_528_1.time_ >= 0 + var_531_0 and arg_528_1.time_ < 0 + var_531_0 + arg_531_0 and not isNil(arg_528_1.actors_["1083"]) and arg_528_1.var_.actorSpriteComps1083 then
				for iter_531_2, iter_531_3 in pairs(arg_528_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_531_3 then
						iter_531_3.color = arg_528_1.isInRecall_ and (arg_528_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_528_1.var_.actorSpriteComps1083 = nil
			end

			local var_531_2 = arg_528_1.actors_["1083"].transform

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.var_.moveOldPos1083 = var_531_2.localPosition
				var_531_2.localScale = Vector3.New(1, 1, 1)

				arg_528_1:CheckSpriteTmpPos("1083", 3)

				for iter_531_4 = 0, var_531_2.childCount - 1 do
					local var_531_3 = var_531_2:GetChild(iter_531_4)

					if var_531_3.name == "split_3" or not string.find(var_531_3.name, "split") then
						var_531_3.gameObject:SetActive(true)
					else
						var_531_3.gameObject:SetActive(false)
					end
				end
			end

			local var_531_4 = 0.001

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				var_531_2.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_528_1.time_ - 0) / var_531_4)
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				var_531_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_531_5 = 0
			local var_531_6 = 0.775

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_5 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_7 = arg_528_1:GetWordFromCfg(423011127)
				local var_531_8 = arg_528_1:FormatText(var_531_7.content)

				arg_528_1.text_.text = var_531_8

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_10 = 31 <= 0 and var_531_6 or var_531_6 * (utf8.len(var_531_8) / 31)

				if (31 <= 0 and var_531_6 or var_531_6 * (utf8.len(var_531_8) / 31)) > 0 and var_531_6 < var_531_10 then
					arg_528_1.talkMaxDuration = var_531_10

					if var_531_10 + var_531_5 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_10 + var_531_5
					end
				end

				arg_528_1.text_.text = var_531_8
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011127", "story_v_out_423011.awb") ~= 0 then
					local var_531_11 = manager.audio:GetVoiceLength("story_v_out_423011", "423011127", "story_v_out_423011.awb") / 1000

					if var_531_11 + var_531_5 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_11 + var_531_5
					end

					if var_531_7.prefab_name ~= "" and arg_528_1.actors_[var_531_7.prefab_name] ~= nil then
						local var_531_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_7.prefab_name].transform, "story_v_out_423011", "423011127", "story_v_out_423011.awb")

						arg_528_1:RecordAudio("423011127", var_531_12)
						arg_528_1:RecordAudio("423011127", var_531_12)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_423011", "423011127", "story_v_out_423011.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_423011", "423011127", "story_v_out_423011.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_13 = math.max(var_531_6, arg_528_1.talkMaxDuration)

			if var_531_5 <= arg_528_1.time_ and arg_528_1.time_ < var_531_5 + var_531_13 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_5) / var_531_13

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_5 + var_531_13 and arg_528_1.time_ < var_531_5 + var_531_13 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play423011128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 423011128
		arg_532_1.duration_ = 3.9

		local var_532_0 = {
			zh = 2.6,
			ja = 3.9
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play423011129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.3

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:GetWordFromCfg(423011128)
				local var_535_2 = arg_532_1:FormatText(var_535_1.content)

				arg_532_1.text_.text = var_535_2

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 12 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 12)

				if (12 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 12)) > 0 and var_535_0 < var_535_4 then
					arg_532_1.talkMaxDuration = var_535_4

					if var_535_4 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_4 + 0
					end
				end

				arg_532_1.text_.text = var_535_2
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011128", "story_v_out_423011.awb") ~= 0 then
					local var_535_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011128", "story_v_out_423011.awb") / 1000

					if var_535_5 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + 0
					end

					if var_535_1.prefab_name ~= "" and arg_532_1.actors_[var_535_1.prefab_name] ~= nil then
						local var_535_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_1.prefab_name].transform, "story_v_out_423011", "423011128", "story_v_out_423011.awb")

						arg_532_1:RecordAudio("423011128", var_535_6)
						arg_532_1:RecordAudio("423011128", var_535_6)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_423011", "423011128", "story_v_out_423011.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_423011", "423011128", "story_v_out_423011.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_7 and arg_532_1.time_ < 0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play423011129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 423011129
		arg_536_1.duration_ = 2.7

		local var_536_0 = {
			zh = 2.7,
			ja = 2.566
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play423011130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(arg_536_1.actors_["1083"]) and arg_536_1.var_.actorSpriteComps1083 == nil then
				arg_536_1.var_.actorSpriteComps1083 = arg_536_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_539_0 = 0.2

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 and not isNil(arg_536_1.actors_["1083"]) then
				if arg_536_1.var_.actorSpriteComps1083 then
					for iter_539_0, iter_539_1 in pairs(arg_536_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_539_1 then
							if arg_536_1.isInRecall_ then
								iter_539_1.color = Color.New(Mathf.Lerp(iter_539_1.color.r, arg_536_1.hightColor2.r, (arg_536_1.time_ - 0) / var_539_0), Mathf.Lerp(iter_539_1.color.g, arg_536_1.hightColor2.g, (arg_536_1.time_ - 0) / var_539_0), (Mathf.Lerp(iter_539_1.color.b, arg_536_1.hightColor2.b, (arg_536_1.time_ - 0) / var_539_0)))
							else
								local var_539_1 = Mathf.Lerp(iter_539_1.color.r, 0.5, (arg_536_1.time_ - 0) / var_539_0)

								iter_539_1.color = Color.New(var_539_1, var_539_1, var_539_1)
							end
						end
					end
				end
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 and not isNil(arg_536_1.actors_["1083"]) and arg_536_1.var_.actorSpriteComps1083 then
				for iter_539_2, iter_539_3 in pairs(arg_536_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_539_3 then
						iter_539_3.color = arg_536_1.isInRecall_ and (arg_536_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_536_1.var_.actorSpriteComps1083 = nil
			end

			local var_539_2 = 0
			local var_539_3 = 0.225

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_2 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_4 = arg_536_1:GetWordFromCfg(423011129)
				local var_539_5 = arg_536_1:FormatText(var_539_4.content)

				arg_536_1.text_.text = var_539_5

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_7 = 9 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 9)

				if (9 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 9)) > 0 and var_539_3 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_2
					end
				end

				arg_536_1.text_.text = var_539_5
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011129", "story_v_out_423011.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011129", "story_v_out_423011.awb") / 1000

					if var_539_8 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_2
					end

					if var_539_4.prefab_name ~= "" and arg_536_1.actors_[var_539_4.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_4.prefab_name].transform, "story_v_out_423011", "423011129", "story_v_out_423011.awb")

						arg_536_1:RecordAudio("423011129", var_539_9)
						arg_536_1:RecordAudio("423011129", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_423011", "423011129", "story_v_out_423011.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_423011", "423011129", "story_v_out_423011.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_3, arg_536_1.talkMaxDuration)

			if var_539_2 <= arg_536_1.time_ and arg_536_1.time_ < var_539_2 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_2) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_2 + var_539_10 and arg_536_1.time_ < var_539_2 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play423011130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 423011130
		arg_540_1.duration_ = 7.27

		local var_540_0 = {
			zh = 7.266,
			ja = 6.566
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play423011131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(arg_540_1.actors_["1083"]) and arg_540_1.var_.actorSpriteComps1083 == nil then
				arg_540_1.var_.actorSpriteComps1083 = arg_540_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_0 = 0.2

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 and not isNil(arg_540_1.actors_["1083"]) then
				if arg_540_1.var_.actorSpriteComps1083 then
					for iter_543_0, iter_543_1 in pairs(arg_540_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_543_1 then
							if arg_540_1.isInRecall_ then
								iter_543_1.color = Color.New(Mathf.Lerp(iter_543_1.color.r, arg_540_1.hightColor1.r, (arg_540_1.time_ - 0) / var_543_0), Mathf.Lerp(iter_543_1.color.g, arg_540_1.hightColor1.g, (arg_540_1.time_ - 0) / var_543_0), (Mathf.Lerp(iter_543_1.color.b, arg_540_1.hightColor1.b, (arg_540_1.time_ - 0) / var_543_0)))
							else
								local var_543_1 = Mathf.Lerp(iter_543_1.color.r, 1, (arg_540_1.time_ - 0) / var_543_0)

								iter_543_1.color = Color.New(var_543_1, var_543_1, var_543_1)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 and not isNil(arg_540_1.actors_["1083"]) and arg_540_1.var_.actorSpriteComps1083 then
				for iter_543_2, iter_543_3 in pairs(arg_540_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_543_3 then
						iter_543_3.color = arg_540_1.isInRecall_ and (arg_540_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_540_1.var_.actorSpriteComps1083 = nil
			end

			local var_543_2 = arg_540_1.actors_["1083"].transform

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos1083 = var_543_2.localPosition
				var_543_2.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("1083", 3)

				for iter_543_4 = 0, var_543_2.childCount - 1 do
					local var_543_3 = var_543_2:GetChild(iter_543_4)

					if var_543_3.name == "split_7" or not string.find(var_543_3.name, "split") then
						var_543_3.gameObject:SetActive(true)
					else
						var_543_3.gameObject:SetActive(false)
					end
				end
			end

			local var_543_4 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_4 then
				var_543_2.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_540_1.time_ - 0) / var_543_4)
			end

			if arg_540_1.time_ >= 0 + var_543_4 and arg_540_1.time_ < 0 + var_543_4 + arg_543_0 then
				var_543_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_543_5 = 0
			local var_543_6 = 0.85

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_5 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_7 = arg_540_1:GetWordFromCfg(423011130)
				local var_543_8 = arg_540_1:FormatText(var_543_7.content)

				arg_540_1.text_.text = var_543_8

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_10 = 34 <= 0 and var_543_6 or var_543_6 * (utf8.len(var_543_8) / 34)

				if (34 <= 0 and var_543_6 or var_543_6 * (utf8.len(var_543_8) / 34)) > 0 and var_543_6 < var_543_10 then
					arg_540_1.talkMaxDuration = var_543_10

					if var_543_10 + var_543_5 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_10 + var_543_5
					end
				end

				arg_540_1.text_.text = var_543_8
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011130", "story_v_out_423011.awb") ~= 0 then
					local var_543_11 = manager.audio:GetVoiceLength("story_v_out_423011", "423011130", "story_v_out_423011.awb") / 1000

					if var_543_11 + var_543_5 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_11 + var_543_5
					end

					if var_543_7.prefab_name ~= "" and arg_540_1.actors_[var_543_7.prefab_name] ~= nil then
						local var_543_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_7.prefab_name].transform, "story_v_out_423011", "423011130", "story_v_out_423011.awb")

						arg_540_1:RecordAudio("423011130", var_543_12)
						arg_540_1:RecordAudio("423011130", var_543_12)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_423011", "423011130", "story_v_out_423011.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_423011", "423011130", "story_v_out_423011.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_13 = math.max(var_543_6, arg_540_1.talkMaxDuration)

			if var_543_5 <= arg_540_1.time_ and arg_540_1.time_ < var_543_5 + var_543_13 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_5) / var_543_13

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_5 + var_543_13 and arg_540_1.time_ < var_543_5 + var_543_13 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play423011131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 423011131
		arg_544_1.duration_ = 5.2

		local var_544_0 = {
			zh = 4.433,
			ja = 5.2
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play423011132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos1083 = arg_544_1.actors_["1083"].transform.localPosition
				arg_544_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("1083", 3)

				for iter_547_0 = 0, arg_544_1.actors_["1083"].transform.childCount - 1 do
					local var_547_0 = arg_544_1.actors_["1083"].transform:GetChild(iter_547_0)

					if var_547_0.name == "split_3" or not string.find(var_547_0.name, "split") then
						var_547_0.gameObject:SetActive(true)
					else
						var_547_0.gameObject:SetActive(false)
					end
				end
			end

			local var_547_1 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_1 then
				arg_544_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_544_1.time_ - 0) / var_547_1)
			end

			if arg_544_1.time_ >= 0 + var_547_1 and arg_544_1.time_ < 0 + var_547_1 + arg_547_0 then
				arg_544_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_547_2 = 0
			local var_547_3 = 0.45

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_2 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_4 = arg_544_1:GetWordFromCfg(423011131)
				local var_547_5 = arg_544_1:FormatText(var_547_4.content)

				arg_544_1.text_.text = var_547_5

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_7 = 18 <= 0 and var_547_3 or var_547_3 * (utf8.len(var_547_5) / 18)

				if (18 <= 0 and var_547_3 or var_547_3 * (utf8.len(var_547_5) / 18)) > 0 and var_547_3 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_2 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_2
					end
				end

				arg_544_1.text_.text = var_547_5
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011131", "story_v_out_423011.awb") ~= 0 then
					local var_547_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011131", "story_v_out_423011.awb") / 1000

					if var_547_8 + var_547_2 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_8 + var_547_2
					end

					if var_547_4.prefab_name ~= "" and arg_544_1.actors_[var_547_4.prefab_name] ~= nil then
						local var_547_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_4.prefab_name].transform, "story_v_out_423011", "423011131", "story_v_out_423011.awb")

						arg_544_1:RecordAudio("423011131", var_547_9)
						arg_544_1:RecordAudio("423011131", var_547_9)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_423011", "423011131", "story_v_out_423011.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_423011", "423011131", "story_v_out_423011.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_10 = math.max(var_547_3, arg_544_1.talkMaxDuration)

			if var_547_2 <= arg_544_1.time_ and arg_544_1.time_ < var_547_2 + var_547_10 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_2) / var_547_10

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_2 + var_547_10 and arg_544_1.time_ < var_547_2 + var_547_10 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play423011132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 423011132
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play423011133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["1083"]) and arg_548_1.var_.actorSpriteComps1083 == nil then
				arg_548_1.var_.actorSpriteComps1083 = arg_548_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_0 = 0.2

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["1083"]) then
				if arg_548_1.var_.actorSpriteComps1083 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_551_1 then
							if arg_548_1.isInRecall_ then
								iter_551_1.color = Color.New(Mathf.Lerp(iter_551_1.color.r, arg_548_1.hightColor2.r, (arg_548_1.time_ - 0) / var_551_0), Mathf.Lerp(iter_551_1.color.g, arg_548_1.hightColor2.g, (arg_548_1.time_ - 0) / var_551_0), (Mathf.Lerp(iter_551_1.color.b, arg_548_1.hightColor2.b, (arg_548_1.time_ - 0) / var_551_0)))
							else
								local var_551_1 = Mathf.Lerp(iter_551_1.color.r, 0.5, (arg_548_1.time_ - 0) / var_551_0)

								iter_551_1.color = Color.New(var_551_1, var_551_1, var_551_1)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["1083"]) and arg_548_1.var_.actorSpriteComps1083 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_551_3 then
						iter_551_3.color = arg_548_1.isInRecall_ and (arg_548_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_548_1.var_.actorSpriteComps1083 = nil
			end

			local var_551_2 = arg_548_1.actors_["1083"].transform

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.var_.moveOldPos1083 = var_551_2.localPosition
				var_551_2.localScale = Vector3.New(1, 1, 1)

				arg_548_1:CheckSpriteTmpPos("1083", 7)

				for iter_551_4 = 0, var_551_2.childCount - 1 do
					local var_551_3 = var_551_2:GetChild(iter_551_4)

					if var_551_3.name == "" or not string.find(var_551_3.name, "split") then
						var_551_3.gameObject:SetActive(true)
					else
						var_551_3.gameObject:SetActive(false)
					end
				end
			end

			local var_551_4 = 0.001

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				var_551_2.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_548_1.time_ - 0) / var_551_4)
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				var_551_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.666666666666667 < arg_548_1.time_ and arg_548_1.time_ <= 0.666666666666667 + arg_551_0 then
				arg_548_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep_back", "")
			end

			local var_551_6 = 0
			local var_551_7 = 1.2

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_6 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_8 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(423011132).content)

				arg_548_1.text_.text = var_551_8

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_10 = 48 <= 0 and var_551_7 or var_551_7 * (utf8.len(var_551_8) / 48)

				if (48 <= 0 and var_551_7 or var_551_7 * (utf8.len(var_551_8) / 48)) > 0 and var_551_7 < var_551_10 then
					arg_548_1.talkMaxDuration = var_551_10

					if var_551_10 + var_551_6 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_10 + var_551_6
					end
				end

				arg_548_1.text_.text = var_551_8
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_11 = math.max(var_551_7, arg_548_1.talkMaxDuration)

			if var_551_6 <= arg_548_1.time_ and arg_548_1.time_ < var_551_6 + var_551_11 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_6) / var_551_11

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_6 + var_551_11 and arg_548_1.time_ < var_551_6 + var_551_11 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play423011133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 423011133
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play423011134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.275

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(423011133).content)

				arg_552_1.text_.text = var_555_1

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_3 = 11 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 11)

				if (11 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 11)) > 0 and var_555_0 < var_555_3 then
					arg_552_1.talkMaxDuration = var_555_3

					if var_555_3 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_3 + 0
					end
				end

				arg_552_1.text_.text = var_555_1
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_4 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_4 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_4

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_4 and arg_552_1.time_ < 0 + var_555_4 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play423011134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 423011134
		arg_556_1.duration_ = 6

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play423011135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_9000

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_559_0 = 1

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 then
				local var_559_1, var_559_2 = math.modf((arg_556_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_559_2 * 0.13, var_559_2 * 0.13, var_559_2 * 0.13) + arg_556_1.var_.shakeOldPos
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 then
				manager.ui.mainCamera.transform.localPosition = arg_556_1.var_.shakeOldPos
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				local var_559_3 = arg_556_1.var_.effectfeichumuxie

				if not arg_556_1.var_.effectfeichumuxie then
					var_559_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_559_3.name = "feichumuxie"
					arg_556_1.var_.effectfeichumuxie = var_559_3
				else
					var_559_3.transform:SetParent(var_559_9000)
				end

				var_559_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_559_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.5 < arg_556_1.time_ and arg_556_1.time_ <= 1.5 + arg_559_0 then
				if arg_556_1.var_.effectfeichumuxie then
					Object.Destroy(arg_556_1.var_.effectfeichumuxie)

					arg_556_1.var_.effectfeichumuxie = nil
				end
			end

			local var_559_6 = 0

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_6 + arg_559_0 then
				arg_556_1.allBtn_.enabled = false
			end

			if arg_556_1.time_ >= var_559_6 + 1 and arg_556_1.time_ < var_559_6 + 1 + arg_559_0 then
				arg_556_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_556_1.time_ and arg_556_1.time_ <= 0.166666666666667 + arg_559_0 then
				arg_556_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun05", "")
			end

			if arg_556_1.frameCnt_ <= 1 then
				arg_556_1.dialog_:SetActive(false)
			end

			local var_559_8 = 1
			local var_559_9 = 1.075

			if 1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_8 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				arg_556_1.dialog_:SetActive(true)

				arg_556_1.dialogCg_.alpha = 0

				local var_559_10 = LeanTween.value(arg_556_1.dialog_, 0, 1, 0.3)

				var_559_10:setOnUpdate(LuaHelper.FloatAction(function(arg_560_0)
					arg_556_1.dialogCg_.alpha = arg_560_0
				end))
				var_559_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_556_1.dialog_)
					var_559_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_556_1.duration_ = arg_556_1.duration_ + 0.3

				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_11 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(423011134).content)

				arg_556_1.text_.text = var_559_11

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_13 = 43 <= 0 and var_559_9 or var_559_9 * (utf8.len(var_559_11) / 43)

				if (43 <= 0 and var_559_9 or var_559_9 * (utf8.len(var_559_11) / 43)) > 0 and var_559_9 < var_559_13 then
					arg_556_1.talkMaxDuration = var_559_13
					var_559_8 = var_559_8 + 0.3

					if var_559_13 + var_559_8 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_13 + var_559_8
					end
				end

				arg_556_1.text_.text = var_559_11
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_14 = var_559_8 + 0.3
			local var_559_15 = math.max(var_559_9, arg_556_1.talkMaxDuration)

			if var_559_8 + 0.3 <= arg_556_1.time_ and arg_556_1.time_ < var_559_14 + var_559_15 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_14) / var_559_15

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_14 + var_559_15 and arg_556_1.time_ < var_559_14 + var_559_15 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play423011135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 423011135
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play423011136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 1.15

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_1 = arg_562_1:FormatText(arg_562_1:GetWordFromCfg(423011135).content)

				arg_562_1.text_.text = var_565_1

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_3 = 46 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_1) / 46)

				if (46 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_1) / 46)) > 0 and var_565_0 < var_565_3 then
					arg_562_1.talkMaxDuration = var_565_3

					if var_565_3 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_3 + 0
					end
				end

				arg_562_1.text_.text = var_565_1
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_4 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_4 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_4

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_4 and arg_562_1.time_ < 0 + var_565_4 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play423011136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 423011136
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play423011137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0.166666666666667 < arg_566_1.time_ and arg_566_1.time_ <= 0.166666666666667 + arg_569_0 then
				arg_566_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_569_1 = 0
			local var_569_2 = 1.25

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_3 = arg_566_1:FormatText(arg_566_1:GetWordFromCfg(423011136).content)

				arg_566_1.text_.text = var_569_3

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 50 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_3) / 50)

				if (50 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_3) / 50)) > 0 and var_569_2 < var_569_5 then
					arg_566_1.talkMaxDuration = var_569_5

					if var_569_5 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_5 + var_569_1
					end
				end

				arg_566_1.text_.text = var_569_3
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_6 = math.max(var_569_2, arg_566_1.talkMaxDuration)

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_6 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_1) / var_569_6

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_1 + var_569_6 and arg_566_1.time_ < var_569_1 + var_569_6 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play423011137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 423011137
		arg_570_1.duration_ = 5.8

		local var_570_0 = {
			zh = 3.433,
			ja = 5.8
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play423011138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1083"]) and arg_570_1.var_.actorSpriteComps1083 == nil then
				arg_570_1.var_.actorSpriteComps1083 = arg_570_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_573_0 = 0.2

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1083"]) then
				if arg_570_1.var_.actorSpriteComps1083 then
					for iter_573_0, iter_573_1 in pairs(arg_570_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_573_1 then
							if arg_570_1.isInRecall_ then
								iter_573_1.color = Color.New(Mathf.Lerp(iter_573_1.color.r, arg_570_1.hightColor1.r, (arg_570_1.time_ - 0) / var_573_0), Mathf.Lerp(iter_573_1.color.g, arg_570_1.hightColor1.g, (arg_570_1.time_ - 0) / var_573_0), (Mathf.Lerp(iter_573_1.color.b, arg_570_1.hightColor1.b, (arg_570_1.time_ - 0) / var_573_0)))
							else
								local var_573_1 = Mathf.Lerp(iter_573_1.color.r, 1, (arg_570_1.time_ - 0) / var_573_0)

								iter_573_1.color = Color.New(var_573_1, var_573_1, var_573_1)
							end
						end
					end
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1083"]) and arg_570_1.var_.actorSpriteComps1083 then
				for iter_573_2, iter_573_3 in pairs(arg_570_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_573_3 then
						iter_573_3.color = arg_570_1.isInRecall_ and (arg_570_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_570_1.var_.actorSpriteComps1083 = nil
			end

			local var_573_2 = arg_570_1.actors_["1083"].transform

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.var_.moveOldPos1083 = var_573_2.localPosition
				var_573_2.localScale = Vector3.New(1, 1, 1)

				arg_570_1:CheckSpriteTmpPos("1083", 3)

				for iter_573_4 = 0, var_573_2.childCount - 1 do
					local var_573_3 = var_573_2:GetChild(iter_573_4)

					if var_573_3.name == "split_3" or not string.find(var_573_3.name, "split") then
						var_573_3.gameObject:SetActive(true)
					else
						var_573_3.gameObject:SetActive(false)
					end
				end
			end

			local var_573_4 = 0.001

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_4 then
				var_573_2.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_570_1.time_ - 0) / var_573_4)
			end

			if arg_570_1.time_ >= 0 + var_573_4 and arg_570_1.time_ < 0 + var_573_4 + arg_573_0 then
				var_573_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_573_5 = 0
			local var_573_6 = 0.475

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_5 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_7 = arg_570_1:GetWordFromCfg(423011137)
				local var_573_8 = arg_570_1:FormatText(var_573_7.content)

				arg_570_1.text_.text = var_573_8

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_10 = 19 <= 0 and var_573_6 or var_573_6 * (utf8.len(var_573_8) / 19)

				if (19 <= 0 and var_573_6 or var_573_6 * (utf8.len(var_573_8) / 19)) > 0 and var_573_6 < var_573_10 then
					arg_570_1.talkMaxDuration = var_573_10

					if var_573_10 + var_573_5 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_10 + var_573_5
					end
				end

				arg_570_1.text_.text = var_573_8
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011137", "story_v_out_423011.awb") ~= 0 then
					local var_573_11 = manager.audio:GetVoiceLength("story_v_out_423011", "423011137", "story_v_out_423011.awb") / 1000

					if var_573_11 + var_573_5 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_11 + var_573_5
					end

					if var_573_7.prefab_name ~= "" and arg_570_1.actors_[var_573_7.prefab_name] ~= nil then
						local var_573_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_7.prefab_name].transform, "story_v_out_423011", "423011137", "story_v_out_423011.awb")

						arg_570_1:RecordAudio("423011137", var_573_12)
						arg_570_1:RecordAudio("423011137", var_573_12)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_423011", "423011137", "story_v_out_423011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_423011", "423011137", "story_v_out_423011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_13 = math.max(var_573_6, arg_570_1.talkMaxDuration)

			if var_573_5 <= arg_570_1.time_ and arg_570_1.time_ < var_573_5 + var_573_13 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_5) / var_573_13

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_5 + var_573_13 and arg_570_1.time_ < var_573_5 + var_573_13 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play423011138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 423011138
		arg_574_1.duration_ = 4.43

		local var_574_0 = {
			zh = 3.466,
			ja = 4.433
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play423011139(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["1083"]) and arg_574_1.var_.actorSpriteComps1083 == nil then
				arg_574_1.var_.actorSpriteComps1083 = arg_574_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_577_0 = 0.2

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["1083"]) then
				if arg_574_1.var_.actorSpriteComps1083 then
					for iter_577_0, iter_577_1 in pairs(arg_574_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_577_1 then
							if arg_574_1.isInRecall_ then
								iter_577_1.color = Color.New(Mathf.Lerp(iter_577_1.color.r, arg_574_1.hightColor2.r, (arg_574_1.time_ - 0) / var_577_0), Mathf.Lerp(iter_577_1.color.g, arg_574_1.hightColor2.g, (arg_574_1.time_ - 0) / var_577_0), (Mathf.Lerp(iter_577_1.color.b, arg_574_1.hightColor2.b, (arg_574_1.time_ - 0) / var_577_0)))
							else
								local var_577_1 = Mathf.Lerp(iter_577_1.color.r, 0.5, (arg_574_1.time_ - 0) / var_577_0)

								iter_577_1.color = Color.New(var_577_1, var_577_1, var_577_1)
							end
						end
					end
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["1083"]) and arg_574_1.var_.actorSpriteComps1083 then
				for iter_577_2, iter_577_3 in pairs(arg_574_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_577_3 then
						iter_577_3.color = arg_574_1.isInRecall_ and (arg_574_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_574_1.var_.actorSpriteComps1083 = nil
			end

			local var_577_2 = 0
			local var_577_3 = 0.375

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_2 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[1330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_4 = arg_574_1:GetWordFromCfg(423011138)
				local var_577_5 = arg_574_1:FormatText(var_577_4.content)

				arg_574_1.text_.text = var_577_5

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_7 = 15 <= 0 and var_577_3 or var_577_3 * (utf8.len(var_577_5) / 15)

				if (15 <= 0 and var_577_3 or var_577_3 * (utf8.len(var_577_5) / 15)) > 0 and var_577_3 < var_577_7 then
					arg_574_1.talkMaxDuration = var_577_7

					if var_577_7 + var_577_2 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_7 + var_577_2
					end
				end

				arg_574_1.text_.text = var_577_5
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011138", "story_v_out_423011.awb") ~= 0 then
					local var_577_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011138", "story_v_out_423011.awb") / 1000

					if var_577_8 + var_577_2 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_8 + var_577_2
					end

					if var_577_4.prefab_name ~= "" and arg_574_1.actors_[var_577_4.prefab_name] ~= nil then
						local var_577_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_4.prefab_name].transform, "story_v_out_423011", "423011138", "story_v_out_423011.awb")

						arg_574_1:RecordAudio("423011138", var_577_9)
						arg_574_1:RecordAudio("423011138", var_577_9)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_423011", "423011138", "story_v_out_423011.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_423011", "423011138", "story_v_out_423011.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_10 = math.max(var_577_3, arg_574_1.talkMaxDuration)

			if var_577_2 <= arg_574_1.time_ and arg_574_1.time_ < var_577_2 + var_577_10 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_2) / var_577_10

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_2 + var_577_10 and arg_574_1.time_ < var_577_2 + var_577_10 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play423011139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 423011139
		arg_578_1.duration_ = 6.8

		local var_578_0 = {
			zh = 5.033,
			ja = 6.8
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play423011140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(arg_578_1.actors_["1083"]) and arg_578_1.var_.actorSpriteComps1083 == nil then
				arg_578_1.var_.actorSpriteComps1083 = arg_578_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_581_0 = 0.2

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 and not isNil(arg_578_1.actors_["1083"]) then
				if arg_578_1.var_.actorSpriteComps1083 then
					for iter_581_0, iter_581_1 in pairs(arg_578_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_581_1 then
							if arg_578_1.isInRecall_ then
								iter_581_1.color = Color.New(Mathf.Lerp(iter_581_1.color.r, arg_578_1.hightColor1.r, (arg_578_1.time_ - 0) / var_581_0), Mathf.Lerp(iter_581_1.color.g, arg_578_1.hightColor1.g, (arg_578_1.time_ - 0) / var_581_0), (Mathf.Lerp(iter_581_1.color.b, arg_578_1.hightColor1.b, (arg_578_1.time_ - 0) / var_581_0)))
							else
								local var_581_1 = Mathf.Lerp(iter_581_1.color.r, 1, (arg_578_1.time_ - 0) / var_581_0)

								iter_581_1.color = Color.New(var_581_1, var_581_1, var_581_1)
							end
						end
					end
				end
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 and not isNil(arg_578_1.actors_["1083"]) and arg_578_1.var_.actorSpriteComps1083 then
				for iter_581_2, iter_581_3 in pairs(arg_578_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_581_3 then
						iter_581_3.color = arg_578_1.isInRecall_ and (arg_578_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_578_1.var_.actorSpriteComps1083 = nil
			end

			local var_581_2 = arg_578_1.actors_["1083"].transform

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos1083 = var_581_2.localPosition
				var_581_2.localScale = Vector3.New(1, 1, 1)

				arg_578_1:CheckSpriteTmpPos("1083", 3)

				for iter_581_4 = 0, var_581_2.childCount - 1 do
					local var_581_3 = var_581_2:GetChild(iter_581_4)

					if var_581_3.name == "" or not string.find(var_581_3.name, "split") then
						var_581_3.gameObject:SetActive(true)
					else
						var_581_3.gameObject:SetActive(false)
					end
				end
			end

			local var_581_4 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_4 then
				var_581_2.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_578_1.time_ - 0) / var_581_4)
			end

			if arg_578_1.time_ >= 0 + var_581_4 and arg_578_1.time_ < 0 + var_581_4 + arg_581_0 then
				var_581_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_581_5 = 0
			local var_581_6 = 0.575

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_5 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_7 = arg_578_1:GetWordFromCfg(423011139)
				local var_581_8 = arg_578_1:FormatText(var_581_7.content)

				arg_578_1.text_.text = var_581_8

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_10 = 23 <= 0 and var_581_6 or var_581_6 * (utf8.len(var_581_8) / 23)

				if (23 <= 0 and var_581_6 or var_581_6 * (utf8.len(var_581_8) / 23)) > 0 and var_581_6 < var_581_10 then
					arg_578_1.talkMaxDuration = var_581_10

					if var_581_10 + var_581_5 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_10 + var_581_5
					end
				end

				arg_578_1.text_.text = var_581_8
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011139", "story_v_out_423011.awb") ~= 0 then
					local var_581_11 = manager.audio:GetVoiceLength("story_v_out_423011", "423011139", "story_v_out_423011.awb") / 1000

					if var_581_11 + var_581_5 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_11 + var_581_5
					end

					if var_581_7.prefab_name ~= "" and arg_578_1.actors_[var_581_7.prefab_name] ~= nil then
						local var_581_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_7.prefab_name].transform, "story_v_out_423011", "423011139", "story_v_out_423011.awb")

						arg_578_1:RecordAudio("423011139", var_581_12)
						arg_578_1:RecordAudio("423011139", var_581_12)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_423011", "423011139", "story_v_out_423011.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_423011", "423011139", "story_v_out_423011.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_13 = math.max(var_581_6, arg_578_1.talkMaxDuration)

			if var_581_5 <= arg_578_1.time_ and arg_578_1.time_ < var_581_5 + var_581_13 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_5) / var_581_13

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_5 + var_581_13 and arg_578_1.time_ < var_581_5 + var_581_13 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play423011140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 423011140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play423011141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["1083"]) and arg_582_1.var_.actorSpriteComps1083 == nil then
				arg_582_1.var_.actorSpriteComps1083 = arg_582_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_585_0 = 0.2

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["1083"]) then
				if arg_582_1.var_.actorSpriteComps1083 then
					for iter_585_0, iter_585_1 in pairs(arg_582_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_585_1 then
							if arg_582_1.isInRecall_ then
								iter_585_1.color = Color.New(Mathf.Lerp(iter_585_1.color.r, arg_582_1.hightColor2.r, (arg_582_1.time_ - 0) / var_585_0), Mathf.Lerp(iter_585_1.color.g, arg_582_1.hightColor2.g, (arg_582_1.time_ - 0) / var_585_0), (Mathf.Lerp(iter_585_1.color.b, arg_582_1.hightColor2.b, (arg_582_1.time_ - 0) / var_585_0)))
							else
								local var_585_1 = Mathf.Lerp(iter_585_1.color.r, 0.5, (arg_582_1.time_ - 0) / var_585_0)

								iter_585_1.color = Color.New(var_585_1, var_585_1, var_585_1)
							end
						end
					end
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["1083"]) and arg_582_1.var_.actorSpriteComps1083 then
				for iter_585_2, iter_585_3 in pairs(arg_582_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_585_3 then
						iter_585_3.color = arg_582_1.isInRecall_ and (arg_582_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_582_1.var_.actorSpriteComps1083 = nil
			end

			local var_585_2 = 0
			local var_585_3 = 0.35

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_2 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_4 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(423011140).content)

				arg_582_1.text_.text = var_585_4

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_6 = 14 <= 0 and var_585_3 or var_585_3 * (utf8.len(var_585_4) / 14)

				if (14 <= 0 and var_585_3 or var_585_3 * (utf8.len(var_585_4) / 14)) > 0 and var_585_3 < var_585_6 then
					arg_582_1.talkMaxDuration = var_585_6

					if var_585_6 + var_585_2 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_6 + var_585_2
					end
				end

				arg_582_1.text_.text = var_585_4
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_7 = math.max(var_585_3, arg_582_1.talkMaxDuration)

			if var_585_2 <= arg_582_1.time_ and arg_582_1.time_ < var_585_2 + var_585_7 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_2) / var_585_7

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_2 + var_585_7 and arg_582_1.time_ < var_585_2 + var_585_7 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play423011141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 423011141
		arg_586_1.duration_ = 5.8

		local var_586_0 = {
			zh = 5.8,
			ja = 4.9
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play423011142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(arg_586_1.actors_["1083"]) and arg_586_1.var_.actorSpriteComps1083 == nil then
				arg_586_1.var_.actorSpriteComps1083 = arg_586_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_589_0 = 0.2

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 and not isNil(arg_586_1.actors_["1083"]) then
				if arg_586_1.var_.actorSpriteComps1083 then
					for iter_589_0, iter_589_1 in pairs(arg_586_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_589_1 then
							if arg_586_1.isInRecall_ then
								iter_589_1.color = Color.New(Mathf.Lerp(iter_589_1.color.r, arg_586_1.hightColor1.r, (arg_586_1.time_ - 0) / var_589_0), Mathf.Lerp(iter_589_1.color.g, arg_586_1.hightColor1.g, (arg_586_1.time_ - 0) / var_589_0), (Mathf.Lerp(iter_589_1.color.b, arg_586_1.hightColor1.b, (arg_586_1.time_ - 0) / var_589_0)))
							else
								local var_589_1 = Mathf.Lerp(iter_589_1.color.r, 1, (arg_586_1.time_ - 0) / var_589_0)

								iter_589_1.color = Color.New(var_589_1, var_589_1, var_589_1)
							end
						end
					end
				end
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 and not isNil(arg_586_1.actors_["1083"]) and arg_586_1.var_.actorSpriteComps1083 then
				for iter_589_2, iter_589_3 in pairs(arg_586_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_589_3 then
						iter_589_3.color = arg_586_1.isInRecall_ and (arg_586_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_586_1.var_.actorSpriteComps1083 = nil
			end

			local var_589_2 = arg_586_1.actors_["1083"].transform

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos1083 = var_589_2.localPosition
				var_589_2.localScale = Vector3.New(1, 1, 1)

				arg_586_1:CheckSpriteTmpPos("1083", 3)

				for iter_589_4 = 0, var_589_2.childCount - 1 do
					local var_589_3 = var_589_2:GetChild(iter_589_4)

					if var_589_3.name == "" or not string.find(var_589_3.name, "split") then
						var_589_3.gameObject:SetActive(true)
					else
						var_589_3.gameObject:SetActive(false)
					end
				end
			end

			local var_589_4 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_4 then
				var_589_2.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_586_1.time_ - 0) / var_589_4)
			end

			if arg_586_1.time_ >= 0 + var_589_4 and arg_586_1.time_ < 0 + var_589_4 + arg_589_0 then
				var_589_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_589_5 = 0
			local var_589_6 = 0.625

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_5 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_7 = arg_586_1:GetWordFromCfg(423011141)
				local var_589_8 = arg_586_1:FormatText(var_589_7.content)

				arg_586_1.text_.text = var_589_8

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_10 = 25 <= 0 and var_589_6 or var_589_6 * (utf8.len(var_589_8) / 25)

				if (25 <= 0 and var_589_6 or var_589_6 * (utf8.len(var_589_8) / 25)) > 0 and var_589_6 < var_589_10 then
					arg_586_1.talkMaxDuration = var_589_10

					if var_589_10 + var_589_5 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_10 + var_589_5
					end
				end

				arg_586_1.text_.text = var_589_8
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011141", "story_v_out_423011.awb") ~= 0 then
					local var_589_11 = manager.audio:GetVoiceLength("story_v_out_423011", "423011141", "story_v_out_423011.awb") / 1000

					if var_589_11 + var_589_5 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_11 + var_589_5
					end

					if var_589_7.prefab_name ~= "" and arg_586_1.actors_[var_589_7.prefab_name] ~= nil then
						local var_589_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_7.prefab_name].transform, "story_v_out_423011", "423011141", "story_v_out_423011.awb")

						arg_586_1:RecordAudio("423011141", var_589_12)
						arg_586_1:RecordAudio("423011141", var_589_12)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_423011", "423011141", "story_v_out_423011.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_423011", "423011141", "story_v_out_423011.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_13 = math.max(var_589_6, arg_586_1.talkMaxDuration)

			if var_589_5 <= arg_586_1.time_ and arg_586_1.time_ < var_589_5 + var_589_13 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_5) / var_589_13

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_5 + var_589_13 and arg_586_1.time_ < var_589_5 + var_589_13 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play423011142 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 423011142
		arg_590_1.duration_ = 4.23

		local var_590_0 = {
			zh = 2.733,
			ja = 4.233
		}
		local var_590_1 = manager.audio:GetLocalizationFlag()

		if var_590_0[var_590_1] ~= nil then
			arg_590_1.duration_ = var_590_0[var_590_1]
		end

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play423011143(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.var_.moveOldPos1083 = arg_590_1.actors_["1083"].transform.localPosition
				arg_590_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_590_1:CheckSpriteTmpPos("1083", 3)

				for iter_593_0 = 0, arg_590_1.actors_["1083"].transform.childCount - 1 do
					local var_593_0 = arg_590_1.actors_["1083"].transform:GetChild(iter_593_0)

					if var_593_0.name == "" or not string.find(var_593_0.name, "split") then
						var_593_0.gameObject:SetActive(true)
					else
						var_593_0.gameObject:SetActive(false)
					end
				end
			end

			local var_593_1 = 0.001

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_1 then
				arg_590_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_590_1.time_ - 0) / var_593_1)
			end

			if arg_590_1.time_ >= 0 + var_593_1 and arg_590_1.time_ < 0 + var_593_1 + arg_593_0 then
				arg_590_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_593_2 = 0
			local var_593_3 = 0.35

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_2 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_4 = arg_590_1:GetWordFromCfg(423011142)
				local var_593_5 = arg_590_1:FormatText(var_593_4.content)

				arg_590_1.text_.text = var_593_5

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_7 = 14 <= 0 and var_593_3 or var_593_3 * (utf8.len(var_593_5) / 14)

				if (14 <= 0 and var_593_3 or var_593_3 * (utf8.len(var_593_5) / 14)) > 0 and var_593_3 < var_593_7 then
					arg_590_1.talkMaxDuration = var_593_7

					if var_593_7 + var_593_2 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_7 + var_593_2
					end
				end

				arg_590_1.text_.text = var_593_5
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011142", "story_v_out_423011.awb") ~= 0 then
					local var_593_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011142", "story_v_out_423011.awb") / 1000

					if var_593_8 + var_593_2 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_8 + var_593_2
					end

					if var_593_4.prefab_name ~= "" and arg_590_1.actors_[var_593_4.prefab_name] ~= nil then
						local var_593_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_4.prefab_name].transform, "story_v_out_423011", "423011142", "story_v_out_423011.awb")

						arg_590_1:RecordAudio("423011142", var_593_9)
						arg_590_1:RecordAudio("423011142", var_593_9)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_423011", "423011142", "story_v_out_423011.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_423011", "423011142", "story_v_out_423011.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_10 = math.max(var_593_3, arg_590_1.talkMaxDuration)

			if var_593_2 <= arg_590_1.time_ and arg_590_1.time_ < var_593_2 + var_593_10 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_2) / var_593_10

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_2 + var_593_10 and arg_590_1.time_ < var_593_2 + var_593_10 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play423011143 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 423011143
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play423011144(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(arg_594_1.actors_["1083"]) and arg_594_1.var_.actorSpriteComps1083 == nil then
				arg_594_1.var_.actorSpriteComps1083 = arg_594_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_597_0 = 0.2

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_0 and not isNil(arg_594_1.actors_["1083"]) then
				if arg_594_1.var_.actorSpriteComps1083 then
					for iter_597_0, iter_597_1 in pairs(arg_594_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_597_1 then
							if arg_594_1.isInRecall_ then
								iter_597_1.color = Color.New(Mathf.Lerp(iter_597_1.color.r, arg_594_1.hightColor2.r, (arg_594_1.time_ - 0) / var_597_0), Mathf.Lerp(iter_597_1.color.g, arg_594_1.hightColor2.g, (arg_594_1.time_ - 0) / var_597_0), (Mathf.Lerp(iter_597_1.color.b, arg_594_1.hightColor2.b, (arg_594_1.time_ - 0) / var_597_0)))
							else
								local var_597_1 = Mathf.Lerp(iter_597_1.color.r, 0.5, (arg_594_1.time_ - 0) / var_597_0)

								iter_597_1.color = Color.New(var_597_1, var_597_1, var_597_1)
							end
						end
					end
				end
			end

			if arg_594_1.time_ >= 0 + var_597_0 and arg_594_1.time_ < 0 + var_597_0 + arg_597_0 and not isNil(arg_594_1.actors_["1083"]) and arg_594_1.var_.actorSpriteComps1083 then
				for iter_597_2, iter_597_3 in pairs(arg_594_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_597_3 then
						iter_597_3.color = arg_594_1.isInRecall_ and (arg_594_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_594_1.var_.actorSpriteComps1083 = nil
			end

			local var_597_2 = arg_594_1.actors_["1083"].transform

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.var_.moveOldPos1083 = var_597_2.localPosition
				var_597_2.localScale = Vector3.New(1, 1, 1)

				arg_594_1:CheckSpriteTmpPos("1083", 7)

				for iter_597_4 = 0, var_597_2.childCount - 1 do
					local var_597_3 = var_597_2:GetChild(iter_597_4)

					if var_597_3.name == "" or not string.find(var_597_3.name, "split") then
						var_597_3.gameObject:SetActive(true)
					else
						var_597_3.gameObject:SetActive(false)
					end
				end
			end

			local var_597_4 = 0.001

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_4 then
				var_597_2.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_594_1.time_ - 0) / var_597_4)
			end

			if arg_594_1.time_ >= 0 + var_597_4 and arg_594_1.time_ < 0 + var_597_4 + arg_597_0 then
				var_597_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_597_5 = 0
			local var_597_6 = 1.45

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_5 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, false)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_7 = arg_594_1:FormatText(arg_594_1:GetWordFromCfg(423011143).content)

				arg_594_1.text_.text = var_597_7

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_9 = 58 <= 0 and var_597_6 or var_597_6 * (utf8.len(var_597_7) / 58)

				if (58 <= 0 and var_597_6 or var_597_6 * (utf8.len(var_597_7) / 58)) > 0 and var_597_6 < var_597_9 then
					arg_594_1.talkMaxDuration = var_597_9

					if var_597_9 + var_597_5 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_9 + var_597_5
					end
				end

				arg_594_1.text_.text = var_597_7
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_10 = math.max(var_597_6, arg_594_1.talkMaxDuration)

			if var_597_5 <= arg_594_1.time_ and arg_594_1.time_ < var_597_5 + var_597_10 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_5) / var_597_10

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_5 + var_597_10 and arg_594_1.time_ < var_597_5 + var_597_10 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play423011144 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 423011144
		arg_598_1.duration_ = 13.57

		local var_598_0 = {
			zh = 11.166,
			ja = 13.566
		}
		local var_598_1 = manager.audio:GetLocalizationFlag()

		if var_598_0[var_598_1] ~= nil then
			arg_598_1.duration_ = var_598_0[var_598_1]
		end

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play423011145(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_9000

			if arg_598_1.bgs_.I24f == nil then
				local var_601_0 = Object.Instantiate(arg_598_1.paintGo_)

				var_601_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I24f")
				var_601_0.name = "I24f"
				var_601_0.transform.parent = arg_598_1.stage_.transform
				var_601_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_598_1.bgs_.I24f = var_601_0
			end

			if 2 < arg_598_1.time_ and arg_598_1.time_ <= 2 + arg_601_0 then
				local var_601_1 = arg_598_1.bgs_.I24f

				arg_598_1.bgs_.I24f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_601_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_601_2 = var_601_1:GetComponent("SpriteRenderer")

				if var_601_2 and var_601_2.sprite then
					local var_601_3 = 2 * (var_601_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_601_1.transform.localScale = Vector3.New(var_601_3 / var_601_2.sprite.bounds.size.y < var_601_3 * manager.ui.mainCameraCom_.aspect / var_601_2.sprite.bounds.size.x and var_601_3 * manager.ui.mainCameraCom_.aspect / var_601_2.sprite.bounds.size.x or var_601_3 / var_601_2.sprite.bounds.size.y, var_601_3 / var_601_2.sprite.bounds.size.y < var_601_3 * manager.ui.mainCameraCom_.aspect / var_601_2.sprite.bounds.size.x and var_601_3 * manager.ui.mainCameraCom_.aspect / var_601_2.sprite.bounds.size.x or var_601_3 / var_601_2.sprite.bounds.size.y, 0)
				end

				for iter_601_0, iter_601_1 in pairs(arg_598_1.bgs_) do
					if iter_601_0 ~= "I24f" then
						iter_601_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_601_4 = 4

			if 4 < arg_598_1.time_ and arg_598_1.time_ <= var_601_4 + arg_601_0 then
				arg_598_1.allBtn_.enabled = false
			end

			if arg_598_1.time_ >= var_601_4 + 0.3 and arg_598_1.time_ < var_601_4 + 0.3 + arg_601_0 then
				arg_598_1.allBtn_.enabled = true
			end

			local var_601_5 = 0

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_5 + arg_601_0 then
				arg_598_1.mask_.enabled = true
				arg_598_1.mask_.raycastTarget = true

				arg_598_1:SetGaussion(false)
			end

			local var_601_6 = 2

			if var_601_5 <= arg_598_1.time_ and arg_598_1.time_ < var_601_5 + var_601_6 then
				local var_601_7 = Color.New(0, 0, 0)

				var_601_7.a = Mathf.Lerp(0, 1, (arg_598_1.time_ - var_601_5) / var_601_6)
				arg_598_1.mask_.color = var_601_7
			end

			if arg_598_1.time_ >= var_601_5 + var_601_6 and arg_598_1.time_ < var_601_5 + var_601_6 + arg_601_0 then
				local var_601_8 = Color.New(0, 0, 0)

				var_601_8.a = 1
				arg_598_1.mask_.color = var_601_8
			end

			local var_601_9 = 2

			if 2 < arg_598_1.time_ and arg_598_1.time_ <= var_601_9 + arg_601_0 then
				arg_598_1.mask_.enabled = true
				arg_598_1.mask_.raycastTarget = true

				arg_598_1:SetGaussion(false)
			end

			local var_601_10 = 2

			if var_601_9 <= arg_598_1.time_ and arg_598_1.time_ < var_601_9 + var_601_10 then
				local var_601_11 = Color.New(0, 0, 0)

				var_601_11.a = Mathf.Lerp(1, 0, (arg_598_1.time_ - var_601_9) / var_601_10)
				arg_598_1.mask_.color = var_601_11
			end

			if arg_598_1.time_ >= var_601_9 + var_601_10 and arg_598_1.time_ < var_601_9 + var_601_10 + arg_601_0 then
				local var_601_12 = Color.New(0, 0, 0)

				arg_598_1.mask_.enabled = false
				var_601_12.a = 0
				arg_598_1.mask_.color = var_601_12
			end

			local var_601_13 = arg_598_1.actors_["1083"]

			if 3.8 < arg_598_1.time_ and arg_598_1.time_ <= 3.8 + arg_601_0 and not isNil(var_601_13) and arg_598_1.var_.actorSpriteComps1083 == nil then
				arg_598_1.var_.actorSpriteComps1083 = var_601_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_601_14 = 0.2

			if 3.8 <= arg_598_1.time_ and arg_598_1.time_ < 3.8 + var_601_14 and not isNil(var_601_13) then
				if arg_598_1.var_.actorSpriteComps1083 then
					for iter_601_2, iter_601_3 in pairs(arg_598_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_601_3 then
							if arg_598_1.isInRecall_ then
								iter_601_3.color = Color.New(Mathf.Lerp(iter_601_3.color.r, arg_598_1.hightColor1.r, (arg_598_1.time_ - 3.8) / var_601_14), Mathf.Lerp(iter_601_3.color.g, arg_598_1.hightColor1.g, (arg_598_1.time_ - 3.8) / var_601_14), (Mathf.Lerp(iter_601_3.color.b, arg_598_1.hightColor1.b, (arg_598_1.time_ - 3.8) / var_601_14)))
							else
								local var_601_15 = Mathf.Lerp(iter_601_3.color.r, 1, (arg_598_1.time_ - 3.8) / var_601_14)

								iter_601_3.color = Color.New(var_601_15, var_601_15, var_601_15)
							end
						end
					end
				end
			end

			if arg_598_1.time_ >= 3.8 + var_601_14 and arg_598_1.time_ < 3.8 + var_601_14 + arg_601_0 and not isNil(var_601_13) and arg_598_1.var_.actorSpriteComps1083 then
				for iter_601_4, iter_601_5 in pairs(arg_598_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_601_5 then
						iter_601_5.color = arg_598_1.isInRecall_ and (arg_598_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_598_1.var_.actorSpriteComps1083 = nil
			end

			local var_601_16 = arg_598_1.actors_["1083"].transform

			if 3.8 < arg_598_1.time_ and arg_598_1.time_ <= 3.8 + arg_601_0 then
				arg_598_1.var_.moveOldPos1083 = var_601_16.localPosition
				var_601_16.localScale = Vector3.New(1, 1, 1)

				arg_598_1:CheckSpriteTmpPos("1083", 3)

				for iter_601_6 = 0, var_601_16.childCount - 1 do
					local var_601_17 = var_601_16:GetChild(iter_601_6)

					if var_601_17.name == "" or not string.find(var_601_17.name, "split") then
						var_601_17.gameObject:SetActive(true)
					else
						var_601_17.gameObject:SetActive(false)
					end
				end
			end

			local var_601_18 = 0.001

			if 3.8 <= arg_598_1.time_ and arg_598_1.time_ < 3.8 + var_601_18 then
				var_601_16.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_598_1.time_ - 3.8) / var_601_18)
			end

			if arg_598_1.time_ >= 3.8 + var_601_18 and arg_598_1.time_ < 3.8 + var_601_18 + arg_601_0 then
				var_601_16.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0.4 < arg_598_1.time_ and arg_598_1.time_ <= 0.4 + arg_601_0 then
				arg_598_1:AudioAction("stop", "effect", "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			if 1.53333333333333 < arg_598_1.time_ and arg_598_1.time_ <= 1.53333333333333 + arg_601_0 then
				arg_598_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_train_roof", "")
			end

			if 2 < arg_598_1.time_ and arg_598_1.time_ <= 2 + arg_601_0 then
				if arg_598_1.var_.effectcangmendakai then
					Object.Destroy(arg_598_1.var_.effectcangmendakai)

					arg_598_1.var_.effectcangmendakai = nil
				end
			end

			if 2 < arg_598_1.time_ and arg_598_1.time_ <= 2 + arg_601_0 then
				local var_601_22 = arg_598_1.var_.effectchedingsudu1

				if not arg_598_1.var_.effectchedingsudu1 then
					var_601_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_601_22.name = "chedingsudu1"
					arg_598_1.var_.effectchedingsudu1 = var_601_22
				else
					var_601_22.transform:SetParent(var_601_9000)
				end

				var_601_22.transform.localPosition = Vector3.New(0, 0, -4)
				var_601_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_598_1.frameCnt_ <= 1 then
				arg_598_1.dialog_:SetActive(false)
			end

			local var_601_24 = 4
			local var_601_25 = 0.7

			if 4 < arg_598_1.time_ and arg_598_1.time_ <= var_601_24 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0

				arg_598_1.dialog_:SetActive(true)

				arg_598_1.dialogCg_.alpha = 0

				local var_601_26 = LeanTween.value(arg_598_1.dialog_, 0, 1, 0.3)

				var_601_26:setOnUpdate(LuaHelper.FloatAction(function(arg_602_0)
					arg_598_1.dialogCg_.alpha = arg_602_0
				end))
				var_601_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_598_1.dialog_)
					var_601_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_598_1.duration_ = arg_598_1.duration_ + 0.3

				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_27 = arg_598_1:GetWordFromCfg(423011144)
				local var_601_28 = arg_598_1:FormatText(var_601_27.content)

				arg_598_1.text_.text = var_601_28

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_30 = 28 <= 0 and var_601_25 or var_601_25 * (utf8.len(var_601_28) / 28)

				if (28 <= 0 and var_601_25 or var_601_25 * (utf8.len(var_601_28) / 28)) > 0 and var_601_25 < var_601_30 then
					arg_598_1.talkMaxDuration = var_601_30
					var_601_24 = var_601_24 + 0.3

					if var_601_30 + var_601_24 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_30 + var_601_24
					end
				end

				arg_598_1.text_.text = var_601_28
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011144", "story_v_out_423011.awb") ~= 0 then
					local var_601_31 = manager.audio:GetVoiceLength("story_v_out_423011", "423011144", "story_v_out_423011.awb") / 1000

					if var_601_31 + var_601_24 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_31 + var_601_24
					end

					if var_601_27.prefab_name ~= "" and arg_598_1.actors_[var_601_27.prefab_name] ~= nil then
						local var_601_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_27.prefab_name].transform, "story_v_out_423011", "423011144", "story_v_out_423011.awb")

						arg_598_1:RecordAudio("423011144", var_601_32)
						arg_598_1:RecordAudio("423011144", var_601_32)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_out_423011", "423011144", "story_v_out_423011.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_out_423011", "423011144", "story_v_out_423011.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_33 = var_601_24 + 0.3
			local var_601_34 = math.max(var_601_25, arg_598_1.talkMaxDuration)

			if var_601_24 + 0.3 <= arg_598_1.time_ and arg_598_1.time_ < var_601_33 + var_601_34 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_33) / var_601_34

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_33 + var_601_34 and arg_598_1.time_ < var_601_33 + var_601_34 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play423011145 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 423011145
		arg_604_1.duration_ = 6.6

		local var_604_0 = {
			zh = 4.1,
			ja = 6.6
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play423011146(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["1083"]) and arg_604_1.var_.actorSpriteComps1083 == nil then
				arg_604_1.var_.actorSpriteComps1083 = arg_604_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_607_0 = 0.2

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["1083"]) then
				if arg_604_1.var_.actorSpriteComps1083 then
					for iter_607_0, iter_607_1 in pairs(arg_604_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_607_1 then
							if arg_604_1.isInRecall_ then
								iter_607_1.color = Color.New(Mathf.Lerp(iter_607_1.color.r, arg_604_1.hightColor2.r, (arg_604_1.time_ - 0) / var_607_0), Mathf.Lerp(iter_607_1.color.g, arg_604_1.hightColor2.g, (arg_604_1.time_ - 0) / var_607_0), (Mathf.Lerp(iter_607_1.color.b, arg_604_1.hightColor2.b, (arg_604_1.time_ - 0) / var_607_0)))
							else
								local var_607_1 = Mathf.Lerp(iter_607_1.color.r, 0.5, (arg_604_1.time_ - 0) / var_607_0)

								iter_607_1.color = Color.New(var_607_1, var_607_1, var_607_1)
							end
						end
					end
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["1083"]) and arg_604_1.var_.actorSpriteComps1083 then
				for iter_607_2, iter_607_3 in pairs(arg_604_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_607_3 then
						iter_607_3.color = arg_604_1.isInRecall_ and (arg_604_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_604_1.var_.actorSpriteComps1083 = nil
			end

			local var_607_2 = 0
			local var_607_3 = 0.575

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_2 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[1328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_4 = arg_604_1:GetWordFromCfg(423011145)
				local var_607_5 = arg_604_1:FormatText(var_607_4.content)

				arg_604_1.text_.text = var_607_5

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_7 = 23 <= 0 and var_607_3 or var_607_3 * (utf8.len(var_607_5) / 23)

				if (23 <= 0 and var_607_3 or var_607_3 * (utf8.len(var_607_5) / 23)) > 0 and var_607_3 < var_607_7 then
					arg_604_1.talkMaxDuration = var_607_7

					if var_607_7 + var_607_2 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_7 + var_607_2
					end
				end

				arg_604_1.text_.text = var_607_5
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011145", "story_v_out_423011.awb") ~= 0 then
					local var_607_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011145", "story_v_out_423011.awb") / 1000

					if var_607_8 + var_607_2 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_8 + var_607_2
					end

					if var_607_4.prefab_name ~= "" and arg_604_1.actors_[var_607_4.prefab_name] ~= nil then
						local var_607_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_4.prefab_name].transform, "story_v_out_423011", "423011145", "story_v_out_423011.awb")

						arg_604_1:RecordAudio("423011145", var_607_9)
						arg_604_1:RecordAudio("423011145", var_607_9)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_423011", "423011145", "story_v_out_423011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_423011", "423011145", "story_v_out_423011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_10 = math.max(var_607_3, arg_604_1.talkMaxDuration)

			if var_607_2 <= arg_604_1.time_ and arg_604_1.time_ < var_607_2 + var_607_10 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_2) / var_607_10

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_2 + var_607_10 and arg_604_1.time_ < var_607_2 + var_607_10 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play423011146 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 423011146
		arg_608_1.duration_ = 4.23

		local var_608_0 = {
			zh = 4.066,
			ja = 4.233
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play423011147(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 and not isNil(arg_608_1.actors_["1083"]) and arg_608_1.var_.actorSpriteComps1083 == nil then
				arg_608_1.var_.actorSpriteComps1083 = arg_608_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_611_0 = 0.2

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 and not isNil(arg_608_1.actors_["1083"]) then
				if arg_608_1.var_.actorSpriteComps1083 then
					for iter_611_0, iter_611_1 in pairs(arg_608_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_611_1 then
							if arg_608_1.isInRecall_ then
								iter_611_1.color = Color.New(Mathf.Lerp(iter_611_1.color.r, arg_608_1.hightColor1.r, (arg_608_1.time_ - 0) / var_611_0), Mathf.Lerp(iter_611_1.color.g, arg_608_1.hightColor1.g, (arg_608_1.time_ - 0) / var_611_0), (Mathf.Lerp(iter_611_1.color.b, arg_608_1.hightColor1.b, (arg_608_1.time_ - 0) / var_611_0)))
							else
								local var_611_1 = Mathf.Lerp(iter_611_1.color.r, 1, (arg_608_1.time_ - 0) / var_611_0)

								iter_611_1.color = Color.New(var_611_1, var_611_1, var_611_1)
							end
						end
					end
				end
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 and not isNil(arg_608_1.actors_["1083"]) and arg_608_1.var_.actorSpriteComps1083 then
				for iter_611_2, iter_611_3 in pairs(arg_608_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_611_3 then
						iter_611_3.color = arg_608_1.isInRecall_ and (arg_608_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_608_1.var_.actorSpriteComps1083 = nil
			end

			local var_611_2 = arg_608_1.actors_["1083"].transform

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos1083 = var_611_2.localPosition
				var_611_2.localScale = Vector3.New(1, 1, 1)

				arg_608_1:CheckSpriteTmpPos("1083", 3)

				for iter_611_4 = 0, var_611_2.childCount - 1 do
					local var_611_3 = var_611_2:GetChild(iter_611_4)

					if var_611_3.name == "split_7" or not string.find(var_611_3.name, "split") then
						var_611_3.gameObject:SetActive(true)
					else
						var_611_3.gameObject:SetActive(false)
					end
				end
			end

			local var_611_4 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_4 then
				var_611_2.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_608_1.time_ - 0) / var_611_4)
			end

			if arg_608_1.time_ >= 0 + var_611_4 and arg_608_1.time_ < 0 + var_611_4 + arg_611_0 then
				var_611_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_611_5 = 0
			local var_611_6 = 0.475

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_5 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_7 = arg_608_1:GetWordFromCfg(423011146)
				local var_611_8 = arg_608_1:FormatText(var_611_7.content)

				arg_608_1.text_.text = var_611_8

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_10 = 19 <= 0 and var_611_6 or var_611_6 * (utf8.len(var_611_8) / 19)

				if (19 <= 0 and var_611_6 or var_611_6 * (utf8.len(var_611_8) / 19)) > 0 and var_611_6 < var_611_10 then
					arg_608_1.talkMaxDuration = var_611_10

					if var_611_10 + var_611_5 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_10 + var_611_5
					end
				end

				arg_608_1.text_.text = var_611_8
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011146", "story_v_out_423011.awb") ~= 0 then
					local var_611_11 = manager.audio:GetVoiceLength("story_v_out_423011", "423011146", "story_v_out_423011.awb") / 1000

					if var_611_11 + var_611_5 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_11 + var_611_5
					end

					if var_611_7.prefab_name ~= "" and arg_608_1.actors_[var_611_7.prefab_name] ~= nil then
						local var_611_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_7.prefab_name].transform, "story_v_out_423011", "423011146", "story_v_out_423011.awb")

						arg_608_1:RecordAudio("423011146", var_611_12)
						arg_608_1:RecordAudio("423011146", var_611_12)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_out_423011", "423011146", "story_v_out_423011.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_out_423011", "423011146", "story_v_out_423011.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_13 = math.max(var_611_6, arg_608_1.talkMaxDuration)

			if var_611_5 <= arg_608_1.time_ and arg_608_1.time_ < var_611_5 + var_611_13 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_5) / var_611_13

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_5 + var_611_13 and arg_608_1.time_ < var_611_5 + var_611_13 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play423011147 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 423011147
		arg_612_1.duration_ = 5.17

		local var_612_0 = {
			zh = 4.133,
			ja = 5.166
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
			arg_612_1.auto_ = false
		end

		function arg_612_1.playNext_(arg_614_0)
			arg_612_1.onStoryFinished_()
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0.5

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_1 = arg_612_1:GetWordFromCfg(423011147)
				local var_615_2 = arg_612_1:FormatText(var_615_1.content)

				arg_612_1.text_.text = var_615_2

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_4 = 20 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_2) / 20)

				if (20 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_2) / 20)) > 0 and var_615_0 < var_615_4 then
					arg_612_1.talkMaxDuration = var_615_4

					if var_615_4 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_4 + 0
					end
				end

				arg_612_1.text_.text = var_615_2
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011147", "story_v_out_423011.awb") ~= 0 then
					local var_615_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011147", "story_v_out_423011.awb") / 1000

					if var_615_5 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_5 + 0
					end

					if var_615_1.prefab_name ~= "" and arg_612_1.actors_[var_615_1.prefab_name] ~= nil then
						local var_615_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_1.prefab_name].transform, "story_v_out_423011", "423011147", "story_v_out_423011.awb")

						arg_612_1:RecordAudio("423011147", var_615_6)
						arg_612_1:RecordAudio("423011147", var_615_6)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_423011", "423011147", "story_v_out_423011.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_423011", "423011147", "story_v_out_423011.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_7 = math.max(var_615_0, arg_612_1.talkMaxDuration)

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_7 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - 0) / var_615_7

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= 0 + var_615_7 and arg_612_1.time_ < 0 + var_615_7 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play423011038 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 423011038
		arg_616_1.duration_ = 7.53

		local var_616_0 = {
			zh = 5.9,
			ja = 7.533
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play423011039(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0.675

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_1 = arg_616_1:GetWordFromCfg(423011038)
				local var_619_2 = arg_616_1:FormatText(var_619_1.content)

				arg_616_1.text_.text = var_619_2

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_4 = 27 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_2) / 27)

				if (27 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_2) / 27)) > 0 and var_619_0 < var_619_4 then
					arg_616_1.talkMaxDuration = var_619_4

					if var_619_4 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_4 + 0
					end
				end

				arg_616_1.text_.text = var_619_2
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011038", "story_v_out_423011.awb") ~= 0 then
					local var_619_5 = manager.audio:GetVoiceLength("story_v_out_423011", "423011038", "story_v_out_423011.awb") / 1000

					if var_619_5 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_5 + 0
					end

					if var_619_1.prefab_name ~= "" and arg_616_1.actors_[var_619_1.prefab_name] ~= nil then
						local var_619_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_1.prefab_name].transform, "story_v_out_423011", "423011038", "story_v_out_423011.awb")

						arg_616_1:RecordAudio("423011038", var_619_6)
						arg_616_1:RecordAudio("423011038", var_619_6)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_423011", "423011038", "story_v_out_423011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_423011", "423011038", "story_v_out_423011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_7 = math.max(var_619_0, arg_616_1.talkMaxDuration)

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_7 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - 0) / var_619_7

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= 0 + var_619_7 and arg_616_1.time_ < 0 + var_619_7 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play423011039 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 423011039
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play423011040(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0.35

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, true)
				arg_620_1.iconController_:SetSelectedState("hero")

				arg_620_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_620_1.callingController_:SetSelectedState("normal")

				arg_620_1.keyicon_.color = Color.New(1, 1, 1)
				arg_620_1.icon_.color = Color.New(1, 1, 1)

				local var_623_1 = arg_620_1:FormatText(arg_620_1:GetWordFromCfg(423011039).content)

				arg_620_1.text_.text = var_623_1

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_3 = 14 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 14)

				if (14 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 14)) > 0 and var_623_0 < var_623_3 then
					arg_620_1.talkMaxDuration = var_623_3

					if var_623_3 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_3 + 0
					end
				end

				arg_620_1.text_.text = var_623_1
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_4 = math.max(var_623_0, arg_620_1.talkMaxDuration)

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_4 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - 0) / var_623_4

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= 0 + var_623_4 and arg_620_1.time_ < 0 + var_623_4 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play423011040 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 423011040
		arg_624_1.duration_ = 6

		local var_624_0 = {
			zh = 3.733,
			ja = 6
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play423011041(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.var_.moveOldPos1047 = arg_624_1.actors_["1047"].transform.localPosition
				arg_624_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_624_1:CheckSpriteTmpPos("1047", 3)

				for iter_627_0 = 0, arg_624_1.actors_["1047"].transform.childCount - 1 do
					local var_627_0 = arg_624_1.actors_["1047"].transform:GetChild(iter_627_0)

					if var_627_0.name == "split_1" or not string.find(var_627_0.name, "split") then
						var_627_0.gameObject:SetActive(true)
					else
						var_627_0.gameObject:SetActive(false)
					end
				end
			end

			local var_627_1 = 0.001

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_1 then
				arg_624_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_624_1.time_ - 0) / var_627_1)
			end

			if arg_624_1.time_ >= 0 + var_627_1 and arg_624_1.time_ < 0 + var_627_1 + arg_627_0 then
				arg_624_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_627_2 = 0
			local var_627_3 = 0.5

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_2 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_4 = arg_624_1:GetWordFromCfg(423011040)
				local var_627_5 = arg_624_1:FormatText(var_627_4.content)

				arg_624_1.text_.text = var_627_5

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_7 = 20 <= 0 and var_627_3 or var_627_3 * (utf8.len(var_627_5) / 20)

				if (20 <= 0 and var_627_3 or var_627_3 * (utf8.len(var_627_5) / 20)) > 0 and var_627_3 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_2 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_2
					end
				end

				arg_624_1.text_.text = var_627_5
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011040", "story_v_out_423011.awb") ~= 0 then
					local var_627_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011040", "story_v_out_423011.awb") / 1000

					if var_627_8 + var_627_2 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_8 + var_627_2
					end

					if var_627_4.prefab_name ~= "" and arg_624_1.actors_[var_627_4.prefab_name] ~= nil then
						local var_627_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_4.prefab_name].transform, "story_v_out_423011", "423011040", "story_v_out_423011.awb")

						arg_624_1:RecordAudio("423011040", var_627_9)
						arg_624_1:RecordAudio("423011040", var_627_9)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_423011", "423011040", "story_v_out_423011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_423011", "423011040", "story_v_out_423011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_10 = math.max(var_627_3, arg_624_1.talkMaxDuration)

			if var_627_2 <= arg_624_1.time_ and arg_624_1.time_ < var_627_2 + var_627_10 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_2) / var_627_10

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_2 + var_627_10 and arg_624_1.time_ < var_627_2 + var_627_10 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25g",
		"TextureConfig/Background/ST0111",
		"TextureConfig/Background/ST0113",
		"TextureConfig/Background/SS2301",
		"TextureConfig/Background/SS2301a",
		"TextureConfig/Background/I24f"
	},
	voices = {
		"story_v_out_423011.awb"
	}
}
