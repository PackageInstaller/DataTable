local config = {
  str_return_system_name = [[
Navigator
Selamat Datang kembali]],
  str_return_system_time_main = "<color=#ffffff>Sisa Waktu Event: </color><color=#df8e00>{1}</color>",
  str_return_system_time_login = "<color=#c46300>Waktu Klaim Berikutnya: </color><color=#ffdb15>{1}</color>",
  str_return_system_time_quest = "<color=#c46300>Hitung Mundur Refresh Quest Harian: </color><color=#ffdb15>{1}</color>",
  str_return_system_time_boost = "<color=#c46300>Hitung Mundur Reset Resolve: </color><color=#ffdb15>{1}</color>",
  str_return_system_btn_intro = "Info Event",
  str_return_system_btn_story = "Rekap Story",
  str_return_system_btn_welecome = "Kamu Kembali!",
  str_return_system_btn_sign = "Returner Sign-In",
  str_return_system_btn_mission = "Returner Quest",
  str_return_system_btn_gift = "Returner Gift",
  str_return_system_btn_assistance = "Returner's Resolve",
  str_return_system_btn_shop = "Toko Pengembalian",
  str_return_system_get_award = "Klaim Returner Reward!",
  str_return_system_greetings = "PlayerName, kamu kembali! Belakangan tidak ada banyak perubahan di sini, tapi... kami semua sangat rindu padamu!",
  str_return_system_extra_drop_times = "Jarahan Ekstra <color=#df8e00>[Resource Raid]</color> Hari Ini: <color=#df8e00>{1}</color>/{2}",
  str_return_system_extra_drop_times_not_enough = "Sisa peluang drop Resource Raid ekstra untuk hari ini tidak cukup!",
  str_return_system_reset_after_d_h = "Mereset di {1}D {2}H",
  str_return_system_reset_after_h_m = "Mereset di {1}H {2} min",
  str_return_system_reset_after_m = "Mereset di {1} min",
  str_return_system_reset_after_lt_m = "Direset dalam kurang dari 1 menit",
  str_return_system_desc = [[
- Selesaikan tahapan Resource Raid selagi kamu memiliki buff Returner's Resolve dan kamu akan mendapatkan hadiah ekstra.
- Anda akan mendapatkan sejumlah peluang tertentu untuk menggunakan Returner's Resolve setiap hari, dan peluang ini akan diperbarui pada waktu yang tetap, setiap hari.
- Gunakan Carrier untuk memasuki tahapan Resource Raid dan dapatkan hadiah ekstra dan upaya konsumsi.]],
  str_return_system_desc_1 = [[
- Selesaikan stage Resource Raid saat kamu memiliki buff Returner's Resolve dan dapatkan <color=#df8e00>2</color> reward ekstra.
- Kamu akan mendapatkan sejumlah peluang untuk menggunakan Returner's Resolve setiap hari. Peluang akan di-refresh di waktu yang sama setiap hari.
- Gunakan Carrier untuk memasuki stage Resource Raid dan dapatkan reward ekstra serta menghabiskan upaya.]],
  str_return_system_reward_triple = "3 Juli - 26 Juli <color=#df8e00>3×</color> Hadiah!",
  str_return_system_goto_challenge = "Tantang Sekarang!",
  str_return_system_goto_challenge_hint = "Resource Raid belum tersedia!",
  str_return_system_award_hello_1600061 = "Semoga Yang Mulia dalam keadaan sehat. Atas nama Lumopolis, saya ucapkan doa-doa terbaik agar kesehatan Yang Mulia lekas pulih!",
  str_return_system_award_hello_1600021 = "Mekar atau layunya bunga tergantung pada cuaca dan musim, tapi kalau kesehatan—kitalah yang bisa mengendalikannya. Jika kita bertemu lagi lain kali, ayo bermeditasi bersama di bawah kelopak bunga Sakura.",
  str_return_system_award_hello_1601051 = "Navigator, kakakku bilang kau pergi berlibur... Benarkah? Ambillah—ini cendera mata dari Rediesel Wrench... Semoga kamu suka!",
  str_return_system_award_hello_1300521 = "Biasanya aku yang membatalkan janji dengan orang lain, tak kusangka kamu akan balas membatalkan janji denganku! Aku sudah cukup lama menyembunyikan ini. Ambillah—jangan bilang siapa-siapa, ya!",
  str_return_system_award_hello_1600381 = "Argh! Menyebalkan tidak sih kalau game yang sedang kamu mainkan tiba-tiba mengalami crash? Tenang saja, aku sudah menyimpan beberapa bonus sambutan kembali untukmu! Ambil dan berusahalah menjadi pemenang! Semoga RNG menyertaimu!",
  str_return_system_award_hello_1600261 = "Saat kau pergi... seolah-olah perasaan ketiadaan itu makin besar... Tidak, aku baik-baik saja... Kamu sudah kembali, dan itu yang terpenting...",
  str_return_system_award_hello_1400571 = "Sudah lama aku tidak melihatmu, Navigator! Chief memintaku untuk memberikan ini padamu agar kondisimu lekas pulih... \"Chief\" yang mana, meong? Philyshy tidak mau bilang, ah!",
  str_return_system_award_hello_1600251 = "Penonton setiaku telah kembali! Mana mungkin aku, Acheron Ferryman Charon, berada di atas panggung tanpamu? Tirai telah diangkat, dan sekarang, lampu panggung yang bersinar menunggu pertunjukan ulang atas kemenanganmu!",
  str_return_system_award_from_1600061 = "Hadiah dari Carleen",
  str_return_system_award_from_1600021 = "Hadiah dari Hiiro",
  str_return_system_award_from_1601051 = "Hadiah dari Eve",
  str_return_system_award_from_1300521 = "Hadiah dari Dove",
  str_return_system_award_from_1600381 = "Hadiah dari Gronru",
  str_return_system_award_from_1600261 = "Hadiah dari Uriel",
  str_return_system_award_from_1400571 = "Hadiah dari Philyshy",
  str_return_system_award_from_1600251 = "Hadiah dari Charon",
  str_return_system_cell_locked = "Terkunci",
  str_return_system_intro_head_1 = "Reward Login",
  str_return_system_intro_body_1 = "1. Login setiap hari selama periode event Returner dan klaim reward login.",
  str_return_system_intro_head_2 = "Returner Quest",
  str_return_system_intro_body_2 = [[
1. Dapatkan poin dengan menyelesaikan Daily Returner Quest atau Returner Quest biasa.
2. Setelah mengakumulasikan jumlah poin event yang dibutuhkan, kamu bisa mengeklaim Returner reward.
3. Quest Harian di-refresh setiap hari dan bisa diselesaikan berulang kali.]],
  str_return_system_intro_head_3 = "Returner Assistant",
  str_return_system_intro_body_3 = [[
1. Peluang Resolve yang Kembali diperbarui setiap hari (peluang yang tidak digunakan juga akan diperbarui).
2.Ketika Anda memiliki peluang Buff Pengembalian yang tersedia, Anda dapat menggunakannya sebelum memasuki tahapan Resource Raid untuk mendapatkan hadiah ekstra.
3.Gunakan Carrier untuk memasuki tahapan Resource Raid dan dapatkan hadiah ekstra dan usaha konsumsi.]],
  str_return_system_intro_head_4 = "Toko Pengembalian",
  str_return_system_intro_body_4 = [[
1. Dalam 7 hari menjelang event Welcome Back, Navigator, kamu akan menerima sejumlah Catatan Pengembalian setiap kali kamu menyelesaikan tahapan Main Story atau Resource Raid yang menghabiskan Prism.
2. Saat acara Selamat Datang Kembali, Navigator dimulai, Anda dapat membelanjakan Catatan Pengembalian di Toko Pengembalian untuk membeli item.
3. Setelah acara Selamat Datang Kembali, Navigator berakhir, Catatan Pengembalian Anda yang tidak terpakai akan dihapus. Harap pastikan Anda memperhatikan kapan acara berakhir!]],
  str_return_system_progress_desc_1 = "Poin Saat Ini",
  str_return_system_progress_desc_2 = "Kamu hanya bisa mengeklaim Reward saat poinmu sudah cukup",
  str_return_system_reward_title = "Returner's Resolve",
  str_return_system_res_enter_title = "Selamat Datang Kembali",
  str_return_system_huiliu_1050001 = "Return Reward",
  str_return_system_huiliu_1050002 = "Returning Ascension Pack",
  str_return_system_huiliu_1050003 = "Returning Recruitment Kit",
  str_return_system_tip_title = "Info Drop Rekam Pengembalian Toko Pengembalian",
  str_return_system_tip_info = [[
1. Dalam 7 hari menjelang event Welcome Back, Navigator, kamu akan menerima sejumlah Catatan Pengembalian setiap kali kamu menyelesaikan tahapan Main Story atau Resource Raid yang menghabiskan Prism.
2. Saat acara Selamat Datang Kembali, Navigator dimulai, Anda dapat membelanjakan Catatan Pengembalian di Toko Pengembalian untuk membeli item.
3. Setelah acara Selamat Datang Kembali, Navigator berakhir, Catatan Pengembalian Anda yang tidak terpakai akan dihapus. Harap pastikan Anda memperhatikan kapan acara berakhir!]],
  str_return_system_tip_time = "Ketersediaan Rekam Pengembalian: {1}"
}
return config
