return {
	Play321011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321011001
		arg_1_1.duration_ = 6.13

		local var_1_0 = {
			zh = 6.133,
			ja = 5.733
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
				arg_1_0:Play321011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(321011001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 13 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 13)

				if (13 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 13)) > 0 and var_4_14 < var_4_19 then
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

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011001", "story_v_out_321011.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_321011", "321011001", "story_v_out_321011.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_321011", "321011001", "story_v_out_321011.awb")

						arg_1_1:RecordAudio("321011001", var_4_21)
						arg_1_1:RecordAudio("321011001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321011", "321011001", "story_v_out_321011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321011", "321011001", "story_v_out_321011.awb")
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
	Play321011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 321011002
		arg_8_1.duration_ = 1.73

		local var_8_0 = {
			zh = 1,
			ja = 1.733
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
				arg_8_0:Play321011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.05

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(321011002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 2 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 2)

				if (2 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 2)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011002", "story_v_out_321011.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011002", "story_v_out_321011.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_321011", "321011002", "story_v_out_321011.awb")

						arg_8_1:RecordAudio("321011002", var_11_6)
						arg_8_1:RecordAudio("321011002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_321011", "321011002", "story_v_out_321011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_321011", "321011002", "story_v_out_321011.awb")
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
	Play321011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 321011003
		arg_12_1.duration_ = 8.6

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play321011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.bgs_.ST0504 == nil then
				local var_15_0 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0504")
				var_15_0.name = "ST0504"
				var_15_0.transform.parent = arg_12_1.stage_.transform
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_.ST0504 = var_15_0
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_1 = arg_12_1.bgs_.ST0504

				arg_12_1.bgs_.ST0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_2 = var_15_1:GetComponent("SpriteRenderer")

				if var_15_2 and var_15_2.sprite then
					local var_15_3 = 2 * (var_15_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_1.transform.localScale = Vector3.New(var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "ST0504" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_4 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_4 + 0.3 and arg_12_1.time_ < var_15_4 + 0.3 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_5 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_6 = 2

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = Color.New(0, 0, 0)

				var_15_7.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - var_15_5) / var_15_6)
				arg_12_1.mask_.color = var_15_7
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				local var_15_8 = Color.New(0, 0, 0)

				var_15_8.a = 1
				arg_12_1.mask_.color = var_15_8
			end

			local var_15_9 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_10 = 2

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_10 then
				local var_15_11 = Color.New(0, 0, 0)

				var_15_11.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_9) / var_15_10)
				arg_12_1.mask_.color = var_15_11
			end

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 then
				local var_15_12 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_12.a = 0
				arg_12_1.mask_.color = var_15_12
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_15_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_15 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_15

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_15
						arg_12_1.bgmTxt2_.text = var_15_15
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

			if 1.86666666666667 < arg_12_1.time_ and arg_12_1.time_ <= 1.86666666666667 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet.awb")

				local var_15_18 = manager.audio:GetAudioName("bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_18 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_18

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_18
						arg_12_1.bgmTxt2_.text = var_15_18
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

			local var_15_19 = 3.6
			local var_15_20 = 1.125

			if 3.6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_21 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_21:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_12_1.dialogCg_.alpha = arg_18_0
				end))
				var_15_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_22 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(321011003).content)

				arg_12_1.text_.text = var_15_22

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_24 = 45 <= 0 and var_15_20 or var_15_20 * (utf8.len(var_15_22) / 45)

				if (45 <= 0 and var_15_20 or var_15_20 * (utf8.len(var_15_22) / 45)) > 0 and var_15_20 < var_15_24 then
					arg_12_1.talkMaxDuration = var_15_24
					var_15_19 = var_15_19 + 0.3

					if var_15_24 + var_15_19 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_24 + var_15_19
					end
				end

				arg_12_1.text_.text = var_15_22
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_25 = var_15_19 + 0.3
			local var_15_26 = math.max(var_15_20, arg_12_1.talkMaxDuration)

			if var_15_19 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_25 + var_15_26 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_25) / var_15_26

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_25 + var_15_26 and arg_12_1.time_ < var_15_25 + var_15_26 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play321011004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 321011004
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play321011005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.25

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

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(321011004).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 50 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 50)

				if (50 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 50)) > 0 and var_23_0 < var_23_3 then
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
	Play321011005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 321011005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play321011006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.575

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(321011005).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 63 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 63)

				if (63 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 63)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play321011006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 321011006
		arg_28_1.duration_ = 9.47

		local var_28_0 = {
			zh = 7.966,
			ja = 9.466
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
				arg_28_0:Play321011007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_140", "se_story_140_action_morning01_down", "")
			end

			local var_31_1 = 0
			local var_31_2 = 0.875

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(321011006)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 35 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 35)

				if (35 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 35)) > 0 and var_31_2 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011006", "story_v_out_321011.awb") ~= 0 then
					local var_31_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011006", "story_v_out_321011.awb") / 1000

					if var_31_7 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_1
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_321011", "321011006", "story_v_out_321011.awb")

						arg_28_1:RecordAudio("321011006", var_31_8)
						arg_28_1:RecordAudio("321011006", var_31_8)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_321011", "321011006", "story_v_out_321011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_321011", "321011006", "story_v_out_321011.awb")
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
	Play321011007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 321011007
		arg_32_1.duration_ = 13.53

		local var_32_0 = {
			zh = 8,
			ja = 13.533
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
				arg_32_0:Play321011008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.1

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(321011007)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 44 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 44)

				if (44 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 44)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011007", "story_v_out_321011.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011007", "story_v_out_321011.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_321011", "321011007", "story_v_out_321011.awb")

						arg_32_1:RecordAudio("321011007", var_35_6)
						arg_32_1:RecordAudio("321011007", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_321011", "321011007", "story_v_out_321011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_321011", "321011007", "story_v_out_321011.awb")
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
	Play321011008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 321011008
		arg_36_1.duration_ = 10.87

		local var_36_0 = {
			zh = 9.433,
			ja = 10.866
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
				arg_36_0:Play321011009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.025

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(321011008)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 41 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 41)

				if (41 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 41)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011008", "story_v_out_321011.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011008", "story_v_out_321011.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_321011", "321011008", "story_v_out_321011.awb")

						arg_36_1:RecordAudio("321011008", var_39_6)
						arg_36_1:RecordAudio("321011008", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_321011", "321011008", "story_v_out_321011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_321011", "321011008", "story_v_out_321011.awb")
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
	Play321011009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 321011009
		arg_40_1.duration_ = 10.8

		local var_40_0 = {
			zh = 8.866,
			ja = 10.8
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
				arg_40_0:Play321011010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.925

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(321011009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 37 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 37)

				if (37 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 37)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011009", "story_v_out_321011.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011009", "story_v_out_321011.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_321011", "321011009", "story_v_out_321011.awb")

						arg_40_1:RecordAudio("321011009", var_43_6)
						arg_40_1:RecordAudio("321011009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_321011", "321011009", "story_v_out_321011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_321011", "321011009", "story_v_out_321011.awb")
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
	Play321011010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 321011010
		arg_44_1.duration_ = 13.87

		local var_44_0 = {
			zh = 11.566,
			ja = 13.866
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
				arg_44_0:Play321011011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.95

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(321011010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 38 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 38)

				if (38 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 38)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011010", "story_v_out_321011.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011010", "story_v_out_321011.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_321011", "321011010", "story_v_out_321011.awb")

						arg_44_1:RecordAudio("321011010", var_47_6)
						arg_44_1:RecordAudio("321011010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_321011", "321011010", "story_v_out_321011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_321011", "321011010", "story_v_out_321011.awb")
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
	Play321011011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 321011011
		arg_48_1.duration_ = 10.07

		local var_48_0 = {
			zh = 9.566,
			ja = 10.066
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
				arg_48_0:Play321011012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.95

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:GetWordFromCfg(321011011)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 38 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 38)

				if (38 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 38)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011011", "story_v_out_321011.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011011", "story_v_out_321011.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_321011", "321011011", "story_v_out_321011.awb")

						arg_48_1:RecordAudio("321011011", var_51_6)
						arg_48_1:RecordAudio("321011011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_321011", "321011011", "story_v_out_321011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_321011", "321011011", "story_v_out_321011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play321011012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 321011012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play321011013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.55

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(321011012).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 22 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 22)

				if (22 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 22)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play321011013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 321011013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play321011014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.6

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(321011013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 64 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 64)

				if (64 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 64)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play321011014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 321011014
		arg_60_1.duration_ = 4.9

		local var_60_0 = {
			zh = 4.633,
			ja = 4.9
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
				arg_60_0:Play321011015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.65

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(321011014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 26 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 26)

				if (26 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 26)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011014", "story_v_out_321011.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011014", "story_v_out_321011.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_321011", "321011014", "story_v_out_321011.awb")

						arg_60_1:RecordAudio("321011014", var_63_6)
						arg_60_1:RecordAudio("321011014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_321011", "321011014", "story_v_out_321011.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_321011", "321011014", "story_v_out_321011.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play321011015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 321011015
		arg_64_1.duration_ = 3.1

		local var_64_0 = {
			zh = 2.8,
			ja = 3.1
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
				arg_64_0:Play321011016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(321011015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 10 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 10)

				if (10 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 10)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011015", "story_v_out_321011.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011015", "story_v_out_321011.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_321011", "321011015", "story_v_out_321011.awb")

						arg_64_1:RecordAudio("321011015", var_67_6)
						arg_64_1:RecordAudio("321011015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_321011", "321011015", "story_v_out_321011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_321011", "321011015", "story_v_out_321011.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play321011016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 321011016
		arg_68_1.duration_ = 11.2

		local var_68_0 = {
			zh = 6.2,
			ja = 11.2
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
				arg_68_0:Play321011017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.675

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(321011016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 27 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 27)

				if (27 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 27)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011016", "story_v_out_321011.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011016", "story_v_out_321011.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_321011", "321011016", "story_v_out_321011.awb")

						arg_68_1:RecordAudio("321011016", var_71_6)
						arg_68_1:RecordAudio("321011016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_321011", "321011016", "story_v_out_321011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_321011", "321011016", "story_v_out_321011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play321011017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 321011017
		arg_72_1.duration_ = 18.47

		local var_72_0 = {
			zh = 11.633,
			ja = 18.466
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
				arg_72_0:Play321011018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.45

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(321011017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 58 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 58)

				if (58 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 58)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011017", "story_v_out_321011.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011017", "story_v_out_321011.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_321011", "321011017", "story_v_out_321011.awb")

						arg_72_1:RecordAudio("321011017", var_75_6)
						arg_72_1:RecordAudio("321011017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_321011", "321011017", "story_v_out_321011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_321011", "321011017", "story_v_out_321011.awb")
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
	Play321011018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 321011018
		arg_76_1.duration_ = 22.1

		local var_76_0 = {
			zh = 12,
			ja = 22.1
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
				arg_76_0:Play321011019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.15

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:GetWordFromCfg(321011018)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 46 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 46)

				if (46 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 46)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011018", "story_v_out_321011.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011018", "story_v_out_321011.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_321011", "321011018", "story_v_out_321011.awb")

						arg_76_1:RecordAudio("321011018", var_79_6)
						arg_76_1:RecordAudio("321011018", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_321011", "321011018", "story_v_out_321011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_321011", "321011018", "story_v_out_321011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play321011019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 321011019
		arg_80_1.duration_ = 8.6

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play321011020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.bgs_.MS2101 == nil then
				local var_83_0 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2101")
				var_83_0.name = "MS2101"
				var_83_0.transform.parent = arg_80_1.stage_.transform
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_.MS2101 = var_83_0
			end

			if 1.98333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 1.98333333333333 + arg_83_0 then
				local var_83_1 = arg_80_1.bgs_.MS2101

				arg_80_1.bgs_.MS2101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_83_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_2 = var_83_1:GetComponent("SpriteRenderer")

				if var_83_2 and var_83_2.sprite then
					local var_83_3 = 2 * (var_83_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_83_1.transform.localScale = Vector3.New(var_83_3 / var_83_2.sprite.bounds.size.y < var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x and var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x or var_83_3 / var_83_2.sprite.bounds.size.y, var_83_3 / var_83_2.sprite.bounds.size.y < var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x and var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x or var_83_3 / var_83_2.sprite.bounds.size.y, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "MS2101" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_4 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_4 + 0.3 and arg_80_1.time_ < var_83_4 + 0.3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_5 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_6 = 2

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 then
				local var_83_7 = Color.New(0, 0, 0)

				var_83_7.a = Mathf.Lerp(0, 1, (arg_80_1.time_ - var_83_5) / var_83_6)
				arg_80_1.mask_.color = var_83_7
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 then
				local var_83_8 = Color.New(0, 0, 0)

				var_83_8.a = 1
				arg_80_1.mask_.color = var_83_8
			end

			local var_83_9 = 2

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_10 = 2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 then
				local var_83_11 = Color.New(0, 0, 0)

				var_83_11.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_9) / var_83_10)
				arg_80_1.mask_.color = var_83_11
			end

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 then
				local var_83_12 = Color.New(0, 0, 0)

				arg_80_1.mask_.enabled = false
				var_83_12.a = 0
				arg_80_1.mask_.color = var_83_12
			end

			local var_83_13 = arg_80_1.bgs_.MS2101.transform

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				arg_80_1.var_.moveOldPosMS2101 = var_83_13.localPosition
			end

			local var_83_14 = 0.001

			if 2 <= arg_80_1.time_ and arg_80_1.time_ < 2 + var_83_14 then
				var_83_13.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosMS2101, Vector3.New(0, 1, 9), (arg_80_1.time_ - 2) / var_83_14)
			end

			if arg_80_1.time_ >= 2 + var_83_14 and arg_80_1.time_ < 2 + var_83_14 + arg_83_0 then
				var_83_13.localPosition = Vector3.New(0, 1, 9)
			end

			local var_83_15 = arg_80_1.bgs_.MS2101.transform

			if 2.01666666666667 < arg_80_1.time_ and arg_80_1.time_ <= 2.01666666666667 + arg_83_0 then
				arg_80_1.var_.moveOldPosMS2101 = var_83_15.localPosition
			end

			local var_83_16 = 1.98333333333333

			if 2.01666666666667 <= arg_80_1.time_ and arg_80_1.time_ < 2.01666666666667 + var_83_16 then
				var_83_15.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosMS2101, Vector3.New(0, 1, 10), (arg_80_1.time_ - 2.01666666666667) / var_83_16)
			end

			if arg_80_1.time_ >= 2.01666666666667 + var_83_16 and arg_80_1.time_ < 2.01666666666667 + var_83_16 + arg_83_0 then
				var_83_15.localPosition = Vector3.New(0, 1, 10)
			end

			if 1.6 < arg_80_1.time_ and arg_80_1.time_ <= 1.6 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_morning_loop", "")
			end

			if 1.6 < arg_80_1.time_ and arg_80_1.time_ <= 1.6 + arg_83_0 then
				arg_80_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 4.33333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 4.33333333333333 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_140", "se_story_140_action01", "")
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_20 = 3.6
			local var_83_21 = 1

			if 3.6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_22 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_22:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_23 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(321011019).content)

				arg_80_1.text_.text = var_83_23

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_25 = 40 <= 0 and var_83_21 or var_83_21 * (utf8.len(var_83_23) / 40)

				if (40 <= 0 and var_83_21 or var_83_21 * (utf8.len(var_83_23) / 40)) > 0 and var_83_21 < var_83_25 then
					arg_80_1.talkMaxDuration = var_83_25
					var_83_20 = var_83_20 + 0.3

					if var_83_25 + var_83_20 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_25 + var_83_20
					end
				end

				arg_80_1.text_.text = var_83_23
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_26 = var_83_20 + 0.3
			local var_83_27 = math.max(var_83_21, arg_80_1.talkMaxDuration)

			if var_83_20 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_26 + var_83_27 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_26) / var_83_27

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_26 + var_83_27 and arg_80_1.time_ < var_83_26 + var_83_27 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play321011020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 321011020
		arg_86_1.duration_ = 9.17

		local var_86_0 = {
			zh = 6.333,
			ja = 9.166
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
				arg_86_0:Play321011021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.8

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(321011020)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 32 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 32)

				if (32 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 32)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011020", "story_v_out_321011.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011020", "story_v_out_321011.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_321011", "321011020", "story_v_out_321011.awb")

						arg_86_1:RecordAudio("321011020", var_89_6)
						arg_86_1:RecordAudio("321011020", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_321011", "321011020", "story_v_out_321011.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_321011", "321011020", "story_v_out_321011.awb")
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
	Play321011021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 321011021
		arg_90_1.duration_ = 5.3

		local var_90_0 = {
			zh = 3.1,
			ja = 5.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play321011022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.4

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(321011021)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 16 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 16)

				if (16 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 16)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011021", "story_v_out_321011.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011021", "story_v_out_321011.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_321011", "321011021", "story_v_out_321011.awb")

						arg_90_1:RecordAudio("321011021", var_93_6)
						arg_90_1:RecordAudio("321011021", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_321011", "321011021", "story_v_out_321011.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_321011", "321011021", "story_v_out_321011.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play321011022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 321011022
		arg_94_1.duration_ = 3.57

		local var_94_0 = {
			zh = 2.266,
			ja = 3.566
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play321011023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.175

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(321011022)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 7 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 7)

				if (7 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 7)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011022", "story_v_out_321011.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011022", "story_v_out_321011.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_321011", "321011022", "story_v_out_321011.awb")

						arg_94_1:RecordAudio("321011022", var_97_6)
						arg_94_1:RecordAudio("321011022", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_321011", "321011022", "story_v_out_321011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_321011", "321011022", "story_v_out_321011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play321011023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 321011023
		arg_98_1.duration_ = 1

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play321011024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.05

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(321011023)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 2 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 2)

				if (2 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 2)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011023", "story_v_out_321011.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011023", "story_v_out_321011.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_321011", "321011023", "story_v_out_321011.awb")

						arg_98_1:RecordAudio("321011023", var_101_6)
						arg_98_1:RecordAudio("321011023", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_321011", "321011023", "story_v_out_321011.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_321011", "321011023", "story_v_out_321011.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play321011024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 321011024
		arg_102_1.duration_ = 4.17

		local var_102_0 = {
			zh = 2.3,
			ja = 4.166
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play321011025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.3

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(321011024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 12 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 12)

				if (12 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 12)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011024", "story_v_out_321011.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011024", "story_v_out_321011.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_321011", "321011024", "story_v_out_321011.awb")

						arg_102_1:RecordAudio("321011024", var_105_6)
						arg_102_1:RecordAudio("321011024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_321011", "321011024", "story_v_out_321011.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_321011", "321011024", "story_v_out_321011.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play321011025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 321011025
		arg_106_1.duration_ = 12.17

		local var_106_0 = {
			zh = 8.9,
			ja = 12.166
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play321011026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.075

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(321011025)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 43 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 43)

				if (43 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 43)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011025", "story_v_out_321011.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011025", "story_v_out_321011.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_321011", "321011025", "story_v_out_321011.awb")

						arg_106_1:RecordAudio("321011025", var_109_6)
						arg_106_1:RecordAudio("321011025", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_321011", "321011025", "story_v_out_321011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_321011", "321011025", "story_v_out_321011.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play321011026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 321011026
		arg_110_1.duration_ = 9.73

		local var_110_0 = {
			zh = 4.6,
			ja = 9.733
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play321011027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.525

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(321011026)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 21 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 21)

				if (21 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 21)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011026", "story_v_out_321011.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011026", "story_v_out_321011.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_321011", "321011026", "story_v_out_321011.awb")

						arg_110_1:RecordAudio("321011026", var_113_6)
						arg_110_1:RecordAudio("321011026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_321011", "321011026", "story_v_out_321011.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_321011", "321011026", "story_v_out_321011.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play321011027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 321011027
		arg_114_1.duration_ = 8.37

		local var_114_0 = {
			zh = 4.4,
			ja = 8.366
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play321011028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.55

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(321011027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 22)

				if (22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 22)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011027", "story_v_out_321011.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011027", "story_v_out_321011.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_321011", "321011027", "story_v_out_321011.awb")

						arg_114_1:RecordAudio("321011027", var_117_6)
						arg_114_1:RecordAudio("321011027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_321011", "321011027", "story_v_out_321011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_321011", "321011027", "story_v_out_321011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play321011028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 321011028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play321011029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.8

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(321011028).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 32 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 32)

				if (32 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 32)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play321011029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 321011029
		arg_122_1.duration_ = 5.7

		local var_122_0 = {
			zh = 3.53266666666667,
			ja = 5.69966666666667
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
				arg_122_0:Play321011030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPosMS2101 = arg_122_1.bgs_.MS2101.transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.bgs_.MS2101.transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPosMS2101, Vector3.New(0, 1, 10), (arg_122_1.time_ - 0) / var_125_0)
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.bgs_.MS2101.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_125_1 = arg_122_1.bgs_.MS2101.transform

			if 0.0166666666666666 < arg_122_1.time_ and arg_122_1.time_ <= 0.0166666666666666 + arg_125_0 then
				arg_122_1.var_.moveOldPosMS2101 = var_125_1.localPosition
			end

			local var_125_2 = 2.55

			if 0.0166666666666666 <= arg_122_1.time_ and arg_122_1.time_ < 0.0166666666666666 + var_125_2 then
				var_125_1.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPosMS2101, Vector3.New(-0.54, 0.43, 7.61), (arg_122_1.time_ - 0.0166666666666666) / var_125_2)
			end

			if arg_122_1.time_ >= 0.0166666666666666 + var_125_2 and arg_122_1.time_ < 0.0166666666666666 + var_125_2 + arg_125_0 then
				var_125_1.localPosition = Vector3.New(-0.54, 0.43, 7.61)
			end

			local var_125_3 = 0

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_3 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			if arg_122_1.time_ >= var_125_3 + 2.13333333333333 and arg_122_1.time_ < var_125_3 + 2.13333333333333 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_4 = 1.56666666666667
			local var_125_5 = 0.2

			if 1.56666666666667 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_6 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_6:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_7 = arg_122_1:GetWordFromCfg(321011029)
				local var_125_8 = arg_122_1:FormatText(var_125_7.content)

				arg_122_1.text_.text = var_125_8

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_10 = 8 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_8) / 8)

				if (8 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_8) / 8)) > 0 and var_125_5 < var_125_10 then
					arg_122_1.talkMaxDuration = var_125_10
					var_125_4 = var_125_4 + 0.3

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_8
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011029", "story_v_out_321011.awb") ~= 0 then
					local var_125_11 = manager.audio:GetVoiceLength("story_v_out_321011", "321011029", "story_v_out_321011.awb") / 1000

					if var_125_11 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_4
					end

					if var_125_7.prefab_name ~= "" and arg_122_1.actors_[var_125_7.prefab_name] ~= nil then
						local var_125_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_7.prefab_name].transform, "story_v_out_321011", "321011029", "story_v_out_321011.awb")

						arg_122_1:RecordAudio("321011029", var_125_12)
						arg_122_1:RecordAudio("321011029", var_125_12)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_321011", "321011029", "story_v_out_321011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_321011", "321011029", "story_v_out_321011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = var_125_4 + 0.3
			local var_125_14 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 + 0.3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_13 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_13) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_13 + var_125_14 and arg_122_1.time_ < var_125_13 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.55,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play321011030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 321011030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play321011031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1.15

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(321011030).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 46 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 46)

				if (46 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 46)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play321011031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 321011031
		arg_132_1.duration_ = 8.7

		local var_132_0 = {
			zh = 6.333,
			ja = 8.7
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
				arg_132_0:Play321011032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.65

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(321011031)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 26 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 26)

				if (26 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 26)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011031", "story_v_out_321011.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011031", "story_v_out_321011.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_321011", "321011031", "story_v_out_321011.awb")

						arg_132_1:RecordAudio("321011031", var_135_6)
						arg_132_1:RecordAudio("321011031", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_321011", "321011031", "story_v_out_321011.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_321011", "321011031", "story_v_out_321011.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play321011032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 321011032
		arg_136_1.duration_ = 9.17

		local var_136_0 = {
			zh = 8.566,
			ja = 9.166
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
				arg_136_0:Play321011033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(321011032)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 38 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 38)

				if (38 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 38)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011032", "story_v_out_321011.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011032", "story_v_out_321011.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_321011", "321011032", "story_v_out_321011.awb")

						arg_136_1:RecordAudio("321011032", var_139_6)
						arg_136_1:RecordAudio("321011032", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_321011", "321011032", "story_v_out_321011.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_321011", "321011032", "story_v_out_321011.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play321011033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 321011033
		arg_140_1.duration_ = 12.83

		local var_140_0 = {
			zh = 11.366,
			ja = 12.833
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
				arg_140_0:Play321011034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.95

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(321011033)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 38 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 38)

				if (38 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 38)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011033", "story_v_out_321011.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011033", "story_v_out_321011.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_321011", "321011033", "story_v_out_321011.awb")

						arg_140_1:RecordAudio("321011033", var_143_6)
						arg_140_1:RecordAudio("321011033", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_321011", "321011033", "story_v_out_321011.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_321011", "321011033", "story_v_out_321011.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play321011034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 321011034
		arg_144_1.duration_ = 15.73

		local var_144_0 = {
			zh = 10.6,
			ja = 15.733
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
				arg_144_0:Play321011035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.975

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(321011034)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 39 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 39)

				if (39 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 39)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011034", "story_v_out_321011.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011034", "story_v_out_321011.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_321011", "321011034", "story_v_out_321011.awb")

						arg_144_1:RecordAudio("321011034", var_147_6)
						arg_144_1:RecordAudio("321011034", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_321011", "321011034", "story_v_out_321011.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_321011", "321011034", "story_v_out_321011.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play321011035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 321011035
		arg_148_1.duration_ = 12.83

		local var_148_0 = {
			zh = 9.4,
			ja = 12.833
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play321011036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 1.1

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(321011035)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 44 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 44)

				if (44 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 44)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011035", "story_v_out_321011.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011035", "story_v_out_321011.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_321011", "321011035", "story_v_out_321011.awb")

						arg_148_1:RecordAudio("321011035", var_151_6)
						arg_148_1:RecordAudio("321011035", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_321011", "321011035", "story_v_out_321011.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_321011", "321011035", "story_v_out_321011.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play321011036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 321011036
		arg_152_1.duration_ = 16.47

		local var_152_0 = {
			zh = 8.733,
			ja = 16.466
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
				arg_152_0:Play321011037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(321011036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 40 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 40)

				if (40 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 40)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011036", "story_v_out_321011.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011036", "story_v_out_321011.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_321011", "321011036", "story_v_out_321011.awb")

						arg_152_1:RecordAudio("321011036", var_155_6)
						arg_152_1:RecordAudio("321011036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_321011", "321011036", "story_v_out_321011.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_321011", "321011036", "story_v_out_321011.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play321011037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 321011037
		arg_156_1.duration_ = 12.1

		local var_156_0 = {
			zh = 7,
			ja = 12.1
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
				arg_156_0:Play321011038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.8

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(321011037)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 32 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 32)

				if (32 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 32)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011037", "story_v_out_321011.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011037", "story_v_out_321011.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_321011", "321011037", "story_v_out_321011.awb")

						arg_156_1:RecordAudio("321011037", var_159_6)
						arg_156_1:RecordAudio("321011037", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_321011", "321011037", "story_v_out_321011.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_321011", "321011037", "story_v_out_321011.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play321011038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 321011038
		arg_160_1.duration_ = 7.33

		local var_160_0 = {
			zh = 3.966,
			ja = 7.333
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play321011039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.35

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(321011038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 14 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 14)

				if (14 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 14)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011038", "story_v_out_321011.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011038", "story_v_out_321011.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_321011", "321011038", "story_v_out_321011.awb")

						arg_160_1:RecordAudio("321011038", var_163_6)
						arg_160_1:RecordAudio("321011038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_321011", "321011038", "story_v_out_321011.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_321011", "321011038", "story_v_out_321011.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play321011039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 321011039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play321011040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.35

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(321011039).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 54 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 54)

				if (54 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 54)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play321011040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 321011040
		arg_168_1.duration_ = 12.33

		local var_168_0 = {
			zh = 10.5,
			ja = 12.333
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play321011041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.775

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:GetWordFromCfg(321011040)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 31 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 31)

				if (31 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 31)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011040", "story_v_out_321011.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011040", "story_v_out_321011.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_321011", "321011040", "story_v_out_321011.awb")

						arg_168_1:RecordAudio("321011040", var_171_6)
						arg_168_1:RecordAudio("321011040", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_321011", "321011040", "story_v_out_321011.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_321011", "321011040", "story_v_out_321011.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play321011041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 321011041
		arg_172_1.duration_ = 6.17

		local var_172_0 = {
			zh = 5.133,
			ja = 6.166
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play321011042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.625

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(321011041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 25 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 25)

				if (25 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 25)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011041", "story_v_out_321011.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011041", "story_v_out_321011.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_321011", "321011041", "story_v_out_321011.awb")

						arg_172_1:RecordAudio("321011041", var_175_6)
						arg_172_1:RecordAudio("321011041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_321011", "321011041", "story_v_out_321011.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_321011", "321011041", "story_v_out_321011.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play321011042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 321011042
		arg_176_1.duration_ = 8.7

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play321011043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 2 < arg_176_1.time_ and arg_176_1.time_ <= 2 + arg_179_0 then
				local var_179_0 = arg_176_1.bgs_.ST0504

				arg_176_1.bgs_.ST0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_179_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_1 = var_179_0:GetComponent("SpriteRenderer")

				if var_179_1 and var_179_1.sprite then
					local var_179_2 = 2 * (var_179_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_179_0.transform.localScale = Vector3.New(var_179_2 / var_179_1.sprite.bounds.size.y < var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x and var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x or var_179_2 / var_179_1.sprite.bounds.size.y, var_179_2 / var_179_1.sprite.bounds.size.y < var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x and var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x or var_179_2 / var_179_1.sprite.bounds.size.y, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "ST0504" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_3 = 0

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_3 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			if arg_176_1.time_ >= var_179_3 + 0.3 and arg_176_1.time_ < var_179_3 + 0.3 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end

			local var_179_4 = 0

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_5 = 2

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_5 then
				local var_179_6 = Color.New(0, 0, 0)

				var_179_6.a = Mathf.Lerp(0, 1, (arg_176_1.time_ - var_179_4) / var_179_5)
				arg_176_1.mask_.color = var_179_6
			end

			if arg_176_1.time_ >= var_179_4 + var_179_5 and arg_176_1.time_ < var_179_4 + var_179_5 + arg_179_0 then
				local var_179_7 = Color.New(0, 0, 0)

				var_179_7.a = 1
				arg_176_1.mask_.color = var_179_7
			end

			local var_179_8 = 2

			if 2 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_9 = 2

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_9 then
				local var_179_10 = Color.New(0, 0, 0)

				var_179_10.a = Mathf.Lerp(1, 0, (arg_176_1.time_ - var_179_8) / var_179_9)
				arg_176_1.mask_.color = var_179_10
			end

			if arg_176_1.time_ >= var_179_8 + var_179_9 and arg_176_1.time_ < var_179_8 + var_179_9 + arg_179_0 then
				local var_179_11 = Color.New(0, 0, 0)

				arg_176_1.mask_.enabled = false
				var_179_11.a = 0
				arg_176_1.mask_.color = var_179_11
			end

			if 1.6 < arg_176_1.time_ and arg_176_1.time_ <= 1.6 + arg_179_0 then
				arg_176_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_morning_loop", "")
			end

			if 1.6 < arg_176_1.time_ and arg_176_1.time_ <= 1.6 + arg_179_0 then
				arg_176_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_176_1.frameCnt_ <= 1 then
				arg_176_1.dialog_:SetActive(false)
			end

			local var_179_14 = 3.7
			local var_179_15 = 0.725

			if 3.7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				arg_176_1.dialog_:SetActive(true)

				arg_176_1.dialogCg_.alpha = 0

				local var_179_16 = LeanTween.value(arg_176_1.dialog_, 0, 1, 0.3)

				var_179_16:setOnUpdate(LuaHelper.FloatAction(function(arg_180_0)
					arg_176_1.dialogCg_.alpha = arg_180_0
				end))
				var_179_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_176_1.dialog_)
					var_179_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_176_1.duration_ = arg_176_1.duration_ + 0.3

				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_17 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(321011042).content)

				arg_176_1.text_.text = var_179_17

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_19 = 29 <= 0 and var_179_15 or var_179_15 * (utf8.len(var_179_17) / 29)

				if (29 <= 0 and var_179_15 or var_179_15 * (utf8.len(var_179_17) / 29)) > 0 and var_179_15 < var_179_19 then
					arg_176_1.talkMaxDuration = var_179_19
					var_179_14 = var_179_14 + 0.3

					if var_179_19 + var_179_14 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_19 + var_179_14
					end
				end

				arg_176_1.text_.text = var_179_17
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_20 = var_179_14 + 0.3
			local var_179_21 = math.max(var_179_15, arg_176_1.talkMaxDuration)

			if var_179_14 + 0.3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_20 + var_179_21 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_20) / var_179_21

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_20 + var_179_21 and arg_176_1.time_ < var_179_20 + var_179_21 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play321011043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 321011043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play321011044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0.833333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 0.833333333333333 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk02", "")
			end

			local var_185_1 = 0
			local var_185_2 = 1.175

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(321011043).content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 47 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 47)

				if (47 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 47)) > 0 and var_185_2 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_6 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_6 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_6

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_6 and arg_182_1.time_ < var_185_1 + var_185_6 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play321011044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 321011044
		arg_186_1.duration_ = 3.17

		local var_186_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_186_0:Play321011045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.3

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:GetWordFromCfg(321011044)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 12 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 12)

				if (12 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 12)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011044", "story_v_out_321011.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011044", "story_v_out_321011.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_321011", "321011044", "story_v_out_321011.awb")

						arg_186_1:RecordAudio("321011044", var_189_6)
						arg_186_1:RecordAudio("321011044", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_321011", "321011044", "story_v_out_321011.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_321011", "321011044", "story_v_out_321011.awb")
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
	Play321011045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 321011045
		arg_190_1.duration_ = 7.47

		local var_190_0 = {
			zh = 6.566,
			ja = 7.466
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play321011046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if arg_190_1.bgs_.MS2101a == nil then
				local var_193_0 = Object.Instantiate(arg_190_1.paintGo_)

				var_193_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2101a")
				var_193_0.name = "MS2101a"
				var_193_0.transform.parent = arg_190_1.stage_.transform
				var_193_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_190_1.bgs_.MS2101a = var_193_0
			end

			if 1.7 < arg_190_1.time_ and arg_190_1.time_ <= 1.7 + arg_193_0 then
				local var_193_1 = arg_190_1.bgs_.MS2101a

				arg_190_1.bgs_.MS2101a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_193_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_2 = var_193_1:GetComponent("SpriteRenderer")

				if var_193_2 and var_193_2.sprite then
					local var_193_3 = 2 * (var_193_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_193_1.transform.localScale = Vector3.New(var_193_3 / var_193_2.sprite.bounds.size.y < var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x and var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x or var_193_3 / var_193_2.sprite.bounds.size.y, var_193_3 / var_193_2.sprite.bounds.size.y < var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x and var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x or var_193_3 / var_193_2.sprite.bounds.size.y, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "MS2101a" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_4 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			if arg_190_1.time_ >= var_193_4 + 0.3 and arg_190_1.time_ < var_193_4 + 0.3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_5 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_6 = 1.7

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 then
				local var_193_7 = Color.New(0, 0, 0)

				var_193_7.a = Mathf.Lerp(0, 1, (arg_190_1.time_ - var_193_5) / var_193_6)
				arg_190_1.mask_.color = var_193_7
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 then
				local var_193_8 = Color.New(0, 0, 0)

				var_193_8.a = 1
				arg_190_1.mask_.color = var_193_8
			end

			local var_193_9 = 1.7

			if 1.7 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_10 = 1.7

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_10 then
				local var_193_11 = Color.New(0, 0, 0)

				var_193_11.a = Mathf.Lerp(1, 0, (arg_190_1.time_ - var_193_9) / var_193_10)
				arg_190_1.mask_.color = var_193_11
			end

			if arg_190_1.time_ >= var_193_9 + var_193_10 and arg_190_1.time_ < var_193_9 + var_193_10 + arg_193_0 then
				local var_193_12 = Color.New(0, 0, 0)

				arg_190_1.mask_.enabled = false
				var_193_12.a = 0
				arg_190_1.mask_.color = var_193_12
			end

			if 1.274527234522 < arg_190_1.time_ and arg_190_1.time_ <= 1.274527234522 + arg_193_0 then
				arg_190_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.274527234522 < arg_190_1.time_ and arg_190_1.time_ <= 1.274527234522 + arg_193_0 then
				arg_190_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_morning_loop", "")
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_15 = 3.4
			local var_193_16 = 0.325

			if 3.4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_17 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_17:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(321011045)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_21 = 13 <= 0 and var_193_16 or var_193_16 * (utf8.len(var_193_19) / 13)

				if (13 <= 0 and var_193_16 or var_193_16 * (utf8.len(var_193_19) / 13)) > 0 and var_193_16 < var_193_21 then
					arg_190_1.talkMaxDuration = var_193_21
					var_193_15 = var_193_15 + 0.3

					if var_193_21 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_21 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011045", "story_v_out_321011.awb") ~= 0 then
					local var_193_22 = manager.audio:GetVoiceLength("story_v_out_321011", "321011045", "story_v_out_321011.awb") / 1000

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end

					if var_193_18.prefab_name ~= "" and arg_190_1.actors_[var_193_18.prefab_name] ~= nil then
						local var_193_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_18.prefab_name].transform, "story_v_out_321011", "321011045", "story_v_out_321011.awb")

						arg_190_1:RecordAudio("321011045", var_193_23)
						arg_190_1:RecordAudio("321011045", var_193_23)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_321011", "321011045", "story_v_out_321011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_321011", "321011045", "story_v_out_321011.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_24 = var_193_15 + 0.3
			local var_193_25 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_24 + var_193_25 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_24) / var_193_25

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_24 + var_193_25 and arg_190_1.time_ < var_193_24 + var_193_25 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play321011046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 321011046
		arg_196_1.duration_ = 13.77

		local var_196_0 = {
			zh = 8.5,
			ja = 13.766
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play321011047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 1.05

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:GetWordFromCfg(321011046)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 42 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 42)

				if (42 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 42)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011046", "story_v_out_321011.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011046", "story_v_out_321011.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_321011", "321011046", "story_v_out_321011.awb")

						arg_196_1:RecordAudio("321011046", var_199_6)
						arg_196_1:RecordAudio("321011046", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_321011", "321011046", "story_v_out_321011.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_321011", "321011046", "story_v_out_321011.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play321011047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 321011047
		arg_200_1.duration_ = 5.43

		local var_200_0 = {
			zh = 3.833,
			ja = 5.433
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play321011048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.4

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(321011047)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 16 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 16)

				if (16 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 16)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011047", "story_v_out_321011.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011047", "story_v_out_321011.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_321011", "321011047", "story_v_out_321011.awb")

						arg_200_1:RecordAudio("321011047", var_203_6)
						arg_200_1:RecordAudio("321011047", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_321011", "321011047", "story_v_out_321011.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_321011", "321011047", "story_v_out_321011.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play321011048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 321011048
		arg_204_1.duration_ = 8.03

		local var_204_0 = {
			zh = 4.9,
			ja = 8.033
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
				arg_204_0:Play321011049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.55

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(321011048)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 22 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 22)

				if (22 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 22)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011048", "story_v_out_321011.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011048", "story_v_out_321011.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_321011", "321011048", "story_v_out_321011.awb")

						arg_204_1:RecordAudio("321011048", var_207_6)
						arg_204_1:RecordAudio("321011048", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_321011", "321011048", "story_v_out_321011.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_321011", "321011048", "story_v_out_321011.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play321011049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 321011049
		arg_208_1.duration_ = 13

		local var_208_0 = {
			zh = 10.1,
			ja = 13
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
				arg_208_0:Play321011050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1.025

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(321011049)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 41 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 41)

				if (41 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 41)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011049", "story_v_out_321011.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011049", "story_v_out_321011.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_321011", "321011049", "story_v_out_321011.awb")

						arg_208_1:RecordAudio("321011049", var_211_6)
						arg_208_1:RecordAudio("321011049", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_321011", "321011049", "story_v_out_321011.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_321011", "321011049", "story_v_out_321011.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play321011050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 321011050
		arg_212_1.duration_ = 8.47

		local var_212_0 = {
			zh = 6.566,
			ja = 8.466
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
				arg_212_0:Play321011051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.65

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(321011050)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 26 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 26)

				if (26 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 26)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011050", "story_v_out_321011.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011050", "story_v_out_321011.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_321011", "321011050", "story_v_out_321011.awb")

						arg_212_1:RecordAudio("321011050", var_215_6)
						arg_212_1:RecordAudio("321011050", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_321011", "321011050", "story_v_out_321011.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_321011", "321011050", "story_v_out_321011.awb")
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
	Play321011051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 321011051
		arg_216_1.duration_ = 7.87

		local var_216_0 = {
			zh = 3.9,
			ja = 7.866
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
				arg_216_0:Play321011052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.45

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:GetWordFromCfg(321011051)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 18 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 18)

				if (18 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 18)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011051", "story_v_out_321011.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011051", "story_v_out_321011.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_321011", "321011051", "story_v_out_321011.awb")

						arg_216_1:RecordAudio("321011051", var_219_6)
						arg_216_1:RecordAudio("321011051", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_321011", "321011051", "story_v_out_321011.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_321011", "321011051", "story_v_out_321011.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play321011052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 321011052
		arg_220_1.duration_ = 3.27

		local var_220_0 = {
			zh = 1.466,
			ja = 3.266
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
				arg_220_0:Play321011053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.125

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_1 = arg_220_1:GetWordFromCfg(321011052)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 5 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 5)

				if (5 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 5)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011052", "story_v_out_321011.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011052", "story_v_out_321011.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_321011", "321011052", "story_v_out_321011.awb")

						arg_220_1:RecordAudio("321011052", var_223_6)
						arg_220_1:RecordAudio("321011052", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_321011", "321011052", "story_v_out_321011.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_321011", "321011052", "story_v_out_321011.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play321011053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 321011053
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play321011054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 1.1

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(321011053).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 44 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 44)

				if (44 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 44)) > 0 and var_227_0 < var_227_3 then
					arg_224_1.talkMaxDuration = var_227_3

					if var_227_3 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_3 + 0
					end
				end

				arg_224_1.text_.text = var_227_1
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_4 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_4

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play321011054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 321011054
		arg_228_1.duration_ = 12.77

		local var_228_0 = {
			zh = 12.766,
			ja = 10.2
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
				arg_228_0:Play321011055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.85

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(321011054)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 34 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 34)

				if (34 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 34)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011054", "story_v_out_321011.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011054", "story_v_out_321011.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_321011", "321011054", "story_v_out_321011.awb")

						arg_228_1:RecordAudio("321011054", var_231_6)
						arg_228_1:RecordAudio("321011054", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_321011", "321011054", "story_v_out_321011.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_321011", "321011054", "story_v_out_321011.awb")
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
	Play321011055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 321011055
		arg_232_1.duration_ = 18.6

		local var_232_0 = {
			zh = 10.466,
			ja = 18.6
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
				arg_232_0:Play321011056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.3

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(321011055)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 52 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 52)

				if (52 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 52)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011055", "story_v_out_321011.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011055", "story_v_out_321011.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_321011", "321011055", "story_v_out_321011.awb")

						arg_232_1:RecordAudio("321011055", var_235_6)
						arg_232_1:RecordAudio("321011055", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_321011", "321011055", "story_v_out_321011.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_321011", "321011055", "story_v_out_321011.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play321011056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 321011056
		arg_236_1.duration_ = 8.03

		local var_236_0 = {
			zh = 5.4,
			ja = 8.033
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play321011057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.7

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:GetWordFromCfg(321011056)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 28 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 28)

				if (28 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 28)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011056", "story_v_out_321011.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011056", "story_v_out_321011.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_321011", "321011056", "story_v_out_321011.awb")

						arg_236_1:RecordAudio("321011056", var_239_6)
						arg_236_1:RecordAudio("321011056", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_321011", "321011056", "story_v_out_321011.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_321011", "321011056", "story_v_out_321011.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play321011057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 321011057
		arg_240_1.duration_ = 2.97

		local var_240_0 = {
			zh = 2.066,
			ja = 2.966
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
				arg_240_0:Play321011058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.25

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:GetWordFromCfg(321011057)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 10 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 10)

				if (10 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 10)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011057", "story_v_out_321011.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011057", "story_v_out_321011.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_321011", "321011057", "story_v_out_321011.awb")

						arg_240_1:RecordAudio("321011057", var_243_6)
						arg_240_1:RecordAudio("321011057", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_321011", "321011057", "story_v_out_321011.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_321011", "321011057", "story_v_out_321011.awb")
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
	Play321011058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 321011058
		arg_244_1.duration_ = 13.23

		local var_244_0 = {
			zh = 7.1,
			ja = 13.233
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
				arg_244_0:Play321011059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.9

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:GetWordFromCfg(321011058)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 36 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 36)

				if (36 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 36)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011058", "story_v_out_321011.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011058", "story_v_out_321011.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_321011", "321011058", "story_v_out_321011.awb")

						arg_244_1:RecordAudio("321011058", var_247_6)
						arg_244_1:RecordAudio("321011058", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_321011", "321011058", "story_v_out_321011.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_321011", "321011058", "story_v_out_321011.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play321011059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 321011059
		arg_248_1.duration_ = 9.8

		local var_248_0 = {
			zh = 6.533,
			ja = 9.8
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
				arg_248_0:Play321011060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.8

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(321011059)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 32 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 32)

				if (32 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 32)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011059", "story_v_out_321011.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011059", "story_v_out_321011.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_321011", "321011059", "story_v_out_321011.awb")

						arg_248_1:RecordAudio("321011059", var_251_6)
						arg_248_1:RecordAudio("321011059", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_321011", "321011059", "story_v_out_321011.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_321011", "321011059", "story_v_out_321011.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play321011060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 321011060
		arg_252_1.duration_ = 2.13

		local var_252_0 = {
			zh = 1.133,
			ja = 2.133
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
				arg_252_0:Play321011061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.1

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_1 = arg_252_1:GetWordFromCfg(321011060)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 4 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 4)

				if (4 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 4)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011060", "story_v_out_321011.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011060", "story_v_out_321011.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_321011", "321011060", "story_v_out_321011.awb")

						arg_252_1:RecordAudio("321011060", var_255_6)
						arg_252_1:RecordAudio("321011060", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_321011", "321011060", "story_v_out_321011.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_321011", "321011060", "story_v_out_321011.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play321011061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 321011061
		arg_256_1.duration_ = 1

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"

			SetActive(arg_256_1.choicesGo_, true)

			for iter_257_0, iter_257_1 in ipairs(arg_256_1.choices_) do
				SetActive(iter_257_1.go, iter_257_0 <= 1)
			end

			arg_256_1.choices_[1].txt.text = arg_256_1:FormatText(StoryChoiceCfg[1246].name)
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play321011062(arg_256_1)
			end

			arg_256_1:RecordChoiceLog(321011061, 1246)
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			return
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play321011062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 321011062
		arg_260_1.duration_ = 3.23

		local var_260_0 = {
			zh = 3.233,
			ja = 3
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
				arg_260_0:Play321011063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.35

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(321011062)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 14 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 14)

				if (14 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 14)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011062", "story_v_out_321011.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011062", "story_v_out_321011.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_321011", "321011062", "story_v_out_321011.awb")

						arg_260_1:RecordAudio("321011062", var_263_6)
						arg_260_1:RecordAudio("321011062", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_321011", "321011062", "story_v_out_321011.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_321011", "321011062", "story_v_out_321011.awb")
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
	Play321011063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 321011063
		arg_264_1.duration_ = 7.6

		local var_264_0 = {
			zh = 3.9,
			ja = 7.6
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
				arg_264_0:Play321011064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.475

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:GetWordFromCfg(321011063)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 19 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 19)

				if (19 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 19)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011063", "story_v_out_321011.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011063", "story_v_out_321011.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_321011", "321011063", "story_v_out_321011.awb")

						arg_264_1:RecordAudio("321011063", var_267_6)
						arg_264_1:RecordAudio("321011063", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_321011", "321011063", "story_v_out_321011.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_321011", "321011063", "story_v_out_321011.awb")
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
	Play321011064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 321011064
		arg_268_1.duration_ = 10.07

		local var_268_0 = {
			zh = 5.333,
			ja = 10.066
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
				arg_268_0:Play321011065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.7

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(321011064)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 28 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 28)

				if (28 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 28)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011064", "story_v_out_321011.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011064", "story_v_out_321011.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_321011", "321011064", "story_v_out_321011.awb")

						arg_268_1:RecordAudio("321011064", var_271_6)
						arg_268_1:RecordAudio("321011064", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_321011", "321011064", "story_v_out_321011.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_321011", "321011064", "story_v_out_321011.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play321011065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 321011065
		arg_272_1.duration_ = 6.17

		local var_272_0 = {
			zh = 3.5,
			ja = 6.166
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
				arg_272_0:Play321011066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.425

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:GetWordFromCfg(321011065)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 17 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 17)

				if (17 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 17)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011065", "story_v_out_321011.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011065", "story_v_out_321011.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_321011", "321011065", "story_v_out_321011.awb")

						arg_272_1:RecordAudio("321011065", var_275_6)
						arg_272_1:RecordAudio("321011065", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_321011", "321011065", "story_v_out_321011.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_321011", "321011065", "story_v_out_321011.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play321011066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 321011066
		arg_276_1.duration_ = 8.13

		local var_276_0 = {
			zh = 6.965999999999,
			ja = 8.132999999999
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
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play321011067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if arg_276_1.bgs_.L06g == nil then
				local var_279_0 = Object.Instantiate(arg_276_1.paintGo_)

				var_279_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L06g")
				var_279_0.name = "L06g"
				var_279_0.transform.parent = arg_276_1.stage_.transform
				var_279_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_276_1.bgs_.L06g = var_279_0
			end

			if 1.999999999999 < arg_276_1.time_ and arg_276_1.time_ <= 1.999999999999 + arg_279_0 then
				local var_279_1 = arg_276_1.bgs_.L06g

				arg_276_1.bgs_.L06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_279_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_2 = var_279_1:GetComponent("SpriteRenderer")

				if var_279_2 and var_279_2.sprite then
					local var_279_3 = 2 * (var_279_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_279_1.transform.localScale = Vector3.New(var_279_3 / var_279_2.sprite.bounds.size.y < var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x and var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x or var_279_3 / var_279_2.sprite.bounds.size.y, var_279_3 / var_279_2.sprite.bounds.size.y < var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x and var_279_3 * manager.ui.mainCameraCom_.aspect / var_279_2.sprite.bounds.size.x or var_279_3 / var_279_2.sprite.bounds.size.y, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "L06g" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_279_4 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.allBtn_.enabled = false
			end

			if arg_276_1.time_ >= var_279_4 + 0.3 and arg_276_1.time_ < var_279_4 + 0.3 + arg_279_0 then
				arg_276_1.allBtn_.enabled = true
			end

			local var_279_5 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_6 = 2

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_6 then
				local var_279_7 = Color.New(0, 0, 0)

				var_279_7.a = Mathf.Lerp(0, 1, (arg_276_1.time_ - var_279_5) / var_279_6)
				arg_276_1.mask_.color = var_279_7
			end

			if arg_276_1.time_ >= var_279_5 + var_279_6 and arg_276_1.time_ < var_279_5 + var_279_6 + arg_279_0 then
				local var_279_8 = Color.New(0, 0, 0)

				var_279_8.a = 1
				arg_276_1.mask_.color = var_279_8
			end

			local var_279_9 = 2

			if 2 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_10 = 2

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_10 then
				local var_279_11 = Color.New(0, 0, 0)

				var_279_11.a = Mathf.Lerp(1, 0, (arg_276_1.time_ - var_279_9) / var_279_10)
				arg_276_1.mask_.color = var_279_11
			end

			if arg_276_1.time_ >= var_279_9 + var_279_10 and arg_276_1.time_ < var_279_9 + var_279_10 + arg_279_0 then
				local var_279_12 = Color.New(0, 0, 0)

				arg_276_1.mask_.enabled = false
				var_279_12.a = 0
				arg_276_1.mask_.color = var_279_12
			end

			if 0.633333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 0.633333333333333 + arg_279_0 then
				arg_276_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_morning_loop", "")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_279_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_276_1.bgmTxt_.text ~= var_279_16 and arg_276_1.bgmTxt_.text ~= "" then
						if arg_276_1.bgmTxt2_.text ~= "" then
							arg_276_1.bgmTxt_.text = arg_276_1.bgmTxt2_.text
						end

						arg_276_1.bgmTxt2_.text = var_279_16

						arg_276_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_276_1.bgmTxt_.text = var_279_16
						arg_276_1.bgmTxt2_.text = var_279_16
					end

					if arg_276_1.bgmTimer then
						arg_276_1.bgmTimer:Stop()

						arg_276_1.bgmTimer = nil
					end

					if arg_276_1.settingData.show_music_name == 1 then
						arg_276_1.musicController:SetSelectedState("show")
						arg_276_1.musicAnimator_:Play("open", 0, 0)

						if arg_276_1.settingData.music_time ~= 0 then
							arg_276_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_276_1.settingData.music_time), function()
								if arg_276_1 == nil or isNil(arg_276_1.bgmTxt_) then
									return
								end

								arg_276_1.musicController:SetSelectedState("hide")
								arg_276_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.83333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 1.83333333333333 + arg_279_0 then
				arg_276_1:AudioAction("play", "music", "bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area.awb")

				local var_279_19 = manager.audio:GetAudioName("bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area")

				if "" ~= "" then
					if arg_276_1.bgmTxt_.text ~= var_279_19 and arg_276_1.bgmTxt_.text ~= "" then
						if arg_276_1.bgmTxt2_.text ~= "" then
							arg_276_1.bgmTxt_.text = arg_276_1.bgmTxt2_.text
						end

						arg_276_1.bgmTxt2_.text = var_279_19

						arg_276_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_276_1.bgmTxt_.text = var_279_19
						arg_276_1.bgmTxt2_.text = var_279_19
					end

					if arg_276_1.bgmTimer then
						arg_276_1.bgmTimer:Stop()

						arg_276_1.bgmTimer = nil
					end

					if arg_276_1.settingData.show_music_name == 1 then
						arg_276_1.musicController:SetSelectedState("show")
						arg_276_1.musicAnimator_:Play("open", 0, 0)

						if arg_276_1.settingData.music_time ~= 0 then
							arg_276_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_276_1.settingData.music_time), function()
								if arg_276_1 == nil or isNil(arg_276_1.bgmTxt_) then
									return
								end

								arg_276_1.musicController:SetSelectedState("hide")
								arg_276_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.23333333333333 < arg_276_1.time_ and arg_276_1.time_ <= 2.23333333333333 + arg_279_0 then
				arg_276_1:AudioAction("stop", "effect", "ui_skip", "ui_reset", "")
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_21 = 3.999999999999
			local var_279_22 = 0.425

			if 3.999999999999 < arg_276_1.time_ and arg_276_1.time_ <= var_279_21 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_23 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_23:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_276_1.dialogCg_.alpha = arg_282_0
				end))
				var_279_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_24 = arg_276_1:GetWordFromCfg(321011066)
				local var_279_25 = arg_276_1:FormatText(var_279_24.content)

				arg_276_1.text_.text = var_279_25

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_27 = 17 <= 0 and var_279_22 or var_279_22 * (utf8.len(var_279_25) / 17)

				if (17 <= 0 and var_279_22 or var_279_22 * (utf8.len(var_279_25) / 17)) > 0 and var_279_22 < var_279_27 then
					arg_276_1.talkMaxDuration = var_279_27
					var_279_21 = var_279_21 + 0.3

					if var_279_27 + var_279_21 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_27 + var_279_21
					end
				end

				arg_276_1.text_.text = var_279_25
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011066", "story_v_out_321011.awb") ~= 0 then
					local var_279_28 = manager.audio:GetVoiceLength("story_v_out_321011", "321011066", "story_v_out_321011.awb") / 1000

					if var_279_28 + var_279_21 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_28 + var_279_21
					end

					if var_279_24.prefab_name ~= "" and arg_276_1.actors_[var_279_24.prefab_name] ~= nil then
						local var_279_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_24.prefab_name].transform, "story_v_out_321011", "321011066", "story_v_out_321011.awb")

						arg_276_1:RecordAudio("321011066", var_279_29)
						arg_276_1:RecordAudio("321011066", var_279_29)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_321011", "321011066", "story_v_out_321011.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_321011", "321011066", "story_v_out_321011.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_30 = var_279_21 + 0.3
			local var_279_31 = math.max(var_279_22, arg_276_1.talkMaxDuration)

			if var_279_21 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_30 + var_279_31 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_30) / var_279_31

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_30 + var_279_31 and arg_276_1.time_ < var_279_30 + var_279_31 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play321011067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 321011067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play321011068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.5

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(321011067).content)

				arg_284_1.text_.text = var_287_1

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_3 = 20 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 20)

				if (20 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 20)) > 0 and var_287_0 < var_287_3 then
					arg_284_1.talkMaxDuration = var_287_3

					if var_287_3 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_3 + 0
					end
				end

				arg_284_1.text_.text = var_287_1
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_4 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_4

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play321011068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 321011068
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play321011069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.525

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(321011068).content)

				arg_288_1.text_.text = var_291_1

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_3 = 61 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 61)

				if (61 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 61)) > 0 and var_291_0 < var_291_3 then
					arg_288_1.talkMaxDuration = var_291_3

					if var_291_3 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_3 + 0
					end
				end

				arg_288_1.text_.text = var_291_1
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_4 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_4

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play321011069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 321011069
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play321011070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 1 < arg_292_1.time_ and arg_292_1.time_ <= 1 + arg_295_0 then
				arg_292_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_295_1 = 0
			local var_295_2 = 1.35

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_3 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(321011069).content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 54 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 54)

				if (54 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 54)) > 0 and var_295_2 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_6 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_6 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_6

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_6 and arg_292_1.time_ < var_295_1 + var_295_6 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play321011070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 321011070
		arg_296_1.duration_ = 7.9

		local var_296_0 = {
			zh = 4.566,
			ja = 7.9
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play321011071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if arg_296_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_299_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_296_1.stage_.transform)

				var_299_0.name = "10104ui_story"
				var_299_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["10104ui_story"] = var_299_0

				local var_299_1 = var_299_0:GetComponentInChildren(typeof(CharacterEffect))

				var_299_1.enabled = true

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_0, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end

				arg_296_1:ShowWeapon(var_299_1.transform, false)

				arg_296_1.var_["10104ui_story" .. "Animator"] = var_299_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_296_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_296_1.var_["10104ui_story" .. "LipSync"] = var_299_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_299_3 = arg_296_1.actors_["10104ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10104ui_story = var_299_3.localPosition
			end

			local var_299_4 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				var_299_3.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_296_1.time_ - 0) / var_299_4)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				var_299_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			local var_299_5 = arg_296_1.actors_["10104ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect10104ui_story == nil then
				arg_296_1.var_.characterEffect10104ui_story = var_299_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_6 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 and not isNil(var_299_5) then
				if arg_296_1.var_.characterEffect10104ui_story and not isNil(var_299_5) then
					arg_296_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect10104ui_story then
				arg_296_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_299_8 = 0
			local var_299_9 = 0.625

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_10 = arg_296_1:GetWordFromCfg(321011070)
				local var_299_11 = arg_296_1:FormatText(var_299_10.content)

				arg_296_1.text_.text = var_299_11

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 25 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_11) / 25)

				if (25 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_11) / 25)) > 0 and var_299_9 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_11
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011070", "story_v_out_321011.awb") ~= 0 then
					local var_299_14 = manager.audio:GetVoiceLength("story_v_out_321011", "321011070", "story_v_out_321011.awb") / 1000

					if var_299_14 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_8
					end

					if var_299_10.prefab_name ~= "" and arg_296_1.actors_[var_299_10.prefab_name] ~= nil then
						local var_299_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_10.prefab_name].transform, "story_v_out_321011", "321011070", "story_v_out_321011.awb")

						arg_296_1:RecordAudio("321011070", var_299_15)
						arg_296_1:RecordAudio("321011070", var_299_15)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_321011", "321011070", "story_v_out_321011.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_321011", "321011070", "story_v_out_321011.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_16 and arg_296_1.time_ < var_299_8 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play321011071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 321011071
		arg_300_1.duration_ = 4.83

		local var_300_0 = {
			zh = 3.066,
			ja = 4.833
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play321011072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["10104ui_story"]) and arg_300_1.var_.characterEffect10104ui_story == nil then
				arg_300_1.var_.characterEffect10104ui_story = arg_300_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["10104ui_story"]) then
				if arg_300_1.var_.characterEffect10104ui_story and not isNil(arg_300_1.actors_["10104ui_story"]) then
					arg_300_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["10104ui_story"]) and arg_300_1.var_.characterEffect10104ui_story then
				arg_300_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.375

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1164].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_300_1.callingController_:SetSelectedState("calling")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(321011071)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 15 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 15)

				if (15 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 15)) > 0 and var_303_2 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011071", "story_v_out_321011.awb") ~= 0 then
					local var_303_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011071", "story_v_out_321011.awb") / 1000

					if var_303_7 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_1
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_321011", "321011071", "story_v_out_321011.awb")

						arg_300_1:RecordAudio("321011071", var_303_8)
						arg_300_1:RecordAudio("321011071", var_303_8)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_321011", "321011071", "story_v_out_321011.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_321011", "321011071", "story_v_out_321011.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_9 and arg_300_1.time_ < var_303_1 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play321011072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321011072
		arg_304_1.duration_ = 1.77

		local var_304_0 = {
			zh = 1.566,
			ja = 1.766
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play321011073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["10104ui_story"]) and arg_304_1.var_.characterEffect10104ui_story == nil then
				arg_304_1.var_.characterEffect10104ui_story = arg_304_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["10104ui_story"]) then
				if arg_304_1.var_.characterEffect10104ui_story and not isNil(arg_304_1.actors_["10104ui_story"]) then
					arg_304_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["10104ui_story"]) and arg_304_1.var_.characterEffect10104ui_story then
				arg_304_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_307_2 = 0
			local var_307_3 = 0.15

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_2 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_4 = arg_304_1:GetWordFromCfg(321011072)
				local var_307_5 = arg_304_1:FormatText(var_307_4.content)

				arg_304_1.text_.text = var_307_5

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_7 = 6 <= 0 and var_307_3 or var_307_3 * (utf8.len(var_307_5) / 6)

				if (6 <= 0 and var_307_3 or var_307_3 * (utf8.len(var_307_5) / 6)) > 0 and var_307_3 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_2
					end
				end

				arg_304_1.text_.text = var_307_5
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011072", "story_v_out_321011.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_321011", "321011072", "story_v_out_321011.awb") / 1000

					if var_307_8 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_2
					end

					if var_307_4.prefab_name ~= "" and arg_304_1.actors_[var_307_4.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_4.prefab_name].transform, "story_v_out_321011", "321011072", "story_v_out_321011.awb")

						arg_304_1:RecordAudio("321011072", var_307_9)
						arg_304_1:RecordAudio("321011072", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_321011", "321011072", "story_v_out_321011.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_321011", "321011072", "story_v_out_321011.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_3, arg_304_1.talkMaxDuration)

			if var_307_2 <= arg_304_1.time_ and arg_304_1.time_ < var_307_2 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_2) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_2 + var_307_10 and arg_304_1.time_ < var_307_2 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play321011073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321011073
		arg_308_1.duration_ = 1

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"

			SetActive(arg_308_1.choicesGo_, true)

			for iter_309_0, iter_309_1 in ipairs(arg_308_1.choices_) do
				SetActive(iter_309_1.go, iter_309_0 <= 2)
			end

			arg_308_1.choices_[1].txt.text = arg_308_1:FormatText(StoryChoiceCfg[1247].name)
			arg_308_1.choices_[2].txt.text = arg_308_1:FormatText(StoryChoiceCfg[1248].name)
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321011074(arg_308_1)
			end

			if arg_310_0 == 2 then
				arg_308_0:Play321011074(arg_308_1)
			end

			arg_308_1:RecordChoiceLog(321011073, 1247, 1248)
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["10104ui_story"]) and arg_308_1.var_.characterEffect10104ui_story == nil then
				arg_308_1.var_.characterEffect10104ui_story = arg_308_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["10104ui_story"]) then
				if arg_308_1.var_.characterEffect10104ui_story and not isNil(arg_308_1.actors_["10104ui_story"]) then
					arg_308_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["10104ui_story"]) and arg_308_1.var_.characterEffect10104ui_story then
				arg_308_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play321011074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 321011074
		arg_312_1.duration_ = 10.2

		local var_312_0 = {
			zh = 4.666,
			ja = 10.2
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play321011075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.6

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1164].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_312_1.callingController_:SetSelectedState("calling")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:GetWordFromCfg(321011074)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 24 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 24)

				if (24 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 24)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011074", "story_v_out_321011.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011074", "story_v_out_321011.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_out_321011", "321011074", "story_v_out_321011.awb")

						arg_312_1:RecordAudio("321011074", var_315_6)
						arg_312_1:RecordAudio("321011074", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_321011", "321011074", "story_v_out_321011.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_321011", "321011074", "story_v_out_321011.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play321011075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321011075
		arg_316_1.duration_ = 5.2

		local var_316_0 = {
			zh = 4.633,
			ja = 5.2
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
				arg_316_0:Play321011076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.6

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1164].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_316_1.callingController_:SetSelectedState("calling")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(321011075)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 24 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 24)

				if (24 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 24)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011075", "story_v_out_321011.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011075", "story_v_out_321011.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_321011", "321011075", "story_v_out_321011.awb")

						arg_316_1:RecordAudio("321011075", var_319_6)
						arg_316_1:RecordAudio("321011075", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_321011", "321011075", "story_v_out_321011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_321011", "321011075", "story_v_out_321011.awb")
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
	Play321011076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321011076
		arg_320_1.duration_ = 2

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play321011077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["10104ui_story"]) and arg_320_1.var_.characterEffect10104ui_story == nil then
				arg_320_1.var_.characterEffect10104ui_story = arg_320_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["10104ui_story"]) then
				if arg_320_1.var_.characterEffect10104ui_story and not isNil(arg_320_1.actors_["10104ui_story"]) then
					arg_320_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["10104ui_story"]) and arg_320_1.var_.characterEffect10104ui_story then
				arg_320_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			local var_323_2 = 0
			local var_323_3 = 0.175

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_2 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_4 = arg_320_1:GetWordFromCfg(321011076)
				local var_323_5 = arg_320_1:FormatText(var_323_4.content)

				arg_320_1.text_.text = var_323_5

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_7 = 7 <= 0 and var_323_3 or var_323_3 * (utf8.len(var_323_5) / 7)

				if (7 <= 0 and var_323_3 or var_323_3 * (utf8.len(var_323_5) / 7)) > 0 and var_323_3 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_2 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_2
					end
				end

				arg_320_1.text_.text = var_323_5
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011076", "story_v_out_321011.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_321011", "321011076", "story_v_out_321011.awb") / 1000

					if var_323_8 + var_323_2 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_2
					end

					if var_323_4.prefab_name ~= "" and arg_320_1.actors_[var_323_4.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_4.prefab_name].transform, "story_v_out_321011", "321011076", "story_v_out_321011.awb")

						arg_320_1:RecordAudio("321011076", var_323_9)
						arg_320_1:RecordAudio("321011076", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_321011", "321011076", "story_v_out_321011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_321011", "321011076", "story_v_out_321011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_3, arg_320_1.talkMaxDuration)

			if var_323_2 <= arg_320_1.time_ and arg_320_1.time_ < var_323_2 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_2) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_2 + var_323_10 and arg_320_1.time_ < var_323_2 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321011077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321011077
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play321011078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos10104ui_story = arg_324_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_327_0 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 then
				arg_324_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_324_1.time_ - 0) / var_327_0)
				arg_324_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["10104ui_story"].transform.position).z)
				arg_324_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["10104ui_story"].transform.localEulerAngles = arg_324_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 then
				arg_324_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_324_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["10104ui_story"].transform.position).z)
				arg_324_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["10104ui_story"].transform.localEulerAngles = arg_324_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_327_1 = arg_324_1.actors_["10104ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect10104ui_story == nil then
				arg_324_1.var_.characterEffect10104ui_story = var_327_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_2 and not isNil(var_327_1) then
				if arg_324_1.var_.characterEffect10104ui_story and not isNil(var_327_1) then
					arg_324_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_324_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_2)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_2 and arg_324_1.time_ < 0 + var_327_2 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect10104ui_story then
				arg_324_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_324_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_327_3 = 0
			local var_327_4 = 0.8

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_3 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_5 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(321011077).content)

				arg_324_1.text_.text = var_327_5

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 32 <= 0 and var_327_4 or var_327_4 * (utf8.len(var_327_5) / 32)

				if (32 <= 0 and var_327_4 or var_327_4 * (utf8.len(var_327_5) / 32)) > 0 and var_327_4 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_3 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_3
					end
				end

				arg_324_1.text_.text = var_327_5
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_8 = math.max(var_327_4, arg_324_1.talkMaxDuration)

			if var_327_3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_3 + var_327_8 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_3) / var_327_8

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_3 + var_327_8 and arg_324_1.time_ < var_327_3 + var_327_8 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play321011078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 321011078
		arg_328_1.duration_ = 7.5

		local var_328_0 = {
			zh = 5.5,
			ja = 7.5
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play321011079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos10104ui_story = arg_328_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 then
				arg_328_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_328_1.time_ - 0) / var_331_0)
				arg_328_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10104ui_story"].transform.position).z)
				arg_328_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["10104ui_story"].transform.localEulerAngles = arg_328_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_328_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["10104ui_story"].transform.position).z)
				arg_328_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["10104ui_story"].transform.localEulerAngles = arg_328_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_331_1 = arg_328_1.actors_["10104ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect10104ui_story == nil then
				arg_328_1.var_.characterEffect10104ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_2 and not isNil(var_331_1) then
				if arg_328_1.var_.characterEffect10104ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_2 and arg_328_1.time_ < 0 + var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect10104ui_story then
				arg_328_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_2")
			end

			local var_331_4 = 0
			local var_331_5 = 0.75

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_6 = arg_328_1:GetWordFromCfg(321011078)
				local var_331_7 = arg_328_1:FormatText(var_331_6.content)

				arg_328_1.text_.text = var_331_7

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 30 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 30)

				if (30 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 30)) > 0 and var_331_5 < var_331_9 then
					arg_328_1.talkMaxDuration = var_331_9

					if var_331_9 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_7
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011078", "story_v_out_321011.awb") ~= 0 then
					local var_331_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011078", "story_v_out_321011.awb") / 1000

					if var_331_10 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_4
					end

					if var_331_6.prefab_name ~= "" and arg_328_1.actors_[var_331_6.prefab_name] ~= nil then
						local var_331_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_6.prefab_name].transform, "story_v_out_321011", "321011078", "story_v_out_321011.awb")

						arg_328_1:RecordAudio("321011078", var_331_11)
						arg_328_1:RecordAudio("321011078", var_331_11)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_321011", "321011078", "story_v_out_321011.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_321011", "321011078", "story_v_out_321011.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_12 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_12 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_12

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_12 and arg_328_1.time_ < var_331_4 + var_331_12 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play321011079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 321011079
		arg_332_1.duration_ = 11.4

		local var_332_0 = {
			zh = 7.2,
			ja = 11.4
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
				arg_332_0:Play321011080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 1.025

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_1 = arg_332_1:GetWordFromCfg(321011079)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 41 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 41)

				if (41 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 41)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011079", "story_v_out_321011.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011079", "story_v_out_321011.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_321011", "321011079", "story_v_out_321011.awb")

						arg_332_1:RecordAudio("321011079", var_335_6)
						arg_332_1:RecordAudio("321011079", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_321011", "321011079", "story_v_out_321011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_321011", "321011079", "story_v_out_321011.awb")
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
	Play321011080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321011080
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play321011081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["10104ui_story"]) and arg_336_1.var_.characterEffect10104ui_story == nil then
				arg_336_1.var_.characterEffect10104ui_story = arg_336_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["10104ui_story"]) then
				if arg_336_1.var_.characterEffect10104ui_story and not isNil(arg_336_1.actors_["10104ui_story"]) then
					arg_336_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_0)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["10104ui_story"]) and arg_336_1.var_.characterEffect10104ui_story then
				arg_336_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_339_1 = 0
			local var_339_2 = 0.3

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(321011080).content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 12 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 12)

				if (12 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 12)) > 0 and var_339_2 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_6 = math.max(var_339_2, arg_336_1.talkMaxDuration)

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_6 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_1) / var_339_6

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_1 + var_339_6 and arg_336_1.time_ < var_339_1 + var_339_6 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play321011081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 321011081
		arg_340_1.duration_ = 8.17

		local var_340_0 = {
			zh = 5.233,
			ja = 8.166
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
				arg_340_0:Play321011082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["10104ui_story"]) and arg_340_1.var_.characterEffect10104ui_story == nil then
				arg_340_1.var_.characterEffect10104ui_story = arg_340_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["10104ui_story"]) then
				if arg_340_1.var_.characterEffect10104ui_story and not isNil(arg_340_1.actors_["10104ui_story"]) then
					arg_340_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["10104ui_story"]) and arg_340_1.var_.characterEffect10104ui_story then
				arg_340_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_343_2 = 0
			local var_343_3 = 0.75

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_4 = arg_340_1:GetWordFromCfg(321011081)
				local var_343_5 = arg_340_1:FormatText(var_343_4.content)

				arg_340_1.text_.text = var_343_5

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 30 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 30)

				if (30 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 30)) > 0 and var_343_3 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_5
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011081", "story_v_out_321011.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_321011", "321011081", "story_v_out_321011.awb") / 1000

					if var_343_8 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_2
					end

					if var_343_4.prefab_name ~= "" and arg_340_1.actors_[var_343_4.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_4.prefab_name].transform, "story_v_out_321011", "321011081", "story_v_out_321011.awb")

						arg_340_1:RecordAudio("321011081", var_343_9)
						arg_340_1:RecordAudio("321011081", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_321011", "321011081", "story_v_out_321011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_321011", "321011081", "story_v_out_321011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_10 and arg_340_1.time_ < var_343_2 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play321011082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 321011082
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play321011083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["10104ui_story"]) and arg_344_1.var_.characterEffect10104ui_story == nil then
				arg_344_1.var_.characterEffect10104ui_story = arg_344_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["10104ui_story"]) then
				if arg_344_1.var_.characterEffect10104ui_story and not isNil(arg_344_1.actors_["10104ui_story"]) then
					arg_344_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_344_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["10104ui_story"]) and arg_344_1.var_.characterEffect10104ui_story then
				arg_344_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_344_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_347_1 = 0
			local var_347_2 = 0.25

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(321011082).content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 10 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 10)

				if (10 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 10)) > 0 and var_347_2 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_6 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_6 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_6

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_6 and arg_344_1.time_ < var_347_1 + var_347_6 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play321011083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 321011083
		arg_348_1.duration_ = 8.1

		local var_348_0 = {
			zh = 7.366,
			ja = 8.1
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play321011084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos10104ui_story = arg_348_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["10104ui_story"].transform.position).z)
				arg_348_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["10104ui_story"].transform.localEulerAngles = arg_348_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_348_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["10104ui_story"].transform.position).z)
				arg_348_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["10104ui_story"].transform.localEulerAngles = arg_348_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["10104ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect10104ui_story == nil then
				arg_348_1.var_.characterEffect10104ui_story = var_351_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 and not isNil(var_351_1) then
				if arg_348_1.var_.characterEffect10104ui_story and not isNil(var_351_1) then
					arg_348_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect10104ui_story then
				arg_348_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action5_1")
			end

			if 0.733333333333333 < arg_348_1.time_ and arg_348_1.time_ <= 0.733333333333333 + arg_351_0 then
				arg_348_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_351_4 = 0

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			if arg_348_1.time_ >= var_351_4 + 1.86666666666667 and arg_348_1.time_ < var_351_4 + 1.86666666666667 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_5 = 0
			local var_351_6 = 0.9

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_7 = arg_348_1:GetWordFromCfg(321011083)
				local var_351_8 = arg_348_1:FormatText(var_351_7.content)

				arg_348_1.text_.text = var_351_8

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_10 = 36 <= 0 and var_351_6 or var_351_6 * (utf8.len(var_351_8) / 36)

				if (36 <= 0 and var_351_6 or var_351_6 * (utf8.len(var_351_8) / 36)) > 0 and var_351_6 < var_351_10 then
					arg_348_1.talkMaxDuration = var_351_10

					if var_351_10 + var_351_5 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_5
					end
				end

				arg_348_1.text_.text = var_351_8
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011083", "story_v_out_321011.awb") ~= 0 then
					local var_351_11 = manager.audio:GetVoiceLength("story_v_out_321011", "321011083", "story_v_out_321011.awb") / 1000

					if var_351_11 + var_351_5 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_11 + var_351_5
					end

					if var_351_7.prefab_name ~= "" and arg_348_1.actors_[var_351_7.prefab_name] ~= nil then
						local var_351_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_7.prefab_name].transform, "story_v_out_321011", "321011083", "story_v_out_321011.awb")

						arg_348_1:RecordAudio("321011083", var_351_12)
						arg_348_1:RecordAudio("321011083", var_351_12)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_321011", "321011083", "story_v_out_321011.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_321011", "321011083", "story_v_out_321011.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_13 = math.max(var_351_6, arg_348_1.talkMaxDuration)

			if var_351_5 <= arg_348_1.time_ and arg_348_1.time_ < var_351_5 + var_351_13 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_5) / var_351_13

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_5 + var_351_13 and arg_348_1.time_ < var_351_5 + var_351_13 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play321011084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 321011084
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play321011085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["10104ui_story"]) and arg_352_1.var_.characterEffect10104ui_story == nil then
				arg_352_1.var_.characterEffect10104ui_story = arg_352_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["10104ui_story"]) then
				if arg_352_1.var_.characterEffect10104ui_story and not isNil(arg_352_1.actors_["10104ui_story"]) then
					arg_352_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_352_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["10104ui_story"]) and arg_352_1.var_.characterEffect10104ui_story then
				arg_352_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_352_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.825

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(321011084).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 33 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 33)

				if (33 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 33)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play321011085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 321011085
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play321011086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos10104ui_story = arg_356_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).z)
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles = arg_356_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).z)
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles = arg_356_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_359_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_356_1.bgmTxt_.text ~= var_359_3 and arg_356_1.bgmTxt_.text ~= "" then
						if arg_356_1.bgmTxt2_.text ~= "" then
							arg_356_1.bgmTxt_.text = arg_356_1.bgmTxt2_.text
						end

						arg_356_1.bgmTxt2_.text = var_359_3

						arg_356_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_356_1.bgmTxt_.text = var_359_3
						arg_356_1.bgmTxt2_.text = var_359_3
					end

					if arg_356_1.bgmTimer then
						arg_356_1.bgmTimer:Stop()

						arg_356_1.bgmTimer = nil
					end

					if arg_356_1.settingData.show_music_name == 1 then
						arg_356_1.musicController:SetSelectedState("show")
						arg_356_1.musicAnimator_:Play("open", 0, 0)

						if arg_356_1.settingData.music_time ~= 0 then
							arg_356_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_356_1.settingData.music_time), function()
								if arg_356_1 == nil or isNil(arg_356_1.bgmTxt_) then
									return
								end

								arg_356_1.musicController:SetSelectedState("hide")
								arg_356_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_356_1.time_ and arg_356_1.time_ <= 0.2 + arg_359_0 then
				arg_356_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_taxi01", "")
			end

			local var_359_5 = 0
			local var_359_6 = 0.975

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_7 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(321011085).content)

				arg_356_1.text_.text = var_359_7

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_9 = 39 <= 0 and var_359_6 or var_359_6 * (utf8.len(var_359_7) / 39)

				if (39 <= 0 and var_359_6 or var_359_6 * (utf8.len(var_359_7) / 39)) > 0 and var_359_6 < var_359_9 then
					arg_356_1.talkMaxDuration = var_359_9

					if var_359_9 + var_359_5 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_9 + var_359_5
					end
				end

				arg_356_1.text_.text = var_359_7
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_6, arg_356_1.talkMaxDuration)

			if var_359_5 <= arg_356_1.time_ and arg_356_1.time_ < var_359_5 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_5) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_5 + var_359_10 and arg_356_1.time_ < var_359_5 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play321011086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 321011086
		arg_361_1.duration_ = 8.75

		local var_361_0 = {
			zh = 6.65,
			ja = 8.75
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play321011087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if arg_361_1.bgs_.L13f == nil then
				local var_364_0 = Object.Instantiate(arg_361_1.paintGo_)

				var_364_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L13f")
				var_364_0.name = "L13f"
				var_364_0.transform.parent = arg_361_1.stage_.transform
				var_364_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_361_1.bgs_.L13f = var_364_0
			end

			if 2 < arg_361_1.time_ and arg_361_1.time_ <= 2 + arg_364_0 then
				local var_364_1 = arg_361_1.bgs_.L13f

				arg_361_1.bgs_.L13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_364_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_364_2 = var_364_1:GetComponent("SpriteRenderer")

				if var_364_2 and var_364_2.sprite then
					local var_364_3 = 2 * (var_364_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_364_1.transform.localScale = Vector3.New(var_364_3 / var_364_2.sprite.bounds.size.y < var_364_3 * manager.ui.mainCameraCom_.aspect / var_364_2.sprite.bounds.size.x and var_364_3 * manager.ui.mainCameraCom_.aspect / var_364_2.sprite.bounds.size.x or var_364_3 / var_364_2.sprite.bounds.size.y, var_364_3 / var_364_2.sprite.bounds.size.y < var_364_3 * manager.ui.mainCameraCom_.aspect / var_364_2.sprite.bounds.size.x and var_364_3 * manager.ui.mainCameraCom_.aspect / var_364_2.sprite.bounds.size.x or var_364_3 / var_364_2.sprite.bounds.size.y, 0)
				end

				for iter_364_0, iter_364_1 in pairs(arg_361_1.bgs_) do
					if iter_364_0 ~= "L13f" then
						iter_364_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_364_4 = 0

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			if arg_361_1.time_ >= var_364_4 + 0.3 and arg_361_1.time_ < var_364_4 + 0.3 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_5 = 0

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_6 = 2

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_6 then
				local var_364_7 = Color.New(0, 0, 0)

				var_364_7.a = Mathf.Lerp(0, 1, (arg_361_1.time_ - var_364_5) / var_364_6)
				arg_361_1.mask_.color = var_364_7
			end

			if arg_361_1.time_ >= var_364_5 + var_364_6 and arg_361_1.time_ < var_364_5 + var_364_6 + arg_364_0 then
				local var_364_8 = Color.New(0, 0, 0)

				var_364_8.a = 1
				arg_361_1.mask_.color = var_364_8
			end

			local var_364_9 = 2

			if 2 < arg_361_1.time_ and arg_361_1.time_ <= var_364_9 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_10 = 2

			if var_364_9 <= arg_361_1.time_ and arg_361_1.time_ < var_364_9 + var_364_10 then
				local var_364_11 = Color.New(0, 0, 0)

				var_364_11.a = Mathf.Lerp(1, 0, (arg_361_1.time_ - var_364_9) / var_364_10)
				arg_361_1.mask_.color = var_364_11
			end

			if arg_361_1.time_ >= var_364_9 + var_364_10 and arg_361_1.time_ < var_364_9 + var_364_10 + arg_364_0 then
				local var_364_12 = Color.New(0, 0, 0)

				arg_361_1.mask_.enabled = false
				var_364_12.a = 0
				arg_361_1.mask_.color = var_364_12
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_364_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_361_1.bgmTxt_.text ~= var_364_15 and arg_361_1.bgmTxt_.text ~= "" then
						if arg_361_1.bgmTxt2_.text ~= "" then
							arg_361_1.bgmTxt_.text = arg_361_1.bgmTxt2_.text
						end

						arg_361_1.bgmTxt2_.text = var_364_15

						arg_361_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_361_1.bgmTxt_.text = var_364_15
						arg_361_1.bgmTxt2_.text = var_364_15
					end

					if arg_361_1.bgmTimer then
						arg_361_1.bgmTimer:Stop()

						arg_361_1.bgmTimer = nil
					end

					if arg_361_1.settingData.show_music_name == 1 then
						arg_361_1.musicController:SetSelectedState("show")
						arg_361_1.musicAnimator_:Play("open", 0, 0)

						if arg_361_1.settingData.music_time ~= 0 then
							arg_361_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_361_1.settingData.music_time), function()
								if arg_361_1 == nil or isNil(arg_361_1.bgmTxt_) then
									return
								end

								arg_361_1.musicController:SetSelectedState("hide")
								arg_361_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.9 < arg_361_1.time_ and arg_361_1.time_ <= 1.9 + arg_364_0 then
				arg_361_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_364_18 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_361_1.bgmTxt_.text ~= var_364_18 and arg_361_1.bgmTxt_.text ~= "" then
						if arg_361_1.bgmTxt2_.text ~= "" then
							arg_361_1.bgmTxt_.text = arg_361_1.bgmTxt2_.text
						end

						arg_361_1.bgmTxt2_.text = var_364_18

						arg_361_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_361_1.bgmTxt_.text = var_364_18
						arg_361_1.bgmTxt2_.text = var_364_18
					end

					if arg_361_1.bgmTimer then
						arg_361_1.bgmTimer:Stop()

						arg_361_1.bgmTimer = nil
					end

					if arg_361_1.settingData.show_music_name == 1 then
						arg_361_1.musicController:SetSelectedState("show")
						arg_361_1.musicAnimator_:Play("open", 0, 0)

						if arg_361_1.settingData.music_time ~= 0 then
							arg_361_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_361_1.settingData.music_time), function()
								if arg_361_1 == nil or isNil(arg_361_1.bgmTxt_) then
									return
								end

								arg_361_1.musicController:SetSelectedState("hide")
								arg_361_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_361_1.frameCnt_ <= 1 then
				arg_361_1.dialog_:SetActive(false)
			end

			local var_364_19 = 3.65
			local var_364_20 = 0.35

			if 3.65 < arg_361_1.time_ and arg_361_1.time_ <= var_364_19 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				arg_361_1.dialog_:SetActive(true)

				arg_361_1.dialogCg_.alpha = 0

				local var_364_21 = LeanTween.value(arg_361_1.dialog_, 0, 1, 0.3)

				var_364_21:setOnUpdate(LuaHelper.FloatAction(function(arg_367_0)
					arg_361_1.dialogCg_.alpha = arg_367_0
				end))
				var_364_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_361_1.dialog_)
					var_364_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_361_1.duration_ = arg_361_1.duration_ + 0.3

				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_22 = arg_361_1:GetWordFromCfg(321011086)
				local var_364_23 = arg_361_1:FormatText(var_364_22.content)

				arg_361_1.text_.text = var_364_23

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_25 = 14 <= 0 and var_364_20 or var_364_20 * (utf8.len(var_364_23) / 14)

				if (14 <= 0 and var_364_20 or var_364_20 * (utf8.len(var_364_23) / 14)) > 0 and var_364_20 < var_364_25 then
					arg_361_1.talkMaxDuration = var_364_25
					var_364_19 = var_364_19 + 0.3

					if var_364_25 + var_364_19 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_25 + var_364_19
					end
				end

				arg_361_1.text_.text = var_364_23
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011086", "story_v_out_321011.awb") ~= 0 then
					local var_364_26 = manager.audio:GetVoiceLength("story_v_out_321011", "321011086", "story_v_out_321011.awb") / 1000

					if var_364_26 + var_364_19 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_26 + var_364_19
					end

					if var_364_22.prefab_name ~= "" and arg_361_1.actors_[var_364_22.prefab_name] ~= nil then
						local var_364_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_22.prefab_name].transform, "story_v_out_321011", "321011086", "story_v_out_321011.awb")

						arg_361_1:RecordAudio("321011086", var_364_27)
						arg_361_1:RecordAudio("321011086", var_364_27)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_321011", "321011086", "story_v_out_321011.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_321011", "321011086", "story_v_out_321011.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_28 = var_364_19 + 0.3
			local var_364_29 = math.max(var_364_20, arg_361_1.talkMaxDuration)

			if var_364_19 + 0.3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_28 + var_364_29 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_28) / var_364_29

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_28 + var_364_29 and arg_361_1.time_ < var_364_28 + var_364_29 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play321011087 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 321011087
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play321011088(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.525

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(321011087).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 21 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 21)

				if (21 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 21)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play321011088 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 321011088
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play321011089(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.5

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(321011088).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 58 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 58)

				if (58 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 58)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play321011089 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 321011089
		arg_377_1.duration_ = 2.43

		local var_377_0 = {
			zh = 1.999999999999,
			ja = 2.433
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play321011090(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if arg_377_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_380_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_377_1.stage_.transform)

				var_380_0.name = "1043ui_story"
				var_380_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.actors_["1043ui_story"] = var_380_0

				local var_380_1 = var_380_0:GetComponentInChildren(typeof(CharacterEffect))

				var_380_1.enabled = true

				local var_380_2 = GameObjectTools.GetOrAddComponent(var_380_0, typeof(DynamicBoneHelper))

				if var_380_2 then
					var_380_2:EnableDynamicBone(false)
				end

				arg_377_1:ShowWeapon(var_380_1.transform, false)

				arg_377_1.var_["1043ui_story" .. "Animator"] = var_380_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_377_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_377_1.var_["1043ui_story" .. "LipSync"] = var_380_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_380_3 = arg_377_1.actors_["1043ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1043ui_story = var_380_3.localPosition
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_3.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_377_1.time_ - 0) / var_380_4)
				var_380_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_3.position).x, (manager.ui.mainCamera.transform.position - var_380_3.position).y, (manager.ui.mainCamera.transform.position - var_380_3.position).z)
				var_380_3.localEulerAngles.z = 0
				var_380_3.localEulerAngles.x = 0
				var_380_3.localEulerAngles = var_380_3.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_380_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_3.position).x, (manager.ui.mainCamera.transform.position - var_380_3.position).y, (manager.ui.mainCamera.transform.position - var_380_3.position).z)
				var_380_3.localEulerAngles.z = 0
				var_380_3.localEulerAngles.x = 0
				var_380_3.localEulerAngles = var_380_3.localEulerAngles
			end

			local var_380_5 = arg_377_1.actors_["1043ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.characterEffect1043ui_story == nil then
				arg_377_1.var_.characterEffect1043ui_story = var_380_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_6 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_6 and not isNil(var_380_5) then
				if arg_377_1.var_.characterEffect1043ui_story and not isNil(var_380_5) then
					arg_377_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_6 and arg_377_1.time_ < 0 + var_380_6 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.characterEffect1043ui_story then
				arg_377_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_380_8 = 0
			local var_380_9 = 0.225

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_10 = arg_377_1:GetWordFromCfg(321011089)
				local var_380_11 = arg_377_1:FormatText(var_380_10.content)

				arg_377_1.text_.text = var_380_11

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_13 = 9 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 9)

				if (9 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 9)) > 0 and var_380_9 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_8
					end
				end

				arg_377_1.text_.text = var_380_11
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011089", "story_v_out_321011.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_out_321011", "321011089", "story_v_out_321011.awb") / 1000

					if var_380_14 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_8
					end

					if var_380_10.prefab_name ~= "" and arg_377_1.actors_[var_380_10.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_10.prefab_name].transform, "story_v_out_321011", "321011089", "story_v_out_321011.awb")

						arg_377_1:RecordAudio("321011089", var_380_15)
						arg_377_1:RecordAudio("321011089", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_321011", "321011089", "story_v_out_321011.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_321011", "321011089", "story_v_out_321011.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_9, arg_377_1.talkMaxDuration)

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_8) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_8 + var_380_16 and arg_377_1.time_ < var_380_8 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play321011090 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 321011090
		arg_381_1.duration_ = 8.57

		local var_381_0 = {
			zh = 5.766,
			ja = 8.566
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play321011091(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1043ui_story"]) and arg_381_1.var_.characterEffect1043ui_story == nil then
				arg_381_1.var_.characterEffect1043ui_story = arg_381_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1043ui_story"]) then
				if arg_381_1.var_.characterEffect1043ui_story and not isNil(arg_381_1.actors_["1043ui_story"]) then
					arg_381_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_0)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1043ui_story"]) and arg_381_1.var_.characterEffect1043ui_story then
				arg_381_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_384_1 = 0
			local var_384_2 = 0.725

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(321011090)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_6 = 29 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_4) / 29)

				if (29 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_4) / 29)) > 0 and var_384_2 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011090", "story_v_out_321011.awb") ~= 0 then
					local var_384_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011090", "story_v_out_321011.awb") / 1000

					if var_384_7 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_1
					end

					if var_384_3.prefab_name ~= "" and arg_381_1.actors_[var_384_3.prefab_name] ~= nil then
						local var_384_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_3.prefab_name].transform, "story_v_out_321011", "321011090", "story_v_out_321011.awb")

						arg_381_1:RecordAudio("321011090", var_384_8)
						arg_381_1:RecordAudio("321011090", var_384_8)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_321011", "321011090", "story_v_out_321011.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_321011", "321011090", "story_v_out_321011.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_9 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_9 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_9

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_9 and arg_381_1.time_ < var_384_1 + var_384_9 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play321011091 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 321011091
		arg_385_1.duration_ = 11.07

		local var_385_0 = {
			zh = 7.066,
			ja = 11.066
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play321011092(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.8

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1163].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinw")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_1 = arg_385_1:GetWordFromCfg(321011091)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 32 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 32)

				if (32 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 32)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011091", "story_v_out_321011.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011091", "story_v_out_321011.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_321011", "321011091", "story_v_out_321011.awb")

						arg_385_1:RecordAudio("321011091", var_388_6)
						arg_385_1:RecordAudio("321011091", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_321011", "321011091", "story_v_out_321011.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_321011", "321011091", "story_v_out_321011.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play321011092 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 321011092
		arg_389_1.duration_ = 2.6

		local var_389_0 = {
			zh = 1.933,
			ja = 2.6
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play321011093(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1043ui_story = arg_389_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1043ui_story"].transform.position).z)
				arg_389_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1043ui_story"].transform.localEulerAngles = arg_389_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_389_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1043ui_story"].transform.position).z)
				arg_389_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1043ui_story"].transform.localEulerAngles = arg_389_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1043ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1043ui_story == nil then
				arg_389_1.var_.characterEffect1043ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1043ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1043ui_story then
				arg_389_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_392_4 = 0
			local var_392_5 = 0.175

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_6 = arg_389_1:GetWordFromCfg(321011092)
				local var_392_7 = arg_389_1:FormatText(var_392_6.content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 6 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 6)

				if (6 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 6)) > 0 and var_392_5 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_4
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011092", "story_v_out_321011.awb") ~= 0 then
					local var_392_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011092", "story_v_out_321011.awb") / 1000

					if var_392_10 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_4
					end

					if var_392_6.prefab_name ~= "" and arg_389_1.actors_[var_392_6.prefab_name] ~= nil then
						local var_392_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_6.prefab_name].transform, "story_v_out_321011", "321011092", "story_v_out_321011.awb")

						arg_389_1:RecordAudio("321011092", var_392_11)
						arg_389_1:RecordAudio("321011092", var_392_11)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_321011", "321011092", "story_v_out_321011.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_321011", "321011092", "story_v_out_321011.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_12 = math.max(var_392_5, arg_389_1.talkMaxDuration)

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_12 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_4) / var_392_12

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_4 + var_392_12 and arg_389_1.time_ < var_392_4 + var_392_12 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play321011093 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 321011093
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play321011094(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1043ui_story = arg_393_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1043ui_story"].transform.position).z)
				arg_393_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1043ui_story"].transform.localEulerAngles = arg_393_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_393_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1043ui_story"].transform.position).z)
				arg_393_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1043ui_story"].transform.localEulerAngles = arg_393_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1043ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1043ui_story == nil then
				arg_393_1.var_.characterEffect1043ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1043ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_2)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1043ui_story then
				arg_393_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_393_1.time_ and arg_393_1.time_ <= 0.034000001847744 + arg_396_0 then
				arg_393_1:AudioAction("play", "effect", "se_story", "se_story_footsteps_out", "")
			end

			local var_396_4 = 0
			local var_396_5 = 0.6

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_6 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(321011093).content)

				arg_393_1.text_.text = var_396_6

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_8 = 24 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_6) / 24)

				if (24 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_6) / 24)) > 0 and var_396_5 < var_396_8 then
					arg_393_1.talkMaxDuration = var_396_8

					if var_396_8 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_4
					end
				end

				arg_393_1.text_.text = var_396_6
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_9 = math.max(var_396_5, arg_393_1.talkMaxDuration)

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_9 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_4) / var_396_9

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_4 + var_396_9 and arg_393_1.time_ < var_396_4 + var_396_9 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play321011094 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 321011094
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play321011095(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0.3 < arg_397_1.time_ and arg_397_1.time_ <= 0.3 + arg_400_0 then
				arg_397_1:AudioAction("play", "effect", "se_story_140", "se_story_140_action02", "")
			end

			local var_400_1 = 0
			local var_400_2 = 1.4

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(321011094).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 56 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 56)

				if (56 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 56)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play321011095 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 321011095
		arg_401_1.duration_ = 4.73

		local var_401_0 = {
			zh = 2.633,
			ja = 4.733
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play321011096(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.275

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:GetWordFromCfg(321011095)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 11 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 11)

				if (11 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 11)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011095", "story_v_out_321011.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011095", "story_v_out_321011.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_321011", "321011095", "story_v_out_321011.awb")

						arg_401_1:RecordAudio("321011095", var_404_6)
						arg_401_1:RecordAudio("321011095", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_321011", "321011095", "story_v_out_321011.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_321011", "321011095", "story_v_out_321011.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play321011096 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 321011096
		arg_405_1.duration_ = 3.7

		local var_405_0 = {
			zh = 2.466,
			ja = 3.7
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play321011097(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1043ui_story = arg_405_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1043ui_story"].transform.position).z)
				arg_405_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1043ui_story"].transform.localEulerAngles = arg_405_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_405_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1043ui_story"].transform.position).z)
				arg_405_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1043ui_story"].transform.localEulerAngles = arg_405_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1043ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1043ui_story == nil then
				arg_405_1.var_.characterEffect1043ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1043ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1043ui_story then
				arg_405_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_408_4 = 0
			local var_408_5 = 0.275

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(321011096)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 11 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 11)

				if (11 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 11)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011096", "story_v_out_321011.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011096", "story_v_out_321011.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_out_321011", "321011096", "story_v_out_321011.awb")

						arg_405_1:RecordAudio("321011096", var_408_11)
						arg_405_1:RecordAudio("321011096", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_321011", "321011096", "story_v_out_321011.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_321011", "321011096", "story_v_out_321011.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play321011097 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 321011097
		arg_409_1.duration_ = 3.03

		local var_409_0 = {
			zh = 2.533,
			ja = 3.033
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play321011098(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1043ui_story"]) and arg_409_1.var_.characterEffect1043ui_story == nil then
				arg_409_1.var_.characterEffect1043ui_story = arg_409_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1043ui_story"]) then
				if arg_409_1.var_.characterEffect1043ui_story and not isNil(arg_409_1.actors_["1043ui_story"]) then
					arg_409_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1043ui_story"]) and arg_409_1.var_.characterEffect1043ui_story then
				arg_409_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.275

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(321011097)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 11 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 11)

				if (11 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 11)) > 0 and var_412_2 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011097", "story_v_out_321011.awb") ~= 0 then
					local var_412_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011097", "story_v_out_321011.awb") / 1000

					if var_412_7 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_1
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_out_321011", "321011097", "story_v_out_321011.awb")

						arg_409_1:RecordAudio("321011097", var_412_8)
						arg_409_1:RecordAudio("321011097", var_412_8)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_321011", "321011097", "story_v_out_321011.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_321011", "321011097", "story_v_out_321011.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_9 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_9 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_9

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_9 and arg_409_1.time_ < var_412_1 + var_412_9 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play321011098 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 321011098
		arg_413_1.duration_ = 1.23

		local var_413_0 = {
			zh = 1.1,
			ja = 1.233
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play321011099(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1043ui_story"]) and arg_413_1.var_.characterEffect1043ui_story == nil then
				arg_413_1.var_.characterEffect1043ui_story = arg_413_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1043ui_story"]) then
				if arg_413_1.var_.characterEffect1043ui_story and not isNil(arg_413_1.actors_["1043ui_story"]) then
					arg_413_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1043ui_story"]) and arg_413_1.var_.characterEffect1043ui_story then
				arg_413_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_416_2 = 0
			local var_416_3 = 0.075

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_4 = arg_413_1:GetWordFromCfg(321011098)
				local var_416_5 = arg_413_1:FormatText(var_416_4.content)

				arg_413_1.text_.text = var_416_5

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_7 = 3 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 3)

				if (3 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 3)) > 0 and var_416_3 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_2
					end
				end

				arg_413_1.text_.text = var_416_5
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011098", "story_v_out_321011.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_out_321011", "321011098", "story_v_out_321011.awb") / 1000

					if var_416_8 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_2
					end

					if var_416_4.prefab_name ~= "" and arg_413_1.actors_[var_416_4.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_4.prefab_name].transform, "story_v_out_321011", "321011098", "story_v_out_321011.awb")

						arg_413_1:RecordAudio("321011098", var_416_9)
						arg_413_1:RecordAudio("321011098", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_321011", "321011098", "story_v_out_321011.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_321011", "321011098", "story_v_out_321011.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_3, arg_413_1.talkMaxDuration)

			if var_416_2 <= arg_413_1.time_ and arg_413_1.time_ < var_416_2 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_2) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_2 + var_416_10 and arg_413_1.time_ < var_416_2 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play321011099 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 321011099
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play321011100(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1043ui_story = arg_417_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).z)
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles = arg_417_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_417_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).z)
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles = arg_417_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1043ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1043ui_story == nil then
				arg_417_1.var_.characterEffect1043ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1043ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_2)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1043ui_story then
				arg_417_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_420_3 = 0
			local var_420_4 = 1.125

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_5 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(321011099).content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 45 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 45)

				if (45 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 45)) > 0 and var_420_4 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_3 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_3
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_4, arg_417_1.talkMaxDuration)

			if var_420_3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_3 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_3) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_3 + var_420_8 and arg_417_1.time_ < var_420_3 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play321011100 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 321011100
		arg_421_1.duration_ = 4.5

		local var_421_0 = {
			zh = 4.5,
			ja = 3.733
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play321011101(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1043ui_story"]) and arg_421_1.var_.characterEffect1043ui_story == nil then
				arg_421_1.var_.characterEffect1043ui_story = arg_421_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1043ui_story"]) then
				if arg_421_1.var_.characterEffect1043ui_story and not isNil(arg_421_1.actors_["1043ui_story"]) then
					arg_421_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1043ui_story"]) and arg_421_1.var_.characterEffect1043ui_story then
				arg_421_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_424_2 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			if arg_421_1.time_ >= var_424_2 + 2 and arg_421_1.time_ < var_424_2 + 2 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end

			local var_424_3 = 0
			local var_424_4 = 0.3

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_3 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_5 = arg_421_1:GetWordFromCfg(321011100)
				local var_424_6 = arg_421_1:FormatText(var_424_5.content)

				arg_421_1.text_.text = var_424_6

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_8 = 12 <= 0 and var_424_4 or var_424_4 * (utf8.len(var_424_6) / 12)

				if (12 <= 0 and var_424_4 or var_424_4 * (utf8.len(var_424_6) / 12)) > 0 and var_424_4 < var_424_8 then
					arg_421_1.talkMaxDuration = var_424_8

					if var_424_8 + var_424_3 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_8 + var_424_3
					end
				end

				arg_421_1.text_.text = var_424_6
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011100", "story_v_out_321011.awb") ~= 0 then
					local var_424_9 = manager.audio:GetVoiceLength("story_v_out_321011", "321011100", "story_v_out_321011.awb") / 1000

					if var_424_9 + var_424_3 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_9 + var_424_3
					end

					if var_424_5.prefab_name ~= "" and arg_421_1.actors_[var_424_5.prefab_name] ~= nil then
						local var_424_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_5.prefab_name].transform, "story_v_out_321011", "321011100", "story_v_out_321011.awb")

						arg_421_1:RecordAudio("321011100", var_424_10)
						arg_421_1:RecordAudio("321011100", var_424_10)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_321011", "321011100", "story_v_out_321011.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_321011", "321011100", "story_v_out_321011.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_11 = math.max(var_424_4, arg_421_1.talkMaxDuration)

			if var_424_3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_3 + var_424_11 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_3) / var_424_11

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_3 + var_424_11 and arg_421_1.time_ < var_424_3 + var_424_11 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play321011101 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 321011101
		arg_425_1.duration_ = 5.97

		local var_425_0 = {
			zh = 5.43266666666667,
			ja = 5.96666666666667
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play321011102(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1043ui_story = arg_425_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1043ui_story"].transform.position).z)
				arg_425_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1043ui_story"].transform.localEulerAngles = arg_425_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_425_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1043ui_story"].transform.position).z)
				arg_425_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1043ui_story"].transform.localEulerAngles = arg_425_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1043ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1043ui_story == nil then
				arg_425_1.var_.characterEffect1043ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1043ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_2)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1043ui_story then
				arg_425_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			local var_428_4 = 0

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			if arg_425_1.time_ >= var_428_4 + 1.16666666666667 and arg_425_1.time_ < var_428_4 + 1.16666666666667 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end

			if arg_425_1.frameCnt_ <= 1 then
				arg_425_1.dialog_:SetActive(false)
			end

			local var_428_5 = 1.16666666666667
			local var_428_6 = 0.4

			if 1.16666666666667 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0

				arg_425_1.dialog_:SetActive(true)

				arg_425_1.dialogCg_.alpha = 0

				local var_428_7 = LeanTween.value(arg_425_1.dialog_, 0, 1, 0.3)

				var_428_7:setOnUpdate(LuaHelper.FloatAction(function(arg_429_0)
					arg_425_1.dialogCg_.alpha = arg_429_0
				end))
				var_428_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_425_1.dialog_)
					var_428_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_425_1.duration_ = arg_425_1.duration_ + 0.3

				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_8 = arg_425_1:GetWordFromCfg(321011101)
				local var_428_9 = arg_425_1:FormatText(var_428_8.content)

				arg_425_1.text_.text = var_428_9

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 16 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_9) / 16)

				if (16 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_9) / 16)) > 0 and var_428_6 < var_428_11 then
					arg_425_1.talkMaxDuration = var_428_11
					var_428_5 = var_428_5 + 0.3

					if var_428_11 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_11 + var_428_5
					end
				end

				arg_425_1.text_.text = var_428_9
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011101", "story_v_out_321011.awb") ~= 0 then
					local var_428_12 = manager.audio:GetVoiceLength("story_v_out_321011", "321011101", "story_v_out_321011.awb") / 1000

					if var_428_12 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_12 + var_428_5
					end

					if var_428_8.prefab_name ~= "" and arg_425_1.actors_[var_428_8.prefab_name] ~= nil then
						local var_428_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_8.prefab_name].transform, "story_v_out_321011", "321011101", "story_v_out_321011.awb")

						arg_425_1:RecordAudio("321011101", var_428_13)
						arg_425_1:RecordAudio("321011101", var_428_13)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_321011", "321011101", "story_v_out_321011.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_321011", "321011101", "story_v_out_321011.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_14 = var_428_5 + 0.3
			local var_428_15 = math.max(var_428_6, arg_425_1.talkMaxDuration)

			if var_428_5 + 0.3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_14 + var_428_15 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_14) / var_428_15

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_14 + var_428_15 and arg_425_1.time_ < var_428_14 + var_428_15 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play321011102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 321011102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play321011103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.2

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(321011102).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 48 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 48)

				if (48 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 48)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play321011103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 321011103
		arg_435_1.duration_ = 3.93

		local var_435_0 = {
			zh = 3.533,
			ja = 3.933
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play321011104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_438_0 = 0
			local var_438_1 = 0.325

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_2 = arg_435_1:GetWordFromCfg(321011103)
				local var_438_3 = arg_435_1:FormatText(var_438_2.content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 13 <= 0 and var_438_1 or var_438_1 * (utf8.len(var_438_3) / 13)

				if (13 <= 0 and var_438_1 or var_438_1 * (utf8.len(var_438_3) / 13)) > 0 and var_438_1 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011103", "story_v_out_321011.awb") ~= 0 then
					local var_438_6 = manager.audio:GetVoiceLength("story_v_out_321011", "321011103", "story_v_out_321011.awb") / 1000

					if var_438_6 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_0
					end

					if var_438_2.prefab_name ~= "" and arg_435_1.actors_[var_438_2.prefab_name] ~= nil then
						local var_438_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_2.prefab_name].transform, "story_v_out_321011", "321011103", "story_v_out_321011.awb")

						arg_435_1:RecordAudio("321011103", var_438_7)
						arg_435_1:RecordAudio("321011103", var_438_7)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_321011", "321011103", "story_v_out_321011.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_321011", "321011103", "story_v_out_321011.awb")
				end

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
	Play321011104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 321011104
		arg_439_1.duration_ = 1.2

		local var_439_0 = {
			zh = 0.999999999999,
			ja = 1.2
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play321011105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1043ui_story = arg_439_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1043ui_story"].transform.position).z)
				arg_439_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1043ui_story"].transform.localEulerAngles = arg_439_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_439_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1043ui_story"].transform.position).z)
				arg_439_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1043ui_story"].transform.localEulerAngles = arg_439_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_442_1 = arg_439_1.actors_["1043ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1043ui_story == nil then
				arg_439_1.var_.characterEffect1043ui_story = var_442_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 and not isNil(var_442_1) then
				if arg_439_1.var_.characterEffect1043ui_story and not isNil(var_442_1) then
					arg_439_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1043ui_story then
				arg_439_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_442_4 = 0
			local var_442_5 = 0.1

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_6 = arg_439_1:GetWordFromCfg(321011104)
				local var_442_7 = arg_439_1:FormatText(var_442_6.content)

				arg_439_1.text_.text = var_442_7

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_9 = 4 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 4)

				if (4 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 4)) > 0 and var_442_5 < var_442_9 then
					arg_439_1.talkMaxDuration = var_442_9

					if var_442_9 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_9 + var_442_4
					end
				end

				arg_439_1.text_.text = var_442_7
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011104", "story_v_out_321011.awb") ~= 0 then
					local var_442_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011104", "story_v_out_321011.awb") / 1000

					if var_442_10 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_4
					end

					if var_442_6.prefab_name ~= "" and arg_439_1.actors_[var_442_6.prefab_name] ~= nil then
						local var_442_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_6.prefab_name].transform, "story_v_out_321011", "321011104", "story_v_out_321011.awb")

						arg_439_1:RecordAudio("321011104", var_442_11)
						arg_439_1:RecordAudio("321011104", var_442_11)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_321011", "321011104", "story_v_out_321011.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_321011", "321011104", "story_v_out_321011.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_12 = math.max(var_442_5, arg_439_1.talkMaxDuration)

			if var_442_4 <= arg_439_1.time_ and arg_439_1.time_ < var_442_4 + var_442_12 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_4) / var_442_12

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_4 + var_442_12 and arg_439_1.time_ < var_442_4 + var_442_12 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play321011105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 321011105
		arg_443_1.duration_ = 3.9

		local var_443_0 = {
			zh = 3.9,
			ja = 3.433
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play321011106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["1043ui_story"]) and arg_443_1.var_.characterEffect1043ui_story == nil then
				arg_443_1.var_.characterEffect1043ui_story = arg_443_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_0 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["1043ui_story"]) then
				if arg_443_1.var_.characterEffect1043ui_story and not isNil(arg_443_1.actors_["1043ui_story"]) then
					arg_443_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_0)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["1043ui_story"]) and arg_443_1.var_.characterEffect1043ui_story then
				arg_443_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_446_1 = 0
			local var_446_2 = 0.25

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(321011105)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_6 = 10 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_4) / 10)

				if (10 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_4) / 10)) > 0 and var_446_2 < var_446_6 then
					arg_443_1.talkMaxDuration = var_446_6

					if var_446_6 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_6 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011105", "story_v_out_321011.awb") ~= 0 then
					local var_446_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011105", "story_v_out_321011.awb") / 1000

					if var_446_7 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_1
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_321011", "321011105", "story_v_out_321011.awb")

						arg_443_1:RecordAudio("321011105", var_446_8)
						arg_443_1:RecordAudio("321011105", var_446_8)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_321011", "321011105", "story_v_out_321011.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_321011", "321011105", "story_v_out_321011.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_9 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_9 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_9

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_9 and arg_443_1.time_ < var_446_1 + var_446_9 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play321011106 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 321011106
		arg_447_1.duration_ = 7.6

		local var_447_0 = {
			zh = 6,
			ja = 7.6
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play321011107(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.6

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_1 = arg_447_1:GetWordFromCfg(321011106)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 24 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 24)

				if (24 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 24)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011106", "story_v_out_321011.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011106", "story_v_out_321011.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_out_321011", "321011106", "story_v_out_321011.awb")

						arg_447_1:RecordAudio("321011106", var_450_6)
						arg_447_1:RecordAudio("321011106", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_321011", "321011106", "story_v_out_321011.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_321011", "321011106", "story_v_out_321011.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play321011107 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 321011107
		arg_451_1.duration_ = 6.4

		local var_451_0 = {
			zh = 5.4,
			ja = 6.4
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play321011108(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1043ui_story = arg_451_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1043ui_story"].transform.position).z)
				arg_451_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1043ui_story"].transform.localEulerAngles = arg_451_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_451_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1043ui_story"].transform.position).z)
				arg_451_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1043ui_story"].transform.localEulerAngles = arg_451_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["1043ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1043ui_story == nil then
				arg_451_1.var_.characterEffect1043ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect1043ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1043ui_story then
				arg_451_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_454_4 = 0
			local var_454_5 = 0.675

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_6 = arg_451_1:GetWordFromCfg(321011107)
				local var_454_7 = arg_451_1:FormatText(var_454_6.content)

				arg_451_1.text_.text = var_454_7

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 27 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 27)

				if (27 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 27)) > 0 and var_454_5 < var_454_9 then
					arg_451_1.talkMaxDuration = var_454_9

					if var_454_9 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_7
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011107", "story_v_out_321011.awb") ~= 0 then
					local var_454_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011107", "story_v_out_321011.awb") / 1000

					if var_454_10 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_4
					end

					if var_454_6.prefab_name ~= "" and arg_451_1.actors_[var_454_6.prefab_name] ~= nil then
						local var_454_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_6.prefab_name].transform, "story_v_out_321011", "321011107", "story_v_out_321011.awb")

						arg_451_1:RecordAudio("321011107", var_454_11)
						arg_451_1:RecordAudio("321011107", var_454_11)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_321011", "321011107", "story_v_out_321011.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_321011", "321011107", "story_v_out_321011.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_12 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_12 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_12

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_12 and arg_451_1.time_ < var_454_4 + var_454_12 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play321011108 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 321011108
		arg_455_1.duration_ = 5.23

		local var_455_0 = {
			zh = 4.733,
			ja = 5.233
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play321011109(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_458_0 = 0
			local var_458_1 = 0.575

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_2 = arg_455_1:GetWordFromCfg(321011108)
				local var_458_3 = arg_455_1:FormatText(var_458_2.content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 23 <= 0 and var_458_1 or var_458_1 * (utf8.len(var_458_3) / 23)

				if (23 <= 0 and var_458_1 or var_458_1 * (utf8.len(var_458_3) / 23)) > 0 and var_458_1 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011108", "story_v_out_321011.awb") ~= 0 then
					local var_458_6 = manager.audio:GetVoiceLength("story_v_out_321011", "321011108", "story_v_out_321011.awb") / 1000

					if var_458_6 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_0
					end

					if var_458_2.prefab_name ~= "" and arg_455_1.actors_[var_458_2.prefab_name] ~= nil then
						local var_458_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_2.prefab_name].transform, "story_v_out_321011", "321011108", "story_v_out_321011.awb")

						arg_455_1:RecordAudio("321011108", var_458_7)
						arg_455_1:RecordAudio("321011108", var_458_7)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_321011", "321011108", "story_v_out_321011.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_321011", "321011108", "story_v_out_321011.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_8 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_8 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_8

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_8 and arg_455_1.time_ < var_458_0 + var_458_8 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play321011109 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 321011109
		arg_459_1.duration_ = 9.3

		local var_459_0 = {
			zh = 9.3,
			ja = 4.533
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play321011110(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1043ui_story"]) and arg_459_1.var_.characterEffect1043ui_story == nil then
				arg_459_1.var_.characterEffect1043ui_story = arg_459_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1043ui_story"]) then
				if arg_459_1.var_.characterEffect1043ui_story and not isNil(arg_459_1.actors_["1043ui_story"]) then
					arg_459_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_0)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1043ui_story"]) and arg_459_1.var_.characterEffect1043ui_story then
				arg_459_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_462_1 = 0
			local var_462_2 = 0.325

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_3 = arg_459_1:GetWordFromCfg(321011109)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_6 = 13 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_4) / 13)

				if (13 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_4) / 13)) > 0 and var_462_2 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011109", "story_v_out_321011.awb") ~= 0 then
					local var_462_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011109", "story_v_out_321011.awb") / 1000

					if var_462_7 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_1
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_out_321011", "321011109", "story_v_out_321011.awb")

						arg_459_1:RecordAudio("321011109", var_462_8)
						arg_459_1:RecordAudio("321011109", var_462_8)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_321011", "321011109", "story_v_out_321011.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_321011", "321011109", "story_v_out_321011.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_9 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_9 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_9

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_9 and arg_459_1.time_ < var_462_1 + var_462_9 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play321011110 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 321011110
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play321011111(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 1.175

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(321011110).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 47 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 47)

				if (47 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 47)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play321011111 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 321011111
		arg_467_1.duration_ = 14.2

		local var_467_0 = {
			zh = 12.633,
			ja = 14.2
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play321011112(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 1.025

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:GetWordFromCfg(321011111)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 41 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 41)

				if (41 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 41)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011111", "story_v_out_321011.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011111", "story_v_out_321011.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_321011", "321011111", "story_v_out_321011.awb")

						arg_467_1:RecordAudio("321011111", var_470_6)
						arg_467_1:RecordAudio("321011111", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_321011", "321011111", "story_v_out_321011.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_321011", "321011111", "story_v_out_321011.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_7 and arg_467_1.time_ < 0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play321011112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 321011112
		arg_471_1.duration_ = 2.2

		local var_471_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play321011113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1043ui_story = arg_471_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_471_1.time_ - 0) / var_474_0)
				arg_471_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1043ui_story"].transform.position).z)
				arg_471_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1043ui_story"].transform.localEulerAngles = arg_471_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_471_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1043ui_story"].transform.position).z)
				arg_471_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1043ui_story"].transform.localEulerAngles = arg_471_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_474_1 = arg_471_1.actors_["1043ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1043ui_story == nil then
				arg_471_1.var_.characterEffect1043ui_story = var_474_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_2 and not isNil(var_474_1) then
				if arg_471_1.var_.characterEffect1043ui_story and not isNil(var_474_1) then
					arg_471_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= 0 + var_474_2 and arg_471_1.time_ < 0 + var_474_2 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1043ui_story then
				arg_471_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_474_4 = 0
			local var_474_5 = 0.2

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_6 = arg_471_1:GetWordFromCfg(321011112)
				local var_474_7 = arg_471_1:FormatText(var_474_6.content)

				arg_471_1.text_.text = var_474_7

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_9 = 8 <= 0 and var_474_5 or var_474_5 * (utf8.len(var_474_7) / 8)

				if (8 <= 0 and var_474_5 or var_474_5 * (utf8.len(var_474_7) / 8)) > 0 and var_474_5 < var_474_9 then
					arg_471_1.talkMaxDuration = var_474_9

					if var_474_9 + var_474_4 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_9 + var_474_4
					end
				end

				arg_471_1.text_.text = var_474_7
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011112", "story_v_out_321011.awb") ~= 0 then
					local var_474_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011112", "story_v_out_321011.awb") / 1000

					if var_474_10 + var_474_4 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_10 + var_474_4
					end

					if var_474_6.prefab_name ~= "" and arg_471_1.actors_[var_474_6.prefab_name] ~= nil then
						local var_474_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_6.prefab_name].transform, "story_v_out_321011", "321011112", "story_v_out_321011.awb")

						arg_471_1:RecordAudio("321011112", var_474_11)
						arg_471_1:RecordAudio("321011112", var_474_11)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_321011", "321011112", "story_v_out_321011.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_321011", "321011112", "story_v_out_321011.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_12 = math.max(var_474_5, arg_471_1.talkMaxDuration)

			if var_474_4 <= arg_471_1.time_ and arg_471_1.time_ < var_474_4 + var_474_12 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_4) / var_474_12

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_4 + var_474_12 and arg_471_1.time_ < var_474_4 + var_474_12 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play321011113 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 321011113
		arg_475_1.duration_ = 10.57

		local var_475_0 = {
			zh = 10.566,
			ja = 10.533
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play321011114(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1043ui_story"]) and arg_475_1.var_.characterEffect1043ui_story == nil then
				arg_475_1.var_.characterEffect1043ui_story = arg_475_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1043ui_story"]) then
				if arg_475_1.var_.characterEffect1043ui_story and not isNil(arg_475_1.actors_["1043ui_story"]) then
					arg_475_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_0)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1043ui_story"]) and arg_475_1.var_.characterEffect1043ui_story then
				arg_475_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_478_1 = 0
			local var_478_2 = 0.75

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_3 = arg_475_1:GetWordFromCfg(321011113)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_6 = 30 <= 0 and var_478_2 or var_478_2 * (utf8.len(var_478_4) / 30)

				if (30 <= 0 and var_478_2 or var_478_2 * (utf8.len(var_478_4) / 30)) > 0 and var_478_2 < var_478_6 then
					arg_475_1.talkMaxDuration = var_478_6

					if var_478_6 + var_478_1 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_6 + var_478_1
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011113", "story_v_out_321011.awb") ~= 0 then
					local var_478_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011113", "story_v_out_321011.awb") / 1000

					if var_478_7 + var_478_1 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_1
					end

					if var_478_3.prefab_name ~= "" and arg_475_1.actors_[var_478_3.prefab_name] ~= nil then
						local var_478_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_3.prefab_name].transform, "story_v_out_321011", "321011113", "story_v_out_321011.awb")

						arg_475_1:RecordAudio("321011113", var_478_8)
						arg_475_1:RecordAudio("321011113", var_478_8)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_321011", "321011113", "story_v_out_321011.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_321011", "321011113", "story_v_out_321011.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_9 = math.max(var_478_2, arg_475_1.talkMaxDuration)

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_9 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_1) / var_478_9

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_1 + var_478_9 and arg_475_1.time_ < var_478_1 + var_478_9 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play321011114 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 321011114
		arg_479_1.duration_ = 7.1

		local var_479_0 = {
			zh = 7.1,
			ja = 7
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play321011115(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.55

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:GetWordFromCfg(321011114)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 22 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 22)

				if (22 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 22)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011114", "story_v_out_321011.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011114", "story_v_out_321011.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_out_321011", "321011114", "story_v_out_321011.awb")

						arg_479_1:RecordAudio("321011114", var_482_6)
						arg_479_1:RecordAudio("321011114", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_321011", "321011114", "story_v_out_321011.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_321011", "321011114", "story_v_out_321011.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play321011115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 321011115
		arg_483_1.duration_ = 10.93

		local var_483_0 = {
			zh = 5.6,
			ja = 10.933
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play321011116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1043ui_story"]) and arg_483_1.var_.characterEffect1043ui_story == nil then
				arg_483_1.var_.characterEffect1043ui_story = arg_483_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1043ui_story"]) then
				if arg_483_1.var_.characterEffect1043ui_story and not isNil(arg_483_1.actors_["1043ui_story"]) then
					arg_483_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1043ui_story"]) and arg_483_1.var_.characterEffect1043ui_story then
				arg_483_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_486_2 = 0
			local var_486_3 = 0.7

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_4 = arg_483_1:GetWordFromCfg(321011115)
				local var_486_5 = arg_483_1:FormatText(var_486_4.content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 28 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 28)

				if (28 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 28)) > 0 and var_486_3 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_2
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011115", "story_v_out_321011.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_321011", "321011115", "story_v_out_321011.awb") / 1000

					if var_486_8 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_2
					end

					if var_486_4.prefab_name ~= "" and arg_483_1.actors_[var_486_4.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_4.prefab_name].transform, "story_v_out_321011", "321011115", "story_v_out_321011.awb")

						arg_483_1:RecordAudio("321011115", var_486_9)
						arg_483_1:RecordAudio("321011115", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_321011", "321011115", "story_v_out_321011.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_321011", "321011115", "story_v_out_321011.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_3, arg_483_1.talkMaxDuration)

			if var_486_2 <= arg_483_1.time_ and arg_483_1.time_ < var_486_2 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_2) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_2 + var_486_10 and arg_483_1.time_ < var_486_2 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play321011116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 321011116
		arg_487_1.duration_ = 6.6

		local var_487_0 = {
			zh = 6.133,
			ja = 6.6
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play321011117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1043ui_story"]) and arg_487_1.var_.characterEffect1043ui_story == nil then
				arg_487_1.var_.characterEffect1043ui_story = arg_487_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1043ui_story"]) then
				if arg_487_1.var_.characterEffect1043ui_story and not isNil(arg_487_1.actors_["1043ui_story"]) then
					arg_487_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1043ui_story"]) and arg_487_1.var_.characterEffect1043ui_story then
				arg_487_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.225

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(321011116)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_6 = 9 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_4) / 9)

				if (9 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_4) / 9)) > 0 and var_490_2 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011116", "story_v_out_321011.awb") ~= 0 then
					local var_490_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011116", "story_v_out_321011.awb") / 1000

					if var_490_7 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_1
					end

					if var_490_3.prefab_name ~= "" and arg_487_1.actors_[var_490_3.prefab_name] ~= nil then
						local var_490_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_3.prefab_name].transform, "story_v_out_321011", "321011116", "story_v_out_321011.awb")

						arg_487_1:RecordAudio("321011116", var_490_8)
						arg_487_1:RecordAudio("321011116", var_490_8)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_321011", "321011116", "story_v_out_321011.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_321011", "321011116", "story_v_out_321011.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_9 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_9 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_9

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_9 and arg_487_1.time_ < var_490_1 + var_490_9 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play321011117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 321011117
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play321011118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1043ui_story = arg_491_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1043ui_story"].transform.position).z)
				arg_491_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1043ui_story"].transform.localEulerAngles = arg_491_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_491_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1043ui_story"].transform.position).z)
				arg_491_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1043ui_story"].transform.localEulerAngles = arg_491_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if 1 < arg_491_1.time_ and arg_491_1.time_ <= 1 + arg_494_0 then
				arg_491_1:AudioAction("play", "effect", "se_story_10", "se_story_10_monster", "")
			end

			local var_494_2 = 0
			local var_494_3 = 1.425

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(321011117).content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_6 = 57 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_4) / 57)

				if (57 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_4) / 57)) > 0 and var_494_3 < var_494_6 then
					arg_491_1.talkMaxDuration = var_494_6

					if var_494_6 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_6 + var_494_2
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_3, arg_491_1.talkMaxDuration)

			if var_494_2 <= arg_491_1.time_ and arg_491_1.time_ < var_494_2 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_2) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_2 + var_494_7 and arg_491_1.time_ < var_494_2 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play321011118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 321011118
		arg_495_1.duration_ = 3

		local var_495_0 = {
			zh = 2.033,
			ja = 3
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play321011119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.2

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:GetWordFromCfg(321011118)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 8 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 8)

				if (8 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 8)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011118", "story_v_out_321011.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011118", "story_v_out_321011.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_321011", "321011118", "story_v_out_321011.awb")

						arg_495_1:RecordAudio("321011118", var_498_6)
						arg_495_1:RecordAudio("321011118", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_321011", "321011118", "story_v_out_321011.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_321011", "321011118", "story_v_out_321011.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play321011119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 321011119
		arg_499_1.duration_ = 12.2

		local var_499_0 = {
			zh = 12.2,
			ja = 11.433
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play321011120(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.825

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_1 = arg_499_1:GetWordFromCfg(321011119)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 33 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 33)

				if (33 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 33)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011119", "story_v_out_321011.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011119", "story_v_out_321011.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_321011", "321011119", "story_v_out_321011.awb")

						arg_499_1:RecordAudio("321011119", var_502_6)
						arg_499_1:RecordAudio("321011119", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_321011", "321011119", "story_v_out_321011.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_321011", "321011119", "story_v_out_321011.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play321011120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 321011120
		arg_503_1.duration_ = 6.33

		local var_503_0 = {
			zh = 5.6,
			ja = 6.333
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play321011121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos1043ui_story = arg_503_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1043ui_story"].transform.position).z)
				arg_503_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["1043ui_story"].transform.localEulerAngles = arg_503_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_503_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1043ui_story"].transform.position).z)
				arg_503_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["1043ui_story"].transform.localEulerAngles = arg_503_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_506_1 = arg_503_1.actors_["1043ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1043ui_story == nil then
				arg_503_1.var_.characterEffect1043ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_2 and not isNil(var_506_1) then
				if arg_503_1.var_.characterEffect1043ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_2 and arg_503_1.time_ < 0 + var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1043ui_story then
				arg_503_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action8_1")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_506_4 = 0
			local var_506_5 = 0.6

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_4 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_6 = arg_503_1:GetWordFromCfg(321011120)
				local var_506_7 = arg_503_1:FormatText(var_506_6.content)

				arg_503_1.text_.text = var_506_7

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_9 = 24 <= 0 and var_506_5 or var_506_5 * (utf8.len(var_506_7) / 24)

				if (24 <= 0 and var_506_5 or var_506_5 * (utf8.len(var_506_7) / 24)) > 0 and var_506_5 < var_506_9 then
					arg_503_1.talkMaxDuration = var_506_9

					if var_506_9 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_9 + var_506_4
					end
				end

				arg_503_1.text_.text = var_506_7
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011120", "story_v_out_321011.awb") ~= 0 then
					local var_506_10 = manager.audio:GetVoiceLength("story_v_out_321011", "321011120", "story_v_out_321011.awb") / 1000

					if var_506_10 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_10 + var_506_4
					end

					if var_506_6.prefab_name ~= "" and arg_503_1.actors_[var_506_6.prefab_name] ~= nil then
						local var_506_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_6.prefab_name].transform, "story_v_out_321011", "321011120", "story_v_out_321011.awb")

						arg_503_1:RecordAudio("321011120", var_506_11)
						arg_503_1:RecordAudio("321011120", var_506_11)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_321011", "321011120", "story_v_out_321011.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_321011", "321011120", "story_v_out_321011.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_12 = math.max(var_506_5, arg_503_1.talkMaxDuration)

			if var_506_4 <= arg_503_1.time_ and arg_503_1.time_ < var_506_4 + var_506_12 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_4) / var_506_12

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_4 + var_506_12 and arg_503_1.time_ < var_506_4 + var_506_12 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play321011121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 321011121
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play321011122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_9000

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1043ui_story = arg_507_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1043ui_story"].transform.position).z)
				arg_507_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1043ui_story"].transform.localEulerAngles = arg_507_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_507_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1043ui_story"].transform.position).z)
				arg_507_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1043ui_story"].transform.localEulerAngles = arg_507_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["1043ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1043ui_story == nil then
				arg_507_1.var_.characterEffect1043ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect1043ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_2)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1043ui_story then
				arg_507_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_507_1.time_ and arg_507_1.time_ <= 0.034000001847744 + arg_510_0 then
				arg_507_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword01", "")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				local var_510_4 = arg_507_1.var_.effect8851

				if not arg_507_1.var_.effect8851 then
					var_510_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_510_4.name = "8851"
					arg_507_1.var_.effect8851 = var_510_4
				else
					var_510_4.transform:SetParent(var_510_9000)
				end

				var_510_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_510_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_510_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_510_0, iter_510_1 in ipairs((var_510_4.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_510_1.transform.localScale = Vector3.New(iter_510_1.transform.localScale.x / var_510_6 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_510_1.transform.localScale.y / var_510_6, iter_510_1.transform.localScale.z)
				end
			end

			local var_510_8 = 0

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_8 + arg_510_0 then
				arg_507_1.allBtn_.enabled = false
			end

			if arg_507_1.time_ >= var_510_8 + 0.925 and arg_507_1.time_ < var_510_8 + 0.925 + arg_510_0 then
				arg_507_1.allBtn_.enabled = true
			end

			local var_510_9 = 0
			local var_510_10 = 0.925

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_9 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_11 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(321011121).content)

				arg_507_1.text_.text = var_510_11

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_13 = 37 <= 0 and var_510_10 or var_510_10 * (utf8.len(var_510_11) / 37)

				if (37 <= 0 and var_510_10 or var_510_10 * (utf8.len(var_510_11) / 37)) > 0 and var_510_10 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_9 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_9
					end
				end

				arg_507_1.text_.text = var_510_11
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_14 = math.max(var_510_10, arg_507_1.talkMaxDuration)

			if var_510_9 <= arg_507_1.time_ and arg_507_1.time_ < var_510_9 + var_510_14 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_9) / var_510_14

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_9 + var_510_14 and arg_507_1.time_ < var_510_9 + var_510_14 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play321011122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 321011122
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play321011123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0.1 < arg_511_1.time_ and arg_511_1.time_ <= 0.1 + arg_514_0 then
				arg_511_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword02", "")
			end

			local var_514_1 = 0
			local var_514_2 = 1

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(321011122).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 39 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 39)

				if (39 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 39)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play321011123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 321011123
		arg_515_1.duration_ = 4.63

		local var_515_0 = {
			zh = 3.466,
			ja = 4.633
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play321011124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1043ui_story"]) and arg_515_1.var_.characterEffect1043ui_story == nil then
				arg_515_1.var_.characterEffect1043ui_story = arg_515_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1043ui_story"]) then
				if arg_515_1.var_.characterEffect1043ui_story and not isNil(arg_515_1.actors_["1043ui_story"]) then
					arg_515_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1043ui_story"]) and arg_515_1.var_.characterEffect1043ui_story then
				arg_515_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_518_2 = 0
			local var_518_3 = 0.325

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_2 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_4 = arg_515_1:GetWordFromCfg(321011123)
				local var_518_5 = arg_515_1:FormatText(var_518_4.content)

				arg_515_1.text_.text = var_518_5

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_7 = 13 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 13)

				if (13 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 13)) > 0 and var_518_3 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_2
					end
				end

				arg_515_1.text_.text = var_518_5
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011123", "story_v_out_321011.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_321011", "321011123", "story_v_out_321011.awb") / 1000

					if var_518_8 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_2
					end

					if var_518_4.prefab_name ~= "" and arg_515_1.actors_[var_518_4.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_4.prefab_name].transform, "story_v_out_321011", "321011123", "story_v_out_321011.awb")

						arg_515_1:RecordAudio("321011123", var_518_9)
						arg_515_1:RecordAudio("321011123", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_321011", "321011123", "story_v_out_321011.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_321011", "321011123", "story_v_out_321011.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_3, arg_515_1.talkMaxDuration)

			if var_518_2 <= arg_515_1.time_ and arg_515_1.time_ < var_518_2 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_2) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_2 + var_518_10 and arg_515_1.time_ < var_518_2 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play321011124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 321011124
		arg_519_1.duration_ = 6.5

		local var_519_0 = {
			zh = 6.5,
			ja = 1.433
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play321011125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["1043ui_story"]) and arg_519_1.var_.characterEffect1043ui_story == nil then
				arg_519_1.var_.characterEffect1043ui_story = arg_519_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["1043ui_story"]) then
				if arg_519_1.var_.characterEffect1043ui_story and not isNil(arg_519_1.actors_["1043ui_story"]) then
					arg_519_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_0)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["1043ui_story"]) and arg_519_1.var_.characterEffect1043ui_story then
				arg_519_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_522_1 = 0
			local var_522_2 = 0.05

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_3 = arg_519_1:GetWordFromCfg(321011124)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_6 = 2 <= 0 and var_522_2 or var_522_2 * (utf8.len(var_522_4) / 2)

				if (2 <= 0 and var_522_2 or var_522_2 * (utf8.len(var_522_4) / 2)) > 0 and var_522_2 < var_522_6 then
					arg_519_1.talkMaxDuration = var_522_6

					if var_522_6 + var_522_1 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_6 + var_522_1
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011124", "story_v_out_321011.awb") ~= 0 then
					local var_522_7 = manager.audio:GetVoiceLength("story_v_out_321011", "321011124", "story_v_out_321011.awb") / 1000

					if var_522_7 + var_522_1 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_1
					end

					if var_522_3.prefab_name ~= "" and arg_519_1.actors_[var_522_3.prefab_name] ~= nil then
						local var_522_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_3.prefab_name].transform, "story_v_out_321011", "321011124", "story_v_out_321011.awb")

						arg_519_1:RecordAudio("321011124", var_522_8)
						arg_519_1:RecordAudio("321011124", var_522_8)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_321011", "321011124", "story_v_out_321011.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_321011", "321011124", "story_v_out_321011.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_9 = math.max(var_522_2, arg_519_1.talkMaxDuration)

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_9 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_1) / var_522_9

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_1 + var_522_9 and arg_519_1.time_ < var_522_1 + var_522_9 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play321011125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 321011125
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play321011126(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0.5 < arg_523_1.time_ and arg_523_1.time_ <= 0.5 + arg_526_0 then
				arg_523_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_526_1 = 0
			local var_526_2 = 1.25

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(321011125).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 49 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 49)

				if (49 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 49)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play321011126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 321011126
		arg_527_1.duration_ = 1.9

		local var_527_0 = {
			zh = 1.7,
			ja = 1.9
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play321011127(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.15

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:GetWordFromCfg(321011126)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 6 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 6)

				if (6 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 6)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011126", "story_v_out_321011.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011126", "story_v_out_321011.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_out_321011", "321011126", "story_v_out_321011.awb")

						arg_527_1:RecordAudio("321011126", var_530_6)
						arg_527_1:RecordAudio("321011126", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_321011", "321011126", "story_v_out_321011.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_321011", "321011126", "story_v_out_321011.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play321011127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 321011127
		arg_531_1.duration_ = 6

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play321011128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_0 = 0.433333333333333

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				local var_534_1 = Color.New(1, 1, 1)

				var_534_1.a = Mathf.Lerp(1, 0, (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.mask_.color = var_534_1
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				local var_534_2 = Color.New(1, 1, 1)

				arg_531_1.mask_.enabled = false
				var_534_2.a = 0
				arg_531_1.mask_.color = var_534_2
			end

			local var_534_3 = manager.ui.mainCamera.transform

			if 0.157419800758362 < arg_531_1.time_ and arg_531_1.time_ <= 0.157419800758362 + arg_534_0 then
				arg_531_1.var_.shakeOldPos = var_534_3.localPosition
			end

			local var_534_4 = 0.642580199241638

			if 0.157419800758362 <= arg_531_1.time_ and arg_531_1.time_ < 0.157419800758362 + var_534_4 then
				local var_534_5, var_534_6 = math.modf((arg_531_1.time_ - 0.157419800758362) / 0.066)

				var_534_3.localPosition = Vector3.New(var_534_6 * 0.13, var_534_6 * 0.13, var_534_6 * 0.13) + arg_531_1.var_.shakeOldPos
			end

			if arg_531_1.time_ >= 0.157419800758362 + var_534_4 and arg_531_1.time_ < 0.157419800758362 + var_534_4 + arg_534_0 then
				var_534_3.localPosition = arg_531_1.var_.shakeOldPos
			end

			local var_534_7 = 0

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_7 + arg_534_0 then
				arg_531_1.allBtn_.enabled = false
			end

			if arg_531_1.time_ >= var_534_7 + 1 and arg_531_1.time_ < var_534_7 + 1 + arg_534_0 then
				arg_531_1.allBtn_.enabled = true
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:AudioAction("play", "effect", "se_story_140", "se_story_140_breakdown", "")
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_9 = 0.999999999999
			local var_534_10 = 0.65

			if 0.999999999999 < arg_531_1.time_ and arg_531_1.time_ <= var_534_9 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_11 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_11:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_12 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(321011127).content)

				arg_531_1.text_.text = var_534_12

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_14 = 26 <= 0 and var_534_10 or var_534_10 * (utf8.len(var_534_12) / 26)

				if (26 <= 0 and var_534_10 or var_534_10 * (utf8.len(var_534_12) / 26)) > 0 and var_534_10 < var_534_14 then
					arg_531_1.talkMaxDuration = var_534_14
					var_534_9 = var_534_9 + 0.3

					if var_534_14 + var_534_9 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_14 + var_534_9
					end
				end

				arg_531_1.text_.text = var_534_12
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_15 = var_534_9 + 0.3
			local var_534_16 = math.max(var_534_10, arg_531_1.talkMaxDuration)

			if var_534_9 + 0.3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_15 + var_534_16 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_15) / var_534_16

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_15 + var_534_16 and arg_531_1.time_ < var_534_15 + var_534_16 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play321011128 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 321011128
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play321011129(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0.433333333333333 < arg_537_1.time_ and arg_537_1.time_ <= 0.433333333333333 + arg_540_0 then
				arg_537_1:AudioAction("play", "effect", "se_story_9", "se_story_9_monster", "")
			end

			local var_540_1 = 0
			local var_540_2 = 0.775

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_3 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(321011128).content)

				arg_537_1.text_.text = var_540_3

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 31 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_3) / 31)

				if (31 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_3) / 31)) > 0 and var_540_2 < var_540_5 then
					arg_537_1.talkMaxDuration = var_540_5

					if var_540_5 + var_540_1 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + var_540_1
					end
				end

				arg_537_1.text_.text = var_540_3
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_6 = math.max(var_540_2, arg_537_1.talkMaxDuration)

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_6 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_1) / var_540_6

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_1 + var_540_6 and arg_537_1.time_ < var_540_1 + var_540_6 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play321011129 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 321011129
		arg_541_1.duration_ = 3

		local var_541_0 = {
			zh = 2.333,
			ja = 3
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play321011130(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.25

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_1 = arg_541_1:GetWordFromCfg(321011129)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 10 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 10)

				if (10 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 10)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011129", "story_v_out_321011.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_out_321011", "321011129", "story_v_out_321011.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_out_321011", "321011129", "story_v_out_321011.awb")

						arg_541_1:RecordAudio("321011129", var_544_6)
						arg_541_1:RecordAudio("321011129", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_321011", "321011129", "story_v_out_321011.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_321011", "321011129", "story_v_out_321011.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play321011130 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 321011130
		arg_545_1.duration_ = 2.77

		local var_545_0 = {
			zh = 2.033,
			ja = 2.766
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play321011131(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if arg_545_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_548_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_545_1.stage_.transform)

				var_548_0.name = "1284ui_story"
				var_548_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_545_1.actors_["1284ui_story"] = var_548_0

				local var_548_1 = var_548_0:GetComponentInChildren(typeof(CharacterEffect))

				var_548_1.enabled = true

				local var_548_2 = GameObjectTools.GetOrAddComponent(var_548_0, typeof(DynamicBoneHelper))

				if var_548_2 then
					var_548_2:EnableDynamicBone(false)
				end

				arg_545_1:ShowWeapon(var_548_1.transform, false)

				arg_545_1.var_["1284ui_story" .. "Animator"] = var_548_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_545_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_545_1.var_["1284ui_story" .. "LipSync"] = var_548_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_548_3 = arg_545_1.actors_["1284ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_3) and arg_545_1.var_.characterEffect1284ui_story == nil then
				arg_545_1.var_.characterEffect1284ui_story = var_548_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_4 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 and not isNil(var_548_3) then
				if arg_545_1.var_.characterEffect1284ui_story and not isNil(var_548_3) then
					arg_545_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 and not isNil(var_548_3) and arg_545_1.var_.characterEffect1284ui_story then
				arg_545_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_548_6 = 0
			local var_548_7 = 0.275

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_545_1.callingController_:SetSelectedState("calling")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_8 = arg_545_1:GetWordFromCfg(321011130)
				local var_548_9 = arg_545_1:FormatText(var_548_8.content)

				arg_545_1.text_.text = var_548_9

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_11 = 11 <= 0 and var_548_7 or var_548_7 * (utf8.len(var_548_9) / 11)

				if (11 <= 0 and var_548_7 or var_548_7 * (utf8.len(var_548_9) / 11)) > 0 and var_548_7 < var_548_11 then
					arg_545_1.talkMaxDuration = var_548_11

					if var_548_11 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_11 + var_548_6
					end
				end

				arg_545_1.text_.text = var_548_9
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011130", "story_v_out_321011.awb") ~= 0 then
					local var_548_12 = manager.audio:GetVoiceLength("story_v_out_321011", "321011130", "story_v_out_321011.awb") / 1000

					if var_548_12 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_12 + var_548_6
					end

					if var_548_8.prefab_name ~= "" and arg_545_1.actors_[var_548_8.prefab_name] ~= nil then
						local var_548_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_8.prefab_name].transform, "story_v_out_321011", "321011130", "story_v_out_321011.awb")

						arg_545_1:RecordAudio("321011130", var_548_13)
						arg_545_1:RecordAudio("321011130", var_548_13)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_321011", "321011130", "story_v_out_321011.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_321011", "321011130", "story_v_out_321011.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_14 = math.max(var_548_7, arg_545_1.talkMaxDuration)

			if var_548_6 <= arg_545_1.time_ and arg_545_1.time_ < var_548_6 + var_548_14 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_6) / var_548_14

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_6 + var_548_14 and arg_545_1.time_ < var_548_6 + var_548_14 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play321011131 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 321011131
		arg_549_1.duration_ = 3

		local var_549_0 = {
			zh = 2.6,
			ja = 3
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
			arg_549_1.auto_ = false
		end

		function arg_549_1.playNext_(arg_551_0)
			arg_549_1.onStoryFinished_()
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1043ui_story = arg_549_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_552_0 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 then
				arg_549_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_549_1.time_ - 0) / var_552_0)
				arg_549_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1043ui_story"].transform.position).z)
				arg_549_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1043ui_story"].transform.localEulerAngles = arg_549_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 then
				arg_549_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_549_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1043ui_story"].transform.position).z)
				arg_549_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1043ui_story"].transform.localEulerAngles = arg_549_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_552_1 = arg_549_1.actors_["1043ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1043ui_story == nil then
				arg_549_1.var_.characterEffect1043ui_story = var_552_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_2 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_2 and not isNil(var_552_1) then
				if arg_549_1.var_.characterEffect1043ui_story and not isNil(var_552_1) then
					arg_549_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= 0 + var_552_2 and arg_549_1.time_ < 0 + var_552_2 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1043ui_story then
				arg_549_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_552_4 = arg_549_1.actors_["1284ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_4) and arg_549_1.var_.characterEffect1284ui_story == nil then
				arg_549_1.var_.characterEffect1284ui_story = var_552_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_5 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_5 and not isNil(var_552_4) then
				if arg_549_1.var_.characterEffect1284ui_story and not isNil(var_552_4) then
					arg_549_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_5)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_5 and arg_549_1.time_ < 0 + var_552_5 + arg_552_0 and not isNil(var_552_4) and arg_549_1.var_.characterEffect1284ui_story then
				arg_549_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action8_2")
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_552_6 = 0
			local var_552_7 = 0.325

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_6 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_8 = arg_549_1:GetWordFromCfg(321011131)
				local var_552_9 = arg_549_1:FormatText(var_552_8.content)

				arg_549_1.text_.text = var_552_9

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_11 = 13 <= 0 and var_552_7 or var_552_7 * (utf8.len(var_552_9) / 13)

				if (13 <= 0 and var_552_7 or var_552_7 * (utf8.len(var_552_9) / 13)) > 0 and var_552_7 < var_552_11 then
					arg_549_1.talkMaxDuration = var_552_11

					if var_552_11 + var_552_6 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_11 + var_552_6
					end
				end

				arg_549_1.text_.text = var_552_9
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321011", "321011131", "story_v_out_321011.awb") ~= 0 then
					local var_552_12 = manager.audio:GetVoiceLength("story_v_out_321011", "321011131", "story_v_out_321011.awb") / 1000

					if var_552_12 + var_552_6 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_12 + var_552_6
					end

					if var_552_8.prefab_name ~= "" and arg_549_1.actors_[var_552_8.prefab_name] ~= nil then
						local var_552_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_8.prefab_name].transform, "story_v_out_321011", "321011131", "story_v_out_321011.awb")

						arg_549_1:RecordAudio("321011131", var_552_13)
						arg_549_1:RecordAudio("321011131", var_552_13)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_321011", "321011131", "story_v_out_321011.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_321011", "321011131", "story_v_out_321011.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_14 = math.max(var_552_7, arg_549_1.talkMaxDuration)

			if var_552_6 <= arg_549_1.time_ and arg_549_1.time_ < var_552_6 + var_552_14 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_6) / var_552_14

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_6 + var_552_14 and arg_549_1.time_ < var_552_6 + var_552_14 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/MS2101",
		"TextureConfig/Background/MS2101a",
		"TextureConfig/Background/L06g",
		"TextureConfig/Background/L13f"
	},
	voices = {
		"story_v_out_321011.awb"
	}
}
